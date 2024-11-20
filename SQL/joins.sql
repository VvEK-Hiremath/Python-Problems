--Table: Employees

--+-------------+----------+
--| Column Name | Type     |
--+-------------+----------+
--| employee_id | int      |
--| name        | varchar  |
--| reports_to  | int      |
--| age         | int      |
--+-------------+----------+
--employee_id is the column with unique values for this table.
--This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 
--For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
--Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the 
--reports rounded to the nearest integer.
--Return the result table ordered by employee_id.

select b.employee_id, b.name, 
count(a.reports_to) as reports_count,
round(avg(a.age)) as average_age
from employees a
join employees b on a.reports_to = b.employee_id
where a.reports_to is not null
group by b.employee_id, b.name
order by b.employee_id 


--1789. Primary Department for Each Employee

select employee_id, department_id from employee
where employee_id in (select employee_id from employee
group by employee_id
having count(employee_id) = 1)
union
select employee_id, department_id from employee
where primary_flag = 'Y'

--180. Consecutive Numbers

SELECT DISTINCT t1.num as ConsecutiveNums
FROM logs t1
JOIN logs t2 ON t1.id = t2.id - 1
JOIN logs t3 ON t2.id = t3.id - 1
WHERE t1.num = t2.num AND t2.num = t3.num;
