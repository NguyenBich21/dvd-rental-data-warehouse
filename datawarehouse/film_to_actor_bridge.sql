CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.film_to_actor_bridge` AS
SELECT
    ROW_NUMBER() OVER () AS film_to_actor_bridge_key,
    f.film_id AS film_key,
    a.actor_id AS actor_key
FROM `single-healer-463211-e8.stg_sakila.film_actor` fa
JOIN `single-healer-463211-e8.stg_sakila.film` f ON fa.film_id = f.film_id
JOIN `single-healer-463211-e8.stg_sakila.actor` a ON fa.actor_id = a.actor_id;
