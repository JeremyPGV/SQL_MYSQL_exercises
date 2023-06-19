SELECT 
    *
FROM
    -- employees.employees -- EXO 1 to 3
    employees.salaries -- Exo 4 
WHERE
    -- Gender ='F' AND (first_name = 'Kellie' OR first_name = 'Aruna'); -- Execise 1 
    -- first_name IN ('Elvis','Denis'); -- Execise 2
    -- first_name NOT IN ('John','Mark','Jacob'); -- Execise 2
    -- first_name LIKE 'Mark%'; -- Exercise 3
    -- hire_date LIKE '%2000%'; -- Exercise 3
    -- emp_no LIKE '1000_'; -- Exercise 3
    -- salary BETWEEN '66000' AND '70000'; -- Exercise 4
    salary NOT BETWEEN '66000' AND '70000'; -- Exercise 4
    
-- ----------------------------------- Exercise 5 -----------------------------------

SELECT 
    *
FROM
    employees.employees
WHERE
    Gender = 'F'
        AND hire_date > '1999-12-31'
        
-- ----------------------------------- Exercise 6 -----------------------------------

SELECT DISTINCT
    hire_date
FROM
    employees.employees
    
-- ----------------------------------- Exercise 7 -----------------------------------
-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?

SELECT 
    count(*)
FROM
    employees.salaries
WHERE
	salary >= 100000;
    
-- ----------------------------------- Exercise 8 -----------------------------------
-- Select all data from the “employees” table, ordering it by “hire date” in descending order.

SELECT 
    *
FROM
    employees.employees
ORDER BY
	hire_date DESC;
    
    
-- ----------------------------------- Exercise 8 -----------------------------------
-- Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
-- The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
-- Lastly, sort the output by the first column.
    
SELECT 
salary,
count(emp_no) AS emps_with_same_salary

FROM employees.salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary ASC;
    