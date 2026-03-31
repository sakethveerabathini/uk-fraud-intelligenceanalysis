-- ================================================
-- UK Fraud Intelligence Analysis
-- Script 02: Fraud Trends Analysis
-- Author: Saketh Veerabathini
-- Date: March 2026
-- Description: Deep dive into trends over time
-- to answer our core question — did COVID
-- permanently change UK fraud patterns?
-- ================================================

-- WHY: Identify pre-COVID vs post-COVID fraud losses
-- 2013-2019 = pre-COVID, 2020-2022 = COVID/post period
SELECT fraud_type,
       ROUND(AVG(CASE WHEN year <= 2019 
           THEN gross_losses_millions END), 2) 
           AS avg_loss_pre_covid,
       ROUND(AVG(CASE WHEN year >= 2020 
           THEN gross_losses_millions END), 2) 
           AS avg_loss_post_covid,
       ROUND(
           (AVG(CASE WHEN year >= 2020 
               THEN gross_losses_millions END) -
            AVG(CASE WHEN year <= 2019 
               THEN gross_losses_millions END)) /
            AVG(CASE WHEN year <= 2019 
               THEN gross_losses_millions END) * 100
       , 1) AS pct_change_covid_impact
FROM fraud_losses
GROUP BY fraud_type
ORDER BY pct_change_covid_impact DESC;

-- WHY: Find the single worst year for each fraud type
-- This becomes a key finding in our report
SELECT fraud_type,
       year AS worst_year,
       gross_losses_millions AS peak_losses,
       cases AS peak_cases
FROM fraud_losses f1
WHERE gross_losses_millions = (
    SELECT MAX(gross_losses_millions)
    FROM fraud_losses f2
    WHERE f2.fraud_type = f1.fraud_type
)
ORDER BY peak_losses DESC;

-- WHY: Year on year growth rate analysis
-- Shows which years had explosive fraud growth
SELECT year,
       fraud_type,
       gross_losses_millions,
       cases,
       ROUND(change_pct * 100, 1) AS change_pct,
       CASE 
           WHEN change_pct > 0.5 THEN 'High Growth'
           WHEN change_pct > 0.1 THEN 'Moderate Growth'
           WHEN change_pct > 0 THEN 'Slow Growth'
           WHEN change_pct = 0 THEN 'No Change'
           ELSE 'Decline'
       END AS growth_category
FROM fraud_losses
ORDER BY year ASC, change_pct DESC;

-- WHY: APP fraud reimbursement analysis
-- Shows how much victims actually get back
-- A key policy insight for our project narrative
SELECT fraud_type,
       gross_losses_millions,
       reimbursed_millions,
       ROUND(gross_losses_millions - reimbursed_millions, 1)
           AS unrecovered_millions,
       ROUND(reimbursed_millions / 
           gross_losses_millions * 100, 1)
           AS reimbursement_rate_pct,
       CASE
           WHEN reimbursed_millions / 
               gross_losses_millions >= 0.5 
               THEN 'Good Recovery'
           WHEN reimbursed_millions / 
               gross_losses_millions >= 0.25 
               THEN 'Partial Recovery'
           ELSE 'Poor Recovery'
       END AS recovery_status
FROM app_fraud_summary
ORDER BY unrecovered_millions DESC;

-- WHY: Prevention effectiveness by category
-- Banks stopped more fraud than was actually stolen
-- This is a powerful insight for the dashboard
SELECT category,
       year,
       gross_losses_millions AS stolen,
       prevented_millions AS prevented,
       gross_losses_millions + prevented_millions 
           AS total_attempted,
       ROUND(prevented_millions / 
           (gross_losses_millions + prevented_millions) 
           * 100, 1) AS prevention_rate_pct
FROM total_losses_by_category
ORDER BY prevention_rate_pct DESC;
