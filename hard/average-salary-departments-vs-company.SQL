-- Write a query to display the comparison result (higher/lower/same)
-- of the average salary of employees in a department to the company's average salary.

-- Solution 1: Window function
SELECT DISTINCT pay_month, department_id,
       (CASE WHEN dept_avg > company_avg THEN 'higher'
             WHEN dept_avg < company_avg THEN 'lower'
             ELSE 'same' END ) AS comparison
FROM (
    SELECT e.department_id, LEFT(pay_date, 7) AS pay_month,
           AVG(amount) OVER(PARTITION BY pay_date) AS company_avg,
           AVG(amount) OVER(PARTITION BY pay_date, department_id) AS dept_avg
    FROM salary s
    JOIN employee e
    ON s.employee_id = e.employee_id
) t
ORDER BY pay_month DESC, department_id



-- Solution 2
SELECT dept.pay_month, dept.department_id,
       (CASE WHEN department_avg > company_avg THEN 'higher'
             WHEN department_avg < company_avg THEN 'lower'
             ELSE 'same'
        END) AS comparison
FROM (
    SELECT DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
           AVG(amount) AS company_avg
    FROM salary
    GROUP BY pay_month ) comp
JOIN (
    SELECT DATE_FORMAT(pay_date, '%Y-%m') AS pay_month, department_id,
           AVG(amount) AS department_avg
    FROM salary s JOIN employee e
    ON (s.employee_id = e.employee_id)
    GROUP BY pay_month, department_id ) dept
ON (comp.pay_month = dept.pay_month)
ORDER BY pay_month DESC, department_id
