-- Write an SQL query to find the team size of each of the employees.

-- Solution 1 - Temp table + JOIN 
SELECT employee_id, team_size
FROM Employee AS e
JOIN (
    SELECT team_id, COUNT(employee_id) AS team_size
    FROM Employee
    GROUP BY team_id
) AS t
ON e.team_id = t.team_id


-- Solution 2 - Window function
SELECT employee_id, COUNT(*) OVER(PARTITION BY team_id) AS team_size
FROM Employee
