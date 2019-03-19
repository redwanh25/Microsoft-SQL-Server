use [Linq_All_Code_DB]
go

create table tblPerson
(
PersonID int primary key,
[Name] nvarchar(50),
[Gender] nvarchar(50),
)

insert into tblPerson values(1, 'redwan', 'male')
insert into tblPerson values(2, 'masuda', 'female')
insert into tblPerson values(3, 'jamila', 'female')
insert into tblPerson values(4, 'ramij', 'male')
insert into tblPerson values(5, 'Joya', 'female')
insert into tblPerson values(6, 'shihab', 'male')

select * from tblPerson

Create table Departments
(
     ID int primary key identity,
     Name nvarchar(50),
     Location nvarchar(50)
)
GO

Create table Employees
(
     ID int primary key identity,
     FirstName nvarchar(50),
     LastName nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references Departments(Id)
)
GO

Insert into Departments values ('IT', 'New York')
Insert into Departments values ('HR', 'London')
Insert into Departments values ('Payroll', 'Sydney')
GO

Insert into Employees values ('Mark', 'Hastings', 'Male', 60000, 1)
Insert into Employees values ('Steve', 'Pound', 'Male', 45000, 3)
Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000, 1)
Insert into Employees values ('Philip', 'Hastings', 'Male', 45000, 2)
Insert into Employees values ('Mary', 'Lambeth', 'Female', 30000, 2)
Insert into Employees values ('Valarie', 'Vikings', 'Female', 35000, 3)
Insert into Employees values ('John', 'Stanmore', 'Male', 80000, 1)
GO

select * from Departments
select * from Employees