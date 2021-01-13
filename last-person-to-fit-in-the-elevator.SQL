-- The maximum weight the elevator can hold is 1000.
-- Write an SQL query to find the person_name of the last person who will fit in the elevator without exceeding
-- the weight limit.
-- It is guaranteed that the person who is first in the queue can fit in the elevator.

-- Window function (MS SQL Server)
SELECT TOP 1 person_name FROM (
    SELECT person_name, weight, turn, SUM(weight) OVER(ORDER BY turn) AS running_sum
    FROM Queue
) AS t
WHERE running_sum <= 1000
ORDER BY turn DESC



-- Window function + temp table (MySQL)
-- My preferred solution
WITH t AS (
  SELECT person_name, weight, turn,
         SUM(weight) OVER(ORDER BY turn) AS running_sum
  FROM Queue
)
SELECT person_name FROM t
WHERE running_sum <= 1000
ORDER BY running_sum DESC
LIMIT 1



-- Self join
-- Get cumulative weight sum using self join
SELECT q1.person_name
FROM Queue q1 JOIN Queue q2
ON q2.turn <= q1.turn
GROUP BY q1.turn
HAVING SUM(q2.weight) <= 1000
ORDER BY q1.turn DESC  -- ORDER BY SUM(q2.weight) DESC
LIMIT 1
