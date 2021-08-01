-- DELIVERABLE 1

SELECT emp_no, first_name, last_name 
FROM employees

SELECT emp_no, title, from_date, to_date 
FROM title

--Drop table if they exist
DROP TABLE retirement_titles

-- joining employee and title tables & filtering by years of 
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date,t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN title as t
ON e.emp_no = t.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

SELECT * FROM retirement_titles;

--Drop table if they exist
DROP TABLE unique_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name,last_name,title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

--Drop table if it exists
DROP TABLE retiring_titles;

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;

SELECT * FROM  retiring_titles

-- DELIVERABLE 2

SELECT emp_no, first_name, last_name, birth_date 
FROM employees

SELECT from_date, to_date 
FROM dept_emp

SELECT title 
FROM title

--drop table if exists
DROP TABLE mentorship_eligibility 

-- finding out possible mentors 
SELECT DISTINCT ON(e.emp_no)e.emp_no,e.first_name,e.last_name, e.birth_date, de.from_date, de.to_date,
t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN title AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility;

-- REFACTORING OUR ANALYSIS 
-- Refactoring the analysis to only include current employees

--Drop table if they exist
DROP TABLE refactored_retirement_titles

-- joining employee and title tables & filtering by years of 
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date,t.to_date
INTO refactored_retirement_titles
FROM employees as e
LEFT JOIN title as t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND to_date =('9999-01-01') 
ORDER BY emp_no;

SELECT * FROM refactored_retirement_titles;

--Drop table if it exists
DROP TABLE refactored_retiring_titles;

SELECT COUNT(rrt.emp_no), rrt.title
INTO refactored_retiring_titles
FROM refactored_retirement_titles as rrt
GROUP BY rrt.title
ORDER BY count DESC;

SELECT * FROM  refactored_retiring_titles

-- DELIVERABLE 3 : ADDITIONAL QUERY
-- Finding out if we have enough Mentors?

-- drop table if it exists
DROP TABLE mentorship_eligibility;

SELECT DISTINCT ON(e.emp_no)e.emp_no,e.first_name,e.last_name, e.birth_date, de.from_date, de.to_date,
t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN title AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility;

-- Drop table if it exists
DROP TABLE mentorship_eligibility_counts

SELECT COUNT(me.emp_no), me.title
INTO mentorship_eligibility_counts
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY count DESC;

SELECT * FROM mentorship_eligibility_counts

-- DELIVERABLE 4 - ADDITIONAL QUERY
-- Which departments are most affected
-- Create departmentwise_retirees table 

--drop table if exists
DROP TABLE departmentwise_retirees

SELECT COUNT(rrt.emp_no), de.dept_no, d.dept_name
INTO departmentwise_retirees
FROM refactored_retirement_titles as rrt
LEFT JOIN dept_emp as de
ON rrt.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no
GROUP BY de.dept_no, d.dept_name
ORDER BY count DESC;
SELECT * FROM departmentwise_retirees;
















