USE COMPANY;

-- Retrieve the names of employees in department 5 who work more than 10 hours per week on the 'ProductX' project.
SELECT Fname
FROM EMPLOYEE, WORKS_ON, PROJECT
WHERE Dno = 5
AND	  Pname = 'ProductX'
AND	  Pno = Pnumber
AND	  Hours > 10
AND	  Ssn = Essn;

-- List the names of employees who have a dependent with the same first name as themselves.  
SELECT Fname
FROM DEPENDENT, EMPLOYEE
WHERE Fname = Dependent_name
AND	  Ssn = Essn;

-- Find the names of employees that are directly supervised by 'Franklin Wong'.
SELECT sub.Fname
FROM EMPLOYEE sub, EMPLOYEE sup
WHERE sub.Super_ssn = sup.Ssn
AND sup.Fname = 'Franklin'
AND sup.Lname = 'Wong'


-- For each project, list the project name and the total hours per week (by all employees) spent on that project.  
SELECT Pname, sum(hours) as Total_Hours
FROM WORKS_ON, PROJECT
WHERE Pno = Pnumber
GROUP BY Pname;

-- Retrieve the names of all employees who work on every project controlled by department 5. 
SELECT Fname
FROM PROJECT, WORKS_ON, EMPLOYEE
WHERE Dnum = 5
AND   Pno = Pnumber
AND   Ssn = Essn
GROUP BY Fname
HAVING Count(Pnumber) = (SELECT Count(Pnumber)
						 FROM PROJECT
                         WHERE Dnum = 5);
					 
-- Retrieve the names of all employees who do not work on any project. 
SELECT Fname
FROM EMPLOYEE
WHERE Ssn NOT IN (SELECT Essn
				  FROM WORKS_ON);
			  
-- Retrieve the names of all employees who do not work on every project.
SELECT Fname
FROM WORKS_ON, EMPLOYEE
WHERE Essn = Ssn
GROUP BY Fname
HAVING Count(Pno) != (SELECT Count(Pnumber)
                      FROM PROJECT);

-- For each department, retrieve the department name, and the average salary of employees working in that department.
SELECT Dname, AVG(Salary) as Average_Salary
FROM EMPLOYEE, DEPARTMENT
WHERE Dno = Dnumber
GROUP BY Dname;

-- Retrieve the average salary of all female employees.
SELECT AVG(Salary) as Average_Female_salary
FROM EMPLOYEE
WHERE Sex = 'F';

-- Find the names and addresses of all employees who work on at least one project located in Houston but whose department has no location in Houston.
SELECT Fname, Address
FROM EMPLOYEE
WHERE address NOT LIKE '%Houston%'
AND Ssn IN (SELECT Essn
            FROM WORKS_ON
			WHERE Pno IN (SELECT Pnumber
			              FROM PROJECT
						  WHERE Plocation = 'Houston')
			);

-- List the last names of department managers who have no dependents.
SELECT Lname
FROM EMPLOYEE, DEPARTMENT
WHERE Ssn = Mgr_ssn
AND   Mgr_ssn NOT IN (SELECT Essn
                      FROM DEPENDENT)
					  