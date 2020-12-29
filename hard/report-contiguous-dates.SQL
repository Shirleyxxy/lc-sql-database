-- Write an SQL query to generate a report of period_state for each continuous interval of days
-- in the period from 2019-01-01 to 2019-12-31.

-- Tricky part: generate groups for continuous interval of days
-- UNION ALL + window function + GROUP BY + date calculation
SELECT period_state, MIN(date) AS start_date, MAX(date) AS end_date
FROM (
    SELECT t.*,
           ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY date) AS seq
    FROM
    ( SELECT fail_date AS date, 'failed' AS period_state
      FROM Failed
      UNION ALL
      SELECT success_date AS date, 'succeeded' AS period_state
      FROM Succeeded ) t
    WHERE date BETWEEN '2019-01-01' AND '2019-12-31'
 ) tmp
GROUP BY date - INTERVAL seq DAY, period_state
ORDER BY start_date



-- Same idea + clean code
WITH combined_dates AS (
    SELECT fail_date AS dt, 'failed' AS period_state,
           fail_date - INTERVAL (ROW_NUMBER() OVER (ORDER BY fail_date)) DAY AS grp
    FROM Failed
    WHERE YEAR(fail_date) = 2019
    UNION ALL
    SELECT success_date AS dt, 'succeeded' AS period_state,
           success_date - INTERVAL (ROW_NUMBER() OVER (ORDER BY success_date)) DAY AS grp
    FROM Succeeded
    WHERE YEAR(success_date) = 2019
)
SELECT period_state, MIN(dt) AS start_date, MAX(dt) AS end_date
FROM combined_dates
GROUP BY period_state, grp
ORDER BY start_date
