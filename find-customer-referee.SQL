-- Write a query to return the list of customers NOT referred by the person with id 2.

SELECT name FROM customer
WHERE referee_id != 2 OR referee_id IS NULL
