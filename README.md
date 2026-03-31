# 🇬🇧 UK Fraud Intelligence Analysis (2019–2024)

## The Problem
UK fraud losses exceeded £1.2 billion in 2023. But where exactly 
is the money going and did COVID permanently shift the pattern?

## What This Project Does
This project analyses UK fraud trends across categories, regions and 
time using real data from UK Finance, ONS and Action Fraud. It builds 
a machine learning model to classify high-risk fraud segments and 
visualises findings in an interactive Power BI dashboard.

## Key Questions Answered
- Which fraud types grew the most post-COVID?
- Which regions of the UK are highest risk?
- Can we predict fraud risk level from category and region alone?

## Tools & Technologies
| Tool | Purpose |
|------|---------|
| SQL (SQLite) | Data exploration & aggregation |
| Python (Pandas, Seaborn, Scikit-learn) | EDA, feature engineering, ML |
| Excel | Executive summary & pivot reporting |
| Power BI | Interactive fraud intelligence dashboard |

## Project Structure
```
uk-fraud-intelligenceanalysis/
├── data/              ← Raw and processed datasets
├── sql/               ← SQL exploration scripts
├── notebooks/         ← Jupyter notebooks (EDA → ML)
├── excel/             ← Executive summary workbook
├── dashboard/         ← Power BI dashboard (.pbix)
└── images/            ← Dashboard & chart previews
```

## Dashboard Preview
*Coming soon*

## Data Sources
- [UK Finance Fraud Report](https://www.ukfinance.org.uk)
- [ONS Crime Statistics](https://www.ons.gov.uk)
- [Action Fraud](https://www.actionfraud.police.uk)
- [Bank of England](https://www.bankofengland.co.uk)

## How to Run
```bash
pip install -r requirements.txt
# Open notebooks/ in order 01 → 02 → 03 → 04
```

##  Author
**Saketh Veerabathini** — MSc Business Analytics, Coventry University  
[LinkedIn](https://www.linkedin.com/in/veerabathini-saketh) | [GitHub](https://github.com/sakethveerabathini)