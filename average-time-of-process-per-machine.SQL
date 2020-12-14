-- Solution 1: CASE WHEN
SELECT machine_id,
  ROUND(SUM(CASE WHEN activity_type = 'end' THEN timestamp ELSE -timestamp END) / COUNT(DISTINCT process_id), 3)
  AS processing_time
FROM Activity
GROUP BY machine_id


-- Solution 2: Self Join
SELECT s.machine_id, ROUND(AVG(e.timestamp - s.timestamp), 3) AS processing_time 
FROM Activity s JOIN Activity e
ON (s.machine_id = e.machine_id AND s.process_id = e.process_id
   AND s.activity_type = 'start' AND e.activity_type = 'end')
GROUP BY s.machine_id
