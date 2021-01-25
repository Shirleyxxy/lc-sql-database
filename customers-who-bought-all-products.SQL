-- Write an SQL query for a report that provides the customer ids
-- from the Customer table that bought all the products in the Product table.

-- Note:
-- Customer: product_key is a foreign key to Product table
-- Product: product_key is the primary key

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product)
