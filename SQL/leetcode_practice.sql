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
