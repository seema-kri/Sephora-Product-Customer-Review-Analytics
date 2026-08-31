# Sephora Skincare Product & Customer Review Intelligence

An end-to-end SQL analytics project evaluating Sephora's skincare catalog and customer sentiment across **2,351 SKUs** and **1,094,411 customer reviews** to uncover revenue drivers, inventory risks, quality bottlenecks, and pricing opportunities.

---

## 1. Executive Summary & KPIs

The SQL analysis demonstrates a strong baseline customer satisfaction score of **4.30 / 5.00**, driving **$192.54M in total revenue proxy**. However, granular querying reveals acute portfolio concentration, quality issues among high-volume items, and millions in lost stockout revenue.

| Core Performance Metric | Analyzed Value | Business Rule & Description |
| :--- | :--- | :--- |
| **Total Revenue Proxy** | **$192,541,041.10** | Computed via `price_usd * total_pos_feedback_count` (BR-04). |
| **Total Customer Reviews** | **1,094,411** | 100% matched across partitioned datasets (BR-01, BR-02). |
| **Active Skincare SKUs** | **2,351** | Cleaned core skincare catalog scope. |
| **Catalog Average Rating** | **4.30 / 5.00** | Healthy platform-wide baseline customer satisfaction. |
| **Flagged Attention SKUs** | **44 SKUs** | High-traffic items with rating < 3.50 and reviews > 50 (BR-07). |
| **Peak Seasonality Period** | **Q1 (Jan – Mar)** | 329,044 reviews \| $55.59M Revenue Share (28.87%) (BR-06). |

---

## 2. Core SQL Business Insights

### 1. Macro & Sub-Category Performance (BR-05)
* **Revenue Concentration:** **Moisturizers ($60.60M, 31.48%)** and **Treatments ($48.38M, 25.13%)** generate **56.61% of total revenue proxy** across 519,000+ reviews.
* **High-Priced Anchor:** **High Tech Tools** delivers an outsized **$14.00M (7.27%)** across only 76 SKUs due to premium unit pricing.
* **Customer Loyalty Spread:** **Treatments (77.23%)** and **Self Tanners (76.64%)** achieve the highest repeat advocacy, while **Lip Balms & Treatments (60.09%)** and **Cleansers (66.27%)** exhibit the highest consumer churn.

### 2. Brand Concentration & Vendor Quality (BR-05)
* **Top 10 Dependency:** The top 10 brands contribute **40.89% ($78.73M)** of overall catalog revenue proxy.
* **Volume vs. Price Drivers:** **La Mer** leads revenue ($13.37M) via luxury pricing, whereas **Drunk Elephant ($11.63M)** and **Tatcha ($10.06M)** grow through mass volume (>42K reviews each).
* **Sentiment Extremes:** Clean clinical brands lead satisfaction (**DAMDAM 4.74★**, **Dr. Lara Devgan 4.72★**), whereas high-volume brands like **NuFACE (3.88★)** and **Topicals (3.66★)** show noticeable customer dissatisfaction relative to their review volume.

### 3. Product Quality & Attention Watchlist (BR-07)
* **44 high-traffic SKUs** maintain customer satisfaction scores below **3.50★**.
* **Mineral Sunscreens:** Physical SPF formulas from Drunk Elephant (*Umbra SPF 30* at 3.31★), COOLA (*Setting Spray SPF 30* at 3.31★), and Supergoop! (*CC Screen Mineral SPF 50* at 3.40★) show recurring complaints regarding white cast and chalky textures.
* **In-House Brand Vulnerabilities:** Private-label staples like **SEPHORA COLLECTION Clean Lip Balm & Scrub (2.28★, 30.1% rec)** and **Clean Cleansing Wipes (2.56★, 37.8% rec)** rank among the lowest-rated items across the entire catalog.

### 4. Pricing Power, Exclusives & Seasonality (BR-06, BR-08)
* **Limited Edition Elasticity:** Limited-run products command a **62.3% price markup** ($78.72 vs. $48.50 average price) while sustaining higher customer ratings (**4.32★ vs. 4.30★**).
* **Sephora Exclusives:** Drive **$54.31M (28.21% of revenue)** across 701 SKUs at an accessible price point of **$40.35** and **4.29★**.
* **Price Tier Performance:** The **Premium Tier ($50–$100)** captures the largest revenue share (**39.68%**) and the catalog's highest recommendation rate (**76.57%**).
* **Discount Inefficiency:** On-sale items account for only **0.30% ($580K)** of revenue proxy and score lower (**4.15★ vs. 4.30★**).
* **Q1 Post-Holiday Surge:** Calendar **Q1 (Jan–Mar)** leads review activity (**329,044 reviews; $55.59M revenue share**), driven by holiday gift usage and routine resets.

---

## 3. Business Impact Assessment

| Risk / Opportunity Area | Direct Business Impact |
| :--- | :--- |
| **44 Attention SKUs (BR-07)** | Elevated return costs, customer support overhead, and wasted ad spend on low-satisfaction items. |
| **Top-Heavy Brand Dependency** | Supplier concentration risk; top 3 brands represent 18.2% of total platform revenue proxy. |
| **Mineral Sunscreen Sentiment Flaws** | White cast and texture complaints degrade customer retention during spring/summer replenishment cycles. |
| **Limited Edition Pricing Elasticity** | Under-leveraged margin upside; customers accept a 62% price premium without rating degradation. |
| **124 Out-of-Stock SKUs** | **$8.13M** in unfulfilled demand across high-velocity daily staples with 4.25★ customer ratings. |

---

## 4. Actionable Strategic Recommendations

### 1. Merchandising & Quality Control
* **Audit the 44 Flagged SKUs:** Collaborate with vendor partners (Drunk Elephant, Peter Thomas Roth, COOLA) to add explicit application guides (e.g., preventing pilling and white cast) on product pages with < 30% recommendation rates.
* **Reformulate Low-Rated In-House Lines:** Revisit formulas for SEPHORA COLLECTION private-label items rated under 3.00★ (*Clean Lip Balm & Scrub* at 2.28★ and *Cleansing Wipes* at 2.56★) to protect house-brand perception.
* **Promote High-Satisfaction Indie Brands:** Feature high-performing clean brands like **DAMDAM (4.74★)** and **Dr. Lara Devgan (4.72★)** in discovery sections to diversify catalog revenue.

### 2. Pricing & Assortment Curation
* **Scale Limited-Edition Seasonal Kits:** Expand limited-run holiday and summer bundles priced within the **$50–$100 sweet spot**, where conversion and customer recommendation rates peak (76.57%).
* **Protect Full-Price Margin Integrity:** Avoid steep clearance markdowns (discounted items account for only 0.30% of sales and score lower at 4.15★); shift promotional spend toward value-add gift packaging.

### 3. Inventory & Marketing Operations
* **Restock High-Velocity OOS Items:** Prioritize replenishment on the 124 out-of-stock everyday essentials to reclaim the **$8.13M** in uncaptured demand.
* **Capitalize on the Q1 Engagement Peak:** Schedule automated review collection prompts, skincare routine guides, and replenishment campaigns throughout January and February.

---

## 5. SQL Repository Reference

All queries powering this report are structured in the repository files:
* **`01_data_validation.sql`:** Schema integrity checks, row count validation (2,351 products / 1,094,411 reviews), and primary key mapping.
* **`02_business_queries.sql`:** Complete implementation of all 13 business analytics queries (BR-04 to BR-08).
