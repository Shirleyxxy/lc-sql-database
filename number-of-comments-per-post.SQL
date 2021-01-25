-- Write an SQL query to find number of comments per each post.

-- Note 1: duplicate comments
-- Note 2: deleted posts
-- Note 3: posts without comments

-- Slow
SELECT s.sub_id AS post_id,
    (SELECT COUNT(DISTINCT s1.sub_id) FROM Submissions s1 WHERE s1.parent_id = s.sub_id)
    AS number_of_comments
FROM Submissions s
WHERE s.parent_id IS NULL
GROUP BY s.sub_id
ORDER BY s.sub_id


-- Self Join (Left Join)
SELECT s.sub_id AS post_id, COUNT(DISTINCT s1.sub_id) AS number_of_comments
FROM Submissions s
LEFT JOIN Submissions s1
ON s.sub_id = s1.parent_id
WHERE s.parent_id IS NULL
GROUP BY s.sub_id
ORDER BY s.sub_id
