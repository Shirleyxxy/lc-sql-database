-- Write an SQL query to find the average for daily percentage of posts
-- that got removed after being reported as spam, rounded to 2 decimal places.

-- Solution 1 - Left join (best)
SELECT ROUND(AVG(removal_rate) * 100, 2) AS average_daily_percent
FROM (
  SELECT COUNT(DISTINCT r.post_id) / COUNT(DISTINCT a.post_id) AS removal_rate
  FROM Actions a LEFT JOIN Removals r
  ON a.post_id = r.post_id
  WHERE a.action = 'report' AND a.extra = 'spam'
  GROUP BY a.action_date
) t


-- Solution 2: Left join with 2 sub-tables
SELECT ROUND(AVG(sub.removal_rate) * 100, 2) AS average_daily_percent
FROM (
  SELECT t.action_date,
         COUNT(DISTINCT CASE WHEN remove_date IS NOT NULL THEN t.post_id ELSE NULL END) / COUNT(DISTINCT t.post_id) AS removal_rate
  FROM (
    SELECT a.post_id, a.action_date, r.remove_date
    FROM Actions a LEFT JOIN Removals r
    ON a.post_id = r.post_id
    WHERE a.action = 'report' AND a.extra = 'spam'
  ) t
  GROUP BY t.action_date
) sub


-- Solution 3: Left join with 1 sub-table
SELECT ROUND(AVG(t.num_removed / t.num_spams) * 100, 2) AS average_daily_percent
FROM (
  SELECT a.action_date, COUNT(DISTINCT a.post_id) AS num_spams,
         COUNT(DISTINCT CASE WHEN remove_date IS NOT NULL THEN a.post_id ELSE NULL END) AS num_removed
  FROM Actions a LEFT JOIN Removals r
  ON a.post_id = r.post_id
  WHERE a.action = 'report' AND a.extra = 'spam'
  GROUP BY a.action_date
  HAVING num_spams > 0
) t
