-- Write a SQL to get the cumulative sum of an employee's salary
-- over a period of 3 months but exclude the most recent month.
-- The result should be displayed by 'Id' ascending, and then by 'Month' descending.

-- Solution 1 - Self join (preferred)
SELECT e1.Id, MAX(e2.Month) AS Month, SUM(e2.Salary) AS Salary
FROM Employee e1, Employee e2
WHERE e1.Id = e2.Id AND e2.Month BETWEEN e1.Month-3 AND e1.Month-1
GROUP BY e1.Id, e1.Month
ORDER BY Id, Month DESC


-- Solution 2 - Window function LAG
SELECT *
FROM (
    SELECT Id,
           LAG(Month, 1) OVER(PARTITION BY Id ORDER BY Month ASC) AS Month,
           IFNULL(LAG(Salary, 1) OVER(PARTITION BY Id ORDER BY Month ASC), 0) +
           IFNULL(LAG(Salary, 2) OVER(PARTITION BY Id ORDER BY Month ASC), 0) +
           IFNULL(LAG(Salary, 3) OVER(PARTITION BY Id ORDER BY Month ASC), 0) AS Salary
    FROM Employee
) t
WHERE Month IS NOT NULL
ORDER BY Id, Month DESC


-- Solution 3 - Left join + IFNULL
-- Slow
SELECT e.Id, e.Month,
       IFNULL(e.Salary, 0) + IFNULL(e1.Salary, 0) + IFNULL(e2.Salary, 0) AS Salary
FROM Employee e
LEFT JOIN Employee e1 ON (e.Id = e1.Id AND e.Month = e1.Month + 1)
LEFT JOIN Employee e2 ON (e.Id = e2.Id AND e.Month = e2.Month + 2)
-- exclude the most recent month
WHERE (e.Id, e.Month) NOT IN (
    SELECT Id, MAX(Month) FROM Employee GROUP BY Id
)
ORDER BY e.ID ASC, e.Month DESC
