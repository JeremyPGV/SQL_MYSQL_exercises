/*
----------------------------------  Exercise 1 -------------------------------------------------

Select ten records from the “titles” table to get a better idea about its content.

Then, in the same table, insert information about employee number 999903. 
State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.

At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.

Hint: To solve this exercise, you’ll need to insert data in only 3 columns!

Don’t forget, we assume that, apart from the code related to the exercises, you always execute all code provided in the lectures. 
This is particularly important for this exercise. 
If you have not run the code from the previous lecture, called ‘The INSERT Statement 
– Part II’, where you have to insert information about employee 999903, you might have trouble solving this exercise!
*/

SELECT * FROM employees.titles LIMIT 10;

INSERT INTO titles (emp_no,title,from_date) VALUES (999903,'Senior Engineer','1997-10-01');

SELECT * FROM employees.titles ORDER BY emp_no DESC;

/*
----------------------------------  Exercise 2 -------------------------------------------------
Create a new department called “Business Analysis”. Register it under number ‘d010’.
*/

INSERT INTO employees.departments VALUES ('d010','Business Analysis');

/*
----------------------------------  Exercise 3 -------------------------------------------------
Change the “Business Analysis” department name to “Data Analysis”.
*/

UPDATE employees.departments
SET dept_name='Data Analysis'
WHERE dept_no='d010';

/*
----------------------------------  Exercise 4 -------------------------------------------------
Remove the department number 10 record from the “departments” table.
*/

DELETE FROM employees.departments
WHERE dept_no='d010';