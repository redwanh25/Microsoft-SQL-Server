create database MVC_Database

use MVC_Database
go

create table tblEmployee
(
Id int primary key identity,
Name nvarchar(50),
Gender nvarchar(50),
City nvarchar(50),
DateOfBirth DateTime
)

insert into tblEmployee values('Mark', 'Male', 'London', getDate())
insert into tblEmployee values('John', 'Male', 'Chennai', getDate())
insert into tblEmployee values('Mary', 'Female', 'New York', getDate())
insert into tblEmployee values('Mike', 'Male', 'Sydeny', getDate())

select * from tblEmployee
go

create procedure tblEmployeeProc
as
begin
	select * from tblEmployee
end

execute tblEmployeeProc

Create procedure spAddEmployee  
@Name nvarchar(50),  
@Gender nvarchar (10),  
@City nvarchar (50),  
@DateOfBirth DateTime  
as  
Begin  
	Insert into tblEmployee (Name, Gender, City, DateOfBirth)  
	 Values (@Name, @Gender, @City, @DateOfBirth)  
End

Create procedure spSaveEmployee      
@Id int,
@Name nvarchar(50),      
@Gender nvarchar (10),      
@City nvarchar (50),      
@DateOfBirth DateTime 
as      
Begin      
	Update tblEmployee Set Name = @Name, Gender = @Gender, City = @City, DateOfBirth = @DateOfBirth
	Where Id = @Id 
End

select * from tblEmployee

create table tblPerson
(
PersonID int primary key identity,
[Name] nvarchar(50),
[Gender] nvarchar(50),
[DepartmentID] int foreign key references tblDepartment(DeptID)
)

-- age ai  table create korte hobe. cs, oi table a foreign key ase.
create table tblDepartment
(
[DeptID] int primary key identity,
[DepartmentName] nvarchar(50),
[DepartmentHeadName] nvarchar(50)
)

drop table tblDepartment

select * from tblPerson
select * from tblDepartment

insert into tblPerson values('redwan', 'male', 1)
insert into tblPerson values('masuda', 'female', 1)
insert into tblPerson values('jamila', 'female', 2)
insert into tblPerson values('ramij', 'male', 3)
insert into tblPerson values('Joya', 'female', 1)
insert into tblPerson values('shihab', 'male', 2)


insert into tblDepartment values('IT', 'Reza Nabi')
insert into tblDepartment values('Accounting', 'Yousuf Jamil')
insert into tblDepartment values('CSE', 'Kella Foteh')
insert into tblDepartment values('BBA', 'Foteh')

select * from AspNetUsers

alter table AspNetUsers add FirstName nvarchar(50)
truncate table [dbo].[__MigrationHistory]

alter table AspNetUsers add LastName nvarchar(50)

Create table tblImages
(
    Id int primary key identity,
    Name nvarchar(255),
    Size int,
    ImageData varbinary(max)
)

Create procedure spUploadImage
@Name nvarchar(255),
@ImageData varbinary(max)
as
Begin
    Insert into tblImages values (@Name, @Size, @ImageData)
End
Go
