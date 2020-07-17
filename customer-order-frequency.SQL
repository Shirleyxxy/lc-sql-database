-- Customers:
-- customer_id | name | country

-- Product:
-- product_id | description | price

-- Orders:
-- order_id | customer_id | product_id | order_date | quantity

-- Write an SQL query to report the customer_id and customer_name of customers
-- who have spent at least $100 in **each** month of June and July 2020.
-- Return the result table in any order.

WITH temp AS (
  SELECT c.customer_id, c.name, SUM(p.price * o.quantity) AS total
  FROM Orders o
  JOIN Customers c ON (o.customer_id = c.customer_id)
  JOIN Product p ON (o.product_id = p.product_id)
  WHERE o.order_date LIKE '2020-06%' OR o.order_date LIKE '2020-07%'
  GROUP BY c.customer_id, c.name, MONTH(o.order_date)
)

SELECT customer_id, name
FROM temp
GROUP BY customer_id, name
HAVING SUM(CASE WHEN total >= 100 THEN 1 ELSE 0 END) = 2
