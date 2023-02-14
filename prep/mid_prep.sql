CREATE DATABASE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT,
	JOINING_DATE DATE,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11', 'Admin');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATE,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');

CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATE,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20'),
 (002, 'Executive', '2016-06-11'),
 (008, 'Executive', '2016-06-11'),
 (005, 'Manager', '2016-06-11'),
 (004, 'Asst. Manager', '2016-06-11'),
 (007, 'Executive', '2016-06-11'),
 (006, 'Lead', '2016-06-11'),
 (003, 'Lead', '2016-06-11');

-- 5, 21, 23, 24, 25, 30, 33, 35, 39, 40, 45

-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT FIRST_NAME as WORKER_NAME FROM Worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT upper(FIRST_NAME) FROM Worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT DEPARTMENT FROM Worker;

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT substr(FIRST_NAME, 1, 3) FROM Worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.
-- INSTR(string, substring, start_position, nth_appearance)
SELECT position('a' IN FIRST_NAME) FROM Worker WHERE FIRST_NAME = 'Amitabh';

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT rtrim(FIRST_NAME) FROM Worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT ltrim(FIRST_NAME) FROM Worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT DEPARTMENT, length(DEPARTMENT) FROM Worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT replace(FIRST_NAME, 'a', 'A') FROM Worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
SELECT FIRST_NAME || ' ' || LAST_NAME AS COMPLETE_NAME FROM Worker;
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS COMPLETE_NAME FROM Worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM Worker ORDER BY FIRST_NAME ASC;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM Worker ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM Worker WHERE FIRST_NAME = 'Vipul' OR FIRST_NAME = 'Satish';
SELECT * FROM Worker WHERE FIRST_NAME IN ('Vipul', 'Satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM Worker WHERE FIRST_NAME NOT IN ('Vipul', 'Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
SELECT * FROM Worker WHERE DEPARTMENT = 'Admin';
SELECT * FROM Worker WHERE DEPARTMENT LIKE 'Admin%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM Worker WHERE FIRST_NAME LIKE '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM Worker WHERE trim(FIRST_NAME) LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM Worker WHERE TRIM(FIRST_NAME) LIKE '%h' AND length(TRIM(FIRST_NAME)) = 6;

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM Worker WHERE SALARY >= 100000 AND SALARY <= 500000;
SELECT * FROM Worker WHERE SALARY BETWEEN 100000 AND 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.

SELECT * FROM Worker WHERE JOINING_DATE >= '2014-02-01' AND JOINING_DATE <= '2014-02-28';

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT COUNT(WORKER_ID) FROM Worker WHERE DEPARTMENT = 'Admin';

-- Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
SELECT FIRST_NAME || ' ' || LAST_NAME AS WORKER_NAME FROM Worker WHERE SALARY BETWEEN 50000 AND 100000;
SELECT * FROM Worker;

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT COUNT(WORKER_ID), DEPARTMENT FROM Worker GROUP BY DEPARTMENT ORDER BY COUNT(WORKER_ID) DESC;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT * FROM Worker, Title where WORKER_ID = WORKER_REF_ID and WORKER_TITLE = 'Manager';
SELECT * FROM Worker WHERE WORKER_ID IN (SELECT WORKER_REF_ID FROM Title WHERE WORKER_TITLE = 'Manager');

-- Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.
SELECT WORKER_TITLE, AFFECTED_FROM FROM Title GROUP BY (WORKER_TITLE, AFFECTED_FROM) HAVING COUNT(WORKER_TITLE) > 1;

-- Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM Worker WHERE WORKER_ID % 2 != 0;
SELECT * FROM Worker WHERE MOD(WORKER_ID, 2) <> 0;

-- Q-27. Write an SQL query to show only even rows from a table.
SELECT * FROM Worker WHERE WORKER_ID % 2 = 0;

-- Q-28. Write an SQL query to clone a new table from another table.
SELECT * INTO Workerclone FROM Worker;

-- Q-29. Write an SQL query to fetch intersecting records of two tables.
(SELECT * FROM Worker) INTERSECT (SELECT * FROM Workerclone);

-- Q-30. Write an SQL query to show records from one table that another table does not have.
SELECT * FROM Worker MINUS
SELECT * FROM TITLE;

-- Q-31. Write an SQL query to show the current date and time.
SELECT NOW();

-- Q-32. Write an SQL query to show the top n (say 10) records of a table.
SELECT * FROM Worker ORDER BY(SALARY) DESC LIMIT 10;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT * FROM Worker ORDER BY SALARY DESC LIMIT 1 OFFSET 4;

-- Q-34. Write an SQL query to determine the 5th highest salary without using TOP or limit method.

SELECT * FROM Worker;
-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT W.FIRST_NAME FROM Worker W, Worker W1 WHERE W.SALARY = W1.SALARY AND W.WORKER_ID != W1.WORKER_ID;

-- Q-36. Write an SQL query to show the second highest salary from a table.
SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY DESC LIMIT 1 OFFSET 1;
SELECT MAX(SALARY) FROM Worker WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM Worker);

-- Q-37. Write an SQL query to show one row twice in results from a table.
SELECT * FROM Worker WHERE DEPARTMENT = 'Admin'
union all
SELECT * FROM Worker WHERE DEPARTMENT = 'Admin';

-- Q-38. Write an SQL query to fetch intersecting records of two tables.
SELECT * FROM Worker
INTERSECT
SELECT * FROM Workerclone;

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
SELECT * FROM Worker WHERE WORKER_ID <= (SELECT COUNT(WORKER_ID) / 2 FROM Worker);

-- Q-40. Write an SQL query to fetch the departments that have less than five people in it.
SELECT DEPARTMENT, COUNT(WORKER_ID) FROM Worker GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) < 5;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT DEPARTMENT, COUNT(WORKER_ID) FROM Worker GROUP BY DEPARTMENT;

-- Q-42. Write an SQL query to show the last record from a table.
SELECT COUNT(WORKER_ID) FROM Worker; --8
SELECT * FROM Worker WHERE WORKER_ID = (SELECT COUNT(WORKER_ID) FROM Worker); -- MAX(WORKER_IT)

-- Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM Worker WHERE WORKER_ID = (SELECT MIN(WORKER_ID) FROM Worker);

-- Q-44. Write an SQL query to fetch the last five records from a table.
SELECT * FROM Worker ORDER BY WORKER_ID DESC LIMIT 5;
SELECT * FROM Worker ORDER BY WORKER_ID ASC LIMIT 5; --FIRST

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT FIRST_NAME FROM Worker WHERE SALARY IN (SELECT MAX(SALARY) FROM Worker GROUP BY DEPARTMENT);

-- Q-46. Write an SQL query to fetch three max salaries from a table.
SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY DESC LIMIT 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table.
SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY LIMIT 3;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY DESC LIMIT 5;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT DEPARTMENT, SUM(SALARY) FROM Worker GROUP BY DEPARTMENT;

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT FIRST_NAME, SALARY FROM Worker WHERE SALARY = (SELECT MAX(SALARY) FROM Worker);
select * from Worker;
-- 10
select salary, first_name,
       case when salary between 0 and 50000 then 'Small salary'
            when salary between 50001 and 100000 then 'Medium salary'
            else 'High salary'
        end from Worker;

select random();
select setseed(0.5);

select char_length(FIRST_NAME),
       bit_length(FIRST_NAME),
       octet_length(FIRST_NAME)
from Worker;


select *
from Worker
where Worker.FIRST_NAME like 'C_as_';

select coalesce(null, 2, null, 4);

select unnest(array [1, 2, 3]);

select *
from unnest(array [1, 2, 3], array ['a', 'b']);

SELECT DISTINCT SALARY FROM Worker ORDER BY SALARY ASC NULLS LAST LIMIT 1 OFFSET 2 ;

SELECT WORKER_REF_ID FROM TITLE WHERE WORKER_TITLE = 'Manager';

SELECT * FROM Title;

SELECT DISTINCT * FROM WORKER WHERE SALARY IN (SELECT MIN(SALARY) FROM Worker GROUP BY DEPARTMENT);

