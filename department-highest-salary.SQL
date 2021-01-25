-- Write a SQL query to find employees who have the highest salary in each of the departments.

-- Subquery 1
SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee e, Department d
WHERE e.DepartmentID = d.ID AND
      e.Salary = (SELECT MAX(Salary) FROM Employee WHERE DepartmentID = e.DepartmentID)


-- Subquery 2 
SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Department d JOIN Employee e
ON d.ID = e.DepartmentID
WHERE e.Salary = (SELECT MAX(Salary) FROM Employee WHERE DepartmentID = e.DepartmentID)


-- Temp table with GROUP BY
SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee e, Department d
WHERE e.DepartmentID = d.Id AND (e.DepartmentId, e.Salary) IN (
    SELECT DepartmentId, MAX(Salary) AS max_salary
    FROM Employee
    GROUP BY DepartmentID )


-- Window function
SELECT d.Name AS Department, t.Name AS Employee, t.Salary
FROM Department d JOIN
(
  SELECT *, RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS rk
  FROM Employee
) t
ON d.Id = t.DepartmentId
WHERE t.rk = 1
