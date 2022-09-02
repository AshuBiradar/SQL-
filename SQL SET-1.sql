create database FISdb2
use FISdb2
create table DEPT(DEPTNO int primary key, DNAME varchar(20),LOC varchar(20))
create table EMP(EMPNO int , ENAME varchar(20), JOB varchar(20), MGR_ID int , HIREDATE Date, SAL FLOAT, COMM int, DEPTNO int foreign key references DEPT(DEPTNO))
insert into DEPT values(10,'ACCOUNTING','NEW YORK'),(20,'RESEARCH',' DALLAS '),(30,' SALES',' CHICAGO '),(40,' OPERATIONS','BOSTON')
select * from DEPT
insert into EMP values(7369,'SMITH','CLERK',7902, ' 17-DEC-80 ', 800,null, 20)
insert into EMP values (7499,' ALLEN',' SALESMAN ', 7698 , ' 20-FEB-81 ',1600 ,300, 30),(7521,' WARD','SALESMAN', 7698 , ' 22-FEB-81 ', 1250, 500,30) ,
(7566,'JONES','MANAGER',7839, '  02-APR-81 ',2975,null,20),(7654,'MARTIN','SALESMAN',7698,' 28-SEP-81 ',1250,1400,30),(7698,'BLAKE','MANAGER ',7839,' 01-MAY-81 ',2850,null,30),
(7782,'CLARK','MANAGER',7839, ' 09-JUN-81  ',2450,null,10),(7788,'SCOTT','ANALYST',7566, ' 19-APR-87 ', 3000,null,20),(7839,'KING','PRESIDENT',null,' 17-NOV-81 ',5000,null,10),
(7844,'TURNER','SALESMAN',7698,'  08-SEP-81 ',1500,0,30),(7876,'ADAMS','CLERK', 7788,' 23-MAY-87 ',1100,null,20),(7900,'JAMES','CLERK',7698,'03-DEC-81 ',950,null,30),
(7902,'FORD','ANALYST',7566,' 03-DEC-81 ',3000,null,20),(7934,'MILLER','CLERK', 7782, '  23-JAN-82 ',1300,null,10)


--1 List all employees whose name begins with 'A'. 
SELECT ENAME FROM EMP WHERE ENAME LIKE 'A%'


--2 Select all those employees who don't have a manager.
SELECT * FROM EMP WHERE MGR_ID IS NULL;


--3 List employee name, number and salary for those employees who earn in the range 1200 to 1400.
SELECT ENAME,EMPNO,SAL FROM EMP WHERE SAL BETWEEN 1200 AND 1400


--4  Give all the employees in the RESEARCH department a 10% pay rise. Verify that this has been done by listing all their details before and after the rise.
SELECT * FROM EMP,DEPT WHERE DEPT.DNAME LIKE ('%RESEARCH%')AND  EMP.DEPTNO=DEPT.DEPTNO  --BEFORE
--SELECT* FROM EMP,DEPT WHERE(EMP.DEPTNO=DEPT.DEPTNO AND DEPT.DNAME LIKE ('%RESEARCH%')) AND SAL=(SAL*1.0)
UPDATE EMP SET SAL=(SAL*1.0) FROM DEPT WHERE(EMP.DEPTNO=DEPT.DEPTNO AND DEPT.DNAME LIKE ('%RESEARCH%'))


--5 Find the number of CLERKS employed. Give it a descriptive heading.
SELECT COUNT(JOB) AS 'COUNT OF NO OF EMPLOYEES HAVING JOB AS CLERKS IN TABLE EMPLOYEE ' FROM EMP WHERE JOB='CLERK' 


--6 Find the average salary for each job type and the number of people employed in each job.
SELECT JOB,AVG(SAL) AS 'SALARY AVERAGE' ,COUNT(EMPNO) AS 'EMPLOYEE GROUPED BY JOB' FROM EMP,DEPT  GROUP BY JOB  


--7 List the employees with the lowest and highest salary
SELECT * FROM EMP  WHERE SAL in ( select min(SAL) 
 from EMP union SELECT max(SAL) from EMP);

SELECT MAX(SAL)AS MAX_SAL, MIN(SAL) AS MIN_SAL FROM EMP;

--8 List full details of departments that don't have any employees.
 SELECT DNAME,LOC FROM DEPT D EXCEPT SELECT DNAME,LOC FROM DEPT D
     JOIN EMP E
     ON E.DEPTNO = D.DEPTNO;

--9 Get the names and salaries of all the analysts earning more than 1200 who are based in department 20. Sort the answer by ascending order of name.
SELECT ENAME,SAL FROM EMP WHERE JOB='ANALYST' AND SAL>1200 AND DEPTNO=20 ORDER BY ENAME ASC


--10 For each department, list its name and number together with the total salary paid to employees in that department.
SELECT DNAME,SUM(SAL) AS 'TOTAL SALARY' FROM DEPT,EMP GROUP BY DNAME 


--11  Find out salary of both MILLER and SMITH.
SELECT ENAME,SAL FROM EMP WHERE ENAME='MILLER' OR ENAME='SMITH'


--12 Find out the names of the employees whose name begin with ‘A’ or ‘M’
SELECT ENAME FROM EMP WHERE ENAME LIKE 'A%'OR ENAME LIKE 'M%'


--13 Compute yearly salary of SMITH
SELECT SUM(12*SAL) AS 'YEARLY SAL OF SMITH' FROM EMP WHERE ENAME='SMITH' 


--14 List the name and salary for all employees whose salary is not in the range of 1500 and 2850
SELECT ENAME,SAL FROM EMP WHERE SAL NOT BETWEEN 1500 AND 2850 

