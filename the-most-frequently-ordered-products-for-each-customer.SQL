-- Window function DENSE_RANK
SELECT customer_id, product_id, product_name
FROM (
  SELECT o.customer_id, o.product_id, p.product_name,
  DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(order_id) DESC) AS rk
  FROM Orders o
  JOIN Products p ON (o.product_id = p.product_id)
  GROUP BY o.customer_id, o.product_id
) sub
WHERE sub.rk = 1


-- My solution
SELECT rk_table.customer_id, rk_table.product_id, p.product_name
FROM (
  SELECT sub.customer_id, sub.product_id,
         DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_cnt DESC) AS prod_rk
  FROM (
    SELECT customer_id, product_id, COUNT(order_id) AS order_cnt
    FROM Orders
    GROUP BY customer_id, product_id ) sub
) rk_table
JOIN Products p ON (rk_table.product_id = p.product_id)
WHERE rk_table.prod_rk = 1
