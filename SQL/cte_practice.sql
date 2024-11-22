--1204. Last Person to Fit in the Bus

with cte as
(select person_id, person_name, weight, turn,
sum(weight) over(order by turn) as tw
from queue)

select person_name from cte where tw in 
(select max(tw) from cte
where tw <=1000)
