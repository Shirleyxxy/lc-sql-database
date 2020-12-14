-- Recursive CTE
-- Temp tables + JOINs

WITH RECURSIVE months AS (
  SELECT 1 AS month
  UNION ALL
  SELECT month + 1
  FROM months
  WHERE month < 12
), drivers_month AS (
  SELECT driver_id,
         (CASE WHEN YEAR(join_date) < 2020 THEN 1 ELSE MONTH(join_date) END) AS month
  FROM Drivers
  WHERE YEAR(join_date) <= 2020
), rides_month AS (
  SELECT MONTH(r.requested_at) AS month, a.ride_id
  FROM Rides r JOIN AcceptedRides a
  ON r.ride_id = a.ride_id
  WHERE YEAR(r.requested_at) = 2020
)

SELECT months.month, COUNT(DISTINCT driver_id) AS active_drivers,
       COUNT(DISTINCT rides_month.ride_id) AS accepted_rides
FROM months
LEFT JOIN drivers_month
ON drivers_month.month <= months.month
LEFT JOIN rides_month
ON rides_month.month = months.month
GROUP BY months.month
ORDER BY months.month
