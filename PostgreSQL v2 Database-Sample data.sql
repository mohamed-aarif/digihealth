-- ============================================================
-- SEED DATA FOR DIGIHEALTH
-- - Configuration (master) tables
-- - 10 Patients, 10 Doctors, 10 Family users
-- - Sample data for all other tables
-- ============================================================

-- Single demo tenant id used everywhere (ABP tenants live elsewhere)
-- You don't insert this anywhere here; we just reuse the literal.
-- 00000000-0000-0000-0000-000000000001

-- ============================================================
-- 1. CONFIGURATION MASTER DATA
-- ============================================================

-- APPOINTMENT STATUSES
INSERT INTO configuration.appointment_statuses (code, name, description, sort_order)
VALUES 
  ('REQUESTED', 'Requested', 'Patient requested an appointment', 1),
  ('CONFIRMED', 'Confirmed', 'Doctor/clinic confirmed the appointment', 2),
  ('COMPLETED', 'Completed', 'Appointment completed', 3),
  ('CANCELLED', 'Cancelled', 'Appointment cancelled', 4),
  ('NO_SHOW', 'No Show', 'Patient did not attend', 5)
ON CONFLICT (code) DO NOTHING;

-- APPOINTMENT CHANNELS
INSERT INTO configuration.appointment_channels (code, name, description, sort_order)
VALUES
  ('IN_PERSON', 'In-person', 'Appointment at physical clinic', 1),
  ('VIDEO', 'Video', 'Video consultation', 2),
  ('PHONE', 'Phone', 'Phone consultation', 3)
ON CONFLICT (code) DO NOTHING;

-- DAYS OF WEEK
INSERT INTO configuration.days_of_week (code, name, description, sort_order)
VALUES
  ('SUNDAY', 'Sunday', NULL, 1),
  ('MONDAY', 'Monday', NULL, 2),
  ('TUESDAY', 'Tuesday', NULL, 3),
  ('WEDNESDAY', 'Wednesday', NULL, 4),
  ('THURSDAY', 'Thursday', NULL, 5),
  ('FRIDAY', 'Friday', NULL, 6),
  ('SATURDAY', 'Saturday', NULL, 7)
ON CONFLICT (code) DO NOTHING;

-- MEDICATION INTAKE STATUSES
INSERT INTO configuration.medication_intake_statuses (code, name, description, sort_order)
VALUES
  ('PENDING', 'Pending', 'Not yet taken', 1),
  ('TAKEN', 'Taken', 'Dose taken as scheduled', 2),
  ('SKIPPED', 'Skipped', 'Dose skipped', 3)
ON CONFLICT (code) DO NOTHING;

-- CONSENT PARTY TYPES
INSERT INTO configuration.consent_party_types (code, name, description, sort_order)
VALUES
  ('DOCTOR', 'Doctor', 'Individual doctor', 1),
  ('ORGANIZATION', 'Organization', 'Healthcare organization', 2),
  ('FAMILY', 'Family', 'Family member / caregiver', 3)
ON CONFLICT (code) DO NOTHING;

-- CONSENT STATUSES
INSERT INTO configuration.consent_statuses (code, name, description, sort_order)
VALUES
  ('ACTIVE', 'Active', 'Consent currently active', 1),
  ('REVOKED', 'Revoked', 'Consent revoked by patient', 2),
  ('EXPIRED', 'Expired', 'Consent expired at end date', 3)
ON CONFLICT (code) DO NOTHING;

-- DEVICE TYPES
INSERT INTO configuration.device_types (code, name, description, sort_order)
VALUES
  ('BLOOD_PRESSURE_MONITOR', 'Blood Pressure Monitor', 'BP Monitor', 1),
  ('GLUCOMETER', 'Glucometer', 'Blood glucose meter', 2),
  ('WEIGHING_SCALE', 'Weighing Scale', 'Body weight scale', 3),
  ('GENERIC', 'Generic Device', 'Other device type', 4)
ON CONFLICT (code) DO NOTHING;

-- NOTIFICATION CHANNELS
INSERT INTO configuration.notification_channels (code, name, description, sort_order)
VALUES
  ('EMAIL', 'Email', 'Email notification', 1),
  ('SMS', 'SMS', 'Text message notification', 2),
  ('PUSH', 'Push', 'Mobile push notification', 3),
  ('IN_APP', 'In-app', 'In-app notification', 4)
ON CONFLICT (code) DO NOTHING;

-- NOTIFICATION STATUSES
INSERT INTO configuration.notification_statuses (code, name, description, sort_order)
VALUES
  ('PENDING', 'Pending', 'Queued for sending', 1),
  ('SENT', 'Sent', 'Successfully sent', 2),
  ('FAILED', 'Failed', 'Failed to send', 3)
ON CONFLICT (code) DO NOTHING;

-- VAULT RECORD TYPES
INSERT INTO configuration.vault_record_types (code, name, description, sort_order)
VALUES
  ('NATIONAL_ID', 'National ID', 'Generic national identification number', 1),
  ('EMIRATES_ID', 'Emirates ID', 'UAE Emirates ID card', 2),
  ('PASSPORT', 'Passport', 'Passport document', 3),
  ('INSURANCE', 'Health Insurance', 'Health insurance policy', 4),
  ('MEDICAL_REPORT', 'Medical Report', 'Medical report or discharge summary', 5),
  ('OTHER', 'Other', 'Other document type', 99)
ON CONFLICT (code) DO NOTHING;

-- ============================================================
-- 2. IDENTITY SERVICE SEED
--    10 Patients, 10 Doctors, 10 Family users
-- ============================================================

-- For simplicity: we assign a single tenant to all:
-- tenant_id = '00000000-0000-0000-0000-000000000001'

-- ---------- USERS (Patients 1–10) ----------
INSERT INTO identity.users (id, tenant_id, user_name, email, salutation, profile_photo_url, name, surname, is_active)
VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'patient1', 'patient1@digihealth.test', 'Mr', NULL, 'Ahmed', 'Khan', TRUE),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'patient2', 'patient2@digihealth.test', 'Ms', NULL, 'Sara', 'Ali', TRUE),
  ('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'patient3', 'patient3@digihealth.test', 'Mr', NULL, 'Fahad', 'Hassan', TRUE),
  ('10000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', 'patient4', 'patient4@digihealth.test', 'Ms', NULL, 'Aisha', 'Noor', TRUE),
  ('10000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', 'patient5', 'patient5@digihealth.test', 'Mr', NULL, 'Omar', 'Saeed', TRUE),
  ('10000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'patient6', 'patient6@digihealth.test', 'Ms', NULL, 'Nadia', 'Rahman', TRUE),
  ('10000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', 'patient7', 'patient7@digihealth.test', 'Mr', NULL, 'Yusuf', 'Saleh', TRUE),
  ('10000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', 'patient8', 'patient8@digihealth.test', 'Ms', NULL, 'Mariam', 'Tariq', TRUE),
  ('10000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', 'patient9', 'patient9@digihealth.test', 'Mr', NULL, 'Khalid', 'Jaber', TRUE),
  ('10000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', 'patient10', 'patient10@digihealth.test', 'Ms', NULL, 'Layla', 'Farooq', TRUE);

-- ---------- USERS (Doctors 1–10) ----------
INSERT INTO identity.users (id, tenant_id, user_name, email, salutation, profile_photo_url, name, surname, is_active)
VALUES
  ('20000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'doctor1', 'doctor1@digihealth.test', 'Dr', NULL, 'Hassan', 'Mahmood', TRUE),
  ('20000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'doctor2', 'doctor2@digihealth.test', 'Dr', NULL, 'Reema', 'Sadiq', TRUE),
  ('20000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'doctor3', 'doctor3@digihealth.test', 'Dr', NULL, 'Imran', 'Qureshi', TRUE),
  ('20000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', 'doctor4', 'doctor4@digihealth.test', 'Dr', NULL, 'Fatima', 'Karim', TRUE),
  ('20000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', 'doctor5', 'doctor5@digihealth.test', 'Dr', NULL, 'Bilal', 'Zahid', TRUE),
  ('20000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'doctor6', 'doctor6@digihealth.test', 'Dr', NULL, 'Noora', 'Syed', TRUE),
  ('20000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', 'doctor7', 'doctor7@digihealth.test', 'Dr', NULL, 'Adnan', 'Yasin', TRUE),
  ('20000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', 'doctor8', 'doctor8@digihealth.test', 'Dr', NULL, 'Hiba', 'Mansoor', TRUE),
  ('20000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', 'doctor9', 'doctor9@digihealth.test', 'Dr', NULL, 'Zaid', 'Latif', TRUE),
  ('20000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', 'doctor10', 'doctor10@digihealth.test', 'Dr', NULL, 'Maha', 'Akram', TRUE);

-- ---------- USERS (Family 1–10) ----------
-- These are "family link" accounts (no patient/doctor row)
INSERT INTO identity.users (id, tenant_id, user_name, email, salutation, profile_photo_url, name, surname, is_active)
VALUES
  ('30000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'family1', 'family1@digihealth.test', 'Mr', NULL, 'Ali', 'Kareem', TRUE),
  ('30000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'family2', 'family2@digihealth.test', 'Ms', NULL, 'Samira', 'Aziz', TRUE),
  ('30000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'family3', 'family3@digihealth.test', 'Mr', NULL, 'Kareem', 'Nasser', TRUE),
  ('30000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', 'family4', 'family4@digihealth.test', 'Ms', NULL, 'Huda', 'Latifa', TRUE),
  ('30000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', 'family5', 'family5@digihealth.test', 'Mr', NULL, 'Rashid', 'Faruqi', TRUE),
  ('30000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'family6', 'family6@digihealth.test', 'Ms', NULL, 'Dina', 'Sajjad', TRUE),
  ('30000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', 'family7', 'family7@digihealth.test', 'Mr', NULL, 'Jamil', 'Habib', TRUE),
  ('30000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', 'family8', 'family8@digihealth.test', 'Ms', NULL, 'Sahar', 'Majeed', TRUE),
  ('30000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', 'family9', 'family9@digihealth.test', 'Mr', NULL, 'Nabil', 'Anwar', TRUE),
  ('30000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', 'family10', 'family10@digihealth.test', 'Ms', NULL, 'Rania', 'Hamdani', TRUE);

-- ---------- DOCTORS TABLE (10) ----------
INSERT INTO identity.doctors (id, tenant_id, user_id, salutation, gender, specialization, registration_number)
VALUES
  ('21000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 'Dr', 'Male',   'Cardiology',        'DHA-CARD-001'),
  ('21000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002', 'Dr', 'Female', 'Dermatology',       'DHA-DERM-002'),
  ('21000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000003', 'Dr', 'Male',   'Orthopedics',       'DHA-ORTH-003'),
  ('21000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000004', 'Dr', 'Female', 'Pediatrics',        'DHA-PED-004'),
  ('21000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000005', 'Dr', 'Male',   'Internal Medicine', 'DHA-INT-005'),
  ('21000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000006', 'Dr', 'Female', 'Endocrinology',     'DHA-ENDO-006'),
  ('21000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000007', 'Dr', 'Male',   'Neurology',         'DHA-NEURO-007'),
  ('21000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000008', 'Dr', 'Female', 'Gynecology',        'DHA-GYN-008'),
  ('21000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000009', 'Dr', 'Male',   'Psychiatry',        'DHA-PSY-009'),
  ('21000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000010', 'Dr', 'Female', 'Ophthalmology',     'DHA-OPH-010');

-- ---------- PATIENTS TABLE (10) ----------
INSERT INTO identity.patients (id, tenant_id, user_id, salutation, date_of_birth, gender, residence_country)
VALUES
  ('11000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'Mr', '1985-01-15', 'Male',   'UAE'),
  ('11000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000002', 'Ms', '1990-03-22', 'Female', 'UAE'),
  ('11000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000003', 'Mr', '1978-07-09', 'Male',   'UAE'),
  ('11000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000004', 'Ms', '2000-11-30', 'Female', 'UAE'),
  ('11000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000005', 'Mr', '1995-05-05', 'Male',   'UAE'),
  ('11000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000006', 'Ms', '1988-09-19', 'Female', 'UAE'),
  ('11000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000007', 'Mr', '1972-02-14', 'Male',   'UAE'),
  ('11000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000008', 'Ms', '1999-06-25', 'Female', 'UAE'),
  ('11000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000009', 'Mr', '1982-12-03', 'Male',   'UAE'),
  ('11000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000010', 'Ms', '1993-08-17', 'Female', 'UAE');

-- ============================================================
-- 3. PATIENT SERVICE SEED
-- ============================================================

-- PROFILE EXTENSIONS FOR 10 PATIENTS
INSERT INTO patient.patient_profile_extensions (
  id, tenant_id, identity_patient_id,
  primary_contact_number, secondary_contact_number,
  email, address_line1, address_line2, city, state, zipcode, country,
  emergency_contact_name, emergency_contact_number, preferred_language
)
VALUES
  ('12000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000001',
   '+971500000001', NULL, 'patient1@digihealth.test', 'Flat 101', 'Tower A', 'Dubai', 'Dubai', '00001', 'UAE',
   'Ali Khan', '+971500100001', 'English'),
  ('12000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000002',
   '+971500000002', NULL, 'patient2@digihealth.test', 'Flat 202', 'Tower B', 'Dubai', 'Dubai', '00002', 'UAE',
   'Sara Noor', '+971500100002', 'Arabic'),
  ('12000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000003',
   '+971500000003', NULL, 'patient3@digihealth.test', 'Villa 3', NULL, 'Sharjah', 'Sharjah', '00003', 'UAE',
   'Fahad Sr', '+971500100003', 'English'),
  ('12000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000004',
   '+971500000004', NULL, 'patient4@digihealth.test', 'Flat 404', 'Tower C', 'Dubai', 'Dubai', '00004', 'UAE',
   'Aisha Sr', '+971500100004', 'English'),
  ('12000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000005',
   '+971500000005', NULL, 'patient5@digihealth.test', 'Flat 505', 'Tower D', 'Abu Dhabi', 'Abu Dhabi', '00005', 'UAE',
   'Omar Sr', '+971500100005', 'Arabic'),
  ('12000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000006',
   '+971500000006', NULL, 'patient6@digihealth.test', 'Flat 606', 'Tower E', 'Dubai', 'Dubai', '00006', 'UAE',
   'Nadia Sr', '+971500100006', 'English'),
  ('12000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000007',
   '+971500000007', NULL, 'patient7@digihealth.test', 'Villa 7', NULL, 'Dubai', 'Dubai', '00007', 'UAE',
   'Yusuf Sr', '+971500100007', 'Arabic'),
  ('12000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000008',
   '+971500000008', NULL, 'patient8@digihealth.test', 'Flat 808', 'Tower F', 'Sharjah', 'Sharjah', '00008', 'UAE',
   'Mariam Sr', '+971500100008', 'English'),
  ('12000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000009',
   '+971500000009', NULL, 'patient9@digihealth.test', 'Flat 909', 'Tower G', 'Dubai', 'Dubai', '00009', 'UAE',
   'Khalid Sr', '+971500100009', 'Arabic'),
  ('12000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000010',
   '+971500000010', NULL, 'patient10@digihealth.test', 'Flat 1010', 'Tower H', 'Abu Dhabi', 'Abu Dhabi', '00010', 'UAE',
   'Layla Sr', '+971500100010', 'English');

-- MEDICAL SUMMARIES (for 5 patients as sample)
INSERT INTO patient.patient_medical_summaries (
  id, tenant_id, identity_patient_id, blood_group, allergies, chronic_conditions, notes
)
VALUES
  ('13000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000001',
   'A+', 'Penicillin', 'Hypertension', 'On regular follow-up'),
  ('13000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000002',
   'B+', 'None', 'Asthma', 'Uses inhaler daily'),
  ('13000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000003',
   'O-', 'Seafood', 'Diabetes', 'On insulin'),
  ('13000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000004',
   'AB+', 'Dust', 'None', 'Healthy'),
  ('13000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000005',
   'A-', 'None', 'Hyperlipidemia', 'On statins');

-- EXTERNAL LINKS (for 3 patients)
INSERT INTO patient.patient_external_links (
  id, tenant_id, identity_patient_id, system_name, external_reference
)
VALUES
  ('14000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000001', 'HospitalEMR', 'HOSP-001'),
  ('14000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000002', 'Insurance', 'AXA-123456'),
  ('14000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000003', 'HospitalEMR', 'HOSP-003');

-- ============================================================
-- 4. APPOINTMENT SERVICE SEED
-- ============================================================

-- SAMPLE DOCTOR SCHEDULE RULES (for first 3 doctors)
INSERT INTO appointment.doctor_schedule_rules (
  id, tenant_id, identity_doctor_id, day_of_week_id,
  start_time_of_day, end_time_of_day, slot_duration_minutes
)
VALUES
  ('22000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '21000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.days_of_week WHERE code = 'SUNDAY'),
   '09:00:00'::interval, '13:00:00'::interval, 30),
  ('22000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '21000000-0000-0000-0000-000000000002',
   (SELECT id FROM configuration.days_of_week WHERE code = 'MONDAY'),
   '10:00:00'::interval, '14:00:00'::interval, 30),
  ('22000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   '21000000-0000-0000-0000-000000000003',
   (SELECT id FROM configuration.days_of_week WHERE code = 'TUESDAY'),
   '16:00:00'::interval, '20:00:00'::interval, 20);

-- SAMPLE APPOINTMENTS (10)
INSERT INTO appointment.appointments (
  id, tenant_id, identity_patient_id, identity_doctor_id,
  start_time, end_time, status_id, channel_id, reason, notes
)
VALUES
  ('23000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '21000000-0000-0000-0000-000000000001',
   '2025-01-10 09:00:00+00', '2025-01-10 09:30:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CONFIRMED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'IN_PERSON'),
   'Chest pain', 'First consultation'),
  ('23000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000002', '21000000-0000-0000-0000-000000000002',
   '2025-01-11 10:00:00+00', '2025-01-11 10:30:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'REQUESTED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'VIDEO'),
   'Skin rash', 'Requested via app'),
  ('23000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000003', '21000000-0000-0000-0000-000000000003',
   '2025-01-12 16:00:00+00', '2025-01-12 16:20:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'COMPLETED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'IN_PERSON'),
   'Knee pain', 'Follow-up visit'),
  ('23000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000004', '21000000-0000-0000-0000-000000000004',
   '2025-01-13 09:30:00+00', '2025-01-13 10:00:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CANCELLED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'VIDEO'),
   'Fever', 'Cancelled by patient'),
  ('23000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000005', '21000000-0000-0000-0000-000000000005',
   '2025-01-14 11:00:00+00', '2025-01-14 11:30:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CONFIRMED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'PHONE'),
   'Routine checkup', NULL),
  ('23000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000006', '21000000-0000-0000-0000-000000000006',
   '2025-01-15 12:00:00+00', '2025-01-15 12:30:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'REQUESTED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'IN_PERSON'),
   'Thyroid follow-up', NULL),
  ('23000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000007', '21000000-0000-0000-0000-000000000007',
   '2025-01-16 09:00:00+00', '2025-01-16 09:30:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'NO_SHOW'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'IN_PERSON'),
   'Migraine', 'Patient did not show'),
  ('23000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000008', '21000000-0000-0000-0000-000000000008',
   '2025-01-17 13:00:00+00', '2025-01-17 13:30:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CONFIRMED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'VIDEO'),
   'Antenatal visit', NULL),
  ('23000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000009', '21000000-0000-0000-0000-000000000009',
   '2025-01-18 10:00:00+00', '2025-01-18 10:45:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'COMPLETED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'IN_PERSON'),
   'Anxiety', 'Therapy session'),
  ('23000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000010', '21000000-0000-0000-0000-000000000010',
   '2025-01-19 15:00:00+00', '2025-01-19 15:30:00+00',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CONFIRMED'),
   (SELECT id FROM configuration.appointment_channels  WHERE code = 'IN_PERSON'),
   'Eye checkup', NULL);

-- SAMPLE APPOINTMENT AUDITS (for 2 appointments)
INSERT INTO appointment.appointment_audits (
  id, appointment_id, changed_by_user_id, old_status_id, new_status_id, comment
)
VALUES
  ('24000000-0000-0000-0000-000000000001',
   '23000000-0000-0000-0000-000000000001',
   '20000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'REQUESTED'),
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CONFIRMED'),
   'Doctor confirmed appointment'),
  ('24000000-0000-0000-0000-000000000002',
   '23000000-0000-0000-0000-000000000004',
   '10000000-0000-0000-0000-000000000004',
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CONFIRMED'),
   (SELECT id FROM configuration.appointment_statuses WHERE code = 'CANCELLED'),
   'Patient cancelled via app');

-- ============================================================
-- 5. MEDICATION SERVICE SEED
-- ============================================================

-- PRESCRIPTIONS (for first 3 patients)
INSERT INTO medication.prescriptions (
  id, tenant_id, identity_patient_id, identity_doctor_id, diagnosis_summary, notes
)
VALUES
  ('25000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '21000000-0000-0000-0000-000000000001',
   'Hypertension', 'Start antihypertensive therapy'),
  ('25000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000002', '21000000-0000-0000-0000-000000000005',
   'Diabetes mellitus type 2', 'Oral hypoglycemics'),
  ('25000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000003', '21000000-0000-0000-0000-000000000003',
   'Osteoarthritis', 'Pain management');

-- PRESCRIPTION ITEMS
INSERT INTO medication.prescription_items (
  id, tenant_id, prescription_id, drug_name, strength, dosage_instructions, start_date, end_date, frequency_per_day
)
VALUES
  ('26000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '25000000-0000-0000-0000-000000000001', 'Amlodipine', '5 mg', 'Once daily in the morning', '2025-01-01', '2025-03-31', 1),
  ('26000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '25000000-0000-0000-0000-000000000002', 'Metformin', '500 mg', 'Twice daily with meals', '2025-01-01', '2025-06-30', 2),
  ('26000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   '25000000-0000-0000-0000-000000000003', 'Ibuprofen', '400 mg', 'As needed up to three times daily', '2025-01-01', '2025-02-28', 3);

-- MEDICATION SCHEDULES (1 per item as sample)
INSERT INTO medication.medication_schedules (
  id, tenant_id, identity_patient_id, prescription_item_id, time_of_day
)
VALUES
  ('27000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '26000000-0000-0000-0000-000000000001', '08:00:00'::interval),
  ('27000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000002', '26000000-0000-0000-0000-000000000002', '08:00:00'::interval),
  ('27000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000002', '26000000-0000-0000-0000-000000000002', '20:00:00'::interval);

-- MEDICATION INTAKE LOGS (sample)
INSERT INTO medication.medication_intake_logs (
  id, tenant_id, identity_patient_id, prescription_item_id,
  scheduled_time, taken_time, status_id, notes
)
VALUES
  ('28000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '26000000-0000-0000-0000-000000000001',
   '2025-01-10 08:00:00+00', '2025-01-10 08:05:00+00',
   (SELECT id FROM configuration.medication_intake_statuses WHERE code = 'TAKEN'),
   'Taken on time'),
  ('28000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '26000000-0000-0000-0000-000000000001',
   '2025-01-11 08:00:00+00', NULL,
   (SELECT id FROM configuration.medication_intake_statuses WHERE code = 'PENDING'),
   'Not yet taken'),
  ('28000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000002', '26000000-0000-0000-0000-000000000002',
   '2025-01-10 08:00:00+00', '2025-01-10 08:20:00+00',
   (SELECT id FROM configuration.medication_intake_statuses WHERE code = 'TAKEN'),
   'Taken with breakfast');

-- ============================================================
-- 6. CONSENT SERVICE SEED
-- ============================================================

-- CONSENTS (linking patients to doctors and family)
INSERT INTO consent.consents (
  id, tenant_id, identity_patient_id,
  granted_to_party_type_id, granted_to_party_id,
  data_scope, purpose_of_use, granted_at, expires_at, status_id
)
VALUES
  ('29000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.consent_party_types WHERE code = 'DOCTOR'),
   '21000000-0000-0000-0000-000000000001',
   'Vitals,Medication,Appointments', 'Ongoing cardiac care',
   '2025-01-01 09:00:00+00', '2025-12-31 23:59:59+00',
   (SELECT id FROM configuration.consent_statuses WHERE code = 'ACTIVE')),
  ('29000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.consent_party_types WHERE code = 'FAMILY'),
   '30000000-0000-0000-0000-000000000001',
   'Vitals,Medication', 'Caregiver access for reminders',
   '2025-01-01 09:00:00+00', NULL,
   (SELECT id FROM configuration.consent_statuses WHERE code = 'ACTIVE'));

INSERT INTO consent.consent_audits (
  id, consent_id, action, performed_by_user_id, details
)
VALUES
  ('29100000-0000-0000-0000-000000000001',
   '29000000-0000-0000-0000-000000000001',
   'Created', '10000000-0000-0000-0000-000000000001',
   'Patient created consent for primary cardiologist'),
  ('29100000-0000-0000-0000-000000000002',
   '29000000-0000-0000-0000-000000000002',
   'Created', '10000000-0000-0000-0000-000000000001',
   'Patient granted consent to family caregiver');

-- ============================================================
-- 7. DEVICE SERVICE SEED
-- ============================================================

-- DEVICES (2 devices for patient1)
INSERT INTO device.devices (
  id, tenant_id, device_serial, device_type_id, manufacturer, model,
  assigned_patient_id, assigned_at, is_active
)
VALUES
  ('30000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   'BP-DEV-0001',
   (SELECT id FROM configuration.device_types WHERE code = 'BLOOD_PRESSURE_MONITOR'),
   'Omron', 'M3',
   '11000000-0000-0000-0000-000000000001', '2025-01-01 08:00:00+00', TRUE),
  ('30000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   'GLU-DEV-0001',
   (SELECT id FROM configuration.device_types WHERE code = 'GLUCOMETER'),
   'Accu-Chek', 'Guide',
   '11000000-0000-0000-0000-000000000002', '2025-01-01 08:00:00+00', TRUE);

-- DEVICE READINGS
INSERT INTO device.device_readings (
  id, tenant_id, device_id, identity_patient_id,
  reading_time, reading_type, value1, value2, unit, raw_payload
)
VALUES
  ('31000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '30000000-0000-0000-0000-000000000001', '11000000-0000-0000-0000-000000000001',
   '2025-01-10 07:30:00+00', 'BP', 130, 85, 'mmHg',
   '{"systolic":130,"diastolic":85,"pulse":78}'),
  ('31000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '30000000-0000-0000-0000-000000000002', '11000000-0000-0000-0000-000000000002',
   '2025-01-10 07:45:00+00', 'GLUCOSE', 7.8, NULL, 'mmol/L',
   '{"glucose":7.8,"fasting":true}');

-- ============================================================
-- 8. ENGAGEMENT SERVICE SEED
-- ============================================================

-- NOTIFICATION TEMPLATES
INSERT INTO engagement.notification_templates (
  id, tenant_id, template_key, channel_id, subject_template, body_template, is_active
)
VALUES
  ('32000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   'AppointmentConfirmed',
   (SELECT id FROM configuration.notification_channels WHERE code = 'EMAIL'),
   'Your appointment is confirmed',
   'Dear {{PatientName}}, your appointment with {{DoctorName}} on {{AppointmentDate}} is confirmed.', TRUE),
  ('32000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   'MedicationReminder',
   (SELECT id FROM configuration.notification_channels WHERE code = 'SMS'),
   NULL,
   'Reminder: Please take your {{DrugName}} dose scheduled at {{Time}}.', TRUE),
  ('32000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   'CriticalDeviceReading',
   (SELECT id FROM configuration.notification_channels WHERE code = 'IN_APP'),
   NULL,
   'Alert: A critical {{ReadingType}} reading was received for {{PatientName}}.', TRUE);

-- NOTIFICATIONS (sample rows)
INSERT INTO engagement.notifications (
  id, tenant_id, recipient_user_id, channel_id,
  template_key, payload_json, created_at, sent_at, status_id, error_message
)
VALUES
  ('33000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '10000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.notification_channels WHERE code = 'EMAIL'),
   'AppointmentConfirmed',
   '{"PatientName":"Ahmed Khan","DoctorName":"Dr Hassan Mahmood","AppointmentDate":"2025-01-10 09:00"}',
   '2025-01-08 10:00:00+00', '2025-01-08 10:00:05+00',
   (SELECT id FROM configuration.notification_statuses WHERE code = 'SENT'),
   NULL),
  ('33000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '10000000-0000-0000-0000-000000000002',
   (SELECT id FROM configuration.notification_channels WHERE code = 'SMS'),
   'MedicationReminder',
   '{"DrugName":"Metformin","Time":"08:00"}',
   '2025-01-10 07:50:00+00', NULL,
   (SELECT id FROM configuration.notification_statuses WHERE code = 'PENDING'),
   NULL);

-- ============================================================
-- 9. VAULT SERVICE SEED
--    National IDs, Passports, Insurance (AXA Gulf, etc.)
-- ============================================================

-- EMIRATES ID & PASSPORT & INSURANCE FOR first 3 patients
INSERT INTO vault.vault_records (
  id, tenant_id, identity_patient_id, owner_user_id,
  record_type_id, title, metadata_json, issue_date, expiry_date,
  storage_location, is_encrypted, created_at, last_updated_at
)
VALUES
  -- Patient1 Emirates ID
  ('34000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.vault_record_types WHERE code = 'EMIRATES_ID'),
   'Emirates ID - Ahmed Khan',
   '{"idNumber":"784-1985-1234567-1","issuingCountry":"UAE","issuingAuthority":"ICA","documentType":"Emirates ID"}',
   '2021-01-01', '2031-01-01',
   NULL, TRUE, NOW(), NOW()),

  -- Patient1 Passport
  ('34000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.vault_record_types WHERE code = 'PASSPORT'),
   'Passport - Ahmed Khan',
   '{"passportNumber":"P1234567","issuingCountry":"IN","holderName":"Ahmed Khan"}',
   '2020-05-15', '2030-05-14',
   NULL, TRUE, NOW(), NOW()),

  -- Patient1 AXA Gulf Insurance
  ('34000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001',
   (SELECT id FROM configuration.vault_record_types WHERE code = 'INSURANCE'),
   'AXA Gulf Health Insurance',
   '{"insurerName":"AXA Gulf","policyNumber":"AXA-001","memberId":"M-0001","planName":"Silver Plus","network":"GN"}',
   '2024-01-01', '2024-12-31',
   NULL, FALSE, NOW(), NOW()),

  -- Patient2 Emirates ID
  ('34000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002',
   (SELECT id FROM configuration.vault_record_types WHERE code = 'EMIRATES_ID'),
   'Emirates ID - Sara Ali',
   '{"idNumber":"784-1990-2345678-2","issuingCountry":"UAE","issuingAuthority":"ICA","documentType":"Emirates ID"}',
   '2022-02-01', '2032-02-01',
   NULL, TRUE, NOW(), NOW()),

  -- Patient2 AXA Gulf Insurance
  ('34000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002',
   (SELECT id FROM configuration.vault_record_types WHERE code = 'INSURANCE'),
   'AXA Gulf Health Insurance',
   '{"insurerName":"AXA Gulf","policyNumber":"AXA-002","memberId":"M-0002","planName":"Gold","network":"GN Plus"}',
   '2024-01-01', '2024-12-31',
   NULL, FALSE, NOW(), NOW()),

  -- Patient3 National ID (generic) + local insurer
  ('34000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000003',
   (SELECT id FROM configuration.vault_record_types WHERE code = 'NATIONAL_ID'),
   'National ID - Fahad Hassan',
   '{"idNumber":"NID-123456789","issuingCountry":"PK"}',
   '2018-06-01', '2028-06-01',
   NULL, TRUE, NOW(), NOW()),
  ('34000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001',
   '11000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000003',
   (SELECT id FROM configuration.vault_record_types WHERE code = 'INSURANCE'),
   'Local Health Insurance',
   '{"insurerName":"Daman","policyNumber":"DAM-1001","memberId":"M-1001"}',
   '2024-01-01', '2024-12-31',
   NULL, FALSE, NOW(), NOW());

-- ============================================================
-- END OF SEED SCRIPT
-- ============================================================
