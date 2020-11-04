
use [Sample_1_to_20]
go

-- view just query gulo kore save kore rakhe.. er beshi view r kono kaj kore na.

select * from tbl_Person
select * from [dbo].[tbl_Department]

create view View_PersonDepartment
as
select Id, Name, Gender, [Department Name]		-- jodi id colomn print korte chai naile tbl_Person tbl_Department ai dui ta table er id colomn er
from tbl_Person E								-- nam unique hote hobe. jemon 	tbl_Person er jonno id; tbl_Department er jonno dept ID
inner join tbl_Department D
on E.DepartmentID = D.[Dept ID]

drop view View_PersonDepartment

select * from View_PersonDepartment

sp_helptext View_PersonDepartment

create view View_PersonDepartment_where
as
select Id, Name, Gender, [Department Name]
from tbl_Person E								
inner join tbl_Department D
on E.DepartmentID = D.[Dept ID]
where D.[Department Name] = 'IT'

select * from View_PersonDepartment_where



create view View_Person
as
select Id, Name, Gender, [DepartmentId]
from tbl_Person

select * from View_Person where tbl_Person.[DepartmentId] = 1		-- this is not possible. but, ai where ta jodi view er moddhe ditam taile
																	-- possible silo.
update View_Person set Name = 'pagli' where DepartmentID = 2
select * from View_Person

insert into tbl_Person values('redwan', '02/12/1999', 'male', 1)
insert into tbl_Person values('masuda', '11/22/1995', 'female', 1)
insert into tbl_Person values('ramij', '09/26/1997', 'male', 3)
insert into tbl_Person values('Joya', '01/01/2000', 'female', 1)
insert into tbl_Person values('shihab', '11/01/1998', 'male', 2)

DBCC CHECKIDENT (tbl_Person, RESEED, 0)
delete from tbl_Person

create view View_Person1
as
select Id, Name, Gender, [DepartmentId]
from tbl_Person
where tbl_Person.[DepartmentId] = 1

select * from View_Person1


create view View_PersonDepartment_GroupBy
as
select Id, Name, Gender, [Department Name], count(id) as [count]		-- select a joto gula colomn thakbe group by a thik toto gulo colomn er 
from tbl_Person E														-- name dite hobe.
inner join tbl_Department D
on E.DepartmentID = D.[Dept ID]
group by Gender, id, [Department Name], name

select * from View_PersonDepartment_GroupBy


create view View_PersonDepartment_GroupBy_Dept
as
select [Department Name], count(id) as [count]
from tbl_Person E
inner join tbl_Department D
on E.DepartmentID = D.[Dept ID]
group by [Department Name]

select * from View_PersonDepartment_GroupBy_Dept

select * from tbl_Person
select * from tbl_Department

create table tbl_Product
(
ProductId int,
Name nvarchar(50),
UnitPrice int
)

create table tbl_Product_quantity
(
ProductId int,
quantitySold int
)

insert into tbl_Product values(1, 'Books', 20)
insert into tbl_Product values(2, 'Pens', 14)
insert into tbl_Product values(3, 'Pencils', 11)
insert into tbl_Product values(4, 'Clips', 10)

select * from tbl_Product

insert into tbl_Product_quantity values(1, 10)
insert into tbl_Product_quantity values(3, 23)
insert into tbl_Product_quantity values(4, 21)
insert into tbl_Product_quantity values(2, 12)
insert into tbl_Product_quantity values(1, 13)
insert into tbl_Product_quantity values(3, 12)
insert into tbl_Product_quantity values(4, 13)
insert into tbl_Product_quantity values(1, 11)
insert into tbl_Product_quantity values(2, 12)
insert into tbl_Product_quantity values(1, 14)

select * from tbl_Product_quantity

create view View_TotalSalesByProduct
as
select [Name], sum(isnull(UnitPrice*quantitySold, 0)) as TotalSales, count(*) as TotalTransactaion
from tbl_Product P
inner join tbl_Product_quantity Q
on P.ProductId = Q.ProductId
group by [Name]

create view View_TotalSalesByProduct_schema
with schemabinding														-- schemabinding hote hobe noile index toiri kora jabe na.
as
select [Name], sum(isnull(UnitPrice*quantitySold, 0)) as TotalSales, count_big(*) as TotalTransactaion		-- count_big(*) dite hobe
from dbo.tbl_Product																				-- noile index toiri kora jabe na.
inner join dbo.tbl_Product_quantity
on dbo.tbl_Product.ProductId = dbo.tbl_Product_quantity.ProductId
group by [Name]

select * from View_TotalSalesByProduct

-- Cannot create index on view 'View_TotalSalesByProduct' because the view is not schema bound
create unique clustered index View_TotalSalesByProduct_index
on View_TotalSalesByProduct([Name])

create unique clustered index View_TotalSalesByProduct_schema_index		-- schemabinding hote hobe noile index toiri kora jabe na.
on View_TotalSalesByProduct_schema([Name])

select * from View_TotalSalesByProduct_schema
