-- We define the install date of a player to be the first login day of that player.
-- Write an SQL query that reports for each install date,
-- the number of players that installed the game on that day and the day 1 retention.

-- Construct the temp table first, then use LEFT JOIN and SUM(CASE WHEN...) to count non-null values.
SELECT t1.install_dt, COUNT(t1.player_id) AS installs,
      ROUND(SUM(CASE WHEN a.event_date IS NOT NULL THEN 1 ELSE 0 END) / COUNT(t1.player_id), 2)
      AS Day1_retention
FROM
( SELECT player_id, MIN(event_date) AS install_dt
  FROM Activity
  GROUP BY player_id ) t1
LEFT JOIN Activity a
ON t1.player_id = a.player_id AND t1.install_dt + 1 = a.event_date
GROUP BY t1.install_dt


-- Same idea: LEFT JOIN
WITH first_login AS (
  SELECT player_id, MIN(event_date) AS install_dt
  FROM Activity
  GROUP BY player_id
)
SELECT f.install_dt, COUNT(f.player_id) AS installs,
       ROUND(SUM(CASE WHEN a.event_date IS NOT NULL THEN 1 ELSE 0 END) / COUNT(f.player_id), 2) AS Day1_retention
FROM first_login f
LEFT JOIN Activity a
ON f.player_id = a.player_id AND DATEDIFF(a.event_date, f.install_dt) = 1
GROUP BY f.install_dt
