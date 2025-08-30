-- DIMS Database Initialization Script
-- This script creates the initial database structure for the DIMS application

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Create schemas
CREATE SCHEMA IF NOT EXISTS dims;
CREATE SCHEMA IF NOT EXISTS auth;
CREATE SCHEMA IF NOT EXISTS ehr;
CREATE SCHEMA IF NOT EXISTS prescription;

-- Set default schema
SET search_path TO dims, auth, ehr, prescription, public;

-- Users and Authentication Tables
CREATE TABLE IF NOT EXISTS auth.users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10),
    is_active BOOLEAN DEFAULT true,
    is_admin BOOLEAN DEFAULT false,
    email_verified BOOLEAN DEFAULT false,
    phone_verified BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- User Profiles
CREATE TABLE IF NOT EXISTS auth.user_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    avatar_url VARCHAR(500),
    address TEXT,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    blood_type VARCHAR(5),
    allergies TEXT[],
    chronic_conditions TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Medicine Database
CREATE TABLE IF NOT EXISTS dims.medicines (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    brand_name VARCHAR(255) NOT NULL,
    generic_name VARCHAR(255) NOT NULL,
    dosage VARCHAR(100),
    indication TEXT,
    medicine_type VARCHAR(100),
    company VARCHAR(255),
    pack_type VARCHAR(50),
    description TEXT,
    side_effects TEXT,
    contraindications TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for medicine search
CREATE INDEX IF NOT EXISTS idx_medicines_brand_name ON dims.medicines USING gin(brand_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_medicines_generic_name ON dims.medicines USING gin(generic_name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_medicines_indication ON dims.medicines USING gin(indication gin_trgm_ops);

-- EHR Tables
CREATE TABLE IF NOT EXISTS ehr.patients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    patient_id VARCHAR(50) UNIQUE NOT NULL,
    medical_record_number VARCHAR(50) UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Prescriptions
CREATE TABLE IF NOT EXISTS prescription.prescriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    prescription_nc_id VARCHAR(100) UNIQUE NOT NULL,
    patient_id UUID REFERENCES ehr.patients(id) ON DELETE CASCADE,
    doctor_name VARCHAR(255),
    department_name VARCHAR(255),
    prescription_date DATE,
    prescription_type_key VARCHAR(100),
    diagnosis TEXT,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Prescription Medicines
CREATE TABLE IF NOT EXISTS prescription.prescription_medicines (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    prescription_id UUID REFERENCES prescription.prescriptions(id) ON DELETE CASCADE,
    medicine_id UUID REFERENCES dims.medicines(id),
    medicine_name VARCHAR(255) NOT NULL,
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    duration VARCHAR(100),
    instructions TEXT,
    quantity INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Appointments
CREATE TABLE IF NOT EXISTS prescription.appointments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    appointment_nc_id VARCHAR(100) UNIQUE NOT NULL,
    patient_id UUID REFERENCES ehr.patients(id) ON DELETE CASCADE,
    doctor_name VARCHAR(255),
    department_name VARCHAR(255),
    appointment_date TIMESTAMP WITH TIME ZONE,
    appointment_type VARCHAR(100),
    status VARCHAR(50) DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Vitals
CREATE TABLE IF NOT EXISTS ehr.vitals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    patient_id UUID REFERENCES ehr.patients(id) ON DELETE CASCADE,
    blood_pressure_systolic INTEGER,
    blood_pressure_diastolic INTEGER,
    temperature DECIMAL(4,2),
    pulse_rate INTEGER,
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    bmi DECIMAL(4,2),
    recorded_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    recorded_by VARCHAR(255),
    notes TEXT
);

-- Medical Records
CREATE TABLE IF NOT EXISTS ehr.medical_records (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    patient_id UUID REFERENCES ehr.patients(id) ON DELETE CASCADE,
    record_type VARCHAR(100) NOT NULL, -- 'lab_report', 'radiology', 'surgical', etc.
    title VARCHAR(255) NOT NULL,
    description TEXT,
    file_url VARCHAR(500),
    record_date DATE,
    department VARCHAR(255),
    doctor_name VARCHAR(255),
    findings TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_prescriptions_patient_id ON prescription.prescriptions(patient_id);
CREATE INDEX IF NOT EXISTS idx_prescriptions_date ON prescription.prescriptions(prescription_date);
CREATE INDEX IF NOT EXISTS idx_appointments_patient_id ON prescription.appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_appointments_date ON prescription.appointments(appointment_date);
CREATE INDEX IF NOT EXISTS idx_vitals_patient_id ON ehr.vitals(patient_id);
CREATE INDEX IF NOT EXISTS idx_vitals_date ON ehr.vitals(recorded_date);
CREATE INDEX IF NOT EXISTS idx_medical_records_patient_id ON ehr.medical_records(patient_id);

-- Insert sample medicines
INSERT INTO dims.medicines (brand_name, generic_name, dosage, indication, medicine_type, company, pack_type) VALUES
('Allegra', 'Fexofenadine', '180mg', 'Allergy Relief', 'Antihistamine', 'Pfizer', 'Tab'),
('Valium', 'Diazepam', '5mg', 'Anxiety, Muscle Relaxant', 'Benzodiazepine', 'Roche', 'Tab'),
('Zoloft', 'Sertraline', '50mg', 'Depression, Panic Disorder', 'SSRI', 'Pfizer', 'Cap'),
('Napa', 'Curcuma longa', '500mg', 'Anti-inflammatory', 'Herbal Supplement', 'Natural Health', 'Cap'),
('Lipitor', 'Atorvastatin', '20mg', 'Cholesterol', 'Statin', 'Pfizer', 'Tab'),
('Rocephin', 'Ceftriaxone', '1g', 'Antibiotic', 'Cephalosporin', 'Roche', 'INJ'),
('Benadryl', 'Diphenhydramine', '25mg/5ml', 'Allergy Relief', 'Antihistamine', 'Johnson & Johnson', 'Syrup')
ON CONFLICT DO NOTHING;

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON auth.users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_profiles_updated_at BEFORE UPDATE ON auth.user_profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_medicines_updated_at BEFORE UPDATE ON dims.medicines FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_prescriptions_updated_at BEFORE UPDATE ON prescription.prescriptions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_appointments_updated_at BEFORE UPDATE ON prescription.appointments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Grant permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA auth TO dims_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA dims TO dims_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ehr TO dims_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA prescription TO dims_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA auth TO dims_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA dims TO dims_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA ehr TO dims_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA prescription TO dims_user;
