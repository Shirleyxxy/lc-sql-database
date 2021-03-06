SELECT p.product_name, p.product_id, o.order_id, o.order_date
FROM Products p JOIN Orders o
ON (p.product_id = o.product_id)
WHERE (o.product_id, o.order_date) IN (
  SELECT product_id, MAX(order_date)
  FROM Orders
  GROUP BY product_id
)
ORDER BY p.product_name, p.product_id, o.order_id
