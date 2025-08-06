/*
-- ========================================
-- QUERY 01: Patient Appointments with Doctor Info
-- ========================================
*/
SELECT patients.patient_id AS "Patient ID", patients.first_name AS "Patient First Name", patients.last_name AS "Patient Last Name", doctors.doctor_id AS "Doctor ID", doctors.first_name AS "Doctor First Name", doctors.last_name AS "Doctor Last Name", appointments.appointment_date AS "Appointment Date"
FROM appointments 
JOIN doctors
ON appointments.doctor_id = doctors.doctor_id
JOIN patients 
ON patients.patient_id = appointments.patient_id
ORDER BY patients.patient_id
LIMIT 30;

-- ========================================
-- QUERY 02: Appointments Scheduled for a Given Date
-- Description: Shows all appointments for a specific date.
-- Use case: Daily schedule view for operational planning.
-- ========================================

SELECT patients.patient_id AS "Patient ID", patients.first_name AS "Patient First Name", patients.last_name AS "Patient Last Name", doctors.doctor_id AS "Doctor ID", doctors.first_name AS "Doctor First Name", doctors.last_name AS "Doctor Last Name", appointments.appointment_date AS "Appointment Date"
FROM appointments 
JOIN doctors
ON appointments.doctor_id = doctors.doctor_id
JOIN patients 
ON patients.patient_id = appointments.patient_id
WHERE appointments.appointment_date = '2023-09-01'
ORDER BY doctors.doctor_id;

-- ========================================
-- QUERY 03: Busiest Appointment Date
-- Description: Returns the date with the highest number of scheduled appointments.
-- Use case: Identify peak days for resource planning and staffing.
-- ========================================

SELECT appointments.appointment_date AS "Appointment Date", COUNT(appointments.appointment_date) 
FROM appointments 
GROUP BY appointments.appointment_date
ORDER BY COUNT(appointments.appointment_date) DESC
LIMIT 1;

-- ========================================
-- QUERY 04: Total Number of Patients Per Doctor
-- Description: Aggregates the number of unique patients seen by each doctor.
-- Use case: Helps evaluate individual doctor workload based on patient count.
-- ========================================

SELECT doctors.doctor_id AS "Doctor ID", doctors.first_name AS "Doctor First Name", doctors.last_name AS "Doctor Last Name", COUNT(DISTINCT patients.patient_id) AS "Patient Count"
FROM appointments 
JOIN doctors
ON appointments.doctor_id = doctors.doctor_id
JOIN patients 
ON patients.patient_id = appointments.patient_id
GROUP BY doctors.doctor_id;

-- ========================================
-- QUERY 05: Patients with More Than 3 Treatments
-- Description: Lists patients who have received more than 3 treatments across all their appointments.
-- Use case: Identify patients with high treatment frequency for case management or review.
-- ========================================

SELECT patients.patient_id AS "Patient ID", patients.first_name AS "Patient First Name", patients.last_name AS "Patient Last Name", COUNT(treatments.treatment_id)
FROM patients 
JOIN appointments
ON patients.patient_id = appointments.patient_id
JOIN treatments
ON treatments.appointment_id = appointments.appointment_id 
GROUP BY patients.patient_id
HAVING COUNT(treatments.treatment_id) > 3;

-- ========================================
-- QUERY 06: Total Billing Amount Per Patient
-- Description: Calculates the total amount billed to each patient across all treatments.
-- Use case: Identify top-paying patients or assess billing distribution.
-- ========================================

SELECT patients.patient_id AS "Patient ID", patients.first_name AS "Patient First Name", patients.last_name AS "Patient Last Name", SUM(billing.amount) AS "Billing Amount"
FROM patients 
JOIN billing
ON patients.patient_id = billing.patient_id
GROUP BY patients.patient_id
ORDER BY SUM(billing.amount) DESC;

-- ========================================
-- QUERY 07: Pending Payments with Patient and Treatment Info
-- Description: Lists all bills with a pending payment status, including patient and treatment details.
-- Use case: Useful for financial follow-up or collections processing.
-- ========================================

SELECT billing.bill_id, billing.payment_status, treatments.treatment_id, treatments.treatment_type, patients.patient_id AS "Patient ID", patients.first_name AS "Patient First Name", patients.last_name AS "Patient Last Name"
FROM patients 
JOIN billing
ON patients.patient_id = billing.patient_id
JOIN treatments
ON treatments.treatment_id = billing.treatment_id
WHERE billing.payment_status = 'Pending'
GROUP BY billing.bill_id, billing.payment_status, treatments.treatment_id, treatments.treatment_type, patients.patient_id
ORDER BY billing.bill_id;

-- ========================================
-- QUERY 08: Monthly Billing Summary
-- Description: Calculates the total billing amount per month by extracting the month from each bill's date.
-- Use case: Useful for tracking monthly revenue trends and seasonal billing patterns.
-- ========================================

SELECT EXTRACT(MONTH FROM bill_date) AS month, SUM(amount) AS "monthly Sum"
FROM billing
GROUP BY month
ORDER BY month ASC;

-- ========================================
-- QUERY 09: Top 5 Most Expensive Treatments
-- Description: Retrieves the top 5 treatments with the highest billing amounts.
-- Use case: Useful for identifying the most costly procedures for financial analysis or pricing review.
-- ========================================
    
SELECT treatments.treatment_id, treatments.treatment_type, billing.bill_id, billing.amount
FROM treatments
JOIN billing
ON treatments.treatment_id = billing.treatment_id
ORDER BY billing.amount DESC
LIMIT 5;

-- ========================================
-- QUERY 10: Treatment Type Frequency
-- Description: Counts how many times each treatment type has been administered.
-- Use case: Useful for analyzing the most commonly performed treatments.
-- ========================================
    
SELECT treatments.treatment_type, COUNT(treatments.treatment_type) AS "Count"
FROM treatments
GROUP BY treatments.treatment_type
ORDER BY COUNT(treatments.treatment_type) DESC;
    
-- ========================================
-- QUERY 11: Average Number of Treatments Per Appointment
-- Description: Calculates the average number of treatments assigned per appointment.
-- Use case: Helps evaluate treatment load and service complexity across appointments.
-- ========================================

SELECT 
    ROUND(AVG(treatment_count)::NUMERIC, 2) AS "Average Treatments per Appointment"
FROM (
    SELECT appointments.appointment_id, COUNT(treatments.treatment_id) AS treatment_count
    FROM appointments 
    JOIN treatments 
    ON treatments.appointment_id = appointments.appointment_id
    GROUP BY appointments.appointment_id
) AS sub;

-- ========================================
-- QUERY 12: Number of Appointments Per Doctor
-- Description: Counts how many distinct appointments each doctor has had.
-- Use case: Helps evaluate doctor workload and scheduling demand.
-- ========================================

SELECT doctors.doctor_id AS "Doctor ID", doctors.first_name AS "Doctor First Name", doctors.last_name AS "Doctor Last Name", COUNT(DISTINCT appointments.appointment_id) AS "Appoitment Count"
FROM appointments 
JOIN doctors
ON appointments.doctor_id = doctors.doctor_id
JOIN patients 
ON patients.patient_id = appointments.patient_id
GROUP BY doctors.doctor_id; 
