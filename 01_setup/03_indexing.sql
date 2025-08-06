-- 03_indexing.sql

-- Index on primary keys (if not automatically created)
CREATE UNIQUE INDEX idx_patients_patient_id ON patients(patient_id);
CREATE UNIQUE INDEX idx_doctors_doctor_id ON doctors(doctor_id);
CREATE UNIQUE INDEX idx_appointments_appointment_id on appointments(appointment_id);
CREATE UNIQUE INDEX idx_treatments_treatment_id on treatments(treatment_id);
CREATE UNIQUE INDEX idx_billing_bill_id ON billing(bill_id);

-- Foreign key indexes
CREATE INDEX idx_appointments_doctor_id ON appointments(doctor_id);
CREATE INDEX idx_appointments_patient_id ON appointments(patient_id);
CREATE INDEX idx_treatments_appointment_id ON treatments(appointment_id);
CREATE INDEX idx_billing_patient_id ON billing(patient_id);
CREATE INDEX idx_billing_treatment_id ON billing(treatment_id);

-- Filter/sort/search improvement 
CREATE INDEX idx_appointments_date ON appointments(appointment_date);
CREATE INDEX idx_patients_insurance_provider ON patients(insurance_provider);
CREATE INDEX idx_billing_payment_status ON billing(payment_status); 
