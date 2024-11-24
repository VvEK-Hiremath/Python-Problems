'''Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.'''

WITH total_cte AS
(
  SELECT DISTINCT visited_on, 
         SUM(amount) OVER (ORDER BY visited_on
                           RANGE BETWEEN INTERVAL 6 DAY PRECEDING
                           AND CURRENT ROW) AS amount
  FROM Customer
)

SELECT visited_on, amount, ROUND(amount/7, 2) AS average_amount
FROM total_cte AS a
INNER JOIN
(SELECT MIN(visited_on) AS min_visited_on FROM total_cte) AS b
ON DATEDIFF(visited_on, min_visited_on) >= 6;
