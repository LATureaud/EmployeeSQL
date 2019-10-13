

drop table departments;

create table departments (
	dept_no varchar (20) NOT NULL,
	dept_name varchar (50) NOT NULL	
	PRIMARY KEY (dept_no)
);

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    dept_no VARCHAR (20)   NOT NULL,
    dept_name VARCHAR (50)  NOT NULL,
    PRIMARY KEY (dept_no)
);

DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp (
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL,
    PRIMARY KEY (emp_no, dept_no)
	);
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INTEGER   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR  NOT NULL,
    PRIMARY KEY (
        dept_no, emp_no
     )
);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_no INTEGER   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    PRIMARY KEY (emp_no)
);

DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
    emp_no INTEGER   NOT NULL,
    salary INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
   PRIMARY KEY (emp_no
     )
);
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
    emp_no INTEGER   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date VARCHAR   NOT NULL,
    to_date VARCHAR   NOT NULL,
    PRIMARY KEY (emp_no, title, from_date)
);





-- Check that tables open properly
SELECT * FROM departments;
SELECT * FROM dept_emp; 
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;*/

-- Code for Queries 1-8
-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
s.emp_no = e.emp_no;
	
-- 2. List employees who were hired in 1986.
SELECT *
FROM employees
WHERE 
	hire_date >= '1986-01-01'
	AND hire_date <= '1986-12-31';

-- 3. List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
JOIN departments AS d ON
	(d.dept_no = dm.dept_no)
	JOIN employees AS e ON
		(e.emp_no = dm.emp_no);

-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON
	(de.emp_no = e.emp_no)
	JOIN departments AS d ON
		(d.dept_no = de.dept_no);

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *  
FROM employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON
	de.emp_no = e.emp_no
	JOIN departments AS d ON
		d.dept_no = de.dept_no
		WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON
	de.emp_no = e.emp_no
	JOIN departments AS d ON
		d.dept_no = de.dept_no
		WHERE dept_name = 'Sales'
			OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
--CREATE VIEW Unique_Last_Names AS
SELECT e.last_name, COUNT(e.last_name) AS "last_name_count"
FROM employees AS e
	GROUP BY e.last_name
	ORDER BY "last_name_count" DESC;
	