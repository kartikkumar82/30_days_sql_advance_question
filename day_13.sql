- Day 13/30 Days Challenge
-- Q1. Write SQL query to find median salary 
-- If we add 1 more record with salary 91,000 what will be median?



-- Create Employee table and insert data
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    id INT,          -- Auto-incrementing ID for each employee
    name VARCHAR(100) NOT NULL,     -- Employee name
    salary NUMERIC(10, 2),          -- Employee salary
    department_id INT,              -- Foreign key linking to Department table
    manager_id INT,                 -- Employee's manager (self-referencing foreign key)
    hire_date DATE NOT NULL        -- Date of hire
);

-- Insert data into Employees table with manually assigned IDs
INSERT INTO Employees (id, name, salary, department_id, manager_id, hire_date)
VALUES 
(1, 'Alice', 90000, 1, NULL, '2022-01-15'),    -- Alice is a top-level manager (no manager)
(2, 'Bob', 80000, 2, 1, '2022-02-20'),         -- Bob reports to Alice
(3, 'Charlie', 75000, 2, 1, '2022-03-12'),     -- Charlie reports to Alice
(4, 'David', 85000, 2, 1, '2022-03-25'),       -- David reports to Alice
(5, 'Eve', 95000, 2, 2, '2022-04-01'),         -- Eve reports to Bob
(6, 'Frank', 78000, 2, 2, '2022-04-20'),       -- Frank reports to Bob
(7, 'Grace', 60000, 3, 3, '2022-05-12'),       -- Grace reports to Charlie
(8, 'Heidi', 88000, 3, 1, '2022-06-15'),       -- Heidi reports to Alice
(9,	'Sam',	 89000, 1, 2, '2022-06-15');


-- ALTER TABLE employees
-- DROP COLUMN department_id;

-- ALTER TABLE employees
-- DROP COLUMN manager_id;

-- ALTER TABLE employees
-- DROP COLUMN hire_date;


-- 1, 2, 3 4, 4, 5, 6 ,7, 1, 8, 9
-- Mean/ Median
-- 1,1, 2, 3, 4, 4, 5, 6, 7, 8, 9 4+4/2 = 4


---------------------------------------------------------------------------------------------------------
Solution
----------------------------------------------------------------------------------------------------------

INSERT INTO employees
VALUEs(9, 'sam' , 91000,NULL, NULL , '2004-10-05')

----------------------------------------------------------------------------------------------------------
-- for odd number

SELECT 
	salary
FROM
(
	SELECT 
		*,
		ROW_NUMBER() OVER(ORDER BY salary) AS asc_order,
		ROW_NUMBER() OVER(ORDER BY salary DESC) as desc_order
	FROM employees
)
WHERE asc_order - desc_order = 0



--------------------------------------------------------------------------------------------
-- For even number



WITH order_salary
as
(SELECT 
		*,
		ROW_NUMBER() OVER(ORDER BY salary) AS asc_order,
		ROW_NUMBER() OVER(ORDER BY salary DESC) as desc_order
	FROM employees)
SELECT 
	ROUND(AVG(salary),2) as midden_salary
FROM order_salary

WHERE ABS(asc_order - desc_order) = 1
