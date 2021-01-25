-- Write an SQL query that reports the best seller by total sales price.
-- If there is a tie, report them all.

-- Temp table + Subquery
WITH t AS (
  SELECT seller_id, SUM(price) AS sales_price
  FROM Sales
  GROUP BY seller_id
)
SELECT seller_id FROM t
WHERE sales_price = (SELECT MAX(sales_price) FROM t)


-- HAVING
SELECT seller_id FROM Sales
GROUP BY seller_id
HAVING SUM(price) = (SELECT SUM(price) FROM Sales
                     GROUP BY seller_id
                     ORDER BY SUM(price) DESC LIMIT 1)
