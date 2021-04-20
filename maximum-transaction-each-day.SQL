-- Subquery
SELECT transaction_id
FROM Transactions
WHERE (DATE(day), amount) IN (
  SELECT DATE(day), MAX(amount)
  FROM Transactions
  GROUP BY DATE(day)
)
ORDER BY transaction_id


-- JOIN
SELECT transaction_id
FROM Transactions t
JOIN (
  SELECT DATE(day) AS day, MAX(amount) AS amount
  FROM Transactions
  GROUP BY DATE(day)
) max_t
ON DATE(t.day) = max_t.day AND t.amount = max_t.amount
ORDER BY transaction_id


-- Window function
SELECT transaction_id
FROM (
  SELECT transaction_id,
         RANK() OVER(PARTITION BY DATE(day) ORDER BY amount DESC) AS rk
  FROM Transactions
) t
WHERE t.rk = 1
ORDER BY transaction_id 
