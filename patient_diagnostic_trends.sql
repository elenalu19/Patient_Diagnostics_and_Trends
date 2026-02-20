SELECT * FROM patient_profile_diagnostic_trends.patient_visits;

#  Count how many times each ICD code appears. 
SELECT icd_code, COUNT(*) AS frequency
FROM patient_visits
GROUP BY icd_code
ORDER BY frequency DESC;

#  Count how many times each ICD code appears, group by sex. 
SELECT patient_sex, icd_code, COUNT(*) AS frequency
FROM patient_visits
GROUP BY icd_code, patient_sex
ORDER BY frequency DESC;

#  Count how many times each ICD code appears, group by age bands. 
SELECT age_bins, icd_code, COUNT(*) AS frequency
FROM patient_visits
GROUP BY icd_code, age_bins
ORDER BY frequency DESC;

# Count total diagnosis events per patient.
SELECT 
    patient_id, 
    COUNT(*) AS total_diagnostic_events
FROM patient_visits
GROUP BY patient_id
ORDER BY patient_id;

# Find the average number of visits per patient.
SELECT AVG(visit_count) AS average_visits
FROM (
    SELECT patient_id, COUNT(visit_id) AS visit_count
    FROM patient_visits
    GROUP BY patient_id
) AS patient_utilization;

#Identify “high utilizers” (patients with 4+ visits)
SELECT patient_id, visit_count
FROM (
    SELECT patient_id, COUNT(visit_id) AS visit_count
    FROM patient_visits
    GROUP BY patient_id
) AS patient_utilization
WHERE visit_count >=4;

# Rank CPT codes by frequency to see which procedures are performed most often
SELECT cpt_code, COUNT(cpt_code)
FROM patient_visits
GROUP BY cpt_code
ORDER BY COUNT(cpt_code) DESC;
