WITH order_quantity AS (
  SELECT order_id,
         SUM(quantity) / COUNT(product_id) AS average_quantity,
         MAX(quantity) AS maximum_quantity
  FROM OrdersDetails
  GROUP BY order_id
)
SELECT order_id
FROM order_quantity
WHERE maximum_quantity > (SELECT MAX(average_quantity) FROM order_quantity)
