--# CODE TO CREATE DATABASE #--
DROP DATABASE IF EXISTS COMPANY
CREATE DATABASE COMPANY

USE COMPANY
--# CODE TO CREATE DATABASE TABLES #--
CREATE TABLE EMPLOYEE
	(
	Fname			VARCHAR(15)			NOT NULL,
	Minit			CHAR,
	Lname			VARCHAR(15)			NOT NULL,
	Ssn				CHAR(9)				NOT NULL,
	Bdate			DATE,
	Address			VARCHAR(30),
	Sex				CHAR,
	Salary			DECIMAL(10,2),
	Super_ssn		CHAR(9),
	Dno				INT					NOT NULL	DEFAULT 1,

	CONSTRAINT EMP_PK
		PRIMARY KEY (Ssn),
	CONSTRAINT SUP_EMP_FK
		FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
	);

CREATE TABLE DEPARTMENT
	(
	Dname			VARCHAR(15)			NOT NULL,
	Dnumber			INT					NOT NULL,
	Mgr_ssn			CHAR(9)				NOT NULL	DEFAULT 888665555,
	Mgr_start_date  DATE,
	
	CONSTRAINT DEPT_PK
		PRIMARY KEY (Dnumber),
	CONSTRAINT DEPT_UN
		UNIQUE (Dname),
	CONSTRAINT DEPT_MGR_FK
		FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)
	);

CREATE TABLE DEPT_LOCATIONS
	(
	Dnumber			INT					NOT NULL,
	Dlocation		VARCHAR(15)			NOT NULL,

	CONSTRAINT DEPT_LOC_PK
		PRIMARY KEY (Dnumber, Dlocation),
	CONSTRAINT DEPT_LOC_NO_FK
		FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
	);

CREATE TABLE PROJECT
	(
	Pname			VARCHAR(15)			NOT NULL,
	Pnumber			INT					NOT NULL,
	Plocation		VARCHAR(15),
	Dnum			INT					NOT NULL,

	CONSTRAINT PROJ_PK
		PRIMARY KEY (Pnumber),
	CONSTRAINT PROJ_UN
		UNIQUE (Pname),
	CONSTRAINT DEPT_PROJ_FK
		FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
	);

CREATE TABLE WORKS_ON
	(
	Essn			CHAR(9)				NOT NULL,
	Pno				INT					NOT NULL,
	Hours			DECIMAL(3,1)		NOT NULL,
	
	CONSTRAINT WORKS_PK
		PRIMARY KEY (Essn, Pno),
	CONSTRAINT EMP_WORKS_FK
		FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
	CONSTRAINT PROJ_WORKS_FK
		FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
	);

CREATE TABLE DEPENDENT
	(
	Essn			CHAR(9)				NOT NULL,
	Dependent_name	VARCHAR(15)			NOT NULL,
	Sex				CHAR,
	Bdate			DATE,
	Relationship	VARCHAR(8),

	CONSTRAINT EMP_DEPT_PK
		PRIMARY KEY (Essn, Dependent_name),
	CONSTRAINT EMP_DEPEND_FK
		FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
	);
	
--# EMPDEPTFK CAUSES SPINLOCK AND MUST BE ADDED LATER #--

ALTER TABLE EMPLOYEE ADD
	CONSTRAINT EMP_DEPT_FK
		FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);
			