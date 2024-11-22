--1204. Last Person to Fit in the Bus

with cte as
(select person_id, person_name, weight, turn,
sum(weight) over(order by turn) as tw
from queue)

select person_name from cte where tw in 
(select max(tw) from cte
where tw <=1000)

--1070. Product Sales Analysis III
  
with cte as
(select product_id, year, quantity, price,
rank() over(partition by product_id order by year) as rn
from sales)

select product_id, year  as first_year, quantity, price
from cte where rn = 1
