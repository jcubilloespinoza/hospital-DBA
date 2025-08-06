-- 02_import_data.sql

-- Assumes comma-separated files (.csv) with headers
-- Adjust the file paths if needed

-- Import into patients
\COPY patients (
    patient_id, first_name, last_name, gender, date_of_birth,
    contact_number, address, registration_date, insurance_provider,
    insurance_number, email
)
FROM './data/patients.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER TRUE, NULL '\N');

-- Import into doctors
\COPY doctors (
    doctor_id,first_name,last_name,specialization,phone_number,years_experience,hospital_branch,email
)
FROM './data/doctors.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER TRUE, NULL '\N');

-- Import into appointments
\COPY appointments (
    appointment_id,patient_id,doctor_id,appointment_date,appointment_time,reason_for_visit,status
)
FROM './data/appointments.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER TRUE, NULL '\N');

-- Import into treatments
\COPY treatments (
    treatment_id,appointment_id,treatment_type,description,cost,treatment_date
)
FROM './data/treatments.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER TRUE, NULL '\N');

-- Import into billing
\COPY billing (
    bill_id,patient_id,treatment_id,bill_date,amount,payment_method,payment_status
)
FROM './data/billing.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER TRUE, NULL '\N');