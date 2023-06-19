/*
----------------------------------  Exercise 1 -------------------------------------------------
Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
*/
SELECT *
FROM employees.employees
WHERE emp_no IN (SELECT emp_no FROM employees.dept_manager WHERE from_date BETWEEN '1990-01-01' AND '1995-01-01');

/*
----------------------------------  Exercise 2 -------------------------------------------------
Select the entire information for all employees whose job title is “Assistant Engineer”. 
*/

SELECT *
FROM employees.employees e
WHERE EXISTS (SELECT * FROM employees.titles t WHERE e.emp_no=t.emp_no AND t.title='Assistant Engineer');

/*
----------------------------------  Exercise 3 -------------------------------------------------
Starting your code with “DROP TABLE”, create a table called “emp_manager” 
(emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
*/

DROP TABLE IF EXISTS employees.emp_manager; 

-- création de la table departments_dup avec 2 colonnes qui accepte les NULL
CREATE TABLE employees.emp_manager 
(emp_no INT(11) NOT NULL,
dept_no CHAR(4) NULL,
manager_no INT(11) NOT NULL) ;


Insert INTO employees.emp_manager SELECT

U.*

FROM
(SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    employees.dept_manager dm
                WHERE
                    dm.emp_no = 110022) AS manager_ID
    FROM
        employees.employees e
    JOIN employees.dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    employees.dept_manager dm
                WHERE
                    dm.emp_no = 110039) AS manager_ID
    FROM
        employees.employees e
    JOIN employees.dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B 
UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    employees.dept_manager dm
                WHERE
                    dm.emp_no = 110039) AS manager_ID
    FROM
        employees.employees e
    JOIN employees.dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS C 
UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    dm.emp_no
                FROM
                    employees.dept_manager dm
                WHERE
                    dm.emp_no = 110022) AS manager_ID
    FROM
        employees.employees e
    JOIN employees.dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS D) AS U;