select count(*) from products
select count(*) from reviews

select * from products limit 5

select * from reviews limit 5

--Q1: Which categories have highest vs lowest average rating?

select primary_category,round(avg(rating)::numeric,2) as avg_rating,
count(*) as product_count
from products
group by primary_category
order by avg_rating desc

--Q2: Does higher price actually correlate with higher rating?

select 
  case 
    when price_usd < 20 then 'under $20'
    when price_usd between 20 and 49.99 then '$20-$49'
    when price_usd between 50 and 99.99 then '$50-$99'
    else '$100+'
  end as price_band,
  round(avg(rating)::numeric,2) as avg_rating,
  count(*) as product_count
from products
group by price_band
order by min(price_usd);

--Q3: Find the risk products (high price, low rating)
select product_name, brand_name, primary_category, price_usd, rating, reviews,
       round((price_usd * reviews)::numeric, 0) as revenue_exposure
from products
where price_usd > 50 and rating < 3.8 and reviews >= 10
order by revenue_exposure desc
limit 10;

--Q4: Brand-level ranking 
select brand_name,
       round(avg(rating)::numeric, 2) as avg_rating,
       count(*) as product_count,
       round(avg(price_usd)::numeric, 2) as avg_price
from products
group by brand_name
having count(*) >= 15
order by avg_rating asc
limit 15;

--Q5: Best-performing brands 

select brand_name,
       round(avg(rating)::numeric, 2) as avg_rating,
       count(*) as product_count,
       round(avg(price_usd)::numeric, 2) as avg_price
from products
group by brand_name
having count(*) >= 15
order by avg_rating desc
limit 10;

--Q6: Does rating differ by skin type?
select skin_type,
       round(avg(rating)::numeric, 2) as avg_rating,
       count(*) as review_count
from reviews
where skin_type != 'Unknown'
group by skin_type
order by review_count desc;

--Q7: Rating trend over time (are things improving or declining?)
select extract(year from submission_time::date) as year,
       round(avg(rating)::numeric, 2) as avg_rating,
       count(*) as review_count
from reviews
group by year
order by year;