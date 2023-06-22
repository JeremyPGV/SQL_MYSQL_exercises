/* ---------------------------  Exercise 1 TRIGGER ---------------- 
Create a trigger that checks if the hire date of an employee is higher than the current date. 
If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
*/

USE employees;
DROP TRIGGER IF EXISTS contract_check;
DELIMITER $$
CREATE TRIGGER contract_check
BEFORE INSERT ON employees.employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > date_format(current_date(), '%Y-%m-%d') THEN
		SET NEW.hire_date = date_format(current_date(), '%Y-%m-%d');
	END IF; 
END $$
DELIMITER ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  
SELECT  *  
FROM  employees.employees
ORDER BY emp_no DESC;

-- --------------------------------------------------------------------------------------------------------------------------

/* ---------------------------  Exercise 2 INDEX ---------------- 
Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
*/

SELECT *
FROM employees.salaries s
WHERE s.salary > 89000;

CREATE INDEX i_salary ON salaries(salary);
SELECT * FROM employees.salaries s WHERE s.salary > 89000;

/* ---------------------------  Exercise 3 CASE ---------------- 
Similar to the exercises done in the lecture, 
obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. 
Create a fourth column in the query, indicating whether 
this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee. 
*/


SELECT e.emp_no, e.first_name, e.last_name,
CASE
	WHEN dm.emp_no IS NOT NULL THEN 'Manager'
    ELSE 'Employee'
END AS manager_or_employee

FROM employees.employees e
LEFT JOIN employees.dept_manager dm 
ON e.emp_no=dm.emp_no

WHERE e.emp_no > 109990;


/* ---------------------------  Exercise 4 CASE  ---------------- 
Extract a dataset containing the following information about the managers: 
employee number, first name, and last name. 
Add two columns at the end – 
one showing the difference between the maximum and minimum salary of that employee, 
and another one saying whether this salary raise was higher than $30,000 or NOT.

If possible, provide more than one solution.
*/

SELECT e.emp_no, e.first_name, e.last_name,
MAX(s.salary)- MIN(s.salary) AS Salary_difference,
CASE 
	WHEN MAX(s.salary)- MIN(s.salary) > 30000 THEN 'raise HIGHER than $30,000'
    ELSE 'raise lower than $30,000'
END AS Raise_interpretation

FROM employees.employees e
JOIN employees.dept_manager dm ON e.emp_no = dm.emp_no
JOIN employees.salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no;


/* ---------------------------  Exercise 5 CASE  ---------------- 
Extract the employee number, first name, and last name of the first 100 employees, 
and add a fourth column, called “current_employee” saying 
“Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t.
*/

SELECT e.emp_no, e.first_name, e.last_name,
CASE 
	WHEN de.to_date <> '9999-01-01' THEN 'Is still employed'
    ELSE 'Not an employee anymore'
END AS current_employee

FROM employees.employees e
JOIN employees.dept_emp de ON e.emp_no = de.emp_no
ORDER BY e.emp_no ASC
LIMIT 100;

















