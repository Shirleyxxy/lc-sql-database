-- Solution 1
-- Fast
WITH t AS (
  SELECT *, SUM(Frequency) OVER(ORDER BY Number) AS CumFrequency,
         (SUM(Frequency) OVER()) / 2 AS MedianNum
  FROM Numbers
)
SELECT AVG(Number) AS median
FROM t
WHERE MedianNum BETWEEN CumFrequency - Frequency AND CumFrequency



-- Solution 2
SELECT AVG(n.Number) AS median
FROM Numbers n
WHERE n.Frequency >= ABS(
   (SELECT SUM(Frequency) FROM Numbers WHERE Number <= n.Number) -
   (SELECT SUM(Frequency) FROM Numbers WHERE Number >= n.Number)
)
