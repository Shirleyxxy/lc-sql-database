-- Query the customer_number from the orders table for the customer who has placed
-- the largest number of orders.

-- It is guaranteed that exactly one customer will have placed more orders
-- than any other customer.
SELECT customer_number FROM orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1


-- Follow up: What if more than one customer have the largest number of orders,
-- can you find all the customer_number in this case?
SELECT customer_number FROM orders
GROUP BY customer_number
HAVING COUNT(customer_number) = (
  SELECT MAX(order_count) FROM (
    SELECT COUNT(customer_number) AS order_count
    FROM orders
    GROUP BY customer_number
  ) t
)
