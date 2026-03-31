-- ================================================
-- UK Fraud Intelligence Analysis
-- Script 03: Risk Segmentation
-- Author: Saketh Veerabathini
-- Date: March 2026
-- Description: Classify fraud into risk segments
-- This feeds directly into our ML model later
-- ================================================

-- WHY: Assign risk scores to each fraud type
-- based on losses and growth — this becomes
-- the target variable for our ML model
SELECT fraud_type,
       year,
       gross_losses_millions,
       cases,
       change_pct,
       CASE
           WHEN gross_losses_millions > 400 
               THEN 'Critical Risk'
           WHEN gross_losses_millions > 100 
               THEN 'High Risk'
           WHEN gross_losses_millions > 40 
               THEN 'Medium Risk'
           ELSE 'Low Risk'
       END AS risk_level,
       CASE
           WHEN change_pct > 0.5 THEN 3
           WHEN change_pct > 0.1 THEN 2
           WHEN change_pct > 0 THEN 1
           ELSE 0
       END AS growth_score
FROM fraud_losses
ORDER BY gross_losses_millions DESC, year DESC;

-- WHY: Segment APP scam types by victim impact
-- Combines loss size with reimbursement failure
-- Higher unrecovered = higher victim harm score
SELECT fraud_type,
       gross_losses_millions,
       cases,
       ROUND(gross_losses_millions / cases * 1000000, 0)
           AS avg_loss_per_victim,
       ROUND((gross_losses_millions - reimbursed_millions) 
           / cases * 1000000, 0) 
           AS avg_unrecovered_per_victim,
       CASE
           WHEN gross_losses_millions / cases * 1000000 > 5000
               THEN 'High Impact Per Victim'
           WHEN gross_losses_millions / cases * 1000000 > 1000
               THEN 'Medium Impact Per Victim'
           ELSE 'Lower Impact Per Victim'
       END AS victim_impact_segment
FROM app_fraud_summary
ORDER BY avg_loss_per_victim DESC;

-- WHY: Access method risk ranking
-- Shows which attack vectors are most dangerous
-- Feeds into our cybersecurity risk analysis
SELECT access_method,
       pct_all_fraud,
       pct_bank_fraud,
       pct_cyber_fraud,
       ROUND((pct_all_fraud + pct_bank_fraud + 
           pct_cyber_fraud) / 3, 2) 
           AS composite_risk_score,
       CASE
           WHEN (pct_all_fraud + pct_bank_fraud + 
               pct_cyber_fraud) / 3 > 10 
               THEN 'Critical Vector'
           WHEN (pct_all_fraud + pct_bank_fraud + 
               pct_cyber_fraud) / 3 > 5 
               THEN 'High Risk Vector'
           ELSE 'Moderate Vector'
       END AS risk_classification
FROM offender_access_methods
ORDER BY composite_risk_score DESC;

-- WHY: Contact method trend risk
-- Online contact grew massively — this query
-- quantifies exactly how much riskier online
-- fraud has become compared to 2017
SELECT contact_method,
       yr_2017,
       yr_2025,
       ROUND(yr_2025 - yr_2017, 2) AS absolute_change,
       CASE
           WHEN yr_2025 > 15 THEN 'Dominant Channel'
           WHEN yr_2025 > 7 THEN 'Growing Channel'
           WHEN yr_2025 > 3 THEN 'Active Channel'
           ELSE 'Minor Channel'
       END AS channel_status,
       CASE
           WHEN yr_2025 - yr_2017 > 10 
               THEN 'Rapidly Growing'
           WHEN yr_2025 - yr_2017 > 3 
               THEN 'Steadily Growing'
           WHEN yr_2025 - yr_2017 > 0 
               THEN 'Slowly Growing'
           ELSE 'Declining'
       END AS trend
FROM fraud_contact_methods
ORDER BY yr_2025 DESC;