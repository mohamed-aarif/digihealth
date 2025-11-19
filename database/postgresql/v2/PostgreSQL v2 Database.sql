-- ============================================================
--  DigiHealth – PostgreSQL DDL (Config tables instead of ENUMs)
--  ABP 9.x, Multi-tenancy via tenant_id UUID
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- 1. Schemas
-- ============================================================
CREATE SCHEMA IF NOT EXISTS identity;
CREATE SCHEMA IF NOT EXISTS patient;
CREATE SCHEMA IF NOT EXISTS appointment;
CREATE SCHEMA IF NOT EXISTS medication;
CREATE SCHEMA IF NOT EXISTS consent;
CREATE SCHEMA IF NOT EXISTS device;
CREATE SCHEMA IF NOT EXISTS engagement;
CREATE SCHEMA IF NOT EXISTS vault;
CREATE SCHEMA IF NOT EXISTS configuration;

-- ============================================================
-- 2. CONFIGURATION (MASTER DATA) SCHEMA
--    These replace the database ENUMs
-- ============================================================

-- Generic pattern:
-- id: PK
-- code: short machine-readable key (unique)
-- name: human-readable label
-- description: optional
-- sort_order: for UI ordering
-- is_active: soft activation

CREATE TABLE IF NOT EXISTS configuration.appointment_statuses (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- e.g. REQUESTED, CONFIRMED
    name        VARCHAR(128) NOT NULL,         -- e.g. "Requested"
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.appointment_channels (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- IN_PERSON, VIDEO, PHONE
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.days_of_week (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(32) NOT NULL UNIQUE,   -- MONDAY, TUESDAY, ...
    name        VARCHAR(64) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.medication_intake_statuses (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- PENDING, TAKEN, SKIPPED
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.consent_party_types (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- DOCTOR, ORGANIZATION, FAMILY
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.consent_statuses (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- ACTIVE, REVOKED, EXPIRED
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.device_types (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- BLOOD_PRESSURE_MONITOR, GLUCOMETER, ...
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.notification_channels (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- EMAIL, SMS, PUSH, IN_APP
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.notification_statuses (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- PENDING, SENT, FAILED
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS configuration.vault_record_types (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(64) NOT NULL UNIQUE,   -- NATIONAL_ID, PASSPORT, INSURANCE, MEDICAL_REPORT, OTHER
    name        VARCHAR(128) NOT NULL,
    description TEXT NULL,
    sort_order  INT NOT NULL DEFAULT 0,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

-- (Optional) You can seed some default rows later via ABP DataSeedContributor
-- instead of hardcoding INSERTs here, so Blazor Admin stays the single source of truth.

-- ============================================================
-- 3. IDENTITY SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS identity.users (
    id                  UUID PRIMARY KEY,
    tenant_id           UUID NULL,
    user_name           VARCHAR(256) NOT NULL,
    email               VARCHAR(256) NOT NULL,
    salutation          VARCHAR(32) NULL,
    profile_photo_url   TEXT NULL,
    name                VARCHAR(128) NULL,
    surname             VARCHAR(128) NULL,
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    creation_time       TIMESTAMPTZ NOT NULL DEFAULT NOW()
    -- Typically mapped to ABP's user with same id or FK to public.abp_users
);

CREATE INDEX IF NOT EXISTS ix_identity_users_tenant ON identity.users (tenant_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_identity_users_username_tenant
    ON identity.users (tenant_id, user_name);

CREATE TABLE IF NOT EXISTS identity.doctors (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    user_id             UUID NOT NULL,
    salutation          VARCHAR(32) NULL,
    gender              VARCHAR(16) NULL,
    specialization      VARCHAR(256) NULL,
    registration_number VARCHAR(128) NULL,
    creation_time       TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_identity_doctors_user
        FOREIGN KEY (user_id) REFERENCES identity.users (id)
);

CREATE INDEX IF NOT EXISTS ix_identity_doctors_tenant ON identity.doctors (tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_doctors_user_id ON identity.doctors (user_id);
CREATE INDEX IF NOT EXISTS ix_identity_doctors_specialization
    ON identity.doctors (specialization);

CREATE TABLE IF NOT EXISTS identity.patients (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    user_id             UUID NOT NULL,
    salutation          VARCHAR(32) NULL,
    date_of_birth       DATE NULL,
    gender              VARCHAR(16) NULL,
    residence_country   VARCHAR(128) NULL,
    creation_time       TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_identity_patients_user
        FOREIGN KEY (user_id) REFERENCES identity.users (id)
);

CREATE INDEX IF NOT EXISTS ix_identity_patients_tenant ON identity.patients (tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_patients_user_id ON identity.patients (user_id);
CREATE INDEX IF NOT EXISTS ix_identity_patients_dob ON identity.patients (date_of_birth);

-- ============================================================
-- 4. PATIENT SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS patient.patient_profile_extensions (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_patient_id     UUID NOT NULL,
    primary_contact_number  VARCHAR(32) NULL,
    secondary_contact_number VARCHAR(32) NULL,
    email                   VARCHAR(256) NULL,
    address_line1           VARCHAR(256) NULL,
    address_line2           VARCHAR(256) NULL,
    city                    VARCHAR(128) NULL,
    state                   VARCHAR(128) NULL,
    zipcode                 VARCHAR(32) NULL,
    country                 VARCHAR(128) NULL,
    emergency_contact_name  VARCHAR(256) NULL,
    emergency_contact_number VARCHAR(32) NULL,
    preferred_language      VARCHAR(64) NULL,
    creation_time           TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_patient_profile_ext_tenant
    ON patient.patient_profile_extensions (tenant_id);
CREATE INDEX IF NOT EXISTS ix_patient_profile_ext_identity_patient
    ON patient.patient_profile_extensions (identity_patient_id);

CREATE TABLE IF NOT EXISTS patient.patient_medical_summaries (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_patient_id     UUID NOT NULL,
    blood_group             VARCHAR(8) NULL,
    allergies               TEXT NULL,
    chronic_conditions      TEXT NULL,
    notes                   TEXT NULL,
    creation_time           TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_patient_med_summaries_tenant
    ON patient.patient_medical_summaries (tenant_id);
CREATE INDEX IF NOT EXISTS ix_patient_med_summaries_identity_patient
    ON patient.patient_medical_summaries (identity_patient_id);

CREATE TABLE IF NOT EXISTS patient.patient_external_links (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_patient_id     UUID NOT NULL,
    system_name             VARCHAR(128) NOT NULL,
    external_reference      VARCHAR(256) NOT NULL,
    creation_time           TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ix_patient_ext_links_tenant
    ON patient.patient_external_links (tenant_id);
CREATE INDEX IF NOT EXISTS ix_patient_ext_links_identity_patient
    ON patient.patient_external_links (identity_patient_id);
CREATE INDEX IF NOT EXISTS ix_patient_ext_links_system
    ON patient.patient_external_links (system_name);

-- ============================================================
-- 5. APPOINTMENT SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS appointment.appointments (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_patient_id     UUID NOT NULL,
    identity_doctor_id      UUID NOT NULL,
    start_time              TIMESTAMPTZ NOT NULL,
    end_time                TIMESTAMPTZ NOT NULL,
    status_id               UUID NOT NULL,  -- FK to configuration.appointment_statuses
    channel_id              UUID NOT NULL,  -- FK to configuration.appointment_channels
    reason                  VARCHAR(512) NULL,
    notes                   TEXT NULL,
    creation_time           TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_appointment_status
        FOREIGN KEY (status_id) REFERENCES configuration.appointment_statuses (id),
    CONSTRAINT fk_appointment_channel
        FOREIGN KEY (channel_id) REFERENCES configuration.appointment_channels (id)
);

CREATE INDEX IF NOT EXISTS ix_appointment_tenant_doctor_start
    ON appointment.appointments (tenant_id, identity_doctor_id, start_time);
CREATE INDEX IF NOT EXISTS ix_appointment_tenant_patient_start
    ON appointment.appointments (tenant_id, identity_patient_id, start_time);
CREATE INDEX IF NOT EXISTS ix_appointment_status_id
    ON appointment.appointments (status_id);

CREATE TABLE IF NOT EXISTS appointment.doctor_schedule_rules (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_doctor_id      UUID NOT NULL,
    day_of_week_id          UUID NOT NULL,        -- FK to configuration.days_of_week
    start_time_of_day       INTERVAL NOT NULL,    -- 'HH:MM:SS'::interval
    end_time_of_day         INTERVAL NOT NULL,
    slot_duration_minutes   INT NOT NULL,
    creation_time           TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_doc_schedule_day
        FOREIGN KEY (day_of_week_id) REFERENCES configuration.days_of_week (id)
);

CREATE INDEX IF NOT EXISTS ix_doc_schedule_tenant_doctor
    ON appointment.doctor_schedule_rules (tenant_id, identity_doctor_id);

CREATE TABLE IF NOT EXISTS appointment.appointment_audits (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    appointment_id          UUID NOT NULL,
    changed_by_user_id      UUID NOT NULL,
    old_status_id           UUID NULL,    -- nullable when created
    new_status_id           UUID NOT NULL,
    change_time             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    comment                 TEXT NULL,

    CONSTRAINT fk_appointment_audits_appointment
        FOREIGN KEY (appointment_id) REFERENCES appointment.appointments (id),
    CONSTRAINT fk_appointment_audits_old_status
        FOREIGN KEY (old_status_id) REFERENCES configuration.appointment_statuses (id),
    CONSTRAINT fk_appointment_audits_new_status
        FOREIGN KEY (new_status_id) REFERENCES configuration.appointment_statuses (id)
);

CREATE INDEX IF NOT EXISTS ix_appointment_audits_appointment
    ON appointment.appointment_audits (appointment_id);

-- ============================================================
-- 6. MEDICATION SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS medication.prescriptions (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    identity_patient_id UUID NOT NULL,
    identity_doctor_id  UUID NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    diagnosis_summary   TEXT NULL,
    notes               TEXT NULL
);

CREATE INDEX IF NOT EXISTS ix_prescriptions_tenant_patient
    ON medication.prescriptions (tenant_id, identity_patient_id, created_at DESC);
CREATE INDEX IF NOT EXISTS ix_prescriptions_tenant_doctor
    ON medication.prescriptions (tenant_id, identity_doctor_id, created_at DESC);

CREATE TABLE IF NOT EXISTS medication.prescription_items (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    prescription_id         UUID NOT NULL,
    drug_name               VARCHAR(256) NOT NULL,
    strength                VARCHAR(128) NULL,
    dosage_instructions     TEXT NULL,
    start_date              DATE NULL,
    end_date                DATE NULL,
    frequency_per_day       INT NULL,

    CONSTRAINT fk_prescription_items_prescription
        FOREIGN KEY (prescription_id) REFERENCES medication.prescriptions (id)
);

CREATE INDEX IF NOT EXISTS ix_prescription_items_prescription
    ON medication.prescription_items (prescription_id);

CREATE TABLE IF NOT EXISTS medication.medication_schedules (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_patient_id     UUID NOT NULL,
    prescription_item_id    UUID NOT NULL,
    time_of_day             INTERVAL NOT NULL, -- 'HH:MM:SS'::interval

    CONSTRAINT fk_med_schedules_item
        FOREIGN KEY (prescription_item_id) REFERENCES medication.prescription_items (id)
);

CREATE INDEX IF NOT EXISTS ix_med_schedules_patient
    ON medication.medication_schedules (identity_patient_id);

CREATE TABLE IF NOT EXISTS medication.medication_intake_logs (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_patient_id     UUID NOT NULL,
    prescription_item_id    UUID NOT NULL,
    scheduled_time          TIMESTAMPTZ NOT NULL,
    taken_time              TIMESTAMPTZ NULL,
    status_id               UUID NOT NULL,   -- FK to configuration.medication_intake_statuses
    notes                   TEXT NULL,
    creation_time           TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_med_intake_logs_item
        FOREIGN KEY (prescription_item_id) REFERENCES medication.prescription_items (id),
    CONSTRAINT fk_med_intake_status
        FOREIGN KEY (status_id) REFERENCES configuration.medication_intake_statuses (id)
);

CREATE INDEX IF NOT EXISTS ix_med_intake_patient_scheduled
    ON medication.medication_intake_logs (identity_patient_id, scheduled_time);
CREATE INDEX IF NOT EXISTS ix_med_intake_status_id
    ON medication.medication_intake_logs (status_id);

-- ============================================================
-- 7. CONSENT SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS consent.consents (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id               UUID NULL,
    identity_patient_id     UUID NOT NULL,
    granted_to_party_type_id UUID NOT NULL,  -- FK to configuration.consent_party_types
    granted_to_party_id     UUID NOT NULL,
    data_scope              VARCHAR(256) NOT NULL,
    purpose_of_use          TEXT NOT NULL,
    granted_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at              TIMESTAMPTZ NULL,
    status_id               UUID NOT NULL,  -- FK to configuration.consent_statuses

    CONSTRAINT fk_consents_party_type
        FOREIGN KEY (granted_to_party_type_id) REFERENCES configuration.consent_party_types (id),
    CONSTRAINT fk_consents_status
        FOREIGN KEY (status_id) REFERENCES configuration.consent_statuses (id)
);

CREATE INDEX IF NOT EXISTS ix_consents_patient
    ON consent.consents (identity_patient_id, status_id);
CREATE INDEX IF NOT EXISTS ix_consents_party
    ON consent.consents (granted_to_party_type_id, granted_to_party_id, status_id);
CREATE INDEX IF NOT EXISTS ix_consents_tenant
    ON consent.consents (tenant_id);

CREATE TABLE IF NOT EXISTS consent.consent_audits (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    consent_id              UUID NOT NULL,
    action                  VARCHAR(32) NOT NULL, -- Created/Updated/Revoked
    performed_by_user_id    UUID NOT NULL,
    action_time             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    details                 TEXT NULL,

    CONSTRAINT fk_consent_audits_consent
        FOREIGN KEY (consent_id) REFERENCES consent.consents (id)
);

CREATE INDEX IF NOT EXISTS ix_consent_audits_consent
    ON consent.consent_audits (consent_id);

-- ============================================================
-- 8. DEVICE SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS device.devices (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    device_serial       VARCHAR(128) NOT NULL,
    device_type_id      UUID NOT NULL,   -- FK to configuration.device_types
    manufacturer        VARCHAR(128) NULL,
    model               VARCHAR(128) NULL,
    assigned_patient_id UUID NULL,       -- IdentityPatientId
    assigned_at         TIMESTAMPTZ NULL,
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    creation_time       TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_devices_type
        FOREIGN KEY (device_type_id) REFERENCES configuration.device_types (id)
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_device_serial_tenant
    ON device.devices (tenant_id, device_serial);
CREATE INDEX IF NOT EXISTS ix_devices_assigned_patient
    ON device.devices (assigned_patient_id);

CREATE TABLE IF NOT EXISTS device.device_readings (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    device_id           UUID NOT NULL,
    identity_patient_id UUID NOT NULL,
    reading_time        TIMESTAMPTZ NOT NULL,
    reading_type        VARCHAR(64) NOT NULL,  -- BP, HR, SPO2, Weight, etc.
    value1              NUMERIC(18,4) NULL,
    value2              NUMERIC(18,4) NULL,
    unit                VARCHAR(32) NULL,
    raw_payload         TEXT NULL,

    CONSTRAINT fk_device_readings_device
        FOREIGN KEY (device_id) REFERENCES device.devices (id)
);

CREATE INDEX IF NOT EXISTS ix_device_readings_patient_time
    ON device.device_readings (identity_patient_id, reading_time);
CREATE INDEX IF NOT EXISTS ix_device_readings_device_time
    ON device.device_readings (device_id, reading_time);
CREATE INDEX IF NOT EXISTS ix_device_readings_type
    ON device.device_readings (reading_type);

-- ============================================================
-- 9. ENGAGEMENT SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS engagement.notification_templates (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    template_key        VARCHAR(128) NOT NULL,
    channel_id          UUID NOT NULL,   -- FK to configuration.notification_channels
    subject_template    VARCHAR(512) NULL,
    body_template       TEXT NOT NULL,
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    creation_time       TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_notif_templates_channel
        FOREIGN KEY (channel_id) REFERENCES configuration.notification_channels (id)
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_notification_templates_key_tenant_channel
    ON engagement.notification_templates (tenant_id, template_key, channel_id);

CREATE TABLE IF NOT EXISTS engagement.notifications (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    recipient_user_id   UUID NOT NULL,
    channel_id          UUID NOT NULL,   -- FK to configuration.notification_channels
    template_key        VARCHAR(128) NOT NULL,
    payload_json        TEXT NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    sent_at             TIMESTAMPTZ NULL,
    status_id           UUID NOT NULL,   -- FK to configuration.notification_statuses
    error_message       TEXT NULL,

    CONSTRAINT fk_notifications_channel
        FOREIGN KEY (channel_id) REFERENCES configuration.notification_channels (id),
    CONSTRAINT fk_notifications_status
        FOREIGN KEY (status_id) REFERENCES configuration.notification_statuses (id)
);

CREATE INDEX IF NOT EXISTS ix_notifications_recipient
    ON engagement.notifications (recipient_user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS ix_notifications_status_id
    ON engagement.notifications (status_id);

-- ============================================================
-- 10. VAULT SERVICE
-- ============================================================

CREATE TABLE IF NOT EXISTS vault.vault_records (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id           UUID NULL,
    identity_patient_id UUID NULL,
    owner_user_id       UUID NOT NULL,
    record_type_id      UUID NOT NULL,    -- FK to configuration.vault_record_types
    title               VARCHAR(256) NOT NULL,
    metadata_json       TEXT NULL,
    issue_date          DATE NULL,
    expiry_date         DATE NULL,
    storage_location    VARCHAR(512) NULL,
    is_encrypted        BOOLEAN NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_vault_record_type
        FOREIGN KEY (record_type_id) REFERENCES configuration.vault_record_types (id)
);

CREATE INDEX IF NOT EXISTS ix_vault_records_patient_type
    ON vault.vault_records (identity_patient_id, record_type_id);
CREATE INDEX IF NOT EXISTS ix_vault_records_expiry
    ON vault.vault_records (expiry_date);
CREATE INDEX IF NOT EXISTS ix_vault_records_owner
    ON vault.vault_records (owner_user_id);

-- ============================================================
-- END
-- ============================================================
