CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.dim_actor` AS
SELECT
    ROW_NUMBER() OVER () AS actor_key,
    a.actor_id,
    a.first_name,
    a.last_name
FROM `single-healer-463211-e8.stg_sakila.actor` a;
