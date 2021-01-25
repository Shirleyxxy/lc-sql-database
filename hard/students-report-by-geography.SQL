-- Pivot the continent column in this table so that each name is sorted alphabetically
-- and displayed underneath its corresponding continent.
-- The output headers should be America, Asia and Europe respectively.
-- It is guaranteed that the student number from America is no less than either Asia or Europe.

-- Window function + CASE WHEN
-- Use window function to generate a useful row_id
-- GROUP BY row_id to group rows
-- Use CASE WHEN to get each continent's data and use MAX function to get all of the non-null values.

SELECT MAX(CASE WHEN continent = 'America' THEN name END) AS America,
       MAX(CASE WHEN continent = 'Asia' THEN name END) AS Asia,
       MAX(CASE WHEN continent = 'Europe' THEN name END) AS Europe
FROM (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) AS row_id
  FROM student
) t
GROUP BY t.row_id
