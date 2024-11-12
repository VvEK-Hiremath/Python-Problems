--Assume you're given a table Twitter tweet data, write a query to obtain a histogram of
--tweets posted per user in 2022. Output the tweet count per user as the bucket and the
--number of Twitter users who fall into that bucket.
--In other words, group the users by the number of tweets they posted in 2022 and count
--the number of users in each group.

WITH total_tweets AS (
SELECT
user_id,
COUNT(tweet_id) AS tweet_count_per_user
FROM tweets
WHERE tweet_date BETWEEN '2022-01-01'
AND '2022-12-31'
GROUP BY user_id)
SELECT
tweet_count_per_user AS tweet_bucket,
Grow Data Skills
COUNT(user_id) AS users_num
FROM total_tweets
GROUP BY tweet_count_per_user;

--Assume you're given the table on user viewership categorised by device type where
--the three types are laptop, tablet, and phone.
--Write a query that calculates the total viewership for laptops and mobile devices where
--mobile is defined as the sum of tablet and phone viewership. Output the total viewership
--for laptops as laptop_reviews and the total viewership for mobile devices as
--mobile_views.

SELECT
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS
laptop_views,
SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END)
AS mobile_views
FROM viewership;

--Candidates with a variety of skillsets have applied for this role, but we need candidates
--who know Python, Tableau, and PostgreSQL.

SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

--To find the top 2 Power Users who sent the most messages on Microsoft Teams in August
--2022, we need to first determine the count of messages sent by each user, which we'll
--refer to as "senders"

SELECT
sender_id,
COUNT(message_id) AS count_messages
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8'
AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY count_messages DESC
LIMIT 2;

--Write a SQL query to get the nth highest salary from the Employee table

CREATE FUNCTION getNthHighestSalary(N INT) 
RETURNS INT 
BEGIN
declare M INT; 
set M = N - 1; 
RETURN (
select distinct Salary
from Employee
order by Salary desc limit 1 offset M
); 
END