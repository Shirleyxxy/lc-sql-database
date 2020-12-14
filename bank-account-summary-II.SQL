-- My first solutin, a little verbose
WITH t AS (
  SELECT account, SUM(amount) AS bal_change
  FROM Transactions
  GROUP BY account
)

SELECT name, IFNULL(bal_change, 0) AS balance
FROM Users u JOIN t
ON (u.account = t.account)
WHERE IFNULL(bal_change, 0) > 10000


-- Since all accounts start with a balance 0,
-- we can do a simple JOIN. (Much faster)
SELECT u.name, SUM(t.amount) AS balance
FROM Users u JOIN Transactions t
ON (u.account = t.account)
GROUP BY u.name
HAVING SUM(t.amount) > 10000
