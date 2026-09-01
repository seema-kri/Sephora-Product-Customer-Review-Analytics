# sephora-skincare-commercial-analytics

An end-to-end SQL & Power BI analytics project evaluating Sephora's skincare catalog and customer sentiment across **2,351 active SKUs** and **1,094,411 customer reviews** to uncover revenue drivers, inventory risks, quality bottlenecks, and pricing opportunities.

---

## 1. Executive Summary & KPIs

The analysis demonstrates a strong baseline customer satisfaction score of **4.30 / 5.00**, driving **$192.54M in total revenue proxy**. However, granular querying reveals acute portfolio concentration, quality issues among high-volume items, and millions in commercial revenue exposure.

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

## 2. Core Business Insights

### 1. Macro & Sub-Category Performance (BR-05)
* **Revenue Concentration:** **Moisturizers ($61M)** and **Treatments ($48M)** dominate category sales, generating over half of total revenue proxy across 500K+ reviews.
* **High-Priced Anchor:** **High Tech Tools ($14M)** delivers outsized revenue contribution relative to its smaller SKU count due to premium unit price points.
* **Customer Loyalty Spread:** **Treatments (77.2%)** and **High Tech Tools (76.6%)** achieve the highest customer advocacy rates, while **Cleansers (66.3%)** exhibit the highest customer churn.

### 2. Brand Concentration & Vendor Quality (BR-05)
* **Top 10 Dependency:** The top 10 brands contribute **40.89% ($78.74M)** of overall catalog revenue proxy.
* **Volume vs. Price Drivers:** **La Mer ($13.4M)** leads revenue through luxury unit pricing, whereas **Drunk Elephant ($11.6M)** and **Tatcha ($10.1M)** scale via high review volume.
* **Sentiment Extremes:** Top clinical brands maintain ratings above 4.50★, while select high-volume device/treatment brands show customer dissatisfaction below 4.00★.

### 3. Product Quality & Attention Watchlist (BR-07)
* **44 high-traffic SKUs** maintain customer satisfaction scores below **3.50★** with more than 50 customer reviews.
* **Customer Exposure:** Over **13,321 reviews** and **$6.27M in revenue proxy** are exposed to low satisfaction across these flagged products.
* **Inventory Intersections:** **5 flagged attention SKUs** are currently out of stock, preventing further negative customer exposure while requiring formulation and PDP review prior to restock.

### 4. Pricing Power, Exclusives & Seasonality (BR-06, BR-08)
* **Limited Edition Elasticity:** Limited-run products command higher average price points (**$57.18 vs. $55.58** standard catalog) while sustaining strong customer ratings.
* **Sephora Exclusives:** Anchor accessible pricing at an average of **$38.24** while driving broad volume across key sub-categories.
* **Price Tier Performance:** The **Premium Band ($50–$100)** represents the primary catalog revenue driver (**$78M proxy**), followed by Luxury ($55M) and Core ($44M).
* **Quarterly Demand Peak:** Calendar **Q1** captures peak demand volume (**329K reviews / $56M revenue proxy**), followed by steady normalization through Q2–Q4.

---

## 3. Executive Dashboard Suite

### Page 1: Executive Overview
![Executive Overview](assets/Executive%20Overview.png)

### Page 2: Brand Dynamics & Assortment
![Brand Dynamics & Assortment](assets/Brand%20Dynamics%20%26%20Assortment.png)

### Page 3: Product Attention & Quality
![Product Attention & Quality](assets/Product%20Attention%20%26%20Quality.png)

---

## 4. Top 3 Strategic Recommendations

### 1. Mitigate Quality Risk & Enforce Restock Holds
* **Action:** Audit the **44 Attention SKUs** scoring below 3.50★ to protect **$6.27M** in exposed revenue proxy.
* **Immediate Intervention:** Place an immediate procurement hold on the **5 out-of-stock flagged items** until formulation, packaging, and PDP accuracy reviews are completed.

### 2. Capitalize on the $50–$100 Premium Tier & Limited Edition Pricing Power
* **Action:** Focus new product onboarding and vendor partnerships within the **$50–$100 Premium Tier**, which drives the largest revenue share (**$78M**).
* **Margin Strategy:** Expand seasonal drops and limited-edition product bundles, leveraging verified pricing elasticity (**$57.18 vs. $55.58**) without risking customer satisfaction.

### 3. De-Risk Brand Concentration & Optimize for Q1 Demand Surge
* **Action:** Scale emerging mid-tier brands ($25–$50 and $50–$100 bands) to reduce supplier dependency, where the **top 10 brands control 40.89% ($78.74M)** of catalog revenue.
* **Supply Chain Timing:** Align procurement lead times, marketing budgets, and inventory buffers to prepare for peak **Q1 seasonal demand** (329K reviews / $56M revenue proxy).

---

## 5. Repository Architecture

* **`01_data_validation.sql`:** Schema integrity checks, record count verification (2,351 SKUs / 1,094,411 reviews), null handling, and relational constraints.
* **`02_business_queries.sql`:** SQL implementation of 13 core business analytics queries (BR-01 through BR-08).
* **`03_dashboard_kpis_validation.sql`:** Metric audit queries mirroring all Power BI DAX cards 1:1.
* **`Power BI/Sephora.pbix`:** Interactive 3-page executive reporting suite.
