-- Write an SQL query to reformat the table such that there is a department id column
-- and a revenue column for each month.

-- To get one row for each id, we need to aggregate by id using GROUP BY.
-- We can use MAX or SUM; they ignore NULL values in their computation.

-- MAX
SELECT id,
       MAX(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
       MAX(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
       MAX(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
       MAX(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
       MAX(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS May_Revenue,
       MAX(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
       MAX(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
       MAX(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
       MAX(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
       MAX(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
       MAX(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
       MAX(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY id
ORDER BY id



-- SUM
SELECT id,
       SUM(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
       SUM(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
       SUM(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
       SUM(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
       SUM(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS May_Revenue,
       SUM(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
       SUM(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
       SUM(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
       SUM(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
       SUM(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
       SUM(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
       SUM(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY id
ORDER BY id
