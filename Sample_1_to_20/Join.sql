use [Sample_1_to_20]
go

create table tblEmployee
(
[ID] int identity(1, 1) Primary key,
[Name] nvarchar(50),
[Gender] nvarchar(50),
[Salary] int,
[DepartmentID] int
)

create table tblDepartment
(
[ID] int identity(1, 1) Primary key,
[DepartmentName] nvarchar(50),
[Location] nvarchar(50),
[DepartmentHead] nvarchar(50)
)

select * from tblEmployee
select * from tblDepartment

insert into tblDepartment values ('IT', 'London', 'Rick')
insert into tblDepartment values ('Payroll', 'Delhi', 'Ron')
insert into tblDepartment values ('HR', 'New York', 'christie')
insert into tblDepartment values ('Other Department', 'sydney', 'cindrella')
insert into tblEmployee values ('Valarie', 'female', 5500, 1)

-- Inner join

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
Inner join tblDepartment
ON tblEmployee.DepartmentID = tblDepartment.Id		-- same as tblDepartment.Id = tblEmployee.DepartmentID

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
join tblDepartment									-- inner join / join same kotha
ON tblDepartment.Id = tblEmployee.DepartmentID		-- aitao hobe. but, no need

-- Outer join

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
left outer join tblDepartment						--  left outer join / left join   -- right outer join / right join				
ON tblEmployee.DepartmentID = tblDepartment.Id

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
Full outer join tblDepartment						-- Full outer join / Full join				
ON tblEmployee.DepartmentID = tblDepartment.Id

-- cross join

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
Cross join tblDepartment

-- intelligent join

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
Left join tblDepartment
on tblEmployee.DepartmentID = tblDepartment.Id
where tblEmployee.DepartmentID is NULL

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
Right join tblDepartment
on tblEmployee.DepartmentID = tblDepartment.Id
where tblEmployee.DepartmentID is NULL

Select [Name], [Gender], [Salary], [DepartmentName] from tblEmployee
Full outer join tblDepartment
on tblEmployee.DepartmentID = tblDepartment.Id
where tblEmployee.DepartmentID is NULL
or tblDepartment.id is NULL

-- self join

create table Self_tblEmployee
(
[EmployeeId] int identity(1, 1) primary key,
[Name] nvarchar(50),
[ManagerId] nvarchar(50)
)

insert into Self_tblEmployee values ('Mike', 3)
insert into Self_tblEmployee values ('Rob', 1)
insert into Self_tblEmployee values ('Todd', NULL)
insert into Self_tblEmployee values ('Ben', 1)
insert into Self_tblEmployee values ('Sam', 1)

select * from Self_tblEmployee

select			E.[Name] as [Employee], M.[Name] as [Manager]
from			Self_tblEmployee E
left outer join Self_tblEmployee M
ON				E.ManagerId = M.EmployeeId

select			E.[Name] as [Employee], M.[Name] as [Manager]
from			Self_tblEmployee E
left outer join Self_tblEmployee M
ON				E.EmployeeId = M.ManagerId		-- becarefull aitar jonno kintu onno result ashbe..

select		E.[Name] as [Employee], M.[name] as [Manager]
from		Self_tblEmployee E
inner join  Self_tblEmployee M
ON			E.ManagerId = M.EmployeeId

select		E.[Name] as [Employee], M.[name] as [Manager]
from		Self_tblEmployee E
cross join  Self_tblEmployee M

-- replacing null value

select isnull(null, 'redwan') as [Name]
select isnull('pragim', 'redwan') as [Name]

select Coalesce(null, 'redwan') as [Name]
select Coalesce('pragim', 'redwan') as [Name]

select case when 'pragim' is null then 'redwan' else 'rojim' end as [Name]
select case when null is null then 'redwan' else 'rojim' end as [Name]

select			E.Name as Employee, isNull(M.Name, 'no manager') as Manager			-- IsNull
from			Self_tblEmployee E
left outer join Self_tblEmployee M
on				E.ManagerId = M.EmployeeId

select			E.Name as Employee, COALESCE(M.Name, 'no manager') as Manager			-- COALESCE
from			Self_tblEmployee E
left outer join Self_tblEmployee M
on				E.ManagerId = M.EmployeeId

select			E.Name as Employee,
				case
					when M.Name is null then 'no manager' else M.Name
				end
				as Manager
from			Self_tblEmployee E
left outer join Self_tblEmployee M
on				E.ManagerId = M.EmployeeId

-- coalesce() function returns the first non null value

create table tbl_Coalesce_Name
(
[Id] int identity(1, 1) primary key,
[FirstName] nvarchar(50),
[MiddleName] nvarchar(50),
[LastName] nvarchar(50)
)

insert into tbl_Coalesce_Name values ('Sam', null, null)
insert into tbl_Coalesce_Name values (null, 'Todd', 'Terzen')
insert into tbl_Coalesce_Name values (null, null, 'Sara')
insert into tbl_Coalesce_Name values ('Ben', 'Parker', null)
insert into tbl_Coalesce_Name values ('James', 'knick', 'nancy')

select * from tbl_Coalesce_Name

select ID, Coalesce(FirstName, MiddleName, LastName) as [Name] from tbl_Coalesce_Name