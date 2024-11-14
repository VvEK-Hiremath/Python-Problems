--1661. Average Time of Process per Machine

with cte_s as
(
    select machine_id, process_id, timestamp as ts
    from activity where activity_type = 'start'
),
cte_e as
(
    select machine_id, process_id, timestamp as te
    from activity where activity_type = 'end'
),
fcte as (
select cte_s.machine_id, cte_e.process_id, (te - ts) as tt
from cte_s,cte_e where cte_s.machine_id = cte_e.machine_id
and cte_s.process_id = cte_e.process_id)

select machine_id, round(avg(tt),3) as processing_time from fcte
group by machine_id


--1280. Students and Examinations

with cte1 as
(
    select * from students
    cross join subjects
    order by student_id, subject_name
),
cte2 as
(
    select student_id, subject_name, count(*) as attended_exams
    from Examinations 
    group by student_id, subject_name
)

select cte1.student_id, cte1.student_name, cte1.subject_name, COALESCE(b.attended_exams,0) as attended_exams
from cte1 left join
cte2 b on cte1.student_id = b.student_id
and cte1.subject_name = b.subject_name
order by cte1.student_id, cte1.subject_name

--1251. Average Selling Price
    
SELECT 
    a.product_id,
    coalesce(ROUND(SUM(a.sales) / NULLIF(SUM(a.units), 0), 2),0) AS average_price
FROM (
    SELECT 
        p.product_id,
        COALESCE(u.units, 0) AS units,
        COALESCE(u.units * p.price, 0) AS sales
    FROM Prices p
    LEFT JOIN UnitsSold u 
        ON p.product_id = u.product_id
        AND u.purchase_date BETWEEN start_date AND end_date
) a
GROUP BY a.product_id;



--176. Second Highest Salary

SELECT 
    CASE
        WHEN COUNT(DISTINCT salary) > 1 
        THEN (SELECT MAX(salary) 
              FROM Employee 
              WHERE salary < (SELECT MAX(salary) FROM Employee))
        ELSE NULL
    END AS SecondHighestSalary
FROM Employee;


--average project experience

select project_id, round(avg(experience_years),2) as average_years
from project a left join
employee b on a.employee_id = b.employee_id
group by project_id

--1211. Queries Quality and Percentage

select query_name,round(avg(rating/position),2) as quality,
round((count(case
when rating < 3 then 1
else null
end)/count(rating)),4) * 100 as poor_query_percentage
from queries 
where query_name is not null
group by query_name

