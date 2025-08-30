-- Sample data for DIMS application
-- This script inserts sample data for testing and development

-- Insert sample users
INSERT INTO auth.users (email, phone, password_hash, first_name, last_name, date_of_birth, gender, is_admin) VALUES
('admin@dims.com', '01700000000', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/8Kz8KzK', 'Admin', 'User', '1990-01-01', 'Male', true),
('patient1@dims.com', '01700000001', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/8Kz8KzK', 'John', 'Doe', '1985-05-15', 'Male', false),
('patient2@dims.com', '01700000002', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/8Kz8KzK', 'Jane', 'Smith', '1992-08-22', 'Female', false)
ON CONFLICT (email) DO NOTHING;

-- Insert user profiles
INSERT INTO auth.user_profiles (user_id, address, emergency_contact_name, emergency_contact_phone, blood_type, allergies, chronic_conditions) 
SELECT 
    u.id,
    '123 Main Street, Dhaka, Bangladesh',
    'Emergency Contact',
    '01700000099',
    'O+',
    ARRAY['Penicillin', 'Shellfish'],
    ARRAY['Diabetes Type 2', 'Hypertension']
FROM auth.users u WHERE u.email = 'patient1@dims.com'
ON CONFLICT DO NOTHING;

INSERT INTO auth.user_profiles (user_id, address, emergency_contact_name, emergency_contact_phone, blood_type, allergies, chronic_conditions) 
SELECT 
    u.id,
    '456 Oak Avenue, Chittagong, Bangladesh',
    'Emergency Contact 2',
    '01700000098',
    'A+',
    ARRAY['Latex'],
    ARRAY['Asthma']
FROM auth.users u WHERE u.email = 'patient2@dims.com'
ON CONFLICT DO NOTHING;

-- Insert patients
INSERT INTO ehr.patients (user_id, patient_id, medical_record_number)
SELECT 
    u.id,
    'P001',
    'MRN001'
FROM auth.users u WHERE u.email = 'patient1@dims.com'
ON CONFLICT DO NOTHING;

INSERT INTO ehr.patients (user_id, patient_id, medical_record_number)
SELECT 
    u.id,
    'P002',
    'MRN002'
FROM auth.users u WHERE u.email = 'patient2@dims.com'
ON CONFLICT DO NOTHING;

-- Insert sample prescriptions
INSERT INTO prescription.prescriptions (prescription_nc_id, patient_id, doctor_name, department_name, prescription_date, prescription_type_key, diagnosis, notes)
SELECT 
    'PRES001',
    p.id,
    'Dr. Ahmed Rahman',
    'Cardiology',
    '2024-01-15',
    'OPD',
    'Hypertension and Diabetes Management',
    'Regular follow-up required'
FROM ehr.patients p WHERE p.patient_id = 'P001'
ON CONFLICT DO NOTHING;

INSERT INTO prescription.prescriptions (prescription_nc_id, patient_id, doctor_name, department_name, prescription_date, prescription_type_key, diagnosis, notes)
SELECT 
    'PRES002',
    p.id,
    'Dr. Fatima Khan',
    'General Medicine',
    '2024-01-20',
    'OPD',
    'Allergic Rhinitis',
    'Seasonal allergy management'
FROM ehr.patients p WHERE p.patient_id = 'P002'
ON CONFLICT DO NOTHING;

-- Insert prescription medicines
INSERT INTO prescription.prescription_medicines (prescription_id, medicine_id, medicine_name, dosage, frequency, duration, instructions, quantity)
SELECT 
    pr.id,
    m.id,
    m.brand_name,
    m.dosage,
    '1-0-1',
    '30 days',
    'Take with food',
    30
FROM prescription.prescriptions pr
JOIN dims.medicines m ON m.brand_name = 'Lipitor'
WHERE pr.prescription_nc_id = 'PRES001'
ON CONFLICT DO NOTHING;

INSERT INTO prescription.prescription_medicines (prescription_id, medicine_id, medicine_name, dosage, frequency, duration, instructions, quantity)
SELECT 
    pr.id,
    m.id,
    m.brand_name,
    m.dosage,
    '1-1-1',
    '7 days',
    'Take as needed for allergy symptoms',
    21
FROM prescription.prescriptions pr
JOIN dims.medicines m ON m.brand_name = 'Allegra'
WHERE pr.prescription_nc_id = 'PRES002'
ON CONFLICT DO NOTHING;

-- Insert sample appointments
INSERT INTO prescription.appointments (appointment_nc_id, patient_id, doctor_name, department_name, appointment_date, appointment_type, status, notes)
SELECT 
    'APT001',
    p.id,
    'Dr. Ahmed Rahman',
    'Cardiology',
    '2024-02-15 10:00:00+06',
    'Follow-up',
    'scheduled',
    'Regular checkup for hypertension'
FROM ehr.patients p WHERE p.patient_id = 'P001'
ON CONFLICT DO NOTHING;

INSERT INTO prescription.appointments (appointment_nc_id, patient_id, doctor_name, department_name, appointment_date, appointment_type, status, notes)
SELECT 
    'APT002',
    p.id,
    'Dr. Fatima Khan',
    'General Medicine',
    '2024-02-20 14:30:00+06',
    'Consultation',
    'scheduled',
    'Allergy consultation'
FROM ehr.patients p WHERE p.patient_id = 'P002'
ON CONFLICT DO NOTHING;

-- Insert sample vitals
INSERT INTO ehr.vitals (patient_id, blood_pressure_systolic, blood_pressure_diastolic, temperature, pulse_rate, height, weight, bmi, recorded_date, recorded_by, notes)
SELECT 
    p.id,
    120,
    80,
    98.6,
    72,
    170.0,
    70.0,
    24.2,
    '2024-01-15 09:00:00+06',
    'Nurse Sarah',
    'Normal vitals'
FROM ehr.patients p WHERE p.patient_id = 'P001'
ON CONFLICT DO NOTHING;

INSERT INTO ehr.vitals (patient_id, blood_pressure_systolic, blood_pressure_diastolic, temperature, pulse_rate, height, weight, bmi, recorded_date, recorded_by, notes)
SELECT 
    p.id,
    118,
    78,
    98.4,
    68,
    165.0,
    60.0,
    22.0,
    '2024-01-20 10:30:00+06',
    'Nurse Maria',
    'Good vitals'
FROM ehr.patients p WHERE p.patient_id = 'P002'
ON CONFLICT DO NOTHING;

-- Insert sample medical records
INSERT INTO ehr.medical_records (patient_id, record_type, title, description, record_date, department, doctor_name, findings)
SELECT 
    p.id,
    'lab_report',
    'Complete Blood Count',
    'Routine blood test',
    '2024-01-10',
    'Pathology',
    'Dr. Lab Tech',
    'All values within normal range'
FROM ehr.patients p WHERE p.patient_id = 'P001'
ON CONFLICT DO NOTHING;

INSERT INTO ehr.medical_records (patient_id, record_type, title, description, record_date, department, doctor_name, findings)
SELECT 
    p.id,
    'lab_report',
    'Lipid Profile',
    'Cholesterol and lipid levels',
    '2024-01-12',
    'Pathology',
    'Dr. Lab Tech',
    'Cholesterol levels slightly elevated, recommend dietary changes'
FROM ehr.patients p WHERE p.patient_id = 'P001'
ON CONFLICT DO NOTHING;

INSERT INTO ehr.medical_records (patient_id, record_type, title, description, record_date, department, doctor_name, findings)
SELECT 
    p.id,
    'radiology',
    'Chest X-Ray',
    'Routine chest examination',
    '2024-01-18',
    'Radiology',
    'Dr. Radiologist',
    'Clear lungs, no abnormalities detected'
FROM ehr.patients p WHERE p.patient_id = 'P002'
ON CONFLICT DO NOTHING;
