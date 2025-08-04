-- 01_create_tables.sql

-- Table: patients
CREATE TABLE patients (
    patient_id TEXT PRIMARY KEY NOT NULL, 
    first_name TEXT, 
    last_name TEXT, 
    gender TEXT, 
    date_of_birth DATE, 
    contact_number TEXT, 
    address TEXT, 
    registration_date DATE, 
    insurance_provider TEXT, 
    insurance_number TEXT
);

-- Table: doctors
CREATE TABLE doctors (
    doctor_id TEXT PRIMARY KEY NOT NULL, 
    first_name TEXT, 
    last_name TEXT, 
    specialization TEXT, 
    phone_number TEXT, 
    years_experience INTEGER, 
    hospital_branch TEXT, 
    email TEXT
);

-- Table: appointments
CREATE TABLE appointments (
    appointment_id TEXT PRIMARY KEY NOT NULL,
    patient_id TEXT,
    doctor_id TEXT, 
    appointment_date DATE, 
    appointment_time TIME, 
    reason_for_visit TEXT, 
    status TEXT
);

-- Table: treatments
CREATE TABLE treatments (
    treatment_id TEXT PRIMARY KEY NOT NULL, 
    appointment_id TEXT, 
    treatment_type TEXT, 
    description TEXT, 
    cost NUMERIC(10, 2), 
    treatment_date DATE
);

-- Table: billing
CREATE TABLE billing (
    bill_id TEXT PRIMARY KEY NOT NULL, 
    patient_id TEXT, 
    treatment_id TEXT, 
    bill_date DATE, 
    amount NUMERIC(10, 2), 
    payment_method TEXT, 
    payment_status TEXT
);

