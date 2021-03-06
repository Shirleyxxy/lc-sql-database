-- Write a SQL query to identify the question which has the highest answer rate.

-- Although the solutions below pass all the test cases on leetcode
-- Note 1: the definition of answer rate should be answer / (answer + show) to me.
-- Note 2: using LIMIT 1 does not account for the case that multiple question_ids
-- correspond to the same highest answer rate.

-- Solution 1
SELECT question_id AS survey_log
FROM (
  SELECT question_id, SUM(CASE WHEN action = 'show' THEN 1 ELSE 0 END) AS num_show,
         SUM(CASE WHEN action = 'answer' THEN 1 ELSE 0 END) AS num_answer
  FROM survey_log
  GROUP BY question_id
) t
ORDER BY num_answer / num_show DESC
LIMIT 1


-- Solution 2
SELECT question_id AS survey_log
FROM survey_log
GROUP BY question_id
ORDER BY COUNT(answer_id) / SUM(CASE WHEN action = 'show' THEN 1 ELSE 0 END) DESC
LIMIT 1


-- Solution 3 (A better solution IMO; adding LIMIT 1 will also pass the test cases)
WITH t AS (
  SELECT question_id,
         COUNT(answer_id) / SUM(CASE WHEN action = 'show' THEN 1 ELSE 0 END) AS answer_rate
  FROM survey_log
  GROUP BY question_id
)
SELECT question_id AS survey_log
FROM t
WHERE answer_rate = (SELECT MAX(answer_rate) FROM t)
