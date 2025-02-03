USE LOCAL;

-- CREATE VIEW AvgTimeInHospital AS
SELECT AVG(time_in_hospital) AS avg_time_in_hopital
FROM hospital_readmissions;

-- CREATE VIEW ReadmissionByAge AS
SELECT age, readmitted, COUNT(*) AS count
FROM hospital_readmissions
GROUP BY age, readmitted
ORDER BY age;

-- CREATE VIEW CommonDiagnosis AS
SELECT diag_1 AS primary_diagnosis, COUNT(*) AS frequency
FROM hospital_readmissions
GROUP BY diag_1
ORDER BY frequency DESC
LIMIT 10;

-- CREATE VIEW DiabetesReadmissions AS
SELECT diabetes_med, COUNT(*) AS total, SUM(CASE WHEN readmitted = 'Yes' THEN 1 ELSE 0 END) AS readmissions
FROM hospital_readmissions
GROUP BY diabetes_med;

-- CREATE VIEW AvgReadmissionByDiagnosis AS
SELECT diag_1 AS primary_diagnosis,
       COUNT(*) AS total_cases,
       SUM(CASE WHEN readmitted = 'Yes' THEN 1 ELSE 0 END) AS readmissions,
       ROUND(SUM(CASE WHEN readmitted = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM hospital_readmissions
GROUP BY diag_1
ORDER BY readmission_rate DESC;

-- CREATE VIEW ResourceUtilization AS
SELECT AVG(n_procedures) AS avg_procedures,
	AVG(n_lab_procedures) AS avg_lab_procedures,
	AVG(n_medications) AS avg_medications,
	AVG(time_in_hospital) AS avg_hospital_stay
FROM hospital_readmissions;

-- CREATE VIEW PatientRisk AS
SELECT age, diabetes_med, n_procedures, n_emergency, time_in_hospital,
	CASE WHEN n_emergency > 1 OR n_procedures > 5 OR time_in_hospital > 7 THEN 'High Risk' 
		ELSE 'Low Risk' 
	END AS risk_category
FROM hospital_readmissions
WHERE readmitted = 'No';

-- CREATE VIEW AgeReadmission AS
SELECT age,
       COUNT(*) AS total_cases,
       SUM(CASE WHEN readmitted = 'Yes' THEN 1 ELSE 0 END) AS readmissions,
       ROUND(SUM(CASE WHEN readmitted = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM hospital_readmissions
GROUP BY age
ORDER BY readmission_rate DESC;


-- SELECT * 
-- FROM DiabetesReadmissions;
-- SELECT * 
-- FROM CommonDiagnosis;
-- SELECT * 
-- FROM ReadmissionByAge;
-- SELECT * 
-- FROM AvgTimeInHospital;
-- SELECT * 
-- FROM AvgReadmissionByDiagnosis;
-- SELECT * 
-- FROM ResourceUtilization;
-- SELECT * 
-- FROM PatientRisk;
-- SELECT *
-- FROM AgeReadmission;