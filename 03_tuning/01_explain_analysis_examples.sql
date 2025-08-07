/*
-- ========================================
-- QUERY 01: Patient Appointments with Doctor Info
-- ========================================
*/
EXPLAIN 
SELECT patients.patient_id AS "Patient ID", patients.first_name AS "Patient First Name", patients.last_name AS "Patient Last Name", doctors.doctor_id AS "Doctor ID", doctors.first_name AS "Doctor First Name", doctors.last_name AS "Doctor Last Name", appointments.appointment_date AS "Appointment Date"
FROM appointments 
JOIN doctors
ON appointments.doctor_id = doctors.doctor_id
JOIN patients 
ON patients.patient_id = appointments.patient_id
ORDER BY patients.patient_id
LIMIT 30;

EXPLAIN ANALYZE
SELECT patients.patient_id AS "Patient ID", patients.first_name AS "Patient First Name", patients.last_name AS "Patient Last Name", doctors.doctor_id AS "Doctor ID", doctors.first_name AS "Doctor First Name", doctors.last_name AS "Doctor Last Name", appointments.appointment_date AS "Appointment Date"
FROM appointments 
JOIN doctors
ON appointments.doctor_id = doctors.doctor_id
JOIN patients 
ON patients.patient_id = appointments.patient_id
ORDER BY patients.patient_id
LIMIT 30;