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
