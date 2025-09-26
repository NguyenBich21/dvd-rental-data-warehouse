CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.dim_store` AS
SELECT
    ROW_NUMBER() OVER () AS store_key,
    st.store_id,
    a.address,
    ci.city,
    co.country,
    st.manager_staff_id
FROM `single-healer-463211-e8.stg_sakila.store` st
JOIN `single-healer-463211-e8.stg_sakila.address` a ON st.address_id = a.address_id
JOIN `single-healer-463211-e8.stg_sakila.city` ci ON a.city_id = ci.city_id
JOIN `single-healer-463211-e8.stg_sakila.country` co ON ci.country_id = co.country_id;
