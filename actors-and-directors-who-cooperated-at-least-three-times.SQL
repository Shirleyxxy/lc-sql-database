-- Write a SQL query for a report that provides the pairs (actor_id, director_id)
-- where the actor have cooperated with the director at least 3 times.

-- My solution: HAVING
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3


-- Similar idea using temp table
SELECT actor_id, director_id
FROM (SELECT actor_id, director_id, COUNT(timestamp) AS coop_times
      FROM ActorDirector
      GROUP BY actor_id, director_id) t
WHERE t.coop_times >= 3
