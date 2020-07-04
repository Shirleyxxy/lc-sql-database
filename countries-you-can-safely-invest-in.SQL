-- Person:
-- id | name | phone_number

-- Country:
-- name | country_code

-- Calls:
-- caller_id | callee_id | duration

-- Invest in the countries where the average call duration in this country is
-- strictly greater than the global average call duration.

SELECT c.name AS country
FROM Person p JOIN Country c
ON SUBSTRING(p.phone_number, 1, 3) = c.country_code
JOIN Calls ON (p.id = caller_id OR p.id = callee_id)
GROUP BY c.name
HAVING AVG(duration) > (SELECT AVG(duration) FROM Calls)
