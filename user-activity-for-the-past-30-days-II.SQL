-- IFNULL + ROUND
-- Temp table
SELECT IFNULL(ROUND(AVG(num_sessions), 2), 0.00) AS average_sessions_per_user
FROM
  ( SELECT user_id, COUNT(DISTINCT session_id) AS num_sessions
    FROM Activity
    WHERE DATEDIFF('2019-07-27', activity_date) < 30
    GROUP BY user_id ) t


WITH user_sessions AS (
  SELECT user_id, COUNT(DISTINCT session_id) AS num_sessions
  FROM Activity
  WHERE DATEDIFF('2019-07-27', activity_date) < 30
  GROUP BY user_id
)

SELECT ROUND(IFNULL(AVG(num_sessions), 0), 2) AS average_sessions_per_user
FROM user_sessions
