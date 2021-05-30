WITH rk AS (
  SELECT salary,
         DENSE_RANK() OVER(ORDER BY salary ASC) AS team_id
  FROM Employees
  GROUP BY salary
  HAVING COUNT(employee_id) > 1
)
SELECT e.employee_id, e.name, e.salary, rk.team_id
FROM Employees e
JOIN rk
ON e.salary = rk.salary
ORDER BY rk.team_id, e.employee_id
