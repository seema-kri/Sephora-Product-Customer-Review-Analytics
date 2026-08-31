--Query 1. Primary Category Macro Performance (BR-05)
-- What is the macro-level revenue proxy contribution, review count, and average customer rating across the primary product catalog?

SELECT 
    p.primary_category,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.primary_category
ORDER BY total_revenue_proxy DESC;

--Query 2: Sub-Category Revenue & Review Breakdown (BR-05)
--Which specific product sub-categories drive the largest shares of revenue and repeat engagement?

SELECT 
    p.secondary_category,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(
        (COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END)::numeric / 
        NULLIF(COUNT(r.product_id), 0) * 100)::numeric, 2
    ) AS recommendation_rate_pct,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy) / SUM(SUM(r.revenue_proxy)) OVER () * 100)::numeric, 2
    ) AS revenue_share_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.secondary_category
ORDER BY total_revenue_proxy DESC;

--Query 3: Top 10 Revenue-Generating Brands (BR-05)
--Which brands dominate revenue proxy, and what is the market share concentration among top partners?

SELECT 
    p.brand_name,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy) / SUM(SUM(r.revenue_proxy)) OVER () * 100)::numeric, 2
    ) AS revenue_share_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.brand_name
ORDER BY total_revenue_proxy DESC
LIMIT 10;

--Query 4: Products Requiring Immediate Attention (BR-07)
--Which high-traffic products have low customer satisfaction (rating $< 3.50$ and review count $> 50$)?

SELECT 
    p.product_id,
    p.product_name,
    p.brand_name,
    p.secondary_category,
    p.price_usd,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(
        (COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END)::numeric / 
        NULLIF(COUNT(r.product_id), 0) * 100)::numeric, 2
    ) AS recommendation_rate_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name, p.brand_name, p.secondary_category, p.price_usd
HAVING COUNT(r.product_id) > 50 AND AVG(r.rating) < 3.50
ORDER BY total_reviews DESC;

--Query 5: Exclusivity Comparison (Sephora Exclusive vs. Regular) (BR-08)
--How do Sephora-exclusive products perform against regular multi-brand products in revenue, pricing, and ratings?

SELECT 
    CASE WHEN p.sephora_exclusive = 1 THEN 'Exclusive' ELSE 'Non-Exclusive' END AS exclusivity_status,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_catalog_price,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy) / SUM(SUM(r.revenue_proxy)) OVER () * 100)::numeric, 2
    ) AS revenue_share_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.sephora_exclusive;

--Query 6: Seasonal Review Demand & Revenue Proxy Trends (BR-05, BR-06)
--What is the quarterly seasonality trend in customer review volume and revenue proxy?

SELECT 
    r.review_quarter,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy) / SUM(SUM(r.revenue_proxy)) OVER () * 100)::numeric, 2
    ) AS revenue_share_pct
FROM reviews r
GROUP BY r.review_quarter
ORDER BY r.review_quarter ASC;

--Query 7: Recommendation Rate by Category
--Which categories achieve the highest vs. lowest customer recommendation rates?

SELECT 
    p.secondary_category,
    COUNT(r.product_id) AS total_reviews,
    ROUND(
        (COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END)::numeric / 
        NULLIF(COUNT(r.product_id), 0) * 100)::numeric, 2
    ) AS recommendation_rate_pct,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.secondary_category
ORDER BY recommendation_rate_pct DESC;

--Query 8: In-Stock vs. Out-of-Stock Demand Analysis
--What is the revenue proxy and customer demand locked in out-of-stock products?

SELECT 
    CASE WHEN p.out_of_stock = 1 THEN 'Out of Stock' ELSE 'In Stock' END AS stock_status,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.out_of_stock;

--Query 9: Online-Only vs. In-Store Channel Performance (BR-08)
--How do digital-exclusive products perform in volume, pricing, and ratings compared to store items?

SELECT 
    CASE WHEN p.online_only = 1 THEN 'Online Only' ELSE 'In-Store / Multi-Channel' END AS channel_type,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.online_only;

--Query 10: Price Tier Performance (Revenue & Customer Sentiment)
-- How do customer sentiment and revenue distribute across budget, mid-range, premium, and luxury price bands?

SELECT 
    CASE 
        WHEN p.price_usd < 25 THEN '1. Budget (< $25)'
        WHEN p.price_usd BETWEEN 25 AND 50 THEN '2. Mid-Range ($25-$50)'
        WHEN p.price_usd BETWEEN 50.01 AND 100 THEN '3. Premium ($50-$100)'
        ELSE '4. Luxury (> $100)'
    END AS price_tier,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(
        (COUNT(CASE WHEN r.is_recommended = 'Recommended' THEN 1 END)::numeric / 
        NULLIF(COUNT(r.product_id), 0) * 100)::numeric, 2
    ) AS recommendation_rate_pct,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy) / SUM(SUM(r.revenue_proxy)) OVER () * 100)::numeric, 2
    ) AS revenue_share_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY price_tier
ORDER BY price_tier;

--Query 11: Top 5 Highest-Rated vs. Bottom 5 Lowest-Rated Brands
-- Which brands deliver the highest vs. lowest customer satisfaction (minimum 1,000 reviews)?

(
    SELECT 
        'Top Rated' AS segment,
        p.brand_name,
        COUNT(r.product_id) AS total_reviews,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
    FROM products p
    JOIN reviews r ON p.product_id = r.product_id
    GROUP BY p.brand_name
    HAVING COUNT(r.product_id) >= 1000
    ORDER BY avg_rating DESC
    LIMIT 5
)
UNION ALL
(
    SELECT 
        'Lowest Rated' AS segment,
        p.brand_name,
        COUNT(r.product_id) AS total_reviews,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
    FROM products p
    JOIN reviews r ON p.product_id = r.product_id
    GROUP BY p.brand_name
    HAVING COUNT(r.product_id) >= 1000
    ORDER BY avg_rating ASC
    LIMIT 5
);

--Query 12: On-Sale vs. Full-Price Inventory Analysis
--What proportion of revenue is tied to markdowns, and does discounting correlate with rating differences?

SELECT 
    CASE WHEN p.on_sale = 1 THEN 'On Sale' ELSE 'Full Price' END AS pricing_type,
    COUNT(DISTINCT p.product_id) AS total_products,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy) / SUM(SUM(r.revenue_proxy)) OVER () * 100)::numeric, 2
    ) AS revenue_share_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.on_sale

--Query 13: Limited Edition vs. Permanent Catalog (BR-08)
-- What is the pricing power and revenue proxy potential of limited-edition releases?

SELECT 
    CASE WHEN p.limited_edition = 1 THEN 'Limited Edition' ELSE 'Permanent Catalog' END AS edition_type,
    COUNT(DISTINCT p.product_id) AS total_products,
    ROUND(AVG(p.price_usd)::numeric, 2) AS avg_price,
    COUNT(r.product_id) AS total_reviews,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy,
    ROUND(
        (SUM(r.revenue_proxy) / SUM(SUM(r.revenue_proxy)) OVER () * 100)::numeric, 2
    ) AS revenue_share_pct
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.limited_edition;