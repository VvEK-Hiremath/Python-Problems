''' convert first letter of name to cpaital and rest to small '''

SELECT user_id,CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name,2))) AS name
FROM Users
order by user_id;



select * from patients
where conditions like "DIAB1%" or conditions like "% DIAB1%"



