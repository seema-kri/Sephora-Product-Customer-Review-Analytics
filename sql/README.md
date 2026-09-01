# Sephora Skincare Product & Customer Review Intelligence

An end-to-end SQL analytics project evaluating Sephora's skincare catalog and customer sentiment across **2,351 active SKUs** and **1,094,411 customer reviews** to uncover revenue drivers, inventory risks, quality bottlenecks, and pricing opportunities.

---

## 1. Executive Summary & KPIs

The SQL analysis demonstrates a strong baseline customer satisfaction score of **4.30 / 5.00**, driving **$192.54M in total revenue proxy**. However, granular querying reveals acute portfolio concentration, quality issues among high-volume items, and millions in lost stockout revenue.

| Core Performance Metric | Analyzed Value | Business Rule & Description |
| :--- | :--- | :--- |
| **Total Revenue Proxy** | **$192,541,041.10** | Computed via `price_usd * total_pos_feedback_count` (BR-04). |
| **Total Customer Reviews** | **1,094,411** | 100% matched across partitioned datasets (BR-01, BR-02). |
| **Active Skincare SKUs** | **2,351** | Cleaned core skincare catalog scope. |
| **Catalog Average Rating** | **4.30 / 5.00** | Healthy platform-wide baseline customer satisfaction. |
| **Catalog Recommendation Rate** | **71.10%** | Baseline customer advocacy across all reviews (BR-05). |
| **Flagged Attention SKUs** | **44 SKUs** | High-traffic items with rating < 3.50 and reviews > 50 (BR-07). |
| **Attention SKUs Revenue at Risk** | **$6,272,296.59** | Commercial revenue tied directly to low-satisfaction items. |
| **Attention SKUs Out of Stock** | **5 SKUs** | Low-rated items currently experiencing unfulfilled stockouts. |
| **Peak Seasonality Period** | **Q1 (Jan – Mar)** | Leads seasonal review activity and revenue proxy generation (BR-06). |

---

## 2. Core SQL Business Insights

### 1. Macro & Sub-Category Performance (BR-05)
* **Revenue Concentration:** **Moisturizers** and **Treatments** dominate category sales, generating over half of total revenue proxy across 500K+ reviews.
* **High-Priced Anchor:** **High Tech Tools** delivers outsized revenue contribution relative to its smaller SKU count due to premium unit price points.
* **Customer Loyalty Spread:** **Treatments** and **Masks** achieve the highest customer advocacy rates, while categories with formulation sensitivity show lower retention.

### 2. Brand Concentration & Vendor Quality (BR-05)
* **Top 10 Dependency:** The top 10 brands contribute **40.89% ($78.74M)** of overall catalog revenue proxy.
* **Volume vs. Price Drivers:** **La Mer** leads revenue through luxury unit pricing, whereas **Drunk Elephant** and **Tatcha** scale via high review volume.
* **Sentiment Extremes:** Top-tier brands maintain ratings above 4.50★, while select high-volume device/treatment brands score below 4.00★.

### 3. Product Quality & Attention Watchlist (BR-07)
* **44 high-traffic SKUs** maintain customer satisfaction scores below **3.50★** with more than 50 customer reviews.
* **Customer Exposure:** Over **13,321 reviews** and **$6.27M in revenue proxy** are exposed to low satisfaction across these flagged products.
* **Inventory Intersections:** **5 flagged attention SKUs** are currently out of stock, preventing further customer exposure while requiring formulation/listing review prior to restock.

### 4. Pricing Power, Exclusives & Seasonality (BR-06, BR-08)
* **Limited Edition Elasticity:** Limited-run products command higher average price points ($57.18 vs. $55.58 standard catalog) while sustaining strong customer ratings.
* **Sephora Exclusives:** Anchor accessible pricing at an average of **$38.24** while driving broad volume across key sub-categories.
* **Price Tier Performance:** The **Premium Band ($50–$100)** represents the primary catalog revenue driver ($78M proxy), followed by Luxury ($55M) and Mid-Range/Core ($44M).
* **Quarterly Demand Peak:** Calendar **Q1** captures the highest demand volume (300K+ reviews), followed by a steady normalization through Q2–Q4.

---

## 3. Business Impact Assessment

| Risk / Opportunity Area | Direct Business Impact |
| :--- | :--- |
| **44 Attention SKUs (BR-07)** | **$6.27M in revenue at risk** driving elevated returns and customer churn. |
| **Top 10 Brand Concentration** | Supplier dependency; top 10 brands control **40.89%** of platform revenue proxy. |
| **5 OOS Flagged Products** | Stockouts prevent negative review velocity but risk automatic re-order without QA remediation. |
| **Limited Edition Pricing Elasticity** | Higher price realization ($57.18 avg) without customer rating degradation. |
| **Premium Price Band Dominance** | **$50–$100 price tier** drives maximum revenue ($78M), validating premium SKU onboarding. |

---

## 4. Actionable Strategic Recommendations

### 1. Merchandising & Quality Control
* **Audit the 44 Flagged Attention SKUs:** Prioritize formulation, packaging, and PDP expectation audits across the 44 products scoring under 3.50★ (protecting **$6.27M** in revenue proxy).
* **Hold Restock on 5 OOS Flagged Items:** Place an operational procurement hold on the 5 out-of-stock attention SKUs until vendor quality audits are completed.
* **Target Formula Reviews on Low-Scoring Categories:** Focus vendor quality interventions on low-advocacy lines to bring category recommendation rates up toward the platform 71.10% benchmark.

### 2. Pricing & Assortment Curation
* **Expand the $50–$100 Premium Assortment:** Focus new product onboarding and vendor partnerships within the **$50–$100 tier**, which generates the largest revenue volume ($78M).
* **Scale Limited-Edition Product Drops:** Expand high-margin seasonal drops and exclusive bundles leveraging verified pricing power ($57.18 vs. $55.58).

### 3. Inventory & Marketing Operations
* **Prepare Inventory for Q1 Demand Surge:** Align inventory purchasing and warehouse capacity for peak Q1 review and demand volumes.
* **Diversify Mid-Tier Brand Partnerships:** Scale emerging brands in the $25–$50 and $50–$100 tiers to mitigate the 40.89% revenue concentration among the top 10 vendor partners.

---

## 5. SQL Repository Reference

All queries powering this report are structured in the repository files:
* **`01_data_validation.sql`:** Schema integrity checks, row count validation (2,351 products / 1,094,411 reviews), null handling, and relational mapping.
* **`02_business_queries.sql`:** Complete implementation of all 13 core business analytics queries (BR-04 through BR-08).
