WITH winners AS (
  SELECT contest_id, gold_medal AS user
  FROM Contests
  UNION ALL
  SELECT contest_id, silver_medal AS user
  FROM Contests
  UNION ALL
  SELECT contest_id, bronze_medal AS user
  FROM Contests
), winners_order AS (
  SELECT contest_id, user,
         ROW_NUMBER() OVER(PARTITION BY user ORDER BY contest_id) AS ord
  FROM winners
), candidates AS (
  SELECT user AS user_id
  FROM winners_order
  -- medal winner for **consecutive** contests ->
  -- the difference between contest_id and order are the same
  GROUP BY user, contest_id - ord
  -- replace 3 with N for "any medal in N or more consecutive contests"
  HAVING COUNT(*) >= 3
  UNION
  SELECT gold_medal AS user_id -- gold medal winners
  FROM Contests
  GROUP BY gold_medal
  HAVING COUNT(*) >= 3
)
SELECT name, mail
FROM Users u
JOIN candidates c
ON u.user_id = c.user_id
