-- Healthcare Dataset Data Analysis (SQLite)
-- Table name: healthcare
-- NOTE: Your columns include:
-- name, age, gender, blood_type, medical_condition, date_of_admission,
-- doctor, hospital, insurance_provider, billing_amount, admission_type,
-- discharge_date, medication, test_results, length_of_stay_days
--
-- Tip: Check columns anytime with:
-- PRAGMA table_info(healthcare);

-- =========================
-- 1) BASIC COUNTS
-- =========================

-- Q01: Total records
SELECT COUNT(*) AS total_records
FROM healthcare;

-- Q02: Age stats
SELECT
  AVG(age) AS avg_age,
  MIN(age) AS min_age,
  MAX(age) AS max_age
FROM healthcare;

-- Q03: Gender distribution
SELECT gender, COUNT(*) AS count
FROM healthcare
GROUP BY gender
ORDER BY count DESC;

-- Q04: Blood type distribution
SELECT blood_type, COUNT(*) AS count
FROM healthcare
GROUP BY blood_type
ORDER BY count DESC;

-- =========================
-- 2) ADMISSIONS
-- =========================

-- Q05: Admission type counts
SELECT admission_type, COUNT(*) AS count
FROM healthcare
GROUP BY admission_type
ORDER BY count DESC;

-- Q06: Admissions by month (YYYY-MM)
SELECT
  substr(date_of_admission, 1, 7) AS month,
  COUNT(*) AS admissions
FROM healthcare
GROUP BY month
ORDER BY month;

-- =========================
-- 3) MEDICAL CONDITIONS
-- =========================

-- Q07: Condition counts
SELECT medical_condition, COUNT(*) AS count
FROM healthcare
GROUP BY medical_condition
ORDER BY count DESC;

-- Q08: Test results counts
SELECT test_results, COUNT(*) AS count
FROM healthcare
GROUP BY test_results
ORDER BY count DESC;

-- =========================
-- 4) LENGTH OF STAY (LOS)
-- =========================

-- Q09: Average LOS
SELECT AVG(length_of_stay_days) AS avg_length_of_stay_days
FROM healthcare;

-- Q10: LOS by admission type
SELECT admission_type, AVG(length_of_stay_days) AS avg_los
FROM healthcare
GROUP BY admission_type
ORDER BY avg_los DESC;

-- Q11: LOS by condition
SELECT medical_condition, AVG(length_of_stay_days) AS avg_los
FROM healthcare
GROUP BY medical_condition
ORDER BY avg_los DESC;

-- Q12: Long stays (over 20 days)
SELECT COUNT(*) AS long_stays_over_20_days
FROM healthcare
WHERE length_of_stay_days > 20;

-- =========================
-- 5) BILLING
-- =========================

-- Q13: Average billing (ignore NULLs)
SELECT AVG(billing_amount) AS avg_billing
FROM healthcare
WHERE billing_amount IS NOT NULL;

-- Q14: Billing min/max (ignore NULLs)
SELECT
  MIN(billing_amount) AS min_billing,
  MAX(billing_amount) AS max_billing
FROM healthcare
WHERE billing_amount IS NOT NULL;

-- Q15: Avg billing by insurance provider
SELECT insurance_provider, AVG(billing_amount) AS avg_billing
FROM healthcare
WHERE billing_amount IS NOT NULL
GROUP BY insurance_provider
ORDER BY avg_billing DESC;

-- Q16: Total billing by insurance provider
SELECT insurance_provider, SUM(billing_amount) AS total_billing
FROM healthcare
WHERE billing_amount IS NOT NULL
GROUP BY insurance_provider
ORDER BY total_billing DESC;

-- Q17: Avg billing by condition
SELECT medical_condition, AVG(billing_amount) AS avg_billing
FROM healthcare
WHERE billing_amount IS NOT NULL
GROUP BY medical_condition
ORDER BY avg_billing DESC;

-- Q18: Top 10 highest billing records
SELECT
  name,
  age,
  medical_condition,
  insurance_provider,
  billing_amount
FROM healthcare
WHERE billing_amount IS NOT NULL
ORDER BY billing_amount DESC
LIMIT 10;

-- =========================
-- 6) DOCTOR & HOSPITAL
-- =========================

-- Q19: Patients per doctor (top 10)
SELECT doctor, COUNT(*) AS patient_count
FROM healthcare
GROUP BY doctor
ORDER BY patient_count DESC
LIMIT 10;

-- Q20: Patients per hospital (top 10)
SELECT hospital, COUNT(*) AS patient_count
FROM healthcare
GROUP BY hospital
ORDER BY patient_count DESC
LIMIT 10;
