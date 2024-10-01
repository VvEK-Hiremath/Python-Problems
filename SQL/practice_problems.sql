--Assume you are given the table below on Uber transactions made by users. Write a query
--to obtain the third transaction of every user. Output the user id, spend and transaction date.

WITH cte AS (
SELECT
user_id,
spend,
transaction_date,
ROW_NUMBER() OVER (
PARTITION BY user_id ORDER BY transaction_date) AS row_num
FROM transactions)
SELECT
user_id,
spend,
transaction_date
FROM cte
WHERE row_num = 3;

--Problem: Find the top 3 employees with the highest salaries in each department.
WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        DepartmentID,
        Salary,
        RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT EmployeeID, DepartmentID, Salary
FROM RankedSalaries
WHERE SalaryRank <= 3;


--Problem: Calculate the running total of sales per salesperson
SELECT 
    SalespersonID,
    SaleDate,
    Amount,
    SUM(Amount) OVER (PARTITION BY SalespersonID ORDER BY SaleDate) AS RunningTotal
FROM Sales;

--Problem: Find pairs of employees who work in the same department.
SELECT 
    e1.EmployeeID AS Employee1,
    e2.EmployeeID AS Employee2,
    e1.DepartmentID
FROM Employees e1
JOIN Employees e2 ON e1.DepartmentID = e2.DepartmentID AND e1.EmployeeID <> e2.EmployeeID;


--Problem: Find all customers who have placed at least one order.
SELECT *
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);


--Problem: Get the average salary per department, but only include departments with more than 10 employees.
SELECT 
    DepartmentID,
    AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(EmployeeID) > 10;


--Problem: Count the number of employees in each department, categorized by their employment status.
SELECT 
    DepartmentID,
    COUNT(CASE WHEN EmploymentStatus = 'Active' THEN 1 END) AS ActiveEmployees,
    COUNT(CASE WHEN EmploymentStatus = 'Inactive' THEN 1 END) AS InactiveEmployees
FROM Employees
GROUP BY DepartmentID;


--Problem: Retrieve a list of all customers and their orders, including customers who haven’t placed any orders.
SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID
FROM Customers c
FULL OUTER JOIN Orders o ON c.CustomerID = o.CustomerID;


--Problem: Pivot sales data to show monthly sales for each product.
SELECT 
    ProductID,
    [January] = SUM(CASE WHEN MONTH(SaleDate) = 1 THEN Amount ELSE 0 END),
    [February] = SUM(CASE WHEN MONTH(SaleDate) = 2 THEN Amount ELSE 0 END),
    [March] = SUM(CASE WHEN MONTH(SaleDate) = 3 THEN Amount ELSE 0 END)
FROM Sales
GROUP BY ProductID;


--Problem: Retrieve the hierarchy of employees and their managers.
WITH EmployeeHierarchy AS (
    SELECT 
        EmployeeID,
        ManagerID,
        EmployeeName,
        0 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    SELECT 
        e.EmployeeID,
        e.ManagerID,
        e.EmployeeName,
        Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;


--Problem: Get the status of each employee based on their salary.
WITH EmployeeStatus AS (
    SELECT 
        EmployeeID,
        Salary,
        CASE 
            WHEN Salary > 100000 THEN 'High'
            WHEN Salary BETWEEN 50000 AND 100000 THEN 'Medium'
            ELSE 'Low'
        END AS SalaryCategory
    FROM Employees
)
SELECT SalaryCategory, COUNT(*) AS Count
FROM EmployeeStatus
GROUP BY SalaryCategory;

--Problem: Retrieve each employee's salary and the salary of the next employee in the same department.
SELECT 
    EmployeeID,
    DepartmentID,
    Salary,
    LEAD(Salary) OVER (PARTITION BY DepartmentID ORDER BY Salary) AS NextSalary
FROM Employees;


--Problem: Retrieve each employee's salary and the salary of the previous employee in the same department.
SELECT 
    EmployeeID,
    DepartmentID,
    Salary,
    LAG(Salary,1,0) OVER (PARTITION BY DepartmentID ORDER BY Salary) AS PreviousSalary
FROM Employees;


--Problem: Find the rank of each employee and compare it to the next employee's rank.
WITH RankedEmployees AS (
    SELECT 
        EmployeeID,
        DepartmentID,
        Salary,
        RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT 
    EmployeeID,
    SalaryRank,
    LEAD(SalaryRank,1,0) OVER (ORDER BY SalaryRank) AS NextRank
FROM RankedEmployees;
