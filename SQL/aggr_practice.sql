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
