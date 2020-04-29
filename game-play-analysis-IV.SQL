-- Write an SQL query that reports the fraction of players that logged in
-- again on the day after the day they first logged in, rounded to 2 decimal places.

-- my solution
SELECT ROUND((COUNT(t.player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity)), 2) AS fraction
FROM
    ( SELECT player_id, event_date FROM Activity
      WHERE (player_id, event_date) IN
        (
          SELECT player_id, ADDDATE(MIN(event_date), INTERVAL 1 DAY) AS target_date
          FROM Activity
          GROUP BY player_id
        )
    ) AS t


-- another solution
SELECT ROUND(COUNT(t2.player_id) / COUNT(t1.player_id), 2) AS fraction
FROM
( SELECT player_id, MIN(event_date) AS first_login
  FROM Activity
  GROUP BY player_id ) t1
LEFT JOIN Activity t2
ON (t1.player_id = t2.player_id AND t1.first_login + 1 = t2.event_date)
