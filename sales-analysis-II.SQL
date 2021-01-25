-- Write an SQL query that reports the buyers who have bought S8 but not iPhone.
-- Note that S8 and iPhone are products present in the Product table.

-- Solution 1
SELECT DISTINCT s.buyer_id
FROM Sales s
LEFT JOIN Product p ON s.product_id = p.product_id
WHERE p.product_name = 'S8' AND s.buyer_id NOT IN (
    SELECT DISTINCT buyer_id FROM Sales
    WHERE product_id = (SELECT Product_id FROM Product WHERE product_name = 'iPhone')
)


-- Solution 2
SELECT DISTINCT s.buyer_id
FROM Sales s
LEFT JOIN Product p ON s.product_id = p.product_id
GROUP BY s.buyer_id
HAVING (SUM(CASE WHEN p.product_name = 'S8' then 1 else 0 END) >= 1) AND
       (SUM(CASE WHEN p.product_name = 'iPhone' then 1 else 0 END) = 0)
       
