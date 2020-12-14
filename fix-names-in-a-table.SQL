-- SUBSTRING(string, start, length)
-- string: the string to extract from
-- start: the start position (can be both positive or negative); the first position is 1
-- length: the number of characters to extract; if omitted, the whole string will be returned
SELECT user_id, CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2, LENGTH(name)-1))) AS name
FROM Users
ORDER BY user_id


-- Note: We can omit the length parameter
SELECT user_id, CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id
