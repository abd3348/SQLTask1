create table Departments(
DepartmentID int identity(1,1) primary key,
DepartmentName varchar(100) not null unique);

create table Students(
StudentID int primary key,
FullName varchar(100) not null,
Email varchar(100) not null unique,
GPA decimal(3,2),
DepartmentID int foreign key references Departments(DepartmentID));

create table StudentProfiles(
ProfileID int primary key,
StudentID int foreign key references Students(StudentID) unique,
Address1 varchar(100),
EmergencyPhone varchar(20));



create table Courses (
CourseID int primary key,
CourseName varchar(100) not null,
Credits int,
DepartmentID int foreign key references Departments(DepartmentID));

CREATE TABLE StudentCourses(
StudentID INT FOREIGN KEY REFERENCES STUDENTS(STUDENTID),
CourseID INT FOREIGN KEY REFERENCES COURSES(COURSEID),
EnrollmentDate DATETIME DEFAULT GETDATE(),
primary key(studentid,courseid)
);

alter table students
add age int;

drop table TempInstsructors;

insert into Departments
values( 'Computer Science'), ( 'Software Engineering'),('Business Administration');

insert into Students
(StudentID,FullName,Email,GPA,DepartmentID,age)
values(101,'Ali Smadi' ,'ali@coursehub.com' ,3.80,1,22),
(102,'Omar Ahmad' , 'omar@coursehub.com' ,2.90 ,1 , 21),
(103,'Laila Hassan' ,'laila@coursehub.com' ,3.50 ,2 ,23),
(104,'Tariq Zaid' , 'tariq@coursehub.com' ,2.10 ,3 ,20);

insert into StudentProfiles
values
(1, 101, 'Amman Jordan', '0791111111'),
(2, 102, 'Irbid Jordan', '0792222222'), 
(3, 103, 'Zarqa Jordan', '0793333333');

insert into Courses
values
(201, 'Database Systems', 3, 1), (202, 'Web Development', 3, 1), (203, 'Software Architecture', 3, 2);

INSERT INTO StudentCourses (StudentID, CourseID)
VALUES
(101,201),
(101,202),
(102,201),
(103,203);

update Students 
set GPA=2.50
where StudentID = 104;

delete Students
where StudentID = 104;

select FullName, GPA,DepartmentName from Students
inner join Departments
on Students.DepartmentID= Departments.DepartmentID;

select DepartmentName,FullName from Departments
left join Students
on Students.DepartmentID= Departments.DepartmentID;

select FullName, Address1,EmergencyPhone from Students
inner join StudentProfiles
on Students.StudentID= StudentProfiles.StudentID;

select FullName,CourseName,EnrollmentDate from Students
inner join StudentCourses
on Students.StudentID= StudentCourses.StudentID
inner join Courses
on StudentCourses.CourseID= Courses.CourseID;

SELECT count(*) as TotalStudents, AVG(gpa) as AverageGPA, max(gpa) as HighestGPA, min(gpa)as LowestGPA
FROM Students;

SELECT AVG(gpa) as AverageGPA,count(*) as TotalStudents
FROM Students
group by DepartmentID;

SELECT DepartmentID,AVG(gpa) as AverageGPA,count(*) as TotalStudents
FROM Students
group by DepartmentID
having AVG(gpa)> 3.00;

SELECT
    DepartmentID,
    COUNT(*) AS TotalStudents
FROM Students
WHERE GPA >= 2.50
GROUP BY DepartmentID
HAVING COUNT(*) > 1;


EXEC sp_helpindex 'Students';

CREATE NONCLUSTERED INDEX IX_Students_Email
ON Students(Email);

SELECT *
FROM Students
WHERE Email = 'ali@coursehub.com';

select fullname from Students
where GPA > (select avg(GPA) from Students);

create view vw_StudentAcademicDetails
as
select StudentID,FullName,gpa,Departments.DepartmentName from Students
inner join Departments
on Students.DepartmentID=Departments.DepartmentID;

select * from vw_StudentAcademicDetails;

CREATE PROCEDURE sp_GetStudentsByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM Students
    WHERE DepartmentID = @DeptID;
END;

EXEC sp_GetStudentsByDepartment @DeptID = 1;