-- Write an SQL query to report the number of calls and the total call duration
-- between each pair of distinct persons (person1, person2) where person1 < person2.

-- My solution
WITH bidirect_calls AS (
  SELECT person1, person2, duration
  FROM (
      SELECT from_id AS person1, to_id AS person2, duration
      FROM Calls
      UNION ALL
      SELECT to_id AS person1, from_id AS person2, duration
      FROM Calls
  ) t
  WHERE person1 < person2
)

SELECT person1, person2, COUNT(duration) AS call_count, SUM(duration) AS total_duration
FROM bidirect_calls
GROUP BY person1, person2


-- A better solution using CASE WHEN
SELECT (CASE WHEN from_id < to_id THEN from_id ELSE to_id END) AS person1,
       (CASE WHEN from_id < to_id THEN to_id ELSE from_id END) AS person2,
       COUNT(duration) AS call_count,
       SUM(duration) AS total_duration
FROM Calls
GROUP BY person1, person2


-- Another solution
-- LEAST(x, y): return the minimum of x and y
-- GREATEST(x, y): return the maximum of x and y
SELECT LEAST(from_id, to_id) AS person1,
       GREATEST(from_id, to_id) AS person2,
       COUNT(duration) AS call_count,
       SUM(duration) AS total_duration
FROM Calls
GROUP BY person1, person2
