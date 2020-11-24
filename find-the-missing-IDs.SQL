-- Recursive CTE
WITH RECURSIVE id_seq AS (
    SELECT 1 AS continued_id
    UNION ALL
    SELECT continued_id + 1
    FROM id_seq
    WHERE continued_id < (SELECT MAX(customer_id) FROM Customers)
)

SELECT continued_id AS ids
FROM id_seq
WHERE continued_id NOT IN (SELECT customer_id FROM Customers)
