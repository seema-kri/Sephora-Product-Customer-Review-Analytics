-- 1. Check Total Record Counts Across Both Tables

SELECT 'products' AS table_name, COUNT(*) AS total_rows FROM products
UNION ALL
SELECT 'reviews' AS table_name, COUNT(*) AS total_rows FROM reviews;

-- 2. Validate Relational Integrity (Foreign Key Check)
SELECT COUNT(*) AS unmatched_reviews_count
FROM reviews r
LEFT JOIN products p ON r.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 3. Check Date Range and Temporal Span
SELECT 
    MIN(submission_time) AS earliest_review_date,
    MAX(submission_time) AS latest_review_date,
    MIN(review_year) AS start_year,
    MAX(review_year) AS end_year
FROM reviews;

-- 4. Check for Nulls in Critical Analytical Fields
SELECT 
    COUNT(*) AS total_products,
    COUNT(CASE WHEN product_id IS NULL THEN 1 END) AS null_product_ids,
    COUNT(CASE WHEN price_usd IS NULL THEN 1 END) AS null_prices,
    COUNT(CASE WHEN primary_category IS NULL THEN 1 END) AS null_categories
FROM products;

SELECT 
    COUNT(*) AS total_reviews,
    COUNT(CASE WHEN product_id IS NULL THEN 1 END) AS null_product_refs,
    COUNT(CASE WHEN rating IS NULL THEN 1 END) AS null_ratings,
    COUNT(CASE WHEN revenue_proxy IS NULL THEN 1 END) AS null_revenue_proxy,
    COUNT(CASE WHEN author_id IS NULL THEN 1 END) AS null_authors
FROM reviews;

-- 5. Preview First 5 Rows of Products Table
SELECT 
    product_id, 
    product_name, 
    brand_name, 
    primary_category, 
    price_usd, 
    rating 
FROM products 
LIMIT 5;

-- 6. Preview First 5 Rows of Reviews Table
SELECT 
    product_id, 
    author_id, 
    rating, 
    is_recommended, 
    revenue_proxy, 
    submission_time 
FROM reviews 
LIMIT 5;