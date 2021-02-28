-- Write an SQL query to report the IDs of the missing subtasks for each task_id.

-- Use recursive CTE to generate all (task_id, subtask_id) pairs
WITH RECURSIVE t AS (
  SELECT task_id, 1 AS subtask_id, subtasks_count FROM Tasks
  UNION ALL
  SELECT task_id, subtask_id + 1, subtasks_count FROM t
  WHERE subtask_id < subtasks_count
)

-- LEFT JOIN to find the missing subtasks for each task_id 
SELECT t.task_id, t.subtask_id
FROM t LEFT JOIN Executed e
ON t.task_id = e.task_id AND t.subtask_id = e.subtask_id
WHERE e.subtask_id IS NULL
