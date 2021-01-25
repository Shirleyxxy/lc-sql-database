-- Write an SQL query that reports the products that were **only** sold in spring 2019.
-- That is, between 2019-01-01 and 2019-03-31 inclusive.

-- Solution 1 - Subquery
SELECT DISTINCT s.product_id, p.product_name
FROM Sales s
JOIN Product p ON s.product_id = p.product_id
WHERE s.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
AND s.product_id NOT IN (
    SELECT DISTINCT product_id FROM Sales
    WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31'
)
ORDER BY s.product_id


-- Solution 2 - HAVING
SELECT s.product_id, MAX(p.product_name) AS product_name
FROM Sales s
JOIN Product p ON s.product_id = p.product_id
GROUP BY s.product_id
HAVING (MAX(s.sale_date) <= '2019-03-31') AND (MIN(s.sale_date) >= '2019-01-01')
