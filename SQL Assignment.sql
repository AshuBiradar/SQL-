create database FISdb
use FISdb
 
create table Clients(Client_ID Numeric(4) primary key, Cname varchar(40) Not Null,Address varchar(30),Email varchar(30) Unique,Phone Numeric(10),Business varchar(20)Not Null)
create table Departments(Deptno Numeric(2) primary key, Dname varchar(15)Not Null ,Loc varchar(20))
create table Employees(Empno Numeric(4) primary key, Ename varchar(20)not null,Job varchar(15),Salary Numeric(7) check(Salary>0),Deptno Numeric(2) foreign key references Departments(Deptno))
create table Projects(Project_ID Numeric(3) primary key,Descr varchar(30)not null,Start_Date Date,Planned_End_Date Date,Actual_End_Date Date,constraint Actual_End_Date check(Actual_End_Date>Planned_End_Date),Budget Numeric(10) check(Budget>0),Client_ID Numeric(4) Foreign key references Clients(Client_ID))
create table EmpProjectTasks(Project_ID Numeric(3) foreign key references Projects,Empno Numeric(4) foreign key references Employees,Start_Date Date,End_Date Date,Task varchar(25)not null,Status varchar(15)not null)

insert into Clients values(1001,'ACME Utilities','Noida','contact@acmeutil.com',9567880032,'Manufacturing'),(1002,'Trackon Consultants','Mumbai','consult@trackon.com',8734210090,'Consultant'),(1003,'MoneySavers Distributors','Kolkata','save@moneysaver.com',7799886655,'Reseller'),(1004,'Lawful Corp','Chennai','justice@lawful.com',9210342219,'Professional')
insert into Departments values(10,'Design','Pune'),(20,'Development','Pune'),(30,'Testing','Mumbai'),(40,'Document','Mumbai')
insert into Employees values(7001,'Sandeep','Analyst',25000,10),(7002,'Rajesh','Designer',30000,10),(7003,'Madhav','Developer',40000,20),(7004,'Manoj','Developer',40000,20),(7005,'Abhay','Designer',35000,20),(7006,'Uma','Tester',30000,30),(7007,'Geeta','Tech.Writer',30000,40),(7008,'Priya','Tester',35000,30),(7009,'Nutan','Developer',45000,20),(7010,'Smita','Analyst',20000,10),(7011,'Anand','Project Mgr',65000,10)
insert into Projects values(401,'Inventory','11-04-01','11-10-01','11-10-31',150000,1001),(402,'Accounting','11-08-01','12-01-01',NULL,50000,1002),(403,'Payroll','11-10-11','11-12-31',NULL,75000,1003),(404,'Contact Mgr','11-11-01','11-12-31',NULL,50000,1004)
insert into EmpProjectTasks values(401,7001,'11-04-01','11-04-20','System Analysis','Completed'),(401,7002,'11-04-21','11-05-30','System Design','Completed'),(401,7003,'11-06-01','11-06-15','Coding','Completed'),(401,7004,'11-07-18','11-09-01','Coding','Completed'),(401,7006,'11-09-03','11-09-15','Testing','Completed'),(401,7009,'11-09-18','11-10-05','Code Change','Completed'),(401,7008,'11-10-06','11-10-16','Testing','Completed'),(401,7007,'11-10-06','11-10-22','Documentation','Completed'),(401,7011,'11-10-22','11-10-31','Sign Off','Completed'),(402,7010,'11-08-01','11-08-20','System Analysis','Completed'),(402,7002,'11-08-22','11-09-30','System Design','Completed'),(402,7004,'11-10-01',NULL,'Coding','In Progress')

Select * from Clients
Select * from Departments
Select * from Employees
Select * from  Projects
Select * from  EmpProjectTasks