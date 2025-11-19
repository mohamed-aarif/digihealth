-- SAMPLE DATA

-- Users
INSERT INTO identity.users (id, user_name, email, password_hash, user_type)
VALUES
  ('00000000-0000-0000-0000-000000000001', 'john', 'john@example.com', 'HASHED_PW_1', 'Patient'),
  ('00000000-0000-0000-0000-000000000002', 'drsara', 'sara@example.com', 'HASHED_PW_2', 'Doctor'),
  ('00000000-0000-0000-0000-000000000003', 'mom', 'mom@example.com', 'HASHED_PW_3', 'Family');

-- Patient
INSERT INTO identity.patients (id, user_id, full_name, date_of_birth, gender, country, mobile_number, healthvault_id)
VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001',
   'John Doe', '1990-05-10', 'Male', 'UAE', '+971500000001', 'JHN-12345');

-- Doctor
INSERT INTO identity.doctors (id, user_id, full_name, specialty, registration_no, clinic_name)
VALUES
  ('20000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002',
   'Dr. Sara Khan', 'Cardiology', 'DHA-123456', 'HeartCare Clinic');

-- Family link
INSERT INTO identity.family_links (patient_id, family_user_id, relationship, is_guardian)
VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003', 'Mother', TRUE);

-- Record
INSERT INTO vault.records (id, patient_id, record_type, title, description, file_storage_key, sensitivity, source)
VALUES
  ('30000000-0000-0000-0000-000000000001',
   '10000000-0000-0000-0000-000000000001',
   'Report',
   'Blood Test - April 2025',
   'Standard fasting blood test',
   'blob://records/john/bloodtest_apr2025.pdf',
   'Restricted',
   'Upload');

-- Appointment
INSERT INTO appointments.appointments (id, patient_id, doctor_id, scheduled_at, status, reason, location)
VALUES
  ('40000000-0000-0000-0000-000000000001',
   '10000000-0000-0000-0000-000000000001',
   '20000000-0000-0000-0000-000000000001',
   '2025-11-20T09:00:00+04',
   'Planned',
   'Follow-up on blood test',
   'HeartCare Clinic, Dubai');

-- Prescription & medication
INSERT INTO medication.prescriptions (id, patient_id, doctor_id, record_id, issued_on, notes)
VALUES
  ('50000000-0000-0000-0000-000000000001',
   '10000000-0000-0000-0000-000000000001',
   '20000000-0000-0000-0000-000000000001',
   '30000000-0000-0000-0000-000000000001',
   '2025-11-01',
   'Start cholesterol medication');

INSERT INTO medication.medication_items (id, prescription_id, name, dosage, frequency, route, duration_days, instructions)
VALUES
  ('50000000-0000-0000-0000-000000000002',
   '50000000-0000-0000-0000-000000000001',
   'Atorvastatin', '10mg', 'Once daily', 'Oral', 90,
   'Take at night after food');

INSERT INTO medication.medication_schedules (id, medication_item_id, start_date, end_date, times_in_day)
VALUES
  ('50000000-0000-0000-0000-000000000003',
   '50000000-0000-0000-0000-000000000002',
   '2025-11-01', '2026-01-30', '["22:00"]'::jsonb);


--=======================================================================================
-- Version 2.0: 15/11/25 - Patient Identifiers and Insurances
--=======================================================================================

-- USERS: set a photo key
UPDATE identity.users
SET photo_storage_key = 'blob://users/00000000-0000-0000-0000-000000000001/avatar.jpg'
WHERE id = '00000000-0000-0000-0000-000000000001';  -- john

-- PATIENTS: set salutation & residence
UPDATE identity.patients
SET salutation = 'Mr',
    residence_country = 'AE'
WHERE id = '10000000-0000-0000-0000-000000000001';  -- John Doe

-- DOCTORS: set salutation & gender
UPDATE identity.doctors
SET salutation = 'Dr',
    gender = 'Female'
WHERE id = '20000000-0000-0000-0000-000000000001';  -- Dr. Sara Khan

-- IDENTITY DOCS: add National ID + Passport for John
INSERT INTO identity.patient_identifiers
  (patient_id, id_type, id_number, issuer_country, issue_date, expiry_date, notes)
VALUES
  ('10000000-0000-0000-0000-000000000001','Passport','N12345678','US','2018-06-15','2028-06-14','US Passport');

-- Emirates ID document in vault.records
INSERT INTO vault.records
  (id, patient_id, record_type, title, description, file_storage_key, sensitivity, source)
VALUES
  ('90000000-0000-0000-0000-000000000001',
   '10000000-0000-0000-0000-000000000001',
   'Other',
   'Emirates ID (Front & Back)',
   'Scanned Emirates ID card',
   'blob://records/john/emirates_id.pdf',
   'Confidential',
   'Upload');

-- Insurance card document in vault.records
INSERT INTO vault.records
  (id, patient_id, record_type, title, description, file_storage_key, sensitivity, source)
VALUES
  ('90000000-0000-0000-0000-000000000002',
   '10000000-0000-0000-0000-000000000001',
   'Other',
   'Health Insurance Card',
   'Front side of AXA card',
   'blob://records/john/axa_card_front.jpg',
   'Confidential',
   'Upload');

-- Structured Emirates ID
INSERT INTO identity.patient_identifiers
  (patient_id, id_type, id_number, issuer_country, issue_date, expiry_date, notes, record_id)
VALUES
  ('10000000-0000-0000-0000-000000000001',
   'NationalId',
   '784-1989-1234567-1',
   'AE',
   '2015-05-01',
   '2030-05-01',
   'UAE Emirates ID',
   '90000000-0000-0000-0000-000000000001');

-- Structured insurance policy
INSERT INTO identity.patient_insurances
  (patient_id, insurer_name, policy_number, member_id, plan_name, insurer_country,
   issue_date, expiry_date, is_active, record_id)
VALUES
  ('10000000-0000-0000-0000-000000000001',
   'AXA Gulf',
   'POL-AXA-0001',
   'MEM-12345',
   'Gold',
   'AE',
   '2025-01-01',
   '2025-12-31',
   TRUE,
   '90000000-0000-0000-0000-000000000002');



