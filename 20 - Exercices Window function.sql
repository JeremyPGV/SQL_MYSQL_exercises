/* ---------------------------  Exercise 1 ----------- 
Write a query that upon execution, assigns a row number to all managers we have information for in the "employees" database 
(regardless of their department).

Let the numbering disregard the department the managers have worked in. 
Also, let it start from the value of 1. Assign that value to the manager with the lowest employee number.
*/

SELECT e.emp_no , e.first_name, e.last_name, dm.dept_no, ROW_NUMBER() OVER (ORDER BY emp_no ASC) AS ranking_emp
FROM employees.dept_manager dm
JOIN employees.employees e ON dm.emp_no=e.emp_no;


/* ---------------------------  Exercise 2 ---------------- 
Write a query that upon execution, assigns a sequential number for each employee number registered in the "employees" table. 
Partition the data by the employee's first name and order it by their last name in ascending order (for each partition).
*/

SELECT e.emp_no, e.first_name, e.last_name, ROW_NUMBER() OVER (PARTITION BY e.first_name ORDER BY e.last_name ASC) AS count_emp
FROM employees.employees e ;

/* ---------------------------  Exercise 3 ---------------- 
Obtain a result set containing the salary values each manager has signed a contract for. 
To obtain the data, refer to the "employees" database.

Use window functions to add the following two columns to the final output:

- a column containing the row number of each row from the obtained dataset, starting from 1.

- a column containing the sequential row numbers associated to the rows for each manager, 
where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.

Finally, while presenting the output, make sure that 
the data has been ordered by the values in the first of the row number columns, 
and then by the salary values for each partition in ascending order.
*/

SELECT e.emp_no, s.salary, s.from_date, s.to_date,
ROW_NUMBER()OVER(PARTITION BY e.emp_no ORDER BY s.salary ASC) AS row_count,
ROW_NUMBER() OVER(PARTITION BY e.emp_no ORDER BY s.salary DESC) AS salary_count

FROM employees.employees e
JOIN employees.dept_manager dm ON e.emp_no=dm.emp_no
JOIN employees.salaries s ON e.emp_no=s.emp_no;


/* ---------------------------  Exercise 4 ---------------- 
Obtain a result set containing the salary values each manager has signed a contract for. 
To obtain the data, refer to the "employees" database.

Use window functions to add the following two columns to the final output:
- a column containing the row numbers associated to each manager, 
where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.
- a column containing the row numbers associated to each manager, 
where their highest salary has been given the number of 1, and the lowest - a value equal to the number of rows in the given partition.

Let your output be ordered by the salary values associated to each manager in descending order.
*/

SELECT dm.emp_no, s.salary,
ROW_NUMBER()OVER(PARTITION BY dm.emp_no ORDER BY s.salary ASC) as row_count_1,
ROW_NUMBER()OVER(PARTITION BY dm.emp_no ORDER BY s.salary DESC) as row_count_2

FROM employees.dept_manager dm
JOIN employees.salaries s ON dm.emp_no=s.emp_no;

/* ---------------------------  Exercise 5 ---------------- 
Write a query that provides row numbers for all workers from the "employees" table, 
partitioning the data by their first names and ordering each partition by their employee number in ascending order.

NB! While writing the desired query, do *not* use an ORDER BY clause in the relevant SELECT statement. 
At the same time, do use a WINDOW clause to provide the required window specification.
*/

SELECT e.emp_no, e.first_name, e.last_name,
ROW_NUMBER() OVER w AS row_count
FROM employees.employees e
WINDOW w AS (PARTITION BY e.first_name ORDER BY e.emp_no ASC);


/* ---------------------------  Exercise 6 ---------------- 
Find out the lowest salary value each employee has ever signed a contract for. 
*/

SELECT a.emp_no, a.salary
FROM (SELECT  s.emp_no, s.salary, ROW_NUMBER()OVER w AS row_count
FROM employees.salaries s
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary ASC)
) a

WHERE a.row_count=1;


/* ---------------------------  Exercise 7 ---------------- 
Find out the lowest salary value each employee has ever signed a contract for. Without window function
*/

SELECT  s.emp_no, MIN(s.salary) AS min_salary
FROM employees.salaries s
GROUP BY s.emp_no;

/* ---------------------------  Exercise 8 ---------------- 
Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.

Order and display the obtained salary values from highest to lowest.
*/

SELECT s.emp_no, s.salary, ROW_NUMBER() OVER w AS row_num
FROM employees.salaries s
WHERE s.emp_no = 10560
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary DESC);

/* ---------------------------  Exercise 9 ---------------- 
Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:

- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.

- contracts that have been signed at least 4 full-years 
after the date when the given employee was hired in the company for the first time.

In addition, let equal salary values of a certain employee bear the same rank. 
Do not allow gaps in the ranks obtained for their subsequent rows.
*/

SELECT s.emp_no, DENSE_RANK() OVER w as employee_salary_ranking,
s.salary,e.hire_date,s.from_date,(YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM
employees e
JOIN salaries s ON s.emp_no = e.emp_no AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);


/* ---------------------------  Exercise 9 ---------------- 
Write a query that can extract the following information from the "employees" database:

- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive

- a column showing the previous salary from the given ordered list

- a column showing the subsequent salary from the given ordered list

- a column displaying the difference between the current salary of a certain employee and their previous salary

- a column displaying the difference between the next salary of a certain employee and their current salary

Limit the output to salary values higher than $80,000 only.

Also, to obtain a meaningful result, partition the data by employee number.
*/

SELECT s.emp_no, s.salary,
lag(salary) OVER w AS previous_salary, 
lead (salary) OVER w AS next_salary,
s.salary - lag(salary) OVER w AS diff_previous_salary,
lead(salary) OVER w - s.salary AS diff_next_salary
FROM employees.salaries s
WHERE (s.emp_no BETWEEN 10500 AND 10600) AND s.salary > 80000
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary ASC);

/* ---------------------------  Exercise 10 ---------------- 
Create a query that upon execution returns a result set containing 
the employee numbers, contract salary values, start, and 
end dates of the first ever contracts that each employee signed for the company.
*/

SELECT sa.emp_no, sa.salary, sa.from_date, sa.to_date
FROM (SELECT *, ROW_NUMBER() OVER w as row_count
FROM employees.salaries s
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.from_date ASC)) AS sa
WHERE sa.row_count=1 AND sa.emp_no =10001;

/* AUTRE SOLUTION
SELECT s1.emp_no, s.salary, s.from_date, s.to_date
FROM employees.salaries s

JOIN (SELECT emp_no, MIN(from_date) AS from_date
	  FROM employees.salaries
      GROUP BY emp_no) s1 
ON s.emp_no = s1.emp_no
      
WHERE s.from_date = s1.from_date AND s.emp_no =10001;
*/



