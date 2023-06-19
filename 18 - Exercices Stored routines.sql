/* ---------------------------  Exercise 1 ---------------- 
Create a procedure that will provide the average salary of all employees.
Then, call the procedure.
*/

USE employees;
DROP procedure IF EXISTS employees_avg_salary;

DELIMITER $$
CREATE PROCEDURE employees_avg_salary()
BEGIN
	SELECT ROUND(AVG(s.salary),2) AS employees_avg_salary
    FROM employees.salaries s
    JOIN employees.employees e ON s.emp_no = e.emp_no;
END $$
DELIMITER ;

call employees.employees_avg_salary();

/* ---------------------------  Exercise 2 ---------------- 
Create a procedure called ‘emp_info’ that uses as parameters 
the first and the last name of an individual, and returns their employee number.
*/

USE employees;
DROP PROCEDURE IF EXISTS p_emp_info;
DELIMITER $$
CREATE PROCEDURE p_emp_info(in p_first_name varchar (255), in p_last_name varchar (255), out p_emp_no int)
BEGIN
	SELECT e.emp_no
    INTO p_emp_no FROM employees.employees e
    WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
END $$
DELIMITER ;

/* ---------------------------  Exercise 3 ---------------- 
Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.
Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.
Finally, select the obtained output.
*/
SET @v_emp_no =0 ;
call p_emp_info ('Aruna','Journel', @v_emp_no);
SELECT @v_emp_no;

/* ---------------------------  Exercise 3 ---------------- 
Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
and returns the salary from the newest contract of that employee.
*/

DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN
      DECLARE v_max_from_date date;
	  DECLARE v_salary decimal(10,2);
SELECT
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
SELECT
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name AND e.last_name = p_last_name AND s.from_date = v_max_from_date;     
    RETURN v_salary;
END$$
DELIMITER ;



SELECT EMP_INFO('Aruna', 'Journel');


