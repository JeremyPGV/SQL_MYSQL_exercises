/* ---------------------------  Création table ddepartments_dup ---------------- */
-- Drop la table si existante
DROP TABLE IF EXISTS employees.departments_dup; 

-- création de la table departments_dup avec 2 colonnes qui accepte les NULL
CREATE TABLE employees.departments_dup 
(dept_no CHAR(4) NULL,
dept_name VARCHAR(40) NULL) ;

-- Insertion des valeurs de la table departments (dept_no,dept_name)
INSERT INTO employees.departments_dup
(dept_no,dept_name) SELECT *
FROM employees.departments;

-- Insertion de la valeur public relation
INSERT INTO employees.departments_dup (dept_name)
VALUES ('Public Relations');

-- Suppression du dept 2 de la table
DELETE FROM employees.departments_dup
WHERE dept_no= 'd002';

-- Insertion de nouvelles valeurs dans departments_dup
INSERT INTO employees.departments_dup(dept_no)
VALUES ('d010'),('d011');

/* ---------------------------  Création table dept_manager_dup ---------------- */

DROP TABLE IF EXISTS employees.dept_manager_dup;

CREATE TABLE employees.dept_manager_dup (

  emp_no int(11) NOT NULL,

  dept_no char(4) NULL,

  from_date date NOT NULL,

  to_date date NULL

  );

 

INSERT INTO employees.dept_manager_dup

select * from employees.dept_manager;

 

INSERT INTO employees.dept_manager_dup (emp_no, from_date)

VALUES                (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');

 

DELETE FROM employees.dept_manager_dup

WHERE

    dept_no = 'd001';

INSERT INTO employees.departments_dup (dept_name)

VALUES                ('Public Relations');

 

DELETE FROM employees.departments_dup

WHERE

    dept_no = 'd002';
    
/* ---------------------------  Exercise 3 ---------------- 
Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date.
*/

SELECT e.emp_no, e.first_name, e.last_name ,dmd.dept_no, e.hire_date
FROM employees.employees e 
INNER JOIN
employees.dept_manager_dup dmd
ON e.emp_no = dmd.emp_no
ORDER BY emp_no;

/* ---------------------------  Exercise 4 ---------------- 
Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date.
Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
See if the output contains a manager with that name.  
*/

SELECT e.emp_no, e.first_name, e.last_name ,dm.dept_no, dm.from_date
FROM employees.employees e 
LEFT JOIN
employees.dept_manager dm
ON e.emp_no = dm.emp_no
WHERE e.last_name='Markovitch'
ORDER BY dept_no DESC, emp_no;

/* ---------------------------  Exercise 5 ---------------- 
Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
Use the old type of join syntax to obtain the result.
*/

SELECT e.emp_no, e.first_name, e.last_name ,dmd.dept_no, e.hire_date
FROM employees.employees e, employees.dept_manager_dup dmd
WHERE e.emp_no = dmd.emp_no
ORDER BY emp_no;

-- set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', ''); -- EVITER ERROR 1055 avec GROUP BY


/* ---------------------------  Exercise 6 ---------------- 
Select the first and last name, the hire date, and the job title of all employees
whose first name is “Margareta” and have the last name “Markovitch”.
*/

SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees.employees e
JOIN employees.titles t
ON e.emp_no = t.emp_no 
WHERE e.first_name = 'Margareta' AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;

/* ---------------------------  Exercise 7 ---------------- 
Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
*/

SELECT dm.*,d.*
FROM employees.departments d
CROSS JOIN employees.dept_manager dm
WHERE d.dept_no='d009'
ORDER BY d.dept_no;

/* ---------------------------  Exercise 8 ---------------- 
Return a list with the first 10 employees with all the departments they can be assigned to.
*/

SELECT e.*, d.*
FROM employees.employees e
CROSS JOIN employees.departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no;

/* ---------------------------  Exercise 9 ---------------- 
Select all managers’ first and last name, hire date, job title, start date, and department name.
*/

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date , t.title, t.from_date, d.dept_no
FROM employees.employees e
JOIN employees.titles t ON e.emp_no = t.emp_no
JOIN employees.dept_emp de ON e.emp_no = de.emp_no -- pas de lien entre employees et departments on passe par dept_emp
JOIN employees.departments d ON de.dept_no = d.dept_no
WHERE t.title='Manager'
ORDER BY e.emp_no;

/* ---------------------------  Exercise 9 ---------------- 
How many male and how many female managers do we have in the ‘employees’ database?
*/

SELECT e.gender, count(dm.emp_no)
FROM employees.employees e
JOIN employees.dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;




