-- Write a SQL query to find the cancellation rate of requests made by unbanned users
-- (both client and driver must be unbanned) between Oct 1, 2013 and Oct 3, 2013.

-- MySQL: set using IN
SELECT Request_at AS Day,
       ROUND(SUM(CASE WHEN Status != 'completed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
WHERE Request_at BETWEEN '2013-10-01' AND '2013-10-03'
      AND Client_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
      AND Driver_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
GROUP BY Request_at
ORDER BY Request_at


-- MySQL: pre-filtering using temp table + three-way join
WITH valid_users AS (
  SELECT Users_Id
  FROM Users
  WHERE Banned = 'No'
), valid_trips AS (
  SELECT *
  FROM Trips
  WHERE Request_at BETWEEN '2013-10-01' AND '2013-10-03'
)
SELECT t.Request_at AS 'Day',
       ROUND(SUM(CASE WHEN t.Status != 'completed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS 'Cancellation Rate'
FROM valid_trips t
JOIN valid_users u1 ON t.Client_Id = u1.Users_Id
JOIN valid_users u2 ON t.Driver_Id = u2.Users_Id
GROUP BY t.Request_at
ORDER BY t.Request_at


-- Preferred solution
-- Pre-filtering by moving the predicate condition inside JOIN
-- Same as the temp table solution: we want to reduce the table size before joining
SELECT t.Request_at AS Day,
       ROUND(SUM(CASE WHEN t.Status != 'completed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS 'Cancellation Rate'
From Trips t
JOIN Users u1
     ON t.Client_Id = u1.Users_Id AND u1.Banned = 'No' AND t.Request_at BETWEEN '2013-10-01' AND '2013-10-03'
JOIN Users u2
     ON t.Driver_Id = u2.Users_Id AND u2.Banned = 'No' AND t.Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.Request_at
ORDER BY t.Request_at
