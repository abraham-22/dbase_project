-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
-- INTO unique_titles
FROM employees as e
-- join the Tiles table to add title,from_date and to_date column.
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no DESC;

-- Create new table for retiring title table
-- retrieve the number of employees by their recent job title who are retiring.
SELECT COUNT(ut.title), ut.title
-- INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.title DESC;

-- create a Mentorship Eligibility table.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date,
    tt.title
INTO mentorship_eligibilty
FROM employees as e
--1. Join the Employees and the Department Employee tables.
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
--2. Join the Employees and the Titles tables.
	INNER JOIN titles as tt
		ON (e.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

-- Mentorship Eligibility table.
SELECT COUNT(me.title), me.title
FROM mentorship_eligibilty as me
GROUP BY me.title
ORDER BY me.title DESC;

--Join Unique title and dept_emp to add dept_name
-- ----------------------------
SELECT DISTINCT ON (ut.emp_no) 
	ut.emp_no,
	ut.first_name,
	ut.last_name,
	ut.title,
	d.dept_name
INTO unique_titles_dept
FROM unique_titles as ut
	INNER JOIN dept_emp as de
		ON (ut.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (d.dept_no = de.dept_no)
ORDER BY ut.emp_no, ut.to_date DESC;

--Number of positions to be filled
----------------------------
SELECT utd.dept_name, utd.title, COUNT(utd.title) 
INTO positions_to_fill
FROM (SELECT title, dept_name from unique_titles_dept) as utd
GROUP BY utd.dept_name, utd.title
ORDER BY utd.dept_name DESC;