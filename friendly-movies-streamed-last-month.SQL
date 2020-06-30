-- TVProgram:
-- program_date | content_id | channel

-- Content:
-- content_id | title | Kids_content | content_type

-- Write an SQL query to report the distinct titles of the kid-friendly
-- movies streamed in June 2020.
-- Return the result table in any order.

SELECT DISTINCT title
FROM Content c JOIN TVProgram t
ON (c.content_id = t.content_id)
WHERE YEAR(program_date) = '2020' AND MONTH(program_date) = '06' AND Kids_content = 'Y' AND content_type = 'Movies'


SELECT DISTINCT title
FROM Content c JOIN TVProgram t
ON (c.content_id = t.content_id)
WHERE DATE_FORMAT(program_date, '%Y-%m') = '2020-06' AND Kids_content = 'Y' AND content_type = 'Movies'
