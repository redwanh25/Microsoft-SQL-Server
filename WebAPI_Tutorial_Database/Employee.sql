create database WebAPI_Tutorial_Database

use WebApi_Tutorial_Database
go

create table Employees
(
ID int identity primary key,
[First Name] nvarchar(50),
[Last Name] nvarchar(50),
Gender nvarchar(50),
Salary int
)

insert into Employees values ('Redwan', 'Hossain', 'Male', 10000)
insert into Employees values ('Sharar', 'Khan', 'Male', 20000)
insert into Employees values ('Nayma', 'Sultana', 'Female', 30000)
insert into Employees values ('Ramijul', 'Islam', 'Male', 40000)
insert into Employees values ('Nazia', 'Afrose', 'Female', 50000)
insert into Employees values ('Jahid', 'Hasan', 'Male', 60000)

select * from Employees

use WebAPI_Tutorial_Database
go
select * from Employees


--{ "id": 1, "first_Name": "Redwan", "last_Name": "Hossain", "gender": "Male", "salary": 10000 }

--http://localhost:59705/api/employees?first_Name=Redwan&last_Name=Hossain&gender=Male&salary=10000
--http://localhost:59705/api/employees?id=1&first_Name=Redwan&last_Name=Hossain&gender=Male&salary=10000

create table Users
(
Id int identity primary key,
Username nvarchar(50),
Password nvarchar(50)
)
insert into Users values ('Male', 'Male')
insert into Users values ('Female', 'Female')

select * from Users
