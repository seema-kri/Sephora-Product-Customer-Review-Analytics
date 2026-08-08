# Sephora Product & Customer Sentiment Analytics

**A revenue-risk investigation: turning 601K+ customer reviews into a self-service decision tool that tells Sephora leadership exactly which products, brands, and categories are quietly costing the business money.**

Built with **SQL (PostgreSQL)**, **Python (Pandas, VADER)**, and **Power BI**, from a signed-off business requirements document through to a published, three-page interactive dashboard.

📊 **[View Live Dashboard](https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare&bookmarkGuid=fab99531-4b07-4150-9863-6456b360d8f9)** &nbsp;|&nbsp; 📄 [Business Requirements Document](Docs/BRD.docx) &nbsp;|&nbsp; 📑 [SQL Findings Report](Docs/Sephora_SQL_Findings_Report.docx)

---

## Table of Contents
- [Executive Summary](#executive-summary)
- [Live Dashboard](#live-dashboard)
- [Business Problem](#business-problem)
- [Project Deliverables](#project-deliverables)
- [Dataset Description](#dataset-description)
- [Tools & Technologies](#tools--technologies)
- [Project Structure](#project-structure)
- [Methodology](#methodology)
- [Key Findings](#key-findings)
- [Dashboard Walkthrough](#dashboard-walkthrough)
- [How to Run This Project](#how-to-run-this-project)
- [Recommendations & Roadmap](#recommendations--roadmap)
- [Author & Contact](#author--contact)

---

## Executive Summary

Sephora's catalog holds 8,200+ products across 9 categories and 300+ brands. Star ratings and reviews are one of the earliest, cheapest signals of a product quietly going bad, but that signal was sitting unused in raw form until a problem was already showing up in sales or returns, by which point the cost was already incurred.

This project was scoped like a paid analytics engagement. A **Business Requirements Document** defined the exact business questions before a single query was written. The output is a validated, quantified answer to "where is our catalog losing us money," not a dashboard of vanity metrics.

| | |
|---|---|
| **Reviews analyzed** | 601,131 (2008 to 2023) |
| **Products analyzed** | 8,216 across 302 brands |
| **Revenue exposure identified** | **$9.32M** across 222 high-price, low-rating SKUs |
| **Rating/sentiment mismatch flagged** | Approximately 56,000 reviews where text disagrees with the star rating |

## Live Dashboard

🔗 **[Open the interactive Power BI dashboard](https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare&bookmarkGuid=fab99531-4b07-4150-9863-6456b360d8f9)**

Three-page interactive report, filterable by category, brand, price range, and year. Explore live in your browser, no download required.

## Business Problem

Underperforming products can sit in Sephora's catalog for years before the problem surfaces in sales or return data, by which point the cost is already sunk. Leadership had no repeatable way to answer:

- Which categories and brands are quietly underperforming?
- Which of those are actually costing the business money, not just collecting bad ratings?
- Is price actually related to satisfaction, or is that assumption wrong?
- Are star ratings alone trustworthy, or do they disagree with what customers are actually writing?

The engagement was scoped up front in a formal **[Business Requirements Document](Docs/BRD.docx)**, defining objectives, in/out-of-scope boundaries, and success criteria before any data work began. This is the same discipline a consulting or enterprise analytics team applies before touching a dataset. This project answers all four questions with data, and hands the answer to stakeholders as a dashboard, not a one-off report.

## Project Deliverables

This repository is structured as a complete analytics engagement, not just a dashboard file.

| Deliverable | Purpose |
|---|---|
| **[Business Requirements Document](Docs/BRD.docx)** | Problem definition, scope, and success criteria, agreed before build |
| **[SQL Findings Report](Docs/Sephora_SQL_Findings_Report.docx)** | Full written analysis behind every number in the dashboard |
| **[Sephora.pbit](Dashboard/Sephora.pbit)** | Reusable Power BI template |
| **[Queries.sql](Sql/Queries.sql)** | Full SQL query set answering each business question |
| **[Data_cleaning.ipynb](Notebook/Data_cleaning.ipynb)** | Reproducible cleaning pipeline |
| **[sentiment_analysis.ipynb](Notebook/sentiment_analysis.ipynb)** | VADER sentiment scoring, validated against star ratings |
| **[Live Dashboard link](https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare&bookmarkGuid=fab99531-4b07-4150-9863-6456b360d8f9)** | Published, self-service report for stakeholders |

## Dataset Description

| File | Rows | Description |
|---|---|---|
| `product_info.csv` | 8,216 | Product name, brand, category, price, rating, review count |
| Reviews data | 601,131 | Rating, review text, skin type, submission date (2008 to 2023) |

Source: [Sephora Products and Skincare Reviews dataset, Kaggle](https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews).

## Tools & Technologies

| Category | Tool |
|---|---|
| Requirements & Scoping | Business Requirements Document (Word) |
| Data Cleaning | Python (Pandas) |
| Sentiment Analysis | Python (VADER) |
| Business-Question Analysis | SQL (PostgreSQL) |
| Visualization | Power BI |
| Validation | Excel |
| Version Control | Git & GitHub |

## Project Structure

```
Sephora-Product-Sentiment-Analytics/
├── Dashboard/
│   ├── Customer Sentiment.png
│   ├── Executive Action Plan.png
│   ├── Executive Overview.png
│   ├── Product Performance.png
│   └── Sephora.pbit
├── Data/
│   ├── product_info.csv
│   └── Readme
├── Docs/
│   ├── BRD.docx
│   ├── Sephora_SQL_Findings_Report.docx
│   └── Readme
├── Notebook/
│   ├── Data_cleaning.ipynb
│   ├── sentiment_analysis.ipynb
│   └── Readme
├── Sql/
│   ├── Queries.sql
│   └── Readme
├── LICENSE
└── README.md
```

## Methodology

**1. Requirements first.** Business questions, scope, and success metrics were documented and agreed in the BRD before any pipeline work began. Every downstream artifact traces back to a question defined up front.

**2. Data Cleaning & Preparation.** See [`Notebook/Data_cleaning.ipynb`](Notebook/Data_cleaning.ipynb).
- Removed duplicate and null product rows, standardized brand/category naming.
- Cast price and rating fields to correct numeric types.
- Built derived fields: price band, revenue exposure (price multiplied by review count).
- Merged product-level and review-level data on `product_id` for downstream sentiment work.

**3. SQL Business-Question Analysis.** See [`Sql/Queries.sql`](Sql/Queries.sql).
- Cleaned tables loaded into PostgreSQL; each business question in the BRD mapped to a dedicated, documented query.
- Findings written up in full in the [SQL Findings Report](Docs/Sephora_SQL_Findings_Report.docx).

**4. Sentiment Validation.** See [`Notebook/sentiment_analysis.ipynb`](Notebook/sentiment_analysis.ipynb).
- VADER sentiment scoring applied to 601K+ review texts.
- Cross-checked against star ratings to flag disagreement, a validation layer raw ratings alone don't provide.

**5. Dashboard & Packaging.** Power BI report built on the cleaned, validated dataset for non-technical stakeholder self-service.

## Key Findings

- 🌸 **Fragrance is the weak category, at scale.** Fragrance brands (KILIAN, TOM FORD, PHLUR, Jo Malone) show up repeatedly at the bottom of brand rankings, consistent across category, brand, and risk-product queries, not a one-off.
- 💸 **$9.32M in revenue exposure sits on high-price, low-rating products.** 222 SKUs priced $50+ with rating under 3.8, led by KILIAN's "Love, Don't Be Shy" at approximately $345K exposure alone.
- 💲 **Price and rating are genuinely correlated** (4.02 avg under $20, 4.27 avg at $100+), which makes the products that break that pattern the real red flags.
- 🧴 **Skin type has almost no effect on rating** (4.29 to 4.31 across all types). Satisfaction is a product/category problem, not an audience-segmentation problem.
- 📉 **Average rating has quietly declined for 13 years** (4.53 in 2010 to 4.21 in 2023) even as review volume grew 10x, flagging a longer-term quality trend worth investigating.
- ✅ **Sentiment analysis (VADER)** on review text largely backs up star ratings, but flags approximately 56,000 reviews where written sentiment and star rating disagree, a validation layer raw ratings alone don't give you.

## Dashboard Walkthrough

🔗 **[View Live Dashboard](https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare&bookmarkGuid=fab99531-4b07-4150-9863-6456b360d8f9)**

Three-page interactive Power BI dashboard, filterable by category, brand, price range, and year.

### Executive Overview
Catalog health at a glance: 8,216 products, 302 brands, 4.31 avg rating, 89.42% positive sentiment.

![Executive Overview](Dashboard/Executive%20Overview.png)

### Customer Sentiment
Rating vs. text-sentiment distribution, recommendation breakdown, and the 13-year rating trend.

![Customer Sentiment](Dashboard/Customer%20Sentiment.png)

### Product Performance
Revenue exposure by category and the ranked list of highest-risk products.

![Product Performance](Dashboard/Product%20Performance.png)

### Executive Action Plan
Prioritized, stakeholder-facing view translating the findings above into recommended next steps.

![Executive Action Plan](Dashboard/Executive%20Action%20Plan.png)

## How to Run This Project

1. **Clone the repo**
   ```bash
   git clone https://github.com/<your-username>/Sephora-Product-Sentiment-Analytics.git
   cd Sephora-Product-Sentiment-Analytics
   ```
2. **Review the requirements.** Read [`Docs/BRD.docx`](Docs/BRD.docx) for the full problem scope and success criteria.
3. **Data cleaning.** Open `Notebook/Data_cleaning.ipynb` in Jupyter and run all cells to regenerate the cleaned dataset from `Data/product_info.csv`.
4. **Sentiment analysis.** Run `Notebook/sentiment_analysis.ipynb` to score review text with VADER.
5. **SQL analysis.** Load the cleaned tables into PostgreSQL and run the queries in `Sql/Queries.sql`. Full write-up in [`Docs/Sephora_SQL_Findings_Report.docx`](Docs/Sephora_SQL_Findings_Report.docx).
6. **Dashboard.** Open `Dashboard/Sephora.pbit` in Power BI Desktop and point it at the cleaned data to refresh, or view it live via the **[Live Dashboard link](https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare&bookmarkGuid=fab99531-4b07-4150-9863-6456b360d8f9)**.

## Recommendations & Roadmap

**Recommendations:**
- Run a targeted quality/reformulation review on the fragrance category and skincare devices (NuFACE, iluminage), the two clusters driving most revenue exposure.
- Investigate the 13-year rating decline, starting with whether it's concentrated in Makeup and Fragrance.
- Deprioritize skin-type-based segmentation for this problem; it isn't a meaningful lever in the data.

**Roadmap:**
- Connect the dashboard to a live, refreshable data source.
- Extend sentiment analysis with a beauty-domain-tuned model.
- Bring in return/sales data to replace revenue exposure with confirmed financial impact.

## Author & Contact

**Seema Kumari**
Data Analyst | Business Intelligence & Microsoft Fabric

- 📧 Email: [seemakri136@gmail.com](mailto:seemakri136@gmail.com)
- 💼 LinkedIn: [linkedin.com/in/seema-kumari-375763308](https://linkedin.com/in/seema-kumari-375763308)

---

⭐ If you found this project useful, consider giving it a star. It helps others discover it.
