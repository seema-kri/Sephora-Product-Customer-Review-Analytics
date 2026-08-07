# Sephora Product & Customer Sentiment Analytics

Identifying which products, brands, and categories put Sephora's revenue at risk using SQL, Python, and Power BI to turn 601K+ customer reviews into a self-service decision tool.

---

## Table of Contents
- [Overview](#overview)
- [Business Problem](#business-problem)
- [Dataset Description](#dataset-description)
- [Tools & Technologies](#tools--technologies)
- [Project Structure](#project-structure)
- [Data Cleaning & Preparation](#data-cleaning--preparation)
- [EDA & Key Insights](#eda--key-insights)
- [Dashboard](#dashboard)
- [How to Run This Project](#how-to-run-this-project)
- [Final Recommendations & Future Work](#final-recommendations--future-work)
- [Author & Contact](#author--contact)

---

## Overview

Sephora's catalog spans 8,200+ products across 9 categories and 300+ brands. Customer ratings and reviews are one of the strongest early signals of product quality but that signal was sitting unused in raw form. This project builds an end-to-end pipeline: clean the raw product and review data, run SQL analysis to answer specific business questions, validate star ratings against written-review sentiment in Python, and package everything into an interactive Power BI dashboard that a non-technical stakeholder can use without ever touching a query.

## Business Problem

Underperforming products can stay in Sephora's catalog for a long time before a problem shows up in sales or return data by which point the cost is already incurred. Leadership had no repeatable way to answer:
- Which categories and brands are quietly underperforming?
- Which of those are actually costing the business money, not just collecting bad ratings?
- Is price actually related to satisfaction, or is that assumption wrong?
- Are star ratings alone trustworthy, or do they disagree with what customers are actually writing?

This project answers all four with data, and hands the answer to stakeholders as a dashboard, not a one-off report.

## Dataset Description

| File | Rows | Description |
|---|---|---|
| `product_info.csv` | 8,216 | Product name, brand, category, price, rating, review count |
| Reviews data | 601,131 | Rating, review text, skin type, submission date (2008–2023) |

Source: [Sephora Products and Skincare Reviews dataset, Kaggle](https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews).

## Tools & Technologies

- **SQL (PostgreSQL)** — business-question analysis
- **Python (Pandas, VADER)** — data cleaning, sentiment analysis
- **Power BI** — interactive dashboard
- **Excel** — quick validation checks
- **Git / GitHub** — version control

## Project Structure

```
Sephora-Product-Sentiment-Analytics/
├── Dashboard/
│   ├── Customer Sentiment.png
│   ├── Executive Overview.png
│   ├── Product Performance.png
│   └── Sephora.pbit
├── Data/
│   └── product_info.csv
├── Docs/
│   ├── BRD.docx
│   └── Sephora_SQL_Findings_Report.docx
├── Notebook/
│   ├── Data_cleaning.ipynb
│   └── sentiment_analysis.ipynb
├── Sql/
│   └── Queries.sql
├── LICENSE
└── README.md
```

## Data Cleaning & Preparation

Done in `Notebook/Data_cleaning.ipynb`:
- Removed duplicate and null product rows, standardized brand/category naming
- Cast price and rating fields to correct numeric types
- Built derived fields: price band, revenue exposure (price × review count)
- Merged product-level and review-level data on `product_id` for downstream sentiment work

## EDA & Key Insights

Full query set in [`Sql/Queries.sql`](Sql/Queries.sql), full write-up in [`Docs/Sephora_SQL_Findings_Report.docx`](Docs/Sephora_SQL_Findings_Report.docx).

- **Fragrance is the weak category, at scale.** Fragrance brands (KILIAN, TOM FORD, PHLUR, Jo Malone) show up repeatedly at the bottom of brand rankings — consistent across category, brand, and risk-product queries, not a one-off.
- **$9.32M in revenue exposure sits on high-price, low-rating products.** 222 SKUs priced $50+ with rating under 3.8 — led by KILIAN's "Love, Don't Be Shy" at ~$345K exposure alone.
- **Price and rating are genuinely correlated** (4.02 avg under $20 → 4.27 avg at $100+), which makes the products that break that pattern the real red flags.
- **Skin type has almost no effect on rating** (4.29–4.31 across all types) — satisfaction is a product/category problem, not an audience-segmentation problem.
- **Average rating has quietly declined for 13 years** (4.53 in 2010 → 4.21 in 2023) even as review volume grew 10x, flagging a longer-term quality trend worth investigating.
- **Sentiment analysis (VADER)** on review text largely backs up star ratings, but flags ~56K reviews where written sentiment and star rating disagree — a validation layer raw ratings alone don't give you.

## Dashboard

🔗 **[Live Dashboard (Power BI / Fabric)](https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare&bookmarkGuid=fab99531-4b07-4150-9863-6456b360d8f9)**

Three-page interactive Power BI dashboard, filterable by category, brand, price range, and year.

**Executive Overview** — catalog health at a glance: 8,216 products, 302 brands, 4.31 avg rating, 89.42% positive sentiment.

![Executive Overview](Dashboard/Executive%20Overview.png)

**Customer Sentiment** — rating vs. text-sentiment distribution, recommendation breakdown, and the 13-year rating trend.

![Customer Sentiment](Dashboard/Customer%20Sentiment.png)

**Product Performance** — revenue exposure by category and the ranked list of highest-risk products.

![Product Performance](Dashboard/Product%20Performance.png)

## How to Run This Project

1. **Clone the repo**
   ```bash
   git clone https://github.com/<your-username>/Sephora-Product-Sentiment-Analytics.git
   cd Sephora-Product-Sentiment-Analytics
   ```
2. **Data cleaning** — open `Notebook/Data_cleaning.ipynb` in Jupyter and run all cells to regenerate the cleaned dataset from `Data/product_info.csv`.
3. **Sentiment analysis** — run `Notebook/sentiment_analysis.ipynb` to score review text with VADER.
4. **SQL analysis** — load the cleaned tables into PostgreSQL and run the queries in `Sql/Queries.sql`.
5. **Dashboard** — open `Dashboard/Sephora.pbit` in Power BI Desktop and point it at the cleaned data to refresh.

## Final Recommendations & Future Work

- Run a targeted quality/reformulation review on the fragrance category and skincare devices (NuFACE, iluminage) — the two clusters driving most revenue exposure.
- Investigate the 13-year rating decline, starting with whether it's concentrated in Makeup and Fragrance.
- Deprioritize skin-type-based segmentation for this problem; it isn't a meaningful lever in the data.
- **Future work:** connect the dashboard to a live/refreshable data source, extend sentiment analysis with a beauty-domain-tuned model, and bring in return/sales data to replace revenue exposure with confirmed financial impact.

## Author & Contact

**Seema Kumari** — Data Analyst

📧 Email: seemakri136@gmail.com
💼 LinkedIn: linkedin.com/in/seema-kumari-375763308

⭐ If you found this project useful, consider giving it a star it helps others discover it.
