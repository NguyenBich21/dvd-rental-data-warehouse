CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.dim_customer` AS
SELECT
    ROW_NUMBER() OVER () AS customer_key,          -- surrogate key (optional)
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.address,
    ci.city,
    co.country,
    c.active,
    c.create_date,
    CURRENT_DATE() as valid_from,                  -- for SCD, optional
    DATE '9999-12-31' as valid_through            -- for SCD, optional
FROM `single-healer-463211-e8.stg_sakila.customer` c
JOIN `single-healer-463211-e8.stg_sakila.address` a ON c.address_id = a.address_id
JOIN `single-healer-463211-e8.stg_sakila.city` ci ON a.city_id = ci.city_id
JOIN `single-healer-463211-e8.stg_sakila.country` co ON ci.country_id = co.country_id;
