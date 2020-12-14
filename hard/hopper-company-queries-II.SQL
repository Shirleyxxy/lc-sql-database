WITH RECURSIVE months AS (
  SELECT 1 AS month
  UNION ALL
  SELECT month + 1
  FROM months
  WHERE month < 12
), drivers_month AS (
  SELECT IF(YEAR(join_date) < 2020, 1, MONTH(join_date)) AS join_month, COUNT(driver_id) AS num_drivers
  FROM Drivers
  WHERE YEAR(join_date) <= 2020
  GROUP BY join_month
), rides_month AS (
  SELECT MONTH(requested_at) AS month, COUNT(DISTINCT ar.driver_id) AS num_working_drivers
  FROM AcceptedRides ar JOIN Rides r
  ON ar.ride_id = r.ride_id
  WHERE YEAR(requested_at) = 2020
  GROUP BY month
)

SELECT m.month AS month,
       ROUND(100 * IFNULL(rm.num_working_drivers / SUM(dm.num_drivers), 0), 2) AS working_percentage
FROM months m
LEFT JOIN drivers_month dm
ON dm.join_month <= m.month
LEFT JOIN rides_month rm
ON m.month = rm.month
GROUP BY m.month
ORDER BY m.month
