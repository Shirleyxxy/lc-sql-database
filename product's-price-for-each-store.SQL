SELECT product_id,
       MAX(CASE WHEN store = 'store1' THEN price ELSE null END) AS store1,
       MAX(CASE WHEN store = 'store2' THEN price ELSE null END) AS store2,
       MAX(CASE WHEN store = 'store3' THEN price ELSE null END) AS store3
FROM Products
GROUP BY product_id
