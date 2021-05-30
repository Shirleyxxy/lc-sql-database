-- A bank account is suspicious if the total income exceeds the max_income for this account
-- for two or more consecutive months.
-- The total income of an account in some month is the sum of all its deposits in that month
-- (i.e., transactions of the type 'Creditor').

WITH monthly_income AS (
  SELECT t.account_id, DATE_FORMAT(day, '%Y%m') AS month, SUM(amount) AS total_income, a.max_income
  FROM Transactions t
  LEFT JOIN Accounts a ON t.account_id = a.account_id
  WHERE t.type = 'Creditor'
  GROUP BY t.account_id, month
  HAVING total_income > a.max_income
)
SELECT DISTINCT t1.account_id
FROM monthly_income t1
JOIN monthly_income t2 ON t1.account_id = t2.account_id AND PERIOD_DIFF(t1.month, t2.month) = 1
ORDER BY t1.account_id
