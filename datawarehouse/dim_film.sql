CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.dim_film` AS
WITH film_category_pivot AS (
    SELECT
        f.film_id,
        MAX(CASE WHEN c.name = 'Action' THEN 1 ELSE 0 END) AS film_category_action,
        MAX(CASE WHEN c.name = 'Animation' THEN 1 ELSE 0 END) AS film_category_animation,
        MAX(CASE WHEN c.name = 'Children' THEN 1 ELSE 0 END) AS film_category_children,
        MAX(CASE WHEN c.name = 'Classics' THEN 1 ELSE 0 END) AS film_category_classics,
        MAX(CASE WHEN c.name = 'Comedy' THEN 1 ELSE 0 END) AS film_category_comedy,
        MAX(CASE WHEN c.name = 'Documentary' THEN 1 ELSE 0 END) AS film_category_documentary,
        MAX(CASE WHEN c.name = 'Drama' THEN 1 ELSE 0 END) AS film_category_drama,
        MAX(CASE WHEN c.name = 'Family' THEN 1 ELSE 0 END) AS film_category_family,
        MAX(CASE WHEN c.name = 'Foreign' THEN 1 ELSE 0 END) AS film_category_foreign,
        MAX(CASE WHEN c.name = 'Games' THEN 1 ELSE 0 END) AS film_category_games,
        MAX(CASE WHEN c.name = 'Horror' THEN 1 ELSE 0 END) AS film_category_horror,
        MAX(CASE WHEN c.name = 'Music' THEN 1 ELSE 0 END) AS film_category_music,
        MAX(CASE WHEN c.name = 'New' THEN 1 ELSE 0 END) AS film_category_new,
        MAX(CASE WHEN c.name = 'Sci-Fi' THEN 1 ELSE 0 END) AS film_category_scifi,
        MAX(CASE WHEN c.name = 'Sports' THEN 1 ELSE 0 END) AS film_category_sports,
        MAX(CASE WHEN c.name = 'Travel' THEN 1 ELSE 0 END) AS film_category_travel
    FROM `single-healer-463211-e8.stg_sakila.film_category` fc
    JOIN `single-healer-463211-e8.stg_sakila.category` c ON fc.category_id = c.category_id
    JOIN `single-healer-463211-e8.stg_sakila.film` f ON fc.film_id = f.film_id
    GROUP BY f.film_id
)
SELECT
    ROW_NUMBER() OVER () AS film_key,
    f.film_id,
    f.title,
    f.description,
    f.release_year,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.replacement_cost,
    f.rating,
    f.special_features,
    f.language_id AS film_language_id,
    l.name AS film_language_name,
    f.last_update,
    -- Thêm tất cả các cột category từ bảng pivot
    p.film_category_action,
    p.film_category_animation,
    p.film_category_children,
    p.film_category_classics,
    p.film_category_comedy,
    p.film_category_documentary,
    p.film_category_drama,
    p.film_category_family,
    p.film_category_foreign,
    p.film_category_games,
    p.film_category_horror,
    p.film_category_music,
    p.film_category_new,
    p.film_category_scifi,
    p.film_category_sports,
    p.film_category_travel
FROM `single-healer-463211-e8.stg_sakila.film` f
JOIN `single-healer-463211-e8.stg_sakila.language` l ON f.language_id = l.language_id
LEFT JOIN film_category_pivot p ON f.film_id = p.film_id;
