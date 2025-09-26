CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.fact_rental` AS
SELECT
    r.rental_id,
    c.customer_id AS customer_key,
    s.staff_id AS staff_key,
    st.store_id AS store_key,
    f.film_id AS film_key,
    DATE(r.rental_date) AS rental_date,
    EXTRACT(HOUR FROM r.rental_date) * 60 + EXTRACT(MINUTE FROM r.rental_date) AS rental_time_key,
    DATE(r.return_date) AS return_date,
    EXTRACT(HOUR FROM r.return_date) * 60 + EXTRACT(MINUTE FROM r.return_date) AS return_time_key,
    DATE(p.payment_date) AS payment_date,
    EXTRACT(HOUR FROM p.payment_date) * 60 + EXTRACT(MINUTE FROM p.payment_date) AS payment_time_key,
    p.amount,
    IF(r.return_date IS NULL, FALSE, TRUE) AS is_returned
FROM `single-healer-463211-e8.stg_sakila.rental` r
JOIN `single-healer-463211-e8.stg_sakila.inventory` i ON r.inventory_id = i.inventory_id
JOIN `single-healer-463211-e8.stg_sakila.film` f ON i.film_id = f.film_id
JOIN `single-healer-463211-e8.stg_sakila.store` st ON i.store_id = st.store_id
JOIN `single-healer-463211-e8.stg_sakila.customer` c ON r.customer_id = c.customer_id
JOIN `single-healer-463211-e8.stg_sakila.staff` s ON r.staff_id = s.staff_id
LEFT JOIN `single-healer-463211-e8.stg_sakila.payment` p ON r.rental_id = p.rental_id;
