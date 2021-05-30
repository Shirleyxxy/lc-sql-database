-- CTE, UNION ALL

WITH score AS (
  SELECT home_team_id AS team_id,
         home_team_goals AS goal_for,
         away_team_goals AS goal_against,
         CASE WHEN home_team_goals > away_team_goals THEN 3
              WHEN home_team_goals = away_team_goals THEN 1
              ELSE 0
         END AS pt
  FROM Matches

  UNION ALL

  SELECT away_team_id AS team_id,
         away_team_goals AS goal_for,
         home_team_goals AS goal_against,
         CASE WHEN away_team_goals > home_team_goals THEN 3
              WHEN away_team_goals = home_team_goals THEN 1
              ELSE 0
         END AS pt
  FROM Matches
)
SELECT t.team_name AS team_name,
       COUNT(s.team_id) AS matches_played,
       SUM(s.pt) AS points,
       SUM(s.goal_for) AS goal_for,
       SUM(s.goal_against) AS goal_against,
       SUM(s.goal_for) - SUM(s.goal_against) AS goal_diff
FROM score s
JOIN Teams t
ON s.team_id = t.team_id
GROUP BY team_name
ORDER BY points DESC, goal_diff DESC, team_name ASC
