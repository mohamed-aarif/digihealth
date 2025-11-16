CREATE EXTENSION IF NOT EXISTS "pgcrypto";

--=======================================================================================
-- Create schemas
--=======================================================================================
-- Schemas per logical microservice
CREATE SCHEMA [identity];
CREATE SCHEMA vault;
CREATE SCHEMA consent;
CREATE SCHEMA medication;
CREATE SCHEMA appointments;
CREATE SCHEMA devices;
CREATE SCHEMA engagement;

-- Optional: set search_path so you can refer to tables without schema
ALTER DATABASE digihealth SET search_path TO public, identity, vault, consent, medication, appointments, devices, engagement;

--=======================================================================================
--Identity schema (users, patients, doctors, family)
--=======================================================================================
-- identity schema

CREATE TABLE [identity].users (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_name       VARCHAR(64) NOT NULL UNIQUE,
    email           VARCHAR(256) NOT NULL UNIQUE,
    password_hash   VARCHAR(256) NOT NULL,
    user_type       VARCHAR(20) NOT NULL, -- 'Patient', 'Doctor', 'Family'
    photo_storage_key VARCHAR(300),
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE [identity].patients (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL REFERENCES [identity].users(id),
    salutation      VARCHAR(20),         -- e.g., 'Mr', 'Ms', 'Dr'
    full_name       VARCHAR(150) NOT NULL,
    date_of_birth   DATE,
    gender          VARCHAR(10),
    country         VARCHAR(80),
    mobile_number   VARCHAR(32),
    healthvault_id  VARCHAR(32) UNIQUE, -- short code / ID visible to others
    residence_country VARCHAR(80),  -- or CHAR(2) for ISO-3166-1 alpha-2
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE [identity].doctors (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL REFERENCES [identity].users(id),
    salutation      VARCHAR(20),  -- 'Dr', 'Prof', etc.
    full_name       VARCHAR(150) NOT NULL,
    gender          VARCHAR(10),      -- keep free-text or constrain later
    specialty       VARCHAR(120),
    registration_no VARCHAR(80),
    clinic_name     VARCHAR(150),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE [identity].family_links (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id          UUID NOT NULL REFERENCES [identity].patients(id),
    family_user_id      UUID NOT NULL REFERENCES [identity].users(id),
    relationship        VARCHAR(50) NOT NULL, -- e.g. 'Parent', 'Spouse'
    is_guardian         BOOLEAN NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

--=======================================================================================
--Vault schema (records + timeline)
--=======================================================================================
-- vault schema

CREATE TYPE vault.record_type AS ENUM ('Report', 'Prescription', 'Discharge', 'Imaging', 'NationalId', 'Insurance', 'Other');
CREATE TYPE vault.sensitivity_level AS ENUM ('Public', 'Restricted', 'Confidential');

CREATE TABLE vault.records (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id          UUID NOT NULL REFERENCES identity.patients(id),
    record_type         vault.record_type NOT NULL,
    title               VARCHAR(200) NOT NULL,
    description         TEXT,
    file_storage_key    VARCHAR(300) NOT NULL, -- blob path/key in object storage
    sensitivity         vault.sensitivity_level NOT NULL DEFAULT 'Restricted',
    source              VARCHAR(50), -- 'Upload', 'Doctor', 'Device'
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TYPE vault.event_type AS ENUM (
    'RecordUploaded',
    'Appointment',
    'MedicationStarted',
    'MedicationReminder',
    'VitalReading',
    'AiInsight'
);

CREATE TABLE vault.timeline_events (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      UUID NOT NULL REFERENCES identity.patients(id),
    event_type      vault.event_type NOT NULL,
    related_id      UUID,
    event_time      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    summary         VARCHAR(300),
    details_json    JSONB
);

--=======================================================================================
--Consent schema (HealthVault ID / QR / sharing)
--=======================================================================================
-- consent schema

CREATE TYPE consent.actor_type AS ENUM ('Doctor', 'Family');

CREATE TABLE consent.consent_sessions (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id          UUID NOT NULL REFERENCES identity.patients(id),
    actor_user_id       UUID NOT NULL REFERENCES identity.users(id),
    actor_type          consent.actor_type NOT NULL,
    scope_json          JSONB NOT NULL, -- e.g. {"records":["Report","Prescription"],"from":"2024-01-01"}
    expires_at          TIMESTAMPTZ NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_revoked          BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE consent.access_logs (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    consent_session_id   UUID NOT NULL REFERENCES consent.consent_sessions(id),
    accessed_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    resource_type   VARCHAR(50), -- 'Record', 'Vitals', etc.
    resource_id     UUID,
    action          VARCHAR(20) -- 'Read','List','Download'
);

--=======================================================================================
--Medication schema (schedules & reminders)
--=======================================================================================
-- medication schema

CREATE TABLE medication.prescriptions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      UUID NOT NULL REFERENCES identity.patients(id),
    doctor_id       UUID REFERENCES identity.doctors(id),
    record_id       UUID REFERENCES vault.records(id), -- original RX document
    issued_on       DATE NOT NULL,
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE medication.medication_items (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    prescription_id     UUID NOT NULL REFERENCES medication.prescriptions(id),
    name                VARCHAR(150) NOT NULL,
    dosage              VARCHAR(80),
    frequency           VARCHAR(80), -- 'Once daily', 'Twice daily'
    route               VARCHAR(50), -- 'Oral','Injection'
    duration_days       INT,
    instructions        TEXT
);

CREATE TABLE medication.medication_schedules (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    medication_item_id  UUID NOT NULL REFERENCES medication.medication_items(id),
    start_date          DATE NOT NULL,
    end_date            DATE,
    times_in_day        JSONB NOT NULL, -- e.g. ["08:00","20:00"]
    timezone            VARCHAR(64) NOT NULL DEFAULT 'Asia/Dubai'
);

CREATE TYPE medication.dose_status AS ENUM ('Scheduled','Taken','Missed','Skipped');

CREATE TABLE medication.medication_doses (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    schedule_id         UUID NOT NULL REFERENCES medication.medication_schedules(id),
    due_at              TIMESTAMPTZ NOT NULL,
    status              medication.dose_status NOT NULL DEFAULT 'Scheduled',
    taken_at            TIMESTAMPTZ,
    notes               TEXT
);


--=======================================================================================
--Appointments schema
--=======================================================================================
-- appointments schema

CREATE TYPE appointments.appointment_status AS ENUM ('Planned','Completed','Cancelled','NoShow');

CREATE TABLE appointments.appointments (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      UUID NOT NULL REFERENCES identity.patients(id),
    doctor_id       UUID NOT NULL REFERENCES identity.doctors(id),
    scheduled_at    TIMESTAMPTZ NOT NULL,
    status          appointments.appointment_status NOT NULL DEFAULT 'Planned',
    reason          VARCHAR(200),
    location        VARCHAR(200),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE appointments.visit_notes (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    appointment_id  UUID NOT NULL REFERENCES appointments.appointments(id),
    notes_by_doctor TEXT,
    notes_by_patient TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE appointments.ai_visit_briefs (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    appointment_id  UUID NOT NULL REFERENCES appointments.appointments(id),
    summary_for_doctor TEXT,
    summary_for_patient TEXT,
    generated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

--=======================================================================================
--Devices schema
--=======================================================================================
-- devices schema

CREATE TABLE devices.device_links (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      UUID NOT NULL REFERENCES identity.patients(id),
    provider        VARCHAR(80) NOT NULL, -- 'AppleHealth','Fitbit','Omron'
    external_id     VARCHAR(200) NOT NULL,
    linked_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_active       BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TYPE devices.vital_type AS ENUM ('HeartRate','BloodPressure','Glucose','Steps','Weight','SpO2');

CREATE TABLE devices.vital_readings (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      UUID NOT NULL REFERENCES identity.patients(id),
    device_link_id  UUID REFERENCES devices.device_links(id),
    vital_type      devices.vital_type NOT NULL,
    value_numeric   NUMERIC(12,4),
    value_text      VARCHAR(80),
    unit            VARCHAR(20),
    taken_at        TIMESTAMPTZ NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_vital_patient_time ON devices.vital_readings (patient_id, taken_at DESC);

--=======================================================================================
--Engagement schema (notifications + chat)
--=======================================================================================
-- engagement schema

CREATE TYPE engagement.channel_type AS ENUM ('Push','Email','Sms','WhatsApp');
CREATE TYPE engagement.notification_status AS ENUM ('Pending','Sent','Failed');

CREATE TABLE engagement.notifications (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      UUID REFERENCES identity.patients(id),
    user_id         UUID REFERENCES identity.users(id),
    channel         engagement.channel_type NOT NULL,
    template_key    VARCHAR(80),
    payload_json    JSONB NOT NULL,
    status          engagement.notification_status NOT NULL DEFAULT 'Pending',
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    sent_at         TIMESTAMPTZ
);

CREATE TABLE engagement.chat_sessions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id      UUID NOT NULL REFERENCES identity.patients(id),
    started_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_active       BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TYPE engagement.message_sender AS ENUM ('Patient','AiAssistant');

CREATE TABLE engagement.chat_messages (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id      UUID NOT NULL REFERENCES engagement.chat_sessions(id),
    sender          engagement.message_sender NOT NULL,
    content         TEXT NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


--=======================================================================================
-- Version 2.0: 15/11/25 - Patient Identifiers and Insurances
--=======================================================================================

CREATE TABLE IF NOT EXISTS identity.patient_identifiers (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id       UUID NOT NULL REFERENCES identity.patients(id) ON DELETE CASCADE,
  id_type          VARCHAR(30) NOT NULL,            -- 'NationalId' | 'Passport' | 'Other'
  id_number        VARCHAR(64) NOT NULL,
  issuer_country   VARCHAR(2),                      -- ISO country code (e.g., 'AE','IN')
  issue_date       DATE,
  expiry_date      DATE,
  notes            TEXT,
  record_id        UUID REFERENCES vault.records(id) ON DELETE SET NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT uq_patient_identifier UNIQUE (patient_id, id_type, id_number)
);

CREATE INDEX IF NOT EXISTS idx_patient_identifiers_patient
  ON identity.patient_identifiers (patient_id);

CREATE INDEX IF NOT EXISTS idx_patient_identifiers_type
  ON identity.patient_identifiers (id_type);


CREATE TABLE IF NOT EXISTS identity.patient_insurances (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id       UUID NOT NULL REFERENCES identity.patients(id) ON DELETE CASCADE,
  insurer_name     VARCHAR(150) NOT NULL,          -- e.g. 'AXA Gulf'
  policy_number    VARCHAR(64)  NOT NULL,
  member_id        VARCHAR(64),                    -- optional member ID
  plan_name        VARCHAR(150),                   -- e.g. 'Gold', 'PPO-Plus'
  insurer_country  VARCHAR(2),                     -- ISO country code
  issue_date       DATE,
  expiry_date      DATE,
  is_active        BOOLEAN NOT NULL DEFAULT TRUE,
  record_id        UUID REFERENCES vault.records(id) ON DELETE SET NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT uq_patient_policy UNIQUE (patient_id, policy_number)
);

CREATE INDEX IF NOT EXISTS idx_patient_insurances_patient
  ON identity.patient_insurances (patient_id);

CREATE INDEX IF NOT EXISTS idx_patient_insurances_active
  ON identity.patient_insurances (is_active);




