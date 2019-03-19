create Database MVC_Demo_Database

use [MVC_Demo_Database]
go

create table tblEmployee
(
EmployeeId int primary key identity,
Name nvarchar(50),
Gender nvarchar(50),
City nvarchar(50)
)

insert into tblEmployee values('Mark', 'Male', 'London')
insert into tblEmployee values('John', 'Male', 'Chennai')
insert into tblEmployee values('Mary', 'Female', 'New York')
insert into tblEmployee values('Mike', 'Male', 'Sydeny')

select * from tblEmployee

create table tblPerson
(
PersonID int primary key,
[Name] nvarchar(50),
[Gender] nvarchar(50),
[DepartmentID] int
)

-- age ai  table create korte hobe. cs, oi table a foreign key ase.
create table tblDepartment
(
[DeptID] int primary key,
[DepartmentName] nvarchar(50),
[DepartmentHeadName] nvarchar(50)
)


select * from tblPerson
select * from tblDepartment

insert into tblPerson values(1, 'redwan', 'male', 1)
insert into tblPerson values(2, 'masuda', 'female', 1)
insert into tblPerson values(3, 'jamila', 'female', 2)
insert into tblPerson values(4, 'ramij', 'male', 3)
insert into tblPerson values(5, 'Joya', 'female', 1)
insert into tblPerson values(6, 'shihab', 'male', 2)


insert into tblDepartment values(1, 'IT', 'Reza Nabi')
insert into tblDepartment values(2, 'Accounting', 'Yousuf Jamil')
insert into tblDepartment values(3, 'CSE', 'Kella Foteh')

create table Brand
(
	BrandId int identity primary key,
	BrandImage varbinary(max)
)

select * from Brand

create proc spGetImageById
@Id int
as
begin
	select BrandImage from Brand where BrandId = @Id
end

spGetImageById 2
