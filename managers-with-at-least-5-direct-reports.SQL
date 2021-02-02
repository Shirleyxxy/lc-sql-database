-- Given the Employee table, write a SQL query that finds out
-- managers with at least 5 direct reports.

-- Solution 1 - IN Subquery
SELECT Name FROM Employee
WHERE Id IN
    ( SELECT ManagerId FROM Employee
      GROUP BY ManagerId
      HAVING COUNT(ManagerId) >= 5 )


-- Solution 2 - JOIN
SELECT Name FROM Employee e1
JOIN
   (
     SELECT ManagerId FROM Employee
     GROUP BY ManagerId
     HAVING COUNT(ManagerId) >= 5
   ) t
ON e1.Id = t.ManagerId
