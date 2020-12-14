-- Solution 1
WITH temp AS (
  SELECT u.user_id, u.user_name, u.credit,
      ( CASE WHEN u.user_id = t.paid_by THEN -t.amount
             WHEN u.user_id = t.paid_to THEN t.amount
             ELSE 0 END ) AS change_in_bal
  FROM Users u LEFT JOIN Transactions t
  ON (u.user_id = t.paid_by OR u.user_id = t.paid_to)
)

SELECT user_id, user_name,
       credit + SUM(change_in_bal) AS credit,
       IF(credit + SUM(change_in_bal) < 0, 'Yes', 'No') AS credit_limit_breached
FROM temp
GROUP BY user_id, user_name


-- Solution 2
-- Create an in-flow table and an out-flow table and update credit as (old_credit + in_flow - out_flow)
-- Left Join, IF, IFNULL
WITH out_t AS (
  SELECT paid_by, SUM(amount) AS out_cash
  FROM Transactions
  GROUP BY paid_by
), in_t AS (
  SELECT paid_to, SUM(amount) AS in_cash
  FROM Transactions
  GROUP BY paid_to
)

SELECT u.user_id, u.user_name,
       (credit - IFNULL(out_cash, 0) + IFNULL(in_cash, 0)) AS credit,
       IF((credit - IFNULL(out_cash, 0) + IFNULL(in_cash, 0)) < 0, 'Yes', 'No') AS credit_limit_breached
FROM Users u
LEFT JOIN out_t ON (u.user_id = out_t.paid_by)
LEFT JOIN in_t ON (u.user_id = in_t.paid_to)
