SELECT LOWER(TRIM(product_name)) AS product_name, LEFT(sale_date, 7) AS sale_date, COUNT(sale_id) AS total
FROM Sales
GROUP BY 1, 2
ORDER BY product_name, sale_date


SELECT LOWER(TRIM(product_name)) AS product_name, DATE_FORMAT(sale_date, '%Y-%m') AS sale_date, COUNT(sale_id) AS total
FROM Sales
GROUP BY 1, 2
ORDER BY 1, 2


-- Using `GROUP BY product_name, sale_date` is wrong
-- The records would be grouped before product_name are trimmed and sale_date are formatted 
