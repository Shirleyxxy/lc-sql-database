-- Tricky part: how to handle NULL here?

-- Subquery
-- Using MAX will return a NULL if the value doesn't exist
SELECT MAX(Salary) AS SecondHighestSalary FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)



-- Another solution that handles NULL
SELECT (
  SELECT DISTINCT Salary FROM Employee
  ORDER BY Salary DESC
  LIMIT 1 OFFSET 1) AS SecondHighestSalary



-- My original solution using window function
-- Cannot return NULL if there is no second highest salary
SELECT Salary AS SecondHighestSalary
FROM (
    SELECT *, DENSE_RANK() OVER(ORDER BY Salary DESC) AS rk
    FROM Employee
) t
WHERE t.rk = 2
