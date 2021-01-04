-- Temp table + window function LEAD + IFNULL + DATEDIFF

WITH visits AS (
  SELECT user_id, visit_date,
         IFNULL(LEAD(visit_date, 1) OVER(PARTITION BY user_id ORDER BY visit_date), '2021-01-01') AS next_visit_date
  FROM UserVisits
)

SELECT user_id, MAX(DATEDIFF(next_visit_date, visit_date)) AS biggest_window
FROM visits
GROUP BY user_id
ORDER BY user_id
