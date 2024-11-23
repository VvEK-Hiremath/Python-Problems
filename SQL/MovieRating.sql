'''Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 

'''Write a solution to:
Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
The result format is in the following example.'''


select name as results from
(select count(b.user_id) as cnt,a.user_id, a.name
from users a
join MovieRating b on a.user_id = b.user_id
group by a.user_id, a.name
order by cnt desc,a.name limit 1) a

union all

select title as results from 
(select avg(a.rating) as avrg, a.movie_id, b.title 
from MovieRating a join
Movies b on a.movie_id = b.movie_id
where Month(created_at) = 2 and Year(created_at) = 2020
group by a.movie_id, b.title 
order by avrg desc,b.title limit 1) b

