create table AccessCards(
CardID int identity(1,1) primary key,
CardNumber varchar(50) not null UNIQUE,
EmployeeID int foreign key References Employees(employeeId) not null UNIQUE);

create table Projects(
ProjectID int identity(1,1) primary key,
ProjectName varchar(50) not null);

create table EmployeeProjects(
AssignedDate  date,
ProjectID  int foreign key References projects(projectid) not null,
EmployeeID int foreign key References Employees(employeeID) not null,
primary key (employeeid,projectid)
);

insert into AccessCards values('Card 101',1),
('Card 102',2),
('Card 103',3);

insert into Projects values('AI & Security Training'),
('Cloud Migration');

select fullname,Salary,DepartmentName from Employees
inner join Departments
on Employees.DepartmentID=Departments.DepartmentID;

select DepartmentName,FullName from Departments
left join Employees
on Employees.DepartmentID=Departments.DepartmentID;

select FullName,CardNumber from Employees
inner join AccessCards
on Employees.EmployeeID=AccessCards.EmployeeID;

select fullname,ProjectName,AssignedDate from Employees
inner join EmployeeProjects
on Employees.EmployeeID=EmployeeProjects.EmployeeID
inner join Projects
on EmployeeProjects.ProjectID=Projects.ProjectID

SELECT
    DepartmentID,
    SUM(Salary) AS TotalSalary,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

SELECT
    DepartmentID,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 1000.00;

SELECT *
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

CREATE VIEW vw_EmployeeDetails AS
SELECT EmployeeID,FullName,Email,DepartmentName
FROM Employees
INNER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID;

select * from vw_EmployeeDetails;

CREATE PROCEDURE sp_GetEmployeesByDepartment 
@DeptID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DeptID;
END;

EXEC sp_GetEmployeesByDepartment @DeptID = 1;

CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Action VARCHAR(50),
    ActionDate DATETIME
);

CREATE TRIGGER trg_EmployeeDelete
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit
        (EmployeeID, Action, ActionDate)
    SELECT
        EmployeeID,
        'DELETE',
        GETDATE()
    FROM deleted;
END;

-- for delete all relations thart with emp

BEGIN TRANSACTION;

DELETE FROM AccessCards
WHERE EmployeeID = 3;

DELETE FROM Employees
WHERE EmployeeID = 3;

COMMIT;

SELECT * FROM EmployeeAudit;