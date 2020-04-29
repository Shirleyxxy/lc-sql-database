## Write a SQL query that reports the device that is first logged in for each player.

SELECT player_id, device_id FROM Activity
WHERE (player_id, event_date) IN (SELECT player_id, MIN(event_date) AS first_login
                                  FROM Activity
                                  GROUP BY player_id)


SELECT a.player_id, a.device_id
FROM Activity a
JOIN ( SELECT player_id, MIN(event_date) AS first_login
       FROM Activity
       GROUP BY player_id
     ) AS temp ON (a.player_id = temp.player_id AND a.event_date = temp.first_login)
