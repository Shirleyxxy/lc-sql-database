-- To determine the rank of a score: count the number of distinct scores that are >= to that score
SELECT S1.Score,
       (SELECT COUNT(DISTINCT Score) FROM Scores AS S2 WHERE S2.Score >= S1.Score) AS `Rank`
FROM Scores AS S1
ORDER BY Score DESC


-- Window function (my preferred solution)
-- Note 1:
-- For MySQL solutions, to escape reserved words used as column names
-- you can use an apostrophe before and after the keyword, e.g. `Rank`.
-- Note 2:
-- No need to use ORDER BY after the SELECT statement since DENSE_RANK
-- already includes ORDER BY
SELECT score,
       DENSE_RANK() OVER(ORDER BY score DESC) AS `Rank`
FROM Scores
