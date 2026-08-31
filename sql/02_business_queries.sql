-- Query 2: Performance Breakdown by Secondary Category (Sub-Department)
-- BRD Requirement: BR-05 (Revenue & Volume by Category Dimension)
SELECT 
    p.primary_category,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_customer_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy)::numeric / SUM(SUM(r.revenue_proxy)::numeric) OVER ()) * 100, 
        2
    ) AS pct_total_revenue
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.primary_category
ORDER BY total_revenue_proxy DESC;

-- Query 2: Performance Breakdown by Secondary Category (Sub-Department)
-- BRD Requirement: BR-05 (Revenue & Volume by Category Dimension)

SELECT 
    p.secondary_category,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_customer_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy)::numeric / SUM(SUM(r.revenue_proxy)::numeric) OVER ()) * 100, 
        2
    ) AS pct_total_revenue
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.secondary_category
ORDER BY total_revenue_proxy DESC;

-- Query 3: Top 10 Revenue-Generating Brands
-- BRD Requirement: BR-05 (Revenue & Volume by Brand)

SELECT 
    p.brand_name,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_customer_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy)::numeric / SUM(SUM(r.revenue_proxy)::numeric) OVER ()) * 100, 
        2
    ) AS pct_total_revenue
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.brand_name
ORDER BY total_revenue_proxy DESC
LIMIT 10;

-- Query 4: High-Volume Underperforming Products ("Requiring Attention")
-- BRD Requirement: BR-07 (Rating < 3.5 AND Review Count > 50)

SELECT 
    p.product_id,
    p.product_name,
    p.brand_name,
    p.secondary_category,
    p.price_usd,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_customer_rating,
    ROUND(
        (COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END)::numeric / COUNT(r.submission_time)) * 100, 
        2
    ) AS recommendation_rate_pct,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name, p.brand_name, p.secondary_category, p.price_usd
HAVING COUNT(r.submission_time) > 50 
   AND AVG(r.rating) < 3.50
ORDER BY total_reviews DESC, avg_customer_rating ASC;


-- Query 5: Sephora Exclusive vs Regular Products (BR-08)
SELECT 
    CASE 
        WHEN p.sephora_exclusive = 1 THEN 'Exclusive'
        ELSE 'Regular'
    END AS product_type,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY 1;

-- Query 6: Quarterly Demand & Revenue Trend Analysis (BR-05, BR-06)
SELECT 
    r.review_quarter,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM reviews r
GROUP BY r.review_quarter
ORDER BY r.review_quarter;

-- Aggregated Seasonality by Quarter (Q1, Q2, Q3, Q4)
SELECT 
    RIGHT(r.review_quarter, 2) AS calendar_quarter,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy)::numeric / SUM(SUM(r.revenue_proxy)::numeric) OVER ()) * 100, 
        2
    ) AS pct_total_revenue
FROM reviews r
GROUP BY 1
ORDER BY 1;

-- Query 7: Customer Recommendation Rate by Sub-Category
SELECT 
    p.secondary_category,
    COUNT(r.submission_time) AS total_reviews,
    COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END) AS recommended_count,
    ROUND(
        (COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END)::numeric / COUNT(r.submission_time)) * 100, 
        2
    ) AS recommendation_rate_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.secondary_category
ORDER BY recommendation_rate_pct DESC;

-- Query 8: In-Stock vs Out-of-Stock Product Performance (Section 8.2)
SELECT 
    CASE 
        WHEN p.out_of_stock = 1 THEN 'Out of Stock'
        ELSE 'In Stock'
    END AS stock_status,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY 1;

-- Query 9: Online-Only vs In-Store Product Performance (BR-08)
SELECT 
    CASE 
        WHEN p.online_only = 1 THEN 'Online Only'
        ELSE 'In-Store & Online'
    END AS channel_type,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY 1;


-- Query 10: Customer Satisfaction by Price Tier (Section 8.2)
SELECT 
    CASE 
        WHEN p.price_usd < 25 THEN '1. Budget (<$25)'
        WHEN p.price_usd BETWEEN 25 AND 50 THEN '2. Mid-Range ($25-$50)'
        WHEN p.price_usd BETWEEN 50.01 AND 100 THEN '3. Premium ($50-$100)'
        ELSE '4. Luxury (>$100)'
    END AS price_tier,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(
        (COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END)::numeric / COUNT(r.submission_time)) * 100, 
        2
    ) AS recommendation_rate_pct,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY 1
ORDER BY 1;


-- Query 11: Top 5 Highest-Rated Brands vs Bottom 5 Lowest-Rated Brands
(
    SELECT 
        p.brand_name,
        'Top 5 Highest Rated' AS ranking_tier,
        COUNT(DISTINCT p.product_id) AS total_products,
        COUNT(r.submission_time) AS total_reviews,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
        ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
    FROM products p
    JOIN reviews r ON p.product_id = r.product_id
    GROUP BY p.brand_name
    HAVING COUNT(r.submission_time) >= 1000
    ORDER BY avg_rating DESC
    LIMIT 5
)
UNION ALL
(
    SELECT 
        p.brand_name,
        'Bottom 5 Lowest Rated' AS ranking_tier,
        COUNT(DISTINCT p.product_id) AS total_products,
        COUNT(r.submission_time) AS total_reviews,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
        ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
    FROM products p
    JOIN reviews r ON p.product_id = r.product_id
    GROUP BY p.brand_name
    HAVING COUNT(r.submission_time) >= 1000
    ORDER BY avg_rating ASC
    LIMIT 5
)
ORDER BY avg_rating DESC;

-- Query 12: On-Sale vs Full-Price Product Analysis (Section 9 & 8.2)
SELECT 
    CASE 
        WHEN p.on_sale = 1 THEN 'On Sale / Discounted'
        ELSE 'Full Price'
    END AS pricing_structure,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY 1;

-- Query 13: Limited Edition vs Regular Catalog Products (BR-08)
SELECT 
    CASE 
        WHEN p.limited_edition = 1 THEN 'Limited Edition'
        ELSE 'Permanent Catalog'
    END AS edition_type,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    COUNT(r.submission_time) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY 1;