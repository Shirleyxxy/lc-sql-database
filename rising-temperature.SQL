-- Write a SQL query to find all dates' id with higher temperature compared to
-- its previous dates (yesterday).

SELECT w2.id
FROM Weather w1, Weather w2
WHERE w1.Temperature < w2.Temperature
AND DATEDIFF(w2.recordDate, w1.recordDate) = 1



SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
AND w1.Temperature > w2.Temperature
