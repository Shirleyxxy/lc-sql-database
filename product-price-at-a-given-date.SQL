-- Write an SQL query to find the prices of all products on 2019-08-16.
-- Assume the price of all products before any change is 10.

-- Two cases:
-- 1. Latest change date <= 2019-08-16 --> select from the table
-- 2. Latest change date > 2019-08-16 --> price = 10 before any change

-- Use UNION to combine the two cases
SELECT product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16'

UNION

SELECT product_id, new_price AS price
FROM Products
WHERE (product_id, change_date) IN (
  SELECT product_id, MAX(change_date)
  FROM Products
  WHERE change_date <= '2019-08-16'
  GROUP BY product_id
)
