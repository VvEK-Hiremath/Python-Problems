--Find the 3 most profitable companies in the entire world.
--Output the result along with the corresponding company name.
--Sort the result based on profits in descending order.

select company,sum(profits) as profit from forbes_global_2010_2014
group by company
order by profit desc limit 3;

--You have been asked to find the job titles of the highest-paid employees.
--Your output should include the highest-paid title or multiple titles with the same salary.

with cte as (select worker_id, salary,
rank() over(order by salary desc) as rnk
from worker)

select worker_title as best_paid_title from cte a
join title b on a.worker_id = b.worker_ref_id
where a.rnk = 1;