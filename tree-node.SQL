-- Write a query to print the node id and the type of the node.
-- Sort your output by the node id.

-- Solution 1 - CASE WHEN
SELECT id, (CASE WHEN p_id is NULL THEN 'Root'
                 WHEN id IN (SELECT DISTINCT p_id FROM tree) THEN 'Inner'
                 ELSE 'Leaf' END) AS Type
FROM tree
ORDER BY id


-- My original solution won't work though the logic is correct
SELECT id, (CASE WHEN p_id IS NULL THEN 'Root'
                 WHEN id NOT IN (SELECT DISTINCT p_id FROM tree) THEN 'Leaf'
                 ELSE 'Inner' END) AS Type
FROM tree
ORDER BY id


-- Problem:
-- NOT IN returns 0 records when compared against an unknown value.
-- Since NULL is an unknown, a NOT IN query containing a NULL or NULLs
-- in the list of possible values will always return 0 records since
-- there is no way to be sure that the NULL value is not the value being tested.

-- This works:
SELECT id, (CASE WHEN p_id IS NULL THEN 'Root'
                 WHEN id NOT IN (SELECT DISTINCT p_id FROM tree WHERE p_id IS NOT NULL) THEN 'Leaf'
                 ELSE 'Inner' END) AS Type
FROM tree
ORDER BY id


-- Solution 2 - IF
SELECT id, IF(ISNULL(p_id), 'Root', IF(id IN (SELECT p_id FROM tree), 'Inner', 'Leaf'))
AS Type
FROM tree
ORDER BY id
