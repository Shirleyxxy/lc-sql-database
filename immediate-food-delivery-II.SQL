-- Write an SQL query to find the percentage of immediate orders
-- in the first orders of all customers, rounded to 2 decimal places.

-- Solution 1 - Subquery / Temp table
SELECT ROUND(100 * SUM(CASE WHEN order_date = customer_pref_delivery_date
             THEN 1 ELSE 0 END) / COUNT(*), 2) AS immediate_percentage
FROM
    ( SELECT customer_id, MIN(order_date) AS order_date, MIN(customer_pref_delivery_date) AS customer_pref_delivery_date
      FROM Delivery
      GROUP BY customer_id ) AS t


-- A different version
WITH t AS (
    SELECT customer_id, MIN(order_date) AS order_date,
           MIN(customer_pref_delivery_date) AS customer_pref_delivery_date
    FROM Delivery
    GROUP BY customer_id
)
SELECT ROUND(100 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2)
AS immediate_percentage
FROM t


-- Solution 2 - IN
SELECT ROUND(100 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2)
AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
)


-- Solution 3 - Window function
SELECT ROUND(100 * SUM(CASE WHEN DATEDIFF(customer_pref_delivery_date, order_date) = 0 THEN 1 ELSE 0
       END) / COUNT(customer_id), 2)
AS immediate_percentage
FROM (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS ord
  FROM Delivery) AS t
WHERE ord = 1
