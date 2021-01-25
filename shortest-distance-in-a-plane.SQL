-- Solution 1
-- Note: Putting the MIN() inside of SQRT() will slightly improve the performance
SELECT ROUND(SQRT(MIN(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 2) AS shortest
FROM point_2d p1 JOIN point_2d p2
ON p1.x != p2.x OR p1.y != p2.y


-- Solution 2
-- Optimize to avoid reduplicate calculations
SELECT ROUND(SQRT(MIN(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 2) AS shortest
FROM point_2d p1, point_2d p2
WHERE (p1.x, p1.y) != (p2.x, p2.y)


-- We can also use CONCAT
SELECT ROUND(SQRT(MIN(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 2) AS shortest
FROM point_2d p1, point_2d p2
WHERE CONCAT(p1.x, p1.y) != CONCAT(p2.x, p2.y)
