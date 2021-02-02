-- Write an SQL query to find employee_id of all employees that directly or
-- indirectly report their work to the head of the company.

-- The head of the company is the employee with employee_id = 1.
-- The indirect relation between managers will not exceed 3 managers as the company is small.

-- Solution 1 - UNION + Subqueries
SELECT employee_id FROM Employees
WHERE employee_id != 1 AND manager_id = 1
UNION
SELECT employee_id FROM Employees
WHERE manager_id IN (
    SELECT employee_id FROM Employees
    WHERE employee_id != 1 AND manager_id = 1 )
UNION
SELECT employee_id FROM Employees
WHERE manager_id IN (
    SELECT employee_id FROM Employees
    WHERE manager_id IN (
        SELECT employee_id FROM Employees
        WHERE employee_id != 1 AND manager_id = 1 )
)
ORDER BY employee_id



-- Solution 2 - JOIN
SELECT e1.employee_id
FROM Employees e1 JOIN Employees e2
ON e1.manager_id = e2.employee_id
JOIN Employees e3
ON e2.manager_id = e3.employee_id
WHERE e1.employee_id != 1 AND e3.manager_id = 1



-- Solution 3 - Cross Join (Same idea as solution 2)
-- Note: Can be inefficient since it produces the Cartesian product of two tables 
-- Database server would take a long time to respond
SELECT e1.employee_id
FROM Employees e1, Employees e2, Employees e3
WHERE e1.manager_id = e2.employee_id
  AND e2.manager_id = e3.employee_id AND e1.employee_id != 1
  AND e3.manager_id = 1
