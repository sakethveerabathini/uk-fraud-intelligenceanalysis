-- ================================================
-- UK Fraud Intelligence Analysis
-- Script 01: Data Exploration
-- Author: Saketh Veerabathini
-- Date: March 2026
-- Description: Initial exploration of all 6 tables
-- ================================================

-- WHY: First thing any analyst does is check
-- what tables exist in the database
SELECT name FROM sqlite_master 
WHERE type = 'table';

-- ================================================
-- SECTION 1: UK FINANCE DATA EXPLORATION
-- ================================================

-- WHY: See all fraud types and years available
-- This tells us the scope of our UK Finance data
SELECT DISTINCT fraud_type, 
       MIN(year) AS earliest_year,
       MAX(year) AS latest_year
FROM fraud_losses
GROUP BY fraud_type;

-- WHY: Total cases across all years per fraud type
-- Gives us the big picture before drilling deeper
SELECT fraud_type,
       SUM(cases) AS total_cases,
       SUM(gross_losses_millions) AS total_losses_millions,
       ROUND(AVG(change_pct) * 100, 2) AS avg_yearly_change_pct
FROM fraud_losses
GROUP BY fraud_type
ORDER BY total_losses_millions DESC;

-- WHY: Which year had the highest fraud cases overall
-- Helps identify if COVID changed fraud patterns
SELECT year,
       SUM(cases) AS total_cases,
       SUM(gross_losses_millions) AS total_losses_millions
FROM fraud_losses
GROUP BY year
ORDER BY year ASC;

-- WHY: APP fraud breakdown — which scam type
-- costs victims the most money on average
SELECT fraud_type,
       gross_losses_millions,
       cases,
       reimbursed_millions,
       ROUND(gross_losses_millions / cases * 1000000, 2) 
           AS avg_loss_per_case_pounds,
       ROUND(reimbursed_millions / gross_losses_millions * 100, 1)
           AS reimbursement_rate_pct
FROM app_fraud_summary
ORDER BY gross_losses_millions DESC;

-- WHY: Overall fraud categories — how does APP fraud
-- compare to card fraud and remote banking?
SELECT category,
       year,
       gross_losses_millions,
       prevented_millions,
       ROUND(prevented_millions / 
           (gross_losses_millions + prevented_millions) * 100, 1)
           AS prevention_rate_pct
FROM total_losses_by_category
ORDER BY year DESC, gross_losses_millions DESC;

-- ================================================
-- SECTION 2: ONS DATA EXPLORATION  
-- ================================================

-- WHY: How has financial loss distribution changed
-- over time — are victims losing more or less?
SELECT amount_band,
       yr_2017,
       yr_2020,
       yr_2025,
       ROUND(yr_2025 - yr_2017, 2) AS change_2017_to_2025
FROM financial_loss_by_amount
ORDER BY yr_2025 DESC;

-- WHY: Which access method is most common
-- for ALL fraud types combined?
SELECT access_method,
       pct_all_fraud,
       pct_bank_fraud,
       pct_consumer_fraud,
       pct_cyber_fraud
FROM offender_access_methods
ORDER BY pct_all_fraud DESC;

-- WHY: How do criminals contact victims —
-- has online fraud grown over time?
SELECT contact_method,
       yr_2017,
       yr_2020,
       yr_2025,
       ROUND(yr_2025 - yr_2017, 2) AS change_2017_to_2025
FROM fraud_contact_methods
ORDER BY yr_2025 DESC;
