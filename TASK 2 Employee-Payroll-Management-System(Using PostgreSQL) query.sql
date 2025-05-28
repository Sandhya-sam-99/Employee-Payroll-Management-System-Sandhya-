---Create employees table---
CREATE TABLE employees (
    EMPLOYEE_ID INT PRIMARY KEY,
    NAME TEXT NOT NULL,
    DEPARTMENT TEXT NOT NULL,
    EMAIL TEXT UNIQUE,
    PHONE_NO NUMERIC,
    JOINING_DATE DATE NOT NULL,
    SALARY NUMERIC NOT NULL,
    BONUS NUMERIC DEFAULT 0,
    TAX_PERCENTAGE NUMERIC DEFAULT 15
);

---Insert data into employee table---
INSERT INTO employees (EMPLOYEE_ID, NAME, DEPARTMENT, EMAIL, PHONE_NO, JOINING_DATE, SALARY, BONUS, TAX_PERCENTAGE) VALUES
(1, 'John Smith', 'Sales', 'john.smith@company.com', 5551234567, '2023-01-15', 85000, 5000, 15),
(2, 'Emily Johnson', 'Marketing', 'emily.j@company.com', 5552345678, '2023-02-20', 92000, 7000, 15),
(3, 'Michael Williams', 'IT', 'michael.w@company.com', 5553456789, '2022-11-10', 110000, 10000, 20),
(4, 'Sarah Brown', 'HR', 'sarah.b@company.com', 5554567890, '2023-05-05', 78000, 3000, 15),
(5, 'David Jones', 'Sales', 'david.j@company.com', 5555678901, '2023-03-15', 88000, 6000, 15),
(6, 'Jessica Garcia', 'Finance', 'jessica.g@company.com', 5556789012, '2022-09-12', 95000, 8000, 18),
(7, 'Robert Miller', 'IT', 'robert.m@company.com', 5557890123, '2023-04-01', 105000, 9000, 20),
(8, 'Jennifer Davis', 'Marketing', 'jennifer.d@company.com', 5558901234, '2023-01-30', 89000, 5500, 15),
(9, 'Thomas Wilson', 'Finance', 'thomas.w@company.com', 5559012345, '2022-12-15', 115000, 12000, 22),
(10, 'Lisa Martinez', 'HR', 'lisa.m@company.com', 5550123456, '2023-06-10', 82000, 4000, 15);

---Retrieve employees sorted by salary in descending order---
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, SALARY
FROM employees
ORDER BY SALARY DESC;

---Find employees with a total compensation (SALARY + BONUS) greater than
$100,000---
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, (SALARY + BONUS) AS total_compensation
FROM employees
WHERE (SALARY + BONUS) > 100000
ORDER BY total_compensation DESC;

---Update the bonus for employees in the ‘Sales’ department by 10%---
UPDATE employees
SET BONUS = BONUS * 1.10
WHERE DEPARTMENT = 'Sales';

-- To Verify the update after the bonus---
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, BONUS
FROM employees
WHERE DEPARTMENT = 'Sales';

---Calculate the net salary after deducting tax for all employees---
SELECT EMPLOYEE_ID, NAME, SALARY, 
       (SALARY * TAX_PERCENTAGE/100) AS tax_deduction,
       (SALARY - (SALARY * TAX_PERCENTAGE/100)) AS net_salary
FROM employees;

---Retrieve the average, minimum, and maximum salary per department---
SELECT DEPARTMENT, 
       ROUND(AVG(SALARY), 2) AS avg_salary,
       MIN(SALARY) AS min_salary,
       MAX(SALARY) AS max_salary
FROM employees
GROUP BY DEPARTMENT
ORDER BY avg_salary DESC;

---Advanced queries---

---Employees who joined in the last 6 months (assuming current date is 2023-07-01)---
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, JOINING_DATE
FROM employees
WHERE JOINING_DATE >= DATE '2023-07-01' - INTERVAL '6 months'
ORDER BY JOINING_DATE DESC;

---Group employees by department and count how many employees each has---
SELECT DEPARTMENT, COUNT(*) AS employee_count
FROM employees
GROUP BY DEPARTMENT
ORDER BY employee_count DESC;

---Find the department with the highest average salary---
SELECT DEPARTMENT, ROUND(AVG(SALARY), 2) AS avg_salary
FROM employees
GROUP BY DEPARTMENT
ORDER BY avg_salary DESC
LIMIT 1;

---Identify employees who have the same salary as at least one other employee---
SELECT e1.EMPLOYEE_ID, e1.NAME, e1.DEPARTMENT, e1.SALARY
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e1.SALARY = e2.SALARY
    AND e1.EMPLOYEE_ID != e2.EMPLOYEE_ID
)
ORDER BY e1.SALARY;