/*
----------------------------------  Exercise 1 -------------------------------------------------
Self join to know which employee is manager as well
*/
-- 1ere méthode avec DISTINCT
SELECT DISTINCT e1.*
FROM employees.emp_manager e1
JOIN employees.emp_manager e2 ON e1.emp_no = e2.manager_no;

-- 2eme méthode avec WHERE+subquery. 
-- La sous requete va voir dans e2 si un n° est dans la colonne emp_no et dans la colonne manager_no
-- Pour ensuite matcher le résultat avec la requête globale et ainsi obtenir le bon résultat

SELECT e1.*
FROM employees.emp_manager e1
JOIN employees.emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE e2.emp_no IN (
SELECT e2.manager_no
FROM employees.emp_manager e2
);