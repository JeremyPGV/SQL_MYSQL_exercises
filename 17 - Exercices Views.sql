/*
----------------------------------  Exercise 1 -------------------------------------------------
Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.

If you have worked correctly, after executing the view from the “Schemas” section in Workbench, you should obtain the value of 66924.27.
*/

CREATE OR REPLACE VIEW employees.v_avg_salary_manager AS
SELECT ROUND(AVG(s.salary),2) AS manager_avg_salary
FROM employees.dept_manager dm
JOIN employees.salaries s
ON dm.emp_no = s.emp_no;