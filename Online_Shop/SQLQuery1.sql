create database Online_Shop

create table tblEmployee
(
ID int identity Primary key,
[Name] nvarchar(50),
Email nvarchar(50),
Gender nvarchar(50),
Age int
)

insert into tblEmployee values('redwan', 'redwan@gmail.com', 'male', 19)
insert into tblEmployee values('shihab', 'shihab@gmail.com', 'male', 20)
insert into tblEmployee values('ramij', 'ramij@gmail.com', 'male', 18)
insert into tblEmployee values('riya', 'riya@gmail.com', 'female', 19)
insert into tblEmployee values('ayon', 'ayon@gmail.com', 'male', 21)
insert into tblEmployee values('nipu', 'nipu@gmail.com', 'female', 17)
insert into tblEmployee values('xack', 'xack@gmail.com', 'male', 24)
insert into tblEmployee values('kafi', 'kafi@gmail.com', 'female', 23)

select * from tblEmployee

create procedure EmployeeProcedure
@name nvarchar(50) = NULL,
@email nvarchar(50) = NULL,
@gender nvarchar(50) = NULL,
@age int = NULL
as
begin
	select * from tblEmployee
	where ([Name] = @name or @name is NULL) and
	(Email = @email or @email is NULL) and
	(Gender = @gender or @gender is NULL) and
	(Age = @age or @age is NULL)
end


Execute EmployeeProcedure @gender = 'female'

create table tblSignUp
(
[ID] int identity primary key,
[First Name] nvarchar(50),
[Last Name] nvarchar(50),
[Email] nvarchar(50),
[Password] nvarchar(50),
[Phone Number] nvarchar(50),
[Gender] nvarchar(50),
)

select Email from tblEmployee where Email = 'redwan@gmail.com'

select * from tblSignUp
select * from tblEmployee

