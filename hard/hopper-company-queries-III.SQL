WITH RECURSIVE months AS (
  SELECT 1 AS month
  UNION ALL
  SELECT month + 1
  FROM months
  WHERE month < 12
), month_rides_metrics AS (
  SELECT MONTH(r.requested_at) AS month,
         SUM(ar.ride_distance) AS sum_ride_distance,
         SUM(ar.ride_duration) AS sum_ride_duration
  FROM Rides r JOIN AcceptedRides ar
  ON r.ride_id = ar.ride_id
  WHERE YEAR(r.requested_at) = 2020
  GROUP BY month
), month_rides AS (
  SELECT m.month,
         IFNULL(r.sum_ride_distance, 0) AS ride_distance,
         IFNULL(r.sum_ride_duration, 0) AS ride_duration
  FROM months m LEFT JOIN month_rides_metrics r
  ON m.month = r.month
)
SELECT r1.month AS month,
       ROUND((r1.ride_distance + r2.ride_distance + r3.ride_distance) / 3, 2) AS average_ride_distance,
       ROUND((r1.ride_duration + r2.ride_duration + r3.ride_duration) / 3, 2) AS average_ride_duration
FROM month_rides r1
JOIN month_rides r2
JOIN month_rides r3
ON r1.month = r2.month - 1 AND r2.month = r3.month - 1
