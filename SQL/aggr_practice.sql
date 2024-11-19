--1193. Monthly Transactions I

select DATE_FORMAT(trans_date, '%Y-%m') as month,
country, count(id) as trans_count,
count(
    case
    when state = "approved" then 1
    else null
    end
) as approved_count,
sum(amount) as trans_total_amount,
sum(
    case 
    when state = "approved" then amount
    else 0
    end
) as approved_total_amount
 from transactions
 group by month,country


--1174. Immediate Food Delivery II
with cte as
(
    select delivery_id, customer_id, order_date as od,
    customer_pref_delivery_date as cpd,
    row_number() over(partition by customer_id order by order_date,delivery_id) as rn
    from delivery
)

select round(count(
   case
    when od = cpd then 1
    else null
    end
)/count(delivery_id),4)*100 as immediate_percentage 
from cte where rn = 1


--550. Game Play Analysis IV
WITH RankedLogins AS (
    -- Assign row numbers to player logins ordered by player_id and event_date
    SELECT player_id, event_date, games_played,
           LAG(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS prev_event_date
    FROM player_activity
),
FirstLogins AS (
    -- Get the first login date for each player
    SELECT player_id, MIN(event_date) AS first_login_date
    FROM player_activity
    GROUP BY player_id
)
-- Calculate the fraction of players who logged in on consecutive days starting from their first login
SELECT ROUND(
           COUNT(DISTINCT rl.player_id) / 
           (SELECT COUNT(DISTINCT player_id) FROM player_activity), 
           2
       ) AS login_fraction
FROM RankedLogins rl
JOIN FirstLogins fl ON rl.player_id = fl.player_id
WHERE rl.prev_event_date = fl.first_login_date
  AND DATEDIFF(rl.event_date, rl.prev_event_date) = 1;
