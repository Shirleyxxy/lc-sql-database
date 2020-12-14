-- Join 
SELECT name, SUM(rest) AS rest, SUM(paid) AS paid,
       SUM(canceled) AS canceled, SUM(refunded) AS refunded
FROM Invoice i JOIN Product p
ON (i.product_id = p.product_id)
GROUP BY name
ORDER BY name
