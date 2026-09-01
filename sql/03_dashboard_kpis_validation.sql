
-- 1.1 Total Catalog Products (Raw Catalog Grain)
SELECT 
    COUNT(DISTINCT product_id) AS total_catalog_products 
FROM products;

-- 1.2 Total Active Products (Joined Analytical Scope)
SELECT 
    COUNT(DISTINCT p.product_id) AS total_active_products
FROM products p
JOIN reviews r ON p.product_id = r.product_id;

-- 1.3 Total Customer Reviews (BR-01, BR-02)

SELECT 
    COUNT(*) AS total_reviews 
FROM reviews;

-- 1.4 Total Revenue Proxy (BR-04)

SELECT 
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS total_revenue_proxy
FROM reviews r;

-- 1.5 Platform Catalog Average Rating

SELECT 
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
FROM reviews r;

-- 1.6 Overall Recommendation Rate % (BR-05)

SELECT 
    ROUND(
        (COUNT(CASE WHEN is_recommended = 'Recommended' THEN 1 END)::numeric / 
        NULLIF(COUNT(product_id), 0) * 100)::numeric, 
        2
    ) AS recommendation_rate_pct
FROM reviews;



-- 2.1 Attention Flagged SKUs Count

SELECT 
    COUNT(*) AS attention_skus_count
FROM (
    SELECT p.product_id
    FROM products p
    JOIN reviews r ON p.product_id = r.product_id
    GROUP BY p.product_id
    HAVING COUNT(r.product_id) > 50 AND AVG(r.rating) < 3.50
) sub;

-- 2.2 Attention SKUs Revenue at Risk

SELECT 
    ROUND(SUM(r.revenue_proxy)::numeric, 2) AS revenue_at_risk
FROM reviews r
WHERE r.product_id IN (
    SELECT p.product_id
    FROM products p
    JOIN reviews rev ON p.product_id = rev.product_id
    GROUP BY p.product_id
    HAVING COUNT(rev.product_id) > 50 AND AVG(rev.rating) < 3.50
);

-- 2.3 Attention SKUs Average Customer Rating

SELECT 
    ROUND(AVG(r.rating)::numeric, 2) AS attention_skus_avg_rating
FROM reviews r
WHERE r.product_id IN (
    SELECT p.product_id
    FROM products p
    JOIN reviews rev ON p.product_id = rev.product_id
    GROUP BY p.product_id
    HAVING COUNT(rev.product_id) > 50 AND AVG(rev.rating) < 3.50
);

-- 2.4 Attention SKUs Total Reviews Exposed

SELECT 
    COUNT(r.product_id) AS attention_skus_total_reviews
FROM reviews r
WHERE r.product_id IN (
    SELECT p.product_id
    FROM products p
    JOIN reviews rev ON p.product_id = rev.product_id
    GROUP BY p.product_id
    HAVING COUNT(rev.product_id) > 50 AND AVG(rev.rating) < 3.50
);

-- 2.5 Out-of-Stock Attention SKUs Count (BR-07 & Query 8)

SELECT 
    COUNT(*) AS attention_oos_count
FROM products p
WHERE p.out_of_stock = 1
  AND p.product_id IN (
      SELECT rev.product_id
      FROM reviews rev
      GROUP BY rev.product_id
      HAVING COUNT(rev.product_id) > 50 AND AVG(rev.rating) < 3.50
  );