-- #1. Tính Recency (R)
WITH recency_cte AS (
  SELECT
    customer_key AS customer_id,
    MAX(rental_date) AS last_rental_date,
    DATE_DIFF(DATE '2006-12-31', MAX(rental_date), DAY) AS recency
  FROM olap_sakila.fact_rental
  GROUP BY customer_key
),

-- #2. Tính Frequency (F)
frequency_cte AS (
  SELECT
    customer_key AS customer_id,
    COUNT(*) AS frequency
  FROM olap_sakila.fact_rental
  GROUP BY customer_key
),

-- #3. Tính Monetary (M)
monetary_cte AS (
  SELECT
    customer_key AS customer_id,
    SUM(amount) AS monetary
  FROM olap_sakila.fact_rental
  GROUP BY customer_key
)

-- #4. Kết hợp 3 chỉ số RFM
SELECT
  r.customer_id,
  r.recency,
  f.frequency,
  m.monetary
FROM recency_cte r
JOIN frequency_cte f ON r.customer_id = f.customer_id
JOIN monetary_cte m ON r.customer_id = m.customer_id
ORDER BY r.customer_id;
