# 💄 Sephora Skincare Commercial & Customer Intelligence Analytics

> End-to-end commercial analytics project analyzing **2,351 active skincare SKUs** and **1.09M+ customer reviews** using **Python, PostgreSQL, and Power BI** to uncover revenue concentration, pricing power, demand seasonality, and product quality risk.

<p align="center">
  <a href="https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare">
    <img src="https://img.shields.io/badge/Power%20BI-Live%20Interactive%20Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" alt="Power BI Dashboard"/>
  </a>
  <a href="https://github.com/seema-kri/sephora-skincare-commercial-analytics">
    <img src="https://img.shields.io/badge/GitHub-Repository-181717?style=for-the-badge&logo=github" alt="GitHub Repository"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License"/>
  </a>
</p>

---

## 📑 Table of Contents

- [Business Problem & Dataset](#-business-problem--dataset)
- [Tools & Technologies](#️-tools--technologies)
- [Project Structure](#-project-structure)
- [Key Insights & Visuals](#-key-insights--visuals)
- [Business Recommendations](#-business-recommendations)
- [How to Run](#️-how-to-run)
- [Future Work](#-future-work)
- [Author & Connect](#-author--connect)

---

## 📌 Business Problem & Dataset

Large e-commerce catalogs can look healthy in aggregate while individual products carry real dissatisfaction, pricing, and inventory risk. This project turns Sephora's skincare catalog and customer review data into **commercial and operational insights** to support merchandising, pricing, and inventory decisions.

**Data used:**
| Source | Fields |
|---|---|
| Product Catalog | Product ID, Brand, Category, Price, Ingredients, Stock Status |
| Customer Reviews | Product ID, Rating, Recommendation Flag, Review Date, Positive Feedback Count, Review Text |

**Scale:**
| Metric | Value |
|---|---:|
| Active Skincare SKUs | **2,351** |
| Customer Reviews | **1,094,411** |
| Average Rating | **4.30 / 5.00** |
| Revenue Proxy (Price × Positive Feedback Count) | **$192.54M** |

Four business questions guided the analysis: **quality risk**, **brand concentration**, **pricing power**, and **demand timing**.

---

## 🛠️ Tools & Technologies

| Category | Stack |
|---|---|
| Programming | Python, Pandas, NumPy, Jupyter |
| Database | PostgreSQL 14, SQL, CTEs, Window Functions |
| BI & Visualization | Power BI, DAX, Power Query, Microsoft Fabric |
| Data Engineering | SQLAlchemy, Psycopg2, ETL, Data Validation |
| Documentation | Git, GitHub, Markdown, BRD (Business Requirements Doc) |

---

## 📂 Project Structure

```text
sephora-skincare-commercial-analytics/
│
├── Data/
│   ├── Raw/                  # product_info.csv
│   └── processed/            # cleaned product & review samples
│
├── Power BI/
│   ├── Sephora.pbix
│   ├── Sephora.pbit
│   └── Sephora.pdf
│
├── assets/                   # dashboard screenshots
├── docs/                     # BRD.docx, presentation deck
├── notebooks/                # data_cleaning_and_eda.ipynb, database_ingestion.ipynb
├── sql/                      # validation, business queries, KPI checks
│
├── LICENSE
└── README.md
```

---

## 📊 Key Insights & Visuals

### Executive Overview
$192.54M revenue proxy, 1.09M reviews, 2,351 products, 4.30 avg rating, and 44 attention SKUs at a glance — with **Treatments (77.2%)** leading recommendation rate and **Cleansers (66.3%)** lagging.

![Executive Overview](assets/Executive%20Overview.png)

### Brand Dynamics & Assortment
The **Top 10 brands drive 40.89% ($78.74M)** of revenue proxy, led by La Mer ($13.4M) and Drunk Elephant ($11.6M). The **$50–$100 Premium tier** is the single largest revenue band ($78M), and **Limited Edition** products command a higher average price ($57.18) than Standard catalog items ($55.58) without a drop in ratings.

![Brand Dynamics & Assortment](assets/Brand%20Dynamics%20%26%20Assortment.png)

### Product Attention & Quality
Products with **rating < 3.50 and reviews > 50** were flagged as commercial risk — **44 Attention SKUs**, representing **$6.27M revenue proxy at risk** and **13.32K exposed reviews**, including 5 SKUs currently out of stock.

![Product Attention & Quality](assets/Product%20Attention%20%26%20Quality.png)

### Additional Findings
- **Category performance:** Moisturizers ($61M) and Treatments ($48M) generate over 56% of total revenue proxy.
- **Demand seasonality:** Q1 is the peak period (329K reviews, $56M revenue proxy), pointing to a need for earlier inventory and supplier planning.
- **Brand scaling paths differ:** La Mer scales via premium pricing, while Drunk Elephant and Tatcha scale via review velocity.

---

## 💡 Business Recommendations

| Insight | Recommended Decision |
|---|---|
| 44 Attention SKUs ($6.27M at risk), 5 already out of stock | Freeze automatic replenishment on OOS Attention SKUs until vendor/quality review is complete; audit remaining 39 for reformulation or delisting |
| Top 10 brands = 40.89% ($78.74M) of revenue proxy | Reduce concentration risk by investing in mid-tier brand development so no single brand failure threatens portfolio revenue |
| $50–$100 Premium tier drives $78M (largest band) | Prioritize new SKU onboarding and marketing spend in this price band over Budget (<$25) and Core ($25–$50) tiers |
| Limited Edition items price 3% higher with no rating drop | Expand seasonal/Limited Edition drop calendar to capture margin without hurting customer retention |
| Cleansers lag at 66.3% recommendation rate vs. 77.2% for Treatments | Launch a category-level root-cause review for Cleansers (ingredients, packaging, positioning) before next reorder cycle |
| Q1 is peak demand (329K reviews, $56M revenue proxy) | Move procurement and safety-stock planning earlier; align supplier lead times to be Q1-ready by late Q4 |
| La Mer scales on price, Drunk Elephant/Tatcha scale on review velocity | Tailor brand strategy by driver — protect premium pricing for La Mer, invest in review/UGC growth for velocity-driven brands |

### KPI Reconciliation (PostgreSQL ↔ Power BI)

| KPI | PostgreSQL | Power BI | Status |
|---|---:|---:|---|
| Revenue Proxy | $192,541,041.10 | $192.54M | ✅ |
| Reviews | 1,094,411 | 1.09M | ✅ |
| Active SKUs | 2,351 | 2,351 | ✅ |
| Average Rating | 4.30 | 4.30 | ✅ |
| Attention SKUs | 44 | 44 | ✅ |
| Revenue Proxy at Risk | $6,272,296.59 | $6.27M | ✅ |

---

## ⚙️ How to Run

**1. Clone the repository**
```bash
git clone https://github.com/seema-kri/sephora-skincare-commercial-analytics.git
cd sephora-skincare-commercial-analytics
```

**2. Install dependencies**
```bash
pip install pandas numpy sqlalchemy psycopg2 jupyter
```

**3. Run the notebooks**
```bash
jupyter notebook notebooks/data_cleaning_and_eda.ipynb
jupyter notebook notebooks/database_ingestion.ipynb
```

**4. Execute the SQL scripts**
```bash
psql -U postgres -d sephora_db -f sql/01_data_validation.sql
psql -U postgres -d sephora_db -f sql/02_business_queries.sql
psql -U postgres -d sephora_db -f sql/03_dashboard_kpis_validation.sql
```

**5. Open the dashboard**
```text
Power BI/Sephora.pbix
```
in Power BI Desktop, or view the [live interactive dashboard](https://app.fabric.microsoft.com/links/qV4QwUWAIz?ctid=e93d71d6-b5c0-4b78-a861-d9964ecdfcd6&pbi_source=linkShare).

---

## 🔮 Future Work

- **Sentiment analysis (NLP)** on review text to surface ingredient, packaging, and performance complaints by SKU.
- **Predictive stockout modeling** (ARIMA, Prophet, XGBoost) ahead of the Q1 demand peak.
- **Price elasticity modeling** using real transaction data to identify optimal price bands.

---

## 📬 Author & Connect

**Seema Kumari**

- LinkedIn: [linkedin.com/in/seema-kumari-375763308](https://linkedin.com/in/seema-kumari-375763308)
- Email: [kriseema87@gmail.com](mailto:kriseema87@gmail.com)
- GitHub: [github.com/seema-kri](https://github.com/seema-kri)
- LeetCode: [leetcode.com/u/seemakri136/](https://leetcode.com/u/seemakri136/)
