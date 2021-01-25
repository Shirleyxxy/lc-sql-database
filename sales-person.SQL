-- Output all the names in the table salesperson, who didn’t have sales to company 'RED'.

-- Solution 1
SELECT s.name FROM salesperson s
WHERE s.sales_id NOT IN (
    SELECT o.sales_id FROM orders o
    WHERE o.com_id = (SELECT com_id FROM company WHERE name = 'RED')
)


-- Solution 2
SELECT s.name
FROM salesperson s
WHERE s.sales_id NOT IN (
  SELECT o.sales_id
  FROM orders o
  JOIN company c ON o.com_id = c.com_id AND c.name = 'RED'
)
