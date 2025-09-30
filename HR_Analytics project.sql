USE HR_Analytics;

-- tables created --
CREATE TABLE Departments (
department_id int primary key,
dept_name varchar(50),
location varchar(50)
);

CREATE TABLE Employees (
emp_id int primary key,
name varchar(50) ,
gender varchar(50),
dob date,
department_id int,
join_date date,
salary decimal(10,3),
foreign key (department_id) References Departments(department_id)
);

CREATE TABLE Leaves (
leave_id int primary key,
emp_id int,
leave_date date,
leave_type varchar(40),
foreign key (emp_id) References Employees(emp_id)
); 

CREATE TABLE Performance (
perf_id int primary key,
emp_id int,
review_year int,
rating int,
foreign key (emp_id) References Employees(emp_id)
);

-- data insert --
INSERT INTO Departments ( department_id , dept_name , location)
VALUES (1, 'IT', 'Delhi'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Bangalore'),
(4, 'Sales', 'Chennai'),
(5, 'Marketing', 'Hyderabad');

INSERT INTO Employees ( emp_id , name , gender , dob , department_id , join_date , salary )
VALUES (101, 'Rahul Sharma', 'Male', '1990-05-12', 1, '2018-03-15', 75000),
(102, 'Priya Singh', 'Female', '1993-07-22', 2, '2019-06-01', 60000),
(103, 'Amit Verma', 'Male', '1988-11-02', 3, '2021-01-10', 90000),
(104, 'Neha Kapoor', 'Female', '1995-03-30', 1, '2022-08-12', 55000),
(105, 'Karan Mehta', 'Male', '1992-09-14', 4, '2020-11-05', 65000),
(106, 'Anita Rao', 'Female', '1989-12-21', 5, '2017-04-19', 72000),
(107, 'Suresh Patil', 'Male', '1991-06-08', 3, '2016-02-23', 88000),
(108, 'Meena Joshi', 'Female', '1994-02-11', 2, '2021-09-07', 50000),
(109, 'Arjun Nair', 'Male', '1990-08-19', 1, '2015-07-01', 95000),
(110, 'Ritika Malhotra', 'Female', '1996-10-25', 4, '2023-01-15', 48000);

INSERT INTO Leaves ( leave_id , emp_id , leave_date , leave_type )
VALUES (1, 101, '2023-05-10', 'Sick'),
(2, 102, '2023-06-15', 'Casual'),
(3, 103, '2023-07-01', 'Paid'),
(4, 104, '2023-08-05', 'Casual'),
(5, 105, '2023-05-18', 'Sick'),
(6, 106, '2023-06-22', 'Paid'),
(7, 107, '2023-07-14', 'Casual'),
(8, 108, '2023-08-20', 'Sick'),
(9, 109, '2023-09-02', 'Paid'),
(10, 110, '2023-05-25', 'Casual');

INSERT INTO Performance ( perf_id , emp_id , review_year , rating )
VALUES(1, 101, 2022, 4),
(2, 102, 2022, 5),
(3, 103, 2022, 3),
(4, 104, 2022, 4),
(5, 105, 2022, 2),
(6, 106, 2022, 5),
(7, 107, 2022, 4),
(8, 108, 2022, 3),
(9, 109, 2022, 5),
(10, 110, 2022, 3);

SELECT * FROM Departments;
SELECT * FROM Employees;
SELECT * FROM Leaves;
SELECT * FROM Performance;
DESCRIBE Performance;
drop table if exists performance;
CREATE TABLE Performance (
perf_id int primary key,
emp_id int,
review_year int,
rating int,
foreign key (emp_id) References Employees(emp_id)
);

-- queries -- 
-- 1.view all employees --
SELECT * FROM Employees;
-- 2.Highest paid employee --
SELECT name, salary FROM Employees
order by salary desc
limit 5;
-- 3.Average salary per department -- 
SELECT d.dept_name, AVG(e.salary) AS avg_salary FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.dept_name;
-- 4.Number of employees per department --
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.dept_name;
-- 5.Employees with maximum leaves
SELECT e.name, COUNT(l.leave_id) AS total_leaves FROM Employees e
JOIN Leaves l ON e.emp_id = l.emp_id
GROUP BY e.name
ORDER BY total_leaves DESC
LIMIT 3;
-- 6.Top performers(rating >= 4)
SELECT e.name, p.rating FROM Employees e
JOIN Performance p ON e.emp_id = p.emp_id
WHERE p.rating >= 4;
-- 7.Employees joined after 2020 --
SELECT name, join_date FROM Employees  
WHERE join_date > '2020-01-01';
-- 8.Highest salary employee per department -- 
SELECT d.dept_name, e.name, e.salary FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(salary) 
    FROM Employees 
    WHERE department_id = d.department_id
);
-- 9.Average performance rating per department --
SELECT d.dept_name, AVG(p.rating) AS avg_rating FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
JOIN Performance p ON e.emp_id = p.emp_id
GROUP BY d.dept_name;
-- 10.Employees with salary above 80,000 --
SELECT name, salary  
FROM Employees  
WHERE salary > 80000;