-- IF + GROUP BY

SELECT player_id, player_name,
       SUM(IF(Wimbledon = player_id, 1, 0) + IF(Fr_open = player_id, 1, 0)
           + IF(US_open = player_id, 1, 0) + IF(Au_open = player_id, 1, 0))
       AS grand_slams_count
FROM Players p JOIN Championships c
ON player_id = Wimbledon OR player_id = Fr_open
   OR player_id = US_open OR player_id = Au_open
GROUP BY player_id, player_name
