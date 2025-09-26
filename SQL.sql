#BUSINESS PERFORMANCE
#Doanh thu theo tháng/năm

SELECT
  d.year,
  d.month,
  SUM(r.amount) AS total_revenue
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_date d ON CAST(r.payment_date AS DATE) = d.date
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

#Chi nhánh có doanh thu cao nhất

SELECT
  s.store_id,
  s.city,
  s.country,
  SUM(r.amount) AS total_revenue
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_store s ON r.store_key = s.store_key
GROUP BY s.store_id, s.city, s.country
ORDER BY total_revenue DESC;

#Phim có doanh thu cao nhất

SELECT
  f.title,
  SUM(r.amount) AS total_revenue
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_film f ON r.film_key = f.film_key
GROUP BY f.title
ORDER BY total_revenue DESC
LIMIT 10;

#Nhân viên có nhiều giao dịch nhất

SELECT
  CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
  COUNT(*) AS total_rentals
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_staff s ON r.staff_key = s.staff_key
GROUP BY staff_name
ORDER BY total_rentals DESC;


#CUSTOMER BEHAVIOR
#Khách hàng nào thuê nhiều phim nhất?

SELECT
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  COUNT(*) AS total_rentals
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_customer c ON r.customer_key = c.customer_key
GROUP BY customer_name
ORDER BY total_rentals DESC
LIMIT 10;

#Mỗi khách hàng thuê trung bình bao nhiêu phim mỗi tháng?

SELECT
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  ROUND(COUNT(*) / COUNT(DISTINCT EXTRACT(YEAR FROM r.rental_date)*100 + EXTRACT(MONTH FROM r.rental_date)), 2) AS avg_rentals_per_month
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_customer c ON r.customer_key = c.customer_key
GROUP BY c.customer_id, customer_name
ORDER BY avg_rentals_per_month DESC;

#Khách thuê nhiều nhất vào ngày nào trong tuần?

SELECT
  d.day_name,
  COUNT(*) AS total_rentals
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_date d ON CAST(r.rental_date AS DATE) = d.date
GROUP BY d.day_name
ORDER BY total_rentals DESC;

#Có mối tương quan nào giữa độ dài phim và số lượt thuê?

SELECT
  f.length AS film_duration,
  COUNT(*) AS total_rentals
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_film f ON r.film_key = f.film_key
GROUP BY film_duration
ORDER BY film_duration;

#FILM & CATEGORY
#Thời lượng phim có ảnh hưởng đến doanh thu không?

SELECT
  f.length AS film_duration,
  SUM(r.amount) AS total_revenue
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_film f ON r.film_key = f.film_key
GROUP BY f.length
ORDER BY f.length;

#Phim nào ít được thuê nhất?

SELECT
  f.title,
  COUNT(r.rental_id) AS total_rentals
FROM
  olap_sakila.dim_film f
LEFT JOIN olap_sakila.fact_rental r ON f.film_key = r.film_key
GROUP BY f.title
ORDER BY total_rentals ASC
LIMIT 10;

#Top phim được thuê nhiều nhất

SELECT
  f.title,
  COUNT(*) AS total_rentals
FROM
  olap_sakila.fact_rental r
JOIN olap_sakila.dim_film f ON r.film_key = f.film_key
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 10;