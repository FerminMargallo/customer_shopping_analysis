# Customer Shopping Behavior Analysis

An end-to-end analysis of **3,900 customer-level purchase records** that examines spending patterns, subscription behavior, product ratings, discounts, customer loyalty, and shipping preferences. The project combines Python data preparation, PostgreSQL analysis, Power BI reporting, and an executive PDF report.

> **Scope:** The source is a public synthetic dataset. The findings are descriptive and identify opportunities for testing; they do not establish causal effects.

## Business Questions

- Which customer groups contribute the most revenue, and is the difference driven by customer volume or spend per customer?
- Do subscribers spend more than non-subscribers?
- Which products have the highest customer ratings or depend most on discounts?
- How are customers distributed by purchase history?
- Does shipping type present an upsell opportunity?

## Dataset at a Glance

| Measure | Value |
| --- | ---: |
| Customer records | 3,900 |
| Original columns | 18 |
| Unique locations | 50 |
| Missing values | 37, all in `review_rating` |
| Average purchase amount | $59.76 |
| Average review rating | 3.75 / 5 |
| Customer age | 18–70 years; average 44 |

Each row represents one customer and a current purchase. `previous_purchases` is the historical purchase count used for loyalty-oriented analysis.

## Workflow

1. **Explore the data** - Profile data types, distributions, missing values, and descriptive statistics in Python.
2. **Clean and prepare** - Rename fields to `snake_case`, impute missing review ratings with the median rating within each product category, and remove the redundant `promo_code_used` field.
3. **Engineer analysis features** - Create age groups and prepare purchase-frequency values for analysis.
4. **Load to PostgreSQL** - Write the prepared DataFrame to a `customer` table for SQL analysis.
5. **Analyze and report** - Use SQL, Power BI, and the executive report to evaluate revenue, subscriptions, product ratings, discount rates, purchase history, shipping, and age groups.

## Key Findings

- **Gender differences in total revenue are volume-driven.** Male customers generated $157,890 in revenue compared with $75,191 from female customers, but also represent 68% of the dataset (2,652 of 3,900). Average spend per customer is nearly the same across genders.
- **Subscriptions do not show a meaningful spend uplift.** Only 27% of customers are subscribed, and subscriber average spend is approximately $59.50, close to the portfolio average.
- **Loyal customers dominate the base.** The SQL segmentation rule classifies customers as Loyal (3,116), Returning (701), or New (83) according to `previous_purchases`.
- **Discount exposure is concentrated.** Hat, Sneakers, Coat, Sweater, and Pants have the highest observed discount rates and should be reviewed alongside margin data.
- **Top-rated products are concentrated in accessories and footwear.** Gloves (3.86), Sandals (3.84), Boots (3.82), Hat (3.80), and Skirt (3.78) receive the highest average ratings.
- **Express shipping warrants a controlled upsell test.** Express customers spend $60.48 on average, versus $58.46 for Standard shipping; this small difference should be tested rather than treated as causal.
- **Age-group revenue is relatively balanced.** Revenue ranges from roughly $55K to $62K per age group, with Young Adults contributing the most.

## Recommendations

1. Test a clearer subscriber value proposition before investing in subscriber acquisition.
2. Protect and reward the Loyal customer base while monitoring the small New segment for onboarding opportunities.
3. Review discount rules for the five most-discounted products with product-level margin data.
4. Run an A/B test for an Express-shipping prompt and measure incremental conversion, revenue, and margin.
5. Combine customer volume, purchase amount, and profitability when prioritizing demographic or age-group campaigns.

## Dashboard and Report

- Open [customer_shopping_analysis.pbix](dashboard/customer_shopping_analysis.pbix) in Power BI Desktop to explore the interactive dashboard.
- See the [dashboard preview](dashboard/screenshot.png) for its current layout and filters.
- Read the [executive report](report/Customer-Shopping-Behavior-Analysis.pdf) for the visual summary and recommendations.

## Repository Structure

```text
customer_shopping_analysis/
├── data/
│   └── customer_shopping_behavior.csv
├── notebooks/
│   └── 01_baseline_eda.ipynb
├── sql/
│   └── 01_analysis_queries.sql
├── dashboard/
│   ├── customer_shopping_analysis.pbix
│   └── screenshot.png
├── report/
│   └── Customer-Shopping-Behavior-Analysis.pdf
├── requirements.txt
└── README.md
```

## Getting Started

### Prerequisites

- Python 3.10+
- PostgreSQL 14+ (optional, required for the SQL workflow)
- Power BI Desktop (optional, required to open the `.pbix` dashboard)

### Install Python Dependencies

```bash
git clone https://github.com/FerminMargallo/customer_shopping_analysis.git
cd customer_shopping_analysis

python -m venv .venv
# Windows PowerShell: .venv\Scripts\Activate.ps1
# macOS/Linux: source .venv/bin/activate

python -m pip install --upgrade pip
python -m pip install -r requirements.txt sqlalchemy psycopg2-binary
```

### Run the Notebook

The notebook reads the dataset with a path relative to the `notebooks/` directory. Start Jupyter from that directory:

```bash
cd notebooks
jupyter notebook 01_baseline_eda.ipynb
```

Before running the PostgreSQL loading cell, configure it with your own local connection details. Do not commit passwords or connection strings to the repository.

### Run the SQL Analysis

After the notebook has created the `customer` table, run the query script against your database:

```bash
psql -d <database_name> -f sql/01_analysis_queries.sql
```

## Tools

- Python: pandas and Jupyter Notebook
- PostgreSQL: SQL analysis
- Power BI: interactive dashboard
- Gamma: executive PDF report

## Author

Fermín Margallo - Data Analyst

[GitHub](https://github.com/FerminMargallo) · [Email](mailto:fmargalloremon@gmail.com)
gmail.com)
