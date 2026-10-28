create database TechWorldHRDB;

create table TemporaryStaff(
StaffID Int primary key,
StaffName varchar(50),
HireDate date);

create table Departments(
DepartmentID Int primary key,
DepartmentName varchar(50) not Null UNIQUE);

create table Employees(
EmployeeID int primary key,
FullName varchar(50) not Null,
Email varchar(50) UNIQUE,
Salary decimal(10,2),
DepartmentID int);

alter table Employees
add PhoneNumber varchar(20);

drop table TemporaryStaff;

insert into Departments values(1,'IT'),
(2,'HR'),
(3,'Finance');

select * from Departments;

insert into Employees values(1,'Ahmad Ali','ahmad@techworld.com',1200,1,'0791111111'),
(2,'Sara Hassan','sara@techworld.com',950.00 ,2,'0792222222'),
(3,'Zaid Omar','zaid@techworld.com' ,1500,1,'0793333333'),
(4,'Mona Khaled','mona@techworld.com' ,800,3,'0794444444');

select * from Employees;

update Employees
set Salary = 1350
where EmployeeID=1;

delete Employees
where EmployeeID=4;

select * from Employees;

select FullName,Salary from Employees;

select sum(Salary) as TotalSalaries from Employees;

select avg(Salary) as AverageSalary from Employees;

select MIN(Salary) as LowestSalary from Employees;

select MIN(Salary) as HighestSalary from Employees;

SELECT COUNT(*) AS TotalEmployees FROM EMPLOYEES;