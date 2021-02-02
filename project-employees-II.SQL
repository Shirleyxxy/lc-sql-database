-- Write an SQL query that reports all the projects that have the most employees.

-- Solution 1
SELECT project_id FROM Project
GROUP BY project_id
HAVING COUNT(employee_id) = (
  SELECT COUNT(employee_id) FROM Project
  GROUP BY project_id
  ORDER BY COUNT(employee_id) DESC
  LIMIT 1
)


-- Solution 2 (preferred)
WITH t AS (
    SELECT project_id, COUNT(employee_id) AS employee_count
    FROM Project
    GROUP BY project_id
)
SELECT project_id
FROM t
WHERE employee_count = (SELECT MAX(employee_count) FROM t)
