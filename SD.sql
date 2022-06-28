USE SunshineDeserts
GO


SELECT * FROM justdate
GO

SELECT * FROM departments
GO

SELECT * FROM employeesWithLeavingDate
GO

SELECT * from salaries
where emp_no = 11725


SELECT * from salaries
where YEAR(to_date) = 2001
order by salary DESC
GO


SELECT * from dept_emp
where emp_no = 11725
GO

SELECT salary from salaries
GO

SELECT SUM(salary) from salaries
GO

SELECT MAX(salary) AS max_salary from salaries
WHERE  YEAR(from_date)=2001
GO

SELECT MIN(salary) AS min_salary from salaries
WHERE  YEAR(from_date)= 2001
GO


--check only year
SELECT YEAR(to_date) AS Calender_Year from salaries


SELECT * FROM employeesWithLeavingDate
WHERE emp_no IS NULL 
GO

SELECT * FROM employeesWithLeavingDate
WHERE birth_date IS NULL 
GO



SELECT * FROM employeesWithLeavingDate
WHERE len(birth_date)>0
GO

SELECT * FROM employeesWithLeavingDate
WHERE emp_no IS NULL 
GO



SELECT * FROM employeesWithLeavingDate
WHERE  NOT len(emp_no)>0 
GO

SELECT * FROM dept_emp
WHERE  NOT len(to_date)>0 
GO


SELECT * FROM dept_emp
ORDER BY emp_no, dept_no
GO

SELECT * FROM dept_emp
WHERE  NOT len(to_date)>0 
GO

SELECT COUNT(emp_no) FROM employeesWithLeavingDate
GO

SELECT DISTINCT emp_no FROM employeesWithLeavingDate
GO

--Total number of male and female over all
SELECT gender, count(emp_no) AS total_emp
FROM employeesWithLeavingDate
GROUP BY gender
GO

SELECT leaving_date from employeesWithLeavingDate
Where YEAR(leaving_date) BETWEEN 1986 AND 2001
order by leaving_date 


SELECT * FROM salaries
WHERE SALARY = NULL 

SELECT * FROM salaries
WHERE NOT LEN(SALARY)>0

SELECT SUM(salary) 
FROM salaries

SELECT * FROM salaries
WHERE to_date = NULL 

SELECT * FROM salaries
WHERE from_date = NULL 

SELECT * FROM salaries
WHERE  NOT LEN(to_date)>0

SELECT * FROM salaries
WHERE  NOT LEN(from_date)>0

SELECT * FROM salaries
WHERE NOT LEN(SALARY)>0


SELECT salary, to_date
FROM salaries
WHERE YEAR(to_date) between 1986 AND 2001
GO


--checking for duplicate values in emp_no
Select emp_no, count(emp_no) 
from employeesWithLeavingDate 
group by emp_no
having count(emp_no)>1


Select emp_no, first_name, gender, leaving_date, count (*)
from employeesWithLeavingDate 
group by  emp_no, first_name, gender, leaving_date
having count(*)>1


Select emp_no, salary, from_date, to_date, count (*)
from salaries 
group by emp_no, salary, from_date, to_date
having count(*)>1



SELECT ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY emp_no DESC), emp_no, dept_no, from_date, to_date
FROM dept_emp


--check if the employee number occurs twice
Select emp_no, count(emp_no) AS count
FROM dept_emp
group by emp_no
having count(emp_no)>1

--Checking for the employees who have changed the depts
SELECT * FROM dept_emp
WHERE emp_no IN (SELECT emp_no FROM dept_emp
group by emp_no
having count(emp_no)>1)
ORDER BY emp_no, from_date ASC


SELECT * FROM salaries
WHERE YEAR(to_date) between 1986 AND 2001
GO

SELECT * FROM salaries
WHERE emp_no  IN (10010, 10018, 10050)
GO

---count of employees from 1986 to 2001
SELECT * FROM employeesWithLeavingDate
order by hire_date 

--There is no info on employees being hired after 1999
SELECT  YEAR(hire_date) AS Calender_Year, COUNT(emp_no) AS num_of_employees from  employeesWithLeavingDate 
GROUP BY YEAR(hire_date)
HAVING YEAR(hire_date) between 1986 AND 2001
order by  Calender_Year

---count of employees by gender from 1986 to 2001
SELECT  YEAR(hire_date) AS Calender_Year, gender, COUNT(emp_no) AS num_of_employees from  employeesWithLeavingDate 
GROUP BY YEAR(hire_date), gender
HAVING YEAR(hire_date) between 1986 AND 2001
order by  Calender_Year ASC, gender

--Number of employees hired per department 1986-2001 (dept no shown).
SELECT  YEAR(d.from_date) AS Calender_Year, d.dept_no, COUNT(e.emp_no) AS num_of_employees from  employeesWithLeavingDate e
JOIN dept_emp d ON e.emp_no = d.emp_no
GROUP BY YEAR(d.from_date), d.dept_no
HAVING YEAR(d.from_date) between 1986 AND 2001 
order by  Calender_Year, num_of_employees

--Count of employees deptwise 1986-2001 (imp) with (dept name shown)
SELECT YEAR(de.from_date) AS calender_year, COUNT(e.emp_no) AS total_employees, d.dept_name
FROM employeesWithLeavingDate e 
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
GROUP BY YEAR(de.from_date), d.dept_name
HAVING YEAR(de.from_date) BETWEEN 1986 AND 2001
ORDER BY calender_year, total_employees desc

SELECT YEAR(de.from_date) AS calender_year, COUNT(e.emp_no) AS total_employees
FROM employeesWithLeavingDate e 
JOIN dept_emp de
ON e.emp_no = de.emp_no
GROUP BY YEAR(de.from_date)
HAVING YEAR(de.from_date) BETWEEN 1986 AND 2001
ORDER BY calender_year, total_employees desc

--Gender bias deptwise 1986-2001 (imp) with (dept name shown)
SELECT YEAR(de.from_date) AS calender_year, COUNT(e.emp_no) AS total_employees, e.gender, d.dept_name
FROM employeesWithLeavingDate e 
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
GROUP BY YEAR(de.from_date), d.dept_name, e.gender
HAVING YEAR(de.from_date) BETWEEN 1986 AND 2001
ORDER BY calender_year 



--Count of employees by gender 1986-2001 (imp)
SELECT  YEAR(d.from_date) AS Calender_Year, e.gender, COUNT(e.emp_no) AS num_of_employees from  employeesWithLeavingDate e
JOIN dept_emp d ON e.emp_no = d.emp_no
GROUP BY YEAR(d.from_date), e.gender
HAVING YEAR(d.from_date) between 1986 AND 2001
order by  Calender_Year, e.gender

--count of employees 1986-2001 (imp)
SELECT  YEAR(d.from_date) AS Calender_Year, COUNT(e.emp_no) AS num_of_employees from  employeesWithLeavingDate e
JOIN dept_emp d ON e.emp_no = d.emp_no
GROUP BY YEAR(d.from_date)
HAVING YEAR(d.from_date) BETWEEN 1986 AND 2001
order by  Calender_Year


--SIMPLE join between dept_emp & department
SELECT  e.emp_no, d.dept_name, de.from_date, de.to_date
FROM employeesWithLeavingDate e 
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no



SELECT * from salaries
where YEAR(to_date) = 2001
order by salary DESC
GO

SELECT  s.emp_no, d.dept_name, s.from_date, s.to_date, s.salary
FROM salaries s
JOIN dept_emp de
ON s.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE YEAR(s.to_date) = 2001 AND d.dept_name = 'Development'
ORDER BY s.salary DESC 

--Total Salary 1986-2001
SELECT SUM(salary) AS Total_salary
FROM salaries
WHERE YEAR(to_date) between 1986 AND 2001
GO
--Total salary 1986 vs 2001 (yearwise)
SELECT YEAR(to_date) AS Calender_Year, SUM(salary) AS Total_Salary from salaries
GROUP BY YEAR(to_date)
HAVING YEAR(to_date) between 1986 AND 2001
ORDER BY Calender_Year
GO

--Total salary by gender 1986 vs 2001(over all)
SELECT e.gender, SUM(s.salary) AS Total_Salary 
from  employeesWithLeavingDate e 
JOIN salaries s  
ON e.emp_no = s.emp_no
GROUP BY e.gender

--Total salary by gender 1986 vs 2001
SELECT  YEAR(s.to_date) AS Calender_Year, e.gender, SUM(s.salary) AS Total_Salary from salaries s
JOIN employeesWithLeavingDate e ON e.emp_no = s.emp_no
GROUP BY YEAR(s.to_date), e.gender
HAVING YEAR(s.to_date) between 1986 AND 2001
order by  Calender_Year, e.gender



--Total salary by department from 1986 vs 2001
SELECT  YEAR(s.to_date) AS Calender_Year, d.dept_name, SUM(s.salary) AS Total_Salary from salaries s
JOIN dept_emp de ON de.emp_no = s.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY YEAR(s.to_date), d.dept_name
HAVING YEAR(s.to_date) between 1986 AND 2001
order by  Calender_Year, Total_Salary DESC



--Average salary 1986 vs 2001
SELECT YEAR(to_date) AS Calender_Year, AVG(salary) from salaries
GROUP BY YEAR(to_date)
HAVING YEAR(to_date) between 1986 AND 2001
ORDER BY Calender_Year
GO

--Average salary by gender(overall)
SELECT e.gender, AVG(s.salary) AS Average_Salary from salaries s
JOIN employeesWithLeavingDate e ON e.emp_no = s.emp_no
GROUP BY e.gender


--Average salary by gender from 1986 vs 2001
SELECT  YEAR(s.to_date) AS Calender_Year, e.gender, AVG(s.salary) AS Average_Salary from salaries s
JOIN employeesWithLeavingDate e ON e.emp_no = s.emp_no
GROUP BY YEAR(s.to_date), e.gender
HAVING YEAR(s.to_date) between 1986 AND 2001
order by  Calender_Year, e.gender


--Average salary by gender from 1986 vs 2001 (Department-wise)
SELECT  YEAR(s.to_date) AS Calender_Year, d.dept_name, e.gender, AVG(s.salary) AS Average_Salary from salaries s
JOIN employeesWithLeavingDate e ON e.emp_no = s.emp_no
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY YEAR(s.to_date), e.gender, d.dept_name
HAVING YEAR(s.to_date) between 1986 AND 2001
order by  Calender_Year, e.gender


--Average salary by department overall
SELECT d.dept_no, AVG(s.salary) AS Average_Salary from salaries s
JOIN dept_emp d ON d.emp_no = s.emp_no
GROUP BY d.dept_no
order by Average_Salary DESC

--Average salary by department from 1986 vs 2001
SELECT  YEAR(s.to_date) AS Calender_Year, d.dept_no, AVG(s.salary) AS Average_Salary from salaries s
JOIN dept_emp d ON d.emp_no = s.emp_no
GROUP BY YEAR(s.to_date), d.dept_no
HAVING YEAR(s.to_date) between 1986 AND 2001
order by  Calender_Year, Average_Salary DESC

