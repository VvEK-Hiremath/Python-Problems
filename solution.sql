--folder_path = '/tmp/input_data'

--create table
create external table car_insurance_data(
Id INT,
Age INT,
Job STRING,
Marital STRING,
Education STRING,
Default INT,
Balance INT,
HHInsurance INT,
CarLoan INT,
Communication STRING,
LastContactDay INT,
LastContactMonth INT,
NoOfContacts INT,
DaysPassed INT,
PrevAttempts INT,
Outcome STRING,
CallStart STRING,
CallEnd STRING,
CarInsurance INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/tmp/input_data/'
TBLPROPERTIES ("skip.header.line.count"="1");



SELECT COUNT(*) FROM car_insurance_data;

SELECT COUNT(DISTINCT Job) FROM car_insurance_data;

SELECT CASE
WHEN Age BETWEEN 18 AND 30 THEN '18-30'
WHEN Age BETWEEN 31 AND 45 THEN '31-45'
WHEN Age BETWEEN 46 AND 60 THEN '46-60'
ELSE '61+'
END AS age_group,
COUNT(*) AS count
FROM car_insurance_data
GROUP BY CASE
WHEN Age BETWEEN 18 AND 30 THEN '18-30'
WHEN Age BETWEEN 31 AND 45 THEN '31-45'
WHEN Age BETWEEN 46 AND 60 THEN '46-60'
ELSE '61+'
END;


SELECT COUNT(*)
FROM car_insurance_data
WHERE Id IS NULL
OR Age IS NULL
OR Job IS NULL
OR Marital IS NULL
OR Education IS NULL
OR Default IS NULL
OR Balance IS NULL
OR HHInsurance IS NULL
OR CarLoan IS NULL
OR Communication IS NULL
OR LastContactDay IS NULL
OR LastContactMonth IS NULL
OR NoOfContacts IS NULL
OR DaysPassed IS NULL
OR PrevAttempts IS NULL
OR Outcome IS NULL
OR CallStart IS NULL
OR CallEnd IS NULL
OR CarInsurance IS NULL;

SELECT Outcome, COUNT(*) FROM car_insurance_data
GROUP BY Outcome;


SELECT COUNT(*)
FROM car_insurance_data
WHERE CarLoan = 1 AND HHInsurance = 1;

SELECT Job, AVG(Balance) as avg_balance,
MIN(Balance) as min_balance, MAX(Balance) as
max_balance
FROM car_insurance_data
GROUP BY Job;
===============

CREATE TABLE car_insurance_data_partitioned (
Id INT,
Age INT,
Job STRING,
Default INT,
Balance INT,
HHInsurance INT,
CarLoan INT,
Communication STRING,
LastContactDay INT,
LastContactMonth INT,
NoOfContacts INT,
DaysPassed INT,
PrevAttempts INT,
Outcome STRING,
CallStart STRING,
CallEnd STRING,
CarInsurance INT)
PARTITIONED BY (Education STRING, Marital STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;
