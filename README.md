# 🇬🇧 UK Fraud Intelligence Analysis (2022–2025)

## The Problem
UK fraud losses exceeded £1.2 billion in 2022. But where exactly 
is the money going and did COVID permanently shift the pattern?

##  What This Project Does
This project analyses UK fraud trends across categories and time 
using real data from UK Finance Annual Fraud Report 2023 and the 
ONS Nature of Crime: Fraud and Computer Misuse dataset (2025).
It cleans and structures the data using Python and Excel, stores 
it in a SQLite database, explores it with SQL queries, builds 
machine learning models to classify fraud risk, and visualises 
all findings in an interactive 3-page Power BI dashboard.

##  Key Findings

-  **Remote Purchase CNP fraud** was the largest fraud type 
  peaking at **£500.7M losses in 2017** before declining to 
  £395.7M in 2022 following Strong Customer Authentication

-  **Card ID Theft surged 97% in 2022** the fastest growing 
  fraud type post-COVID with 82,064 cases recorded

-  **Impersonation fraud** was the most damaging APP scam 
  with **£177.6M stolen** from 43,307 victims  only 59% 
  was reimbursed

-  **Investment scams** had the highest loss per victim 
  average **£6,753 per case** making them the most financially 
  devastating scam type

-  **Banks prevented £1.2 billion** in unauthorised fraud 
  in 2022  stopping 61.5p in every £1 of attempted fraud

-  **Online fraud contact grew from 18% in 2019 to 24.5% 
  in 2025**  buying and selling online is now the dominant 
  channel criminals use to reach victims

-  **Database breaches** are the most common access method 
  affecting 11.9% of all fraud cases

##  Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python (Pandas, Seaborn, Scikit-learn) | Data cleaning, EDA, ML |
| Excel | Manual data extraction and cleaning from PDF-converted reports |
| SQL (SQLite) | Database creation, exploration and risk segmentation queries |
| Power BI | Interactive 3-page fraud intelligence dashboard |
| Git & GitHub | Version control throughout the project |

## Project Structure
```
uk-fraud-intelligenceanalysis/
├── data/
│   ├── raw/               ← Original UK Finance and ONS datasets
│   └── processed/         ← Cleaned Excel files, CSVs and SQLite DB
├── sql/
│   ├── 01_data_exploration.sql    ← Initial table exploration
│   ├── 02_fraud_trends.sql        ← Pre vs post COVID analysis
│   └── 03_risk_segmentation.sql   ← Risk classification queries
├── notebooks/
│   ├── 01_data_cleaning.ipynb     ← Load, clean and export to DB
│   ├── 02_exploratory_analysis.ipynb  ← 5 charts and key findings
│   └── 03_ml_model.ipynb          ← ML models and evaluation
├── excel/
│   ├── uk_finance_clean.xlsx      ← Manually cleaned UK Finance data
│   └── ons_fraud_clean.xlsx       ← Manually cleaned ONS data
├── dashboard/
│   └── uk_fraud_dashboard.pbix    ← Power BI dashboard (3 pages)
└── images/                        ← All charts and dashboard screenshots
```

##  Dashboard Pages

**Page 1  Fraud Overview**
- KPI cards: Total losses, total cases, APP fraud losses
- Line chart: Fraud losses over time by type (2013–2022)
- Bar chart: Total cases by fraud type
- Year slicer for interactive filtering

**Page 2  APP Scam Intelligence**
- KPI cards: Total APP losses, reimbursed amount, total cases
- Clustered bar chart: Losses vs reimbursed by scam type
- Donut chart: Share of losses by scam type
- Full data table with all APP scam details

**Page 3  Risk & Access Analysis**
- Clustered bar chart: How criminals gain access by fraud type
- Line chart: Contact method trends 2017 vs 2020 vs 2025
- Stacked bar chart: Fraud stolen vs prevented by category
- Risk breakdown table with composite scores

##  Dashboard Preview

![Dashboard Page 1](images/dashboard_page1.png)

##  Machine Learning

### Models Built
Two classification models were trained to predict fraud risk level
(Critical / High / Medium / Low) based on year, fraud type, 
number of cases and year-on-year change percentage.

### Results

| Model | Single Split | Cross Validation | Std Deviation |
|---|---|---|---|
| Logistic Regression | 100% | 65% | 12% |
| Random Forest | 75% | 45% | 24% |

### Key Findings
- Logistic Regression scored 100% on a single split identified 
  as **overfitting** on the small 20-row dataset
- Cross validation gave a more honest picture  65% average 
  across 5 folds
- **Chosen model: Logistic Regression**  more consistent with 
  lower variance (12% std) vs Random Forest (24% std)
- **Number of cases** is the strongest predictor of fraud risk
- **Year** is the second strongest predictor confirming fraud 
  patterns shift significantly over time
- Dataset limitation: only 20 rows from manually extracted data 
  full ONS microdata would significantly improve model accuracy

### What This Demonstrates
- Ability to build and compare multiple ML models
- Understanding of overfitting and how to identify it
- Use of cross validation for honest model evaluation
- Feature importance analysis to extract business insights
- Honest reporting  not chasing high scores

##  Data Sources

- [UK Finance Annual Fraud Report 2023](https://www.ukfinance.org.uk)
- [ONS Nature of Crime: Fraud and Computer Misuse 2025](https://www.ons.gov.uk)

##  How to Run
```bash
pip install -r requirements.txt

# Run notebooks in order:
# 1. notebooks/01_data_cleaning.ipynb
# 2. notebooks/02_exploratory_analysis.ipynb  
# 3. notebooks/03_ml_model.ipynb

# Open dashboard:
# dashboard/uk_fraud_dashboard.pbix
```

##  Author

**Saketh Veerabathini**  
MSc Business Analytics -  Coventry University  
[LinkedIn](https://www.linkedin.com/in/veerabathini-saketh) | [GitHub](https://github.com/sakethveerabathini)