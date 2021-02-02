-- Write a query to print the sum of all total investment values
-- in 2016 (TIV_2016), to a scale of 2 decimal places, for all policy holders
-- who meet the following criteria:

-- 1. Have the same TIV_2015 value as one or more other policyholders.
-- 2. Are not located in the same city as any other policyholder
-- (i.e.: the (latitude, longitude) attribute pairs must be unique).

-- Solution 1 - IN subquery
SELECT SUM(TIV_2016) AS TIV_2016
FROM insurance
WHERE TIV_2015 IN (
    SELECT TIV_2015 FROM insurance
    GROUP BY TIV_2015
    HAVING COUNT(*) > 1
  )
AND (LAT, LON) IN (
    SELECT LAT, LON FROM insurance
    GROUP BY LAT, LON
    HAVING COUNT(*) = 1
  )


-- Solution 2
SELECT SUM(TIV_2016) AS TIV_2016
FROM insurance a
WHERE 1 = (SELECT COUNT(*) FROM insurance b WHERE a.LAT = b.LAT AND a.LON = b.LON)
AND 1 < (SELECT COUNT(*) FROM insurance c WHERE a.TIV_2015 = c.TIV_2015)
