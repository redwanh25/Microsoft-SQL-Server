create table tbl_Test
(
SPId int default @@SPid
)

select * from tbl_Test

insert into tbl_Test default values
go 10		-- 10 times default values insert hobe.

select * from tbl_Department
select * from tbl_Person

-- view

create view tbl_Per_Dep_view
as
select [Department Name], [DepartmentID], count(*) as [Total Employee]
from tbl_Person
join tbl_Department
on tbl_Person.DepartmentID = tbl_Department.DeptID
group by [Department Name], DepartmentID

select * from tbl_Per_Dep_view
select * from tbl_Person_Department_View

select [Department Name], [Total Employee] from tbl_Per_Dep_view
where [Total Employee] >= 2

sp_helptext tbl_Person_Department_View

-- temp table

select [Department Name], [DepartmentID], count(*) as [Total Employee] into #TempEmployeeCount_Table
from tbl_Person
join tbl_Department
on tbl_Person.DepartmentID = tbl_Department.DeptID
group by [Department Name], DepartmentID

select [Department Name], [Total Employee] from #TempEmployeeCount_Table
where [Total Employee] >= 2

drop table #TempEmployeeCount_Table		-- jodio temp table automatic delete hoye jay. but, nije delete kore daoya good practice.

-- table variable

declare @tblEmployeeCount table ([Department Name] nvarchar(50), [DepartmentID] int, [Total Employee] int)
insert @tblEmployeeCount
select [Department Name], [DepartmentID], count(*) as [Total Employee]
--select [Department Name], [DepartmentID], count(*) as [Total Employee] into @tblEmployeeCount     -- ai vabe deoya jabe na.
from tbl_Person
join tbl_Department
on tbl_Person.DepartmentID = tbl_Department.DeptID
group by [Department Name], DepartmentID

select * from @tblEmployeeCount

select [Department Name], [Total Employee] from @tblEmployeeCount
where [Total Employee] >= 2


-- derived table

select [Department Name], [Total Employee]
from 
	(
	select [Department Name], [DepartmentID], count(*) as [Total Employee]
	from tbl_Person
	join tbl_Department
	on tbl_Person.DepartmentID = tbl_Department.DeptID
	group by [Department Name], DepartmentID
	)
as EmployeeCount				--EmployeeCount is the derived table 
where [Total Employee] >= 2


-- CTE (Common table expressions)

with EmployeeCount([Department Name], [DepartmentID], [Total Employee])
as
	(
	select [Department Name], [DepartmentID], count(*) as [Total Employee]
	from tbl_Person
	join tbl_Department
	on tbl_Person.DepartmentID = tbl_Department.DeptID
	group by [Department Name], DepartmentID
	)

--select abs(-4)		-- with er shathe jei 1st select keyword ta thakbe oi tai use hobe. akhun jodi ami "EmployeeCount" ta 2nd select a
						-- use kori taile 2nd select a oi ta pabe na. cs, "EmployeeCount" ai ta shudhu matro 1st select ai valid thake.
						-- thats why CTE k use korte chaile immediate select ai use korte hobe. majhkhane onno akta select diye porer select
						-- a use korle hobe na.. (be careful)

select [Department Name], [Total Employee] from EmployeeCount
where [Total Employee] >= 2

-- CTE (Common table expressions)

with EmployeeCount([DepartmentID], [Total Employee])
as
(
	select [DepartmentID], count(*) as [Total Employee] from tbl_Person
	group by DepartmentID
)
select [Department Name], [Total Employee]
from EmployeeCount
join tbl_Department
on EmployeeCount.DepartmentID = tbl_Department.DeptID
order by [Total Employee] -- asc -- desc

select * from tbl_Department

-- CTE (Common table expressions)

with Employee1([ID], [Name])
as
(
	select [id], [name] from tbl_Person
),
Employee2([ID], [Name])
as
(
	select [DeptID], [Department Name] from tbl_Department
)

select * from Employee1
union all
select * from Employee2