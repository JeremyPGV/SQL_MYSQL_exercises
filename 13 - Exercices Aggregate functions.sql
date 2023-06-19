/*
----------------------------------  Exercise 1 -------------------------------------------------
How many departments are there in the “employees” database?
*/

SELECT COUNT(DISTINCT dept_no)
FROM employees.dept_emp;

/*
----------------------------------  Exercise 2 -------------------------------------------------
What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?
*/

SELECT SUM(salary)
FROM employees.salaries
WHERE from_date > '1997-01-01';

/*
----------------------------------  Exercise 3 -------------------------------------------------
1. Which is the lowest employee number in the database?
2. Which is the highest employee number in the database?
*/

SELECT MIN(emp_no), MAX(emp_no)
FROM employees.salaries;

/*
----------------------------------  Exercise 4 + 5 -------------------------------------------------
What is the average annual salary paid to employees who started after the 1st of January 1997?
*/

SELECT ROUND(AVG(salary),2)
FROM employees.salaries
WHERE from_date > '1997-01-01';