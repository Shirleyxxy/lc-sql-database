-- Write an SQL query to report, How much cubic feet of volume does the inventory occupy in each warehouse.

SELECT name AS warehouse_name,
       SUM(units * width * height * length) AS volume
FROM Warehouse w
JOIN Products p ON (w.product_id = p.product_id)
GROUP BY warehouse_name
