-- DAY 1--

CREATE TABLE employees1 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    salary INT,
    department_id INT,
    manager_id INT
);

INSERT INTO employees1 (employee_id, employee_name, salary, department_id, manager_id) VALUES
(1, 'Sophia', 150000, 1, NULL),
(2, 'Liam', 140000, 2, NULL),
(3, 'Olivia', 80000, 1, 1),
(4, 'Noah', 90000, 1, 1),
(5, 'Ava', 160000, 1, 1),
(6, 'Emma', 85000, 2, 2),
(7, 'Lucas', 145000, 2, 2),
(8, 'Mia', 95000, 2, 2),
(9, 'Ethan', 135000, 2, 2),
(10, 'John', 65000, 4, 1),
(11, 'Mike', 55000, 4, 2),
(12, 'Sam', 85000, 4, NULL),
(13, 'Alex', 110000, 4, 2);

SELECT * FROM employees1


-- Questions 

-- 5 Data Analystics Interview Questions

-- 1. Identify Employees who earn more than their managers
-- 2. Return each employee along with their manager name
-- 3. 2nd highest salary (use subquery)
-- 4 Display the names of employees who have a salary 
--   above the average salary in their department.

-- 5. Can we get same task done using FULL JOIN instead LEFT JOIN 
-- -- IF yes explain how (also tell which join will get the job done in faster)


-- 1. Identify Employees who earn more than their managers

SELECT 
	e1.*
FROM employees1 e1
JOIN employees1 e2
ON e1.manager_id = e2.employee_id
WHERE e1.salary > e2.salary

-- 2. Return each employee along with their manager name


SELECT 
	e1.employee_name,
	e2.employee_name as manager_name
FROM employees1 e1
JOIN employees1 e2
ON e1.manager_id = e2.employee_id

-- 3. 2nd highest salary (use subquery)

SELECT
	employee_name,
	salary
FROM
(SELECT
	*,
	DENSE_RANK() OVER(ORDER BY salary DESC) as rnk
FROM employees1)
WHERE rnk =1
------------------------------------------------------------------
SELECT 
	MAX(salary) as mx_salary
FROM employees1
WHERE salary < (SELECT 
				MAX(salary)
				FROM employees1)
-------------------------------------------------------------------
SELECT
	employee_name,
	salary,
	DENSE_RANK() OVER(ORDER BY salary DESC) as rnk
FROM employees1
LIMIT 1
OFFSET 1

---------------------------------------------------------------------



-- 4 Display the names of employees who have a salary 
--   above the average salary in their department.

WITH e2
AS
(
SELECT 
    employee_name,
    department_id,
    salary,
    ROUND(AVG(salary) OVER(PARTITION BY department_id)) AS avg_salary
FROM employees1
)
SELECT 
	employee_name,
	salary,
	department_id,
	avg_salary
FROM e2
WHERE salary > avg_salary 


