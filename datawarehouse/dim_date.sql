-- Nếu bạn đã có bảng calendar/date riêng, chỉ cần import vào; nếu chưa thì dùng script generate ngày
CREATE OR REPLACE TABLE `single-healer-463211-e8.olap_sakila.dim_date` AS
SELECT
    CAST(FORMAT_DATE('%Y%m%d', d) AS INT64) AS date_key,
    d AS date,
    EXTRACT(DAY FROM d) AS day_of_month,
    EXTRACT(DAYOFWEEK FROM d) AS day_of_week,
    FORMAT_DATE('%A', d) AS day_name,
    EXTRACT(WEEK FROM d) AS week_of_year,
    EXTRACT(MONTH FROM d) AS month,
    FORMAT_DATE('%B', d) AS month_name,
    EXTRACT(QUARTER FROM d) AS quarter,
    EXTRACT(YEAR FROM d) AS year
FROM UNNEST(GENERATE_DATE_ARRAY('2005-01-01', '2006-12-31', INTERVAL 1 DAY)) AS d;
