-- Write an SQL query to recommend pages to the user with user_id = 1 using the pages
-- that your friends liked. It should not recommend pages you already liked.
-- Return result table in any order without duplicates.

-- Solution 1 - UNION
SELECT DISTINCT page_id AS recommended_page
FROM Likes
WHERE user_id IN (
    SELECT user2_id AS friend_id FROM Friendship WHERE user1_id = 1
    UNION
    SELECT user1_id AS friend_id FROM Friendship WHERE user2_id = 1) AND
    page_id NOT IN (
      SELECT page_id FROM Likes WHERE user_id = 1
    )


-- Solution 2 - CASE WHEN... + JOIN
SELECT DISTINCT page_id AS recommended_page
FROM (
  SELECT CASE WHEN user1_id = 1 THEN user2_id
              WHEN user2_id = 1 THEN user1_id
         END AS friend_id
  FROM Friendship
) t
JOIN Likes
ON t.friend_id = Likes.user_id
WHERE page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1)
