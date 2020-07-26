-- Patients
-- patient_id | patient_name | conditions

-- Write an SQL query to report the patient_id, patient_name and all conditions of patients
-- who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.
-- Return the result table in any order.

SELECT * FROM Patients
WHERE conditions LIKE '%DIAB1%'
