-- Each customer has one order per day.
-- Write an SQL query to find the most recent 3 orders of each user.
-- If a user ordered fewer than 3 orders return all of their orders.

WITH temp AS (
  SELECT c.name AS customer_name, c.customer_id, o.order_id, o.order_date,
         RANK() OVER(PARTITION BY c.customer_id ORDER BY o.order_date DESC) AS rk
  FROM Customers c
  JOIN Orders o ON (c.customer_id = o.customer_id)
)
SELECT customer_name, customer_id, order_id, order_date
FROM temp
WHERE rk <= 3
ORDER BY customer_name, customer_id, order_date DESC
