create database FISdb_3;
use FISdb_3;

--1 
create table books(id int primary key,title varchar(30),author varchar(20),isbn numeric(13) unique,publised_date datetime);
insert into books values(1,'My First SQL Book','Mary Parker',981483029127,'2012-02-22 12:08:17'),(2,'My Second SQL Book','John Mayer',857300923713 ,'1972-07-03 09:22:45')
,(3,'My Third SQL Book','Cary Flint ',523120967812 ,'2015-10-18 14:05:44')

select * from books where author like '%er'

--2
create table reviews(id int foreign key references books(id),book_id int ,reviewer_name varchar(30),content varchar(30), rating int,publised_date datetime)
insert into reviews values(1,1,'John Smith','My First Review',4,'2017-12-10 05:50:11'),(2,2,'John Smith','My Second Review',5,'2017-10-13 15:50:12')
,(3,2,'Alice Walker','Another Review',1,'2017-10-22 23:47:10')

select title,author,reviewer_name as 'Reviewer Name' from books,reviews where books.id=reviews.id

--3
select reviewer_name from (select reviewer_name from reviews group by reviewer_name having count(reviewer_name) > 1) reviews

--4
create table CUSTOMERS(ID int primary key,NAME varchar(20),AGE int,ADDRESS varchar(20),SALARY float)
insert into CUSTOMERS values(1,'Ramesh',32,'Ahmedabad',2000.00),(2,'Khilan',25,'Delhi',1500.00),(3,'Kaushik',23,'Kota',2000.00),(4,'Chaitali',25,'Mumbai',6500.00),
(5,'Hardik',27,'Bhopal',8500.00),(6,'Komal',22,'MP',4500.00),(7,'Muffy',24,'Indore',10000.00)

select NAME  from CUSTOMERS where ADDRESS in (select ADDRESS from CUSTOMERS where ADDRESS like '%o%' )

--5
create table ORDERS(OID int,DATE datetime,CUSTOMER_ID int references CUSTOMERS(ID),AMOUNT int)
insert into ORDERS values(102,'2009-10-08 00:00:00',3,3000),(100,'2009-10-08 00:00:00',3,1500),(101,'2009-11-20 00:00:00',2,1560),(103,'2008-05-20 00:00:00',4,2060)

select count(*)'Total No of customers placed order on same date',O.Date 'Order Date' from CUSTOMERS c  join ORDERS O on c.ID= O.CUSTOMER_ID 
group by O.DATE having count(*)>1


--6 
create table Employee(ID int primary key,NAME varchar(20),AGE int,ADDRESS varchar(20),SALARY float)
insert into Employee values(1,'Ramesh',32,'Ahmedabad',2000.00),(2,'Khilan',25,'Delhi',1500.00),(3,'Kaushik',23,'Kota',2000.00),(4,'Chaitali',25,'Mumbai',6500.00),
(5,'Hardik',27,'Bhopal',8500.00),(6,'Komal',22,'MP',null),(7,'Muffy',24,'Indore',null)

select lower(NAME) as'Employee Name'  from Employee where SALARY is null;

--7
create table Studentdetails(id int,RegisterNo int primary key, Name varchar(20),Age int,Qualification varchar(30),MobileNo numeric(10),Mail_id varchar(30),Location varchar(20),Gender varchar(1))
insert into Studentdetails values(1,2,'Sai',22,'B.E',9876543256,'Sai@gmail.com','Chennai','M'),(2,3,'Kumar',20,'BSC',7876543256,'Kumar@gmail.com','Madhurai','M'),(3,4,'Selvi',22,'B.Tech',8876543256,'selvi@gmail.com','Selam','F')
,(4,5,'Nisha',25,'M.E',7786543256,'Nisha@gmail.com','Theni','F'),(5,6,'SaiSaran',21,'B.A',9876543256,'saran@gmail.com','Madurai','F'),(6,7,'Tom',23,'BCA',9876543256,'Tom@gmail.com','Pune','M')

select Gender ,count(case when Studentdetails.Gender='M'then 1 end)as Male_Count,
count(case when Studentdetails.Gender='F'then 1 end)as Female_Count from Studentdetails group by Gender

--8
create table Coursedetails(C_id varchar(5) primary key,C_Name varchar(20),Start_Date date,End_Date date,Fee numeric(5))
insert into Coursedetails values('DN003','DotNet','2018-02-01','2018-02-28',15000),('DV004','Data Visualization','2018-03-01','2018-04-15',15000),
('JA002','AdvancedJava','2018-01-02','2018-01-20',10000),('JC001','CoreJava','2018-01-02','2018-01-12',3000)

create table CourseRegistration(RegisterNo int references Studentdetails(RegisterNo) ,C_id VARCHAR(5) references Coursedetails(C_id),Batch varchar(4))
insert into CourseRegistration values(2,'DN003','FN'),(3,'DV004','AN'),(4,'JA002','FN'),(2,'JA002','AN'),(5,'JC001','FN')

SELECT C_Name as 'Course Name',(select count(*) from CourseRegistration  WHERE  C_id=d.C_id)'No Of Student Registered' from Coursedetails d 
where Start_Date>='2018-01-02' and End_Date<='2018-02-28' ORDER BY C_id DESC


--9
create table Customer(customer_id int primary key,first_name varchar(10),last_name varchar(10))
insert into Customer values(1,'George','Washington'),(2,'John','Adams'),(3,'Thomas','Jeffersons'),(4,'James','Madison'),(5,'James','Monroe')
create table order1(order_id int primary key,order_date date,amount varchar(7),customer_id int foreign key references Customer(customer_id))
insert into order1 values(1,'07/04/1776','$234.56',1),(2,'03/14/1760','$78.50',3),(3,'05/23/1784','$124.00',2),(4,'09/03/1790','$65.50',3),(5,'07/21/1795','$25.50',1),(6,'11/27/1787','$14.40',2)

select * from Customer c where (select count(*) from order1 where customer_id=c.customer_id)=2

--10
select Name,upper(Location)as 'Location' from Studentdetails order by Name desc 

--11
create table ORDER2(ID int primary key,OrderName varchar(10),OrderNumber int,CustomerId int,TotalAmount float)
create table PRODUCT(ID int primary key,ProductName varchar(10),UnitPrice float,Package varchar(10),IsDiscontinued varchar(5))
create table ORDERITEM(ID int primary key,OrderID int references ORDER2(ID),ProductID int references PRODUCT(ID),UnitPrice float,Quanity int)


create view ORDER2view as select ProductName,Quanity,OrderNumber from ORDER2 o join ORDERITEM oi on o.ID=oi.ID join PRODUCT p on oi.ProductID=p.ID


--12
select C_Name as 'Course Name of Nisha 'from (( Coursedetails d inner join CourseRegistration c on d.C_id=c.C_id ) inner join Studentdetails s on s.RegisterNo=c.RegisterNo)
where Name='Nisha'
