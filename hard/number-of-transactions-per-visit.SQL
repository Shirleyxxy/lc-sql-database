-- Visits table:
-- user_id | visit_date
-- primary key: (user_id, visit_date)

-- Transactions table:
-- user_id | transaction_date | amount
-- no primary key

-- Write an SQL query to find how many users visited the bank and didn't do any
-- transactions, how many visited the bank and did one transaction and so on.

-- The result table:
-- transactions_count | visits_count

-- transactions_count is the number of transactions done in one visit
-- visits_count is the corresponding number of users who did transactions_count in one visit to the bank
-- transactions_count should take all values from 0 to max(transactions_count) done by one or more users.

WITH t1 AS (
  SELECT v.user_id, v.visit_date,
         SUM(CASE WHEN t.transaction_date IS NOT NULL THEN 1 ELSE 0 END) AS transactions_count
  FROM Visits v
  LEFT JOIN Transactions t
  ON v.user_id = t.user_id AND v.visit_date = t.transaction_date   -- per user per day
  GROUP BY v.user_id, v.visit_date
), t AS (
    SELECT 0 AS rn
    UNION
    SELECT ROW_NUMBER() OVER() AS rn FROM Transactions
)

SELECT t.rn AS transactions_count,
       COUNT(transactions_count) AS visits_count
FROM t
LEFT JOIN t1 ON t.rn = t1.transactions_count
WHERE t.rn <= (SELECT MAX(transactions_count) FROM t1)
GROUP BY t.rn
ORDER BY t.rn
