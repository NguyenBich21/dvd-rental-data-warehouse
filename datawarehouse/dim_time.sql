-- Tạo time dimension từ 00:00 đến 23:59
CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.dim_time` AS
SELECT
    (h * 60 + m) AS time_key,
    TIME(h, m, 0) AS full_time,
    h AS hour,
    m AS minute
FROM UNNEST(GENERATE_ARRAY(0, 23)) AS h
CROSS JOIN UNNEST(GENERATE_ARRAY(0, 59)) AS m;
