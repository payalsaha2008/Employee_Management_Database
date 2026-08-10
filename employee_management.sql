-- ============================================
-- EMPLOYEE MANAGEMENT DATABASE
-- PostgreSQL Project
-- ============================================

-- 1. Create Employees Table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    department VARCHAR(50),
    job_title VARCHAR(50),
    salary NUMERIC(10,2),
    joining_date DATE
);

-- 2. Insert Employee Data
INSERT INTO employees
(employee_name, age, gender, department, job_title, salary, joining_date)
VALUES
('Rahul Sharma', 25, 'Male', 'Sales', 'Sales Executive', 30000, '2023-04-15'),
('Priya Das', 28, 'Female', 'HR', 'HR Executive', 35000, '2022-08-10'),
('Arjun Singh', 30, 'Male', 'IT', 'Software Developer', 55000, '2021-06-20'),
('Sneha Sharma', 26, 'Female', 'Finance', 'Accountant', 40000, '2023-01-12'),
('Rohan Gupta', 32, 'Male', 'Marketing', 'Marketing Manager', 65000, '2020-09-05'),
('Ananya Roy', 24, 'Female', 'Sales', 'Senior Sales Executive', 30000, '2024-02-18'),
('Vikash Kumar', 29, 'Male', 'IT', 'System Analyst', 48000, '2022-11-25'),
('Neha Singh', 27, 'Female', 'Finance', 'Financial Analyst', 52000, '2021-12-01'),
('Amit Das', 35, 'Male', 'HR', 'HR Manager', 70000, '2019-07-15');

-- 3. Create Departments Table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50),
    manager_name VARCHAR(100),
    location VARCHAR(100)
);

-- 4. Insert Department Data
INSERT INTO departments
(department_name, manager_name, location)
VALUES
('Sales', 'Rohan Gupta', 'Guwahati'),
('HR', 'Amit Das', 'Guwahati'),
('IT', 'Arjun Singh', 'Bangalore'),
('Finance', 'Neha Singh', 'Kolkata'),
('Marketing', 'Rohan Gupta', 'Delhi');

-- 5. Add Department ID to Employees
ALTER TABLE employees
ADD COLUMN department_id INT;

-- 6. Fill Department IDs
UPDATE employees
SET department_id = d.department_id
FROM departments AS d
WHERE employees.department = d.department_name;

-- 7. Create Foreign Key
ALTER TABLE employees
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

-- ============================================
-- BUSINESS ANALYSIS QUERIES
-- ============================================

-- View all employees
SELECT * FROM employees;

-- Employees with department information
SELECT
    e.employee_name,
    e.job_title,
    e.salary,
    d.department_name,
    d.manager_name,
    d.location
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY e.salary DESC;

-- Department salary report
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;

-- Highest-paid employee
SELECT
    employee_name,
    department,
    job_title,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 1;

-- Employees earning above average salary
SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- Oldest employee
SELECT
    employee_name,
    age,
    department,
    job_title
FROM employees
ORDER BY age DESC
LIMIT 1;

-- Employees who joined after 2023
SELECT
    employee_name,
    department,
    job_title,
    joining_date
FROM employees
WHERE joining_date > '2023-12-31'
ORDER BY joining_date;

-- Employees grouped by joining year
SELECT
    EXTRACT(YEAR FROM joining_date) AS joining_year,
    COUNT(*) AS employees_joined
FROM employees
GROUP BY EXTRACT(YEAR FROM joining_date)
ORDER BY joining_year;

-- Highest-paid employee in each department
SELECT
    department,
    employee_name,
    salary
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department = e.department
)
ORDER BY salary DESC;