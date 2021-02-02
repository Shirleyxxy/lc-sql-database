-- Product:
-- product_id | product_name

-- Sales:
-- product_id | period_start | period_end | average_daily_sales

-- Write an SQL query to report the total sales amount of each item for each year
-- with corresponding product_id, product_name and report_year.

-- Dates of the sales years are between 2018 to 2020.
-- Return the result table ordered by product_id and report_year.

-- MySQL
WITH t AS (
  SELECT product_id, '2018' AS report_year,
         average_daily_sales * (DATEDIFF(LEAST(period_end, '2018-12-31'), GREATEST(period_start, '2018-01-01')) + 1) AS total_amount
  FROM Sales
  WHERE YEAR(period_start) = 2018 OR YEAR(period_end) = 2018

  UNION ALL

  SELECT product_id, '2019' AS report_year,
         average_daily_sales * (DATEDIFF(LEAST(period_end, '2019-12-31'), GREATEST(period_start, '2019-01-01')) + 1) AS total_amount
  FROM Sales
  WHERE YEAR(period_start) <= 2019 AND YEAR(period_end) >= 2019

  UNION ALL

  SELECT product_id, '2020' AS report_year,
         average_daily_sales * (DATEDIFF(LEAST(period_end, '2020-12-31'), GREATEST(period_start, '2020-01-01')) + 1) AS total_amount
  FROM Sales
  WHERE YEAR(period_start) = 2020 OR YEAR(period_end) = 2020
)
SELECT t.product_id, p.product_name, t.report_year, t.total_amount
FROM t JOIN Product p
ON t.product_id = p.product_id
ORDER BY t.product_id, t.report_year
