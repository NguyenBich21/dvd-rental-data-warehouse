CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.dim_staff` AS
SELECT
    ROW_NUMBER() OVER () AS staff_key,
    s.staff_id,
    s.first_name,
    s.last_name,
    s.email,
    a.address,
    ci.city,
    co.country,
    s.active,
    s.username,
    s.store_id,
    s.last_update
FROM `single-healer-463211-e8.stg_sakila.staff` s
JOIN `single-healer-463211-e8.stg_sakila.address` a ON s.address_id = a.address_id
JOIN `single-healer-463211-e8.stg_sakila.city` ci ON a.city_id = ci.city_id
JOIN `single-healer-463211-e8.stg_sakila.country` co ON ci.country_id = co.country_id;
