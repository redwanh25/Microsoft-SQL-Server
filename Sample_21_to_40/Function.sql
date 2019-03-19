use [Sample_21_to_40]
go

sp_helptext [ageDifference]

select * from DateOfBirth
select ID, [Name], [Date Of Birthday], dbo.ageDifference(getDate(), [Date Of Birthday]) as [Age] from DateOfBirth

-- scalar function

create function ageDifference(@dob1 date, @dob2 date)		-- function er name same rekhe vitore kono kisu change korte chaile create er jaygay
returns nvarchar(50)										--  alter dite hobe.
as
begin
	declare @tempDate date, @year int, @month int, @day int
	if(day(@dob1) >= day(@dob2))
		begin
			set @day =  day(@dob1) - day(@dob2)
		end
	else
		begin
			if(day(EoMonth(dateadd(month, -1, @dob1))) = 31)
				begin
					set @day = 31 + day(@dob1)
				end
			else if (day(EoMonth(dateadd(month, -1, @dob1))) = 30)
				begin
					set @day = 30 + day(@dob1)
				end
			else if (day(EoMonth(dateadd(month, -1, @dob1))) = 28)
				begin
					set @day = 28 + day(@dob1)
				end
			else
				begin
					set @day = 29 + day(@dob1)			-- if leap year februay month = 29
				end

			set @day = @day - day(@dob2)
			set @dob1 = dateadd(month, -1, @dob1)
		end

	if(month(@dob1) >= month(@dob2))
		begin
			set @month = month(@dob1) - month(@dob2)
		end
	else
		begin
			set @month = 12 + month(@dob1) - month(@dob2)
			set @dob1 = dateAdd(year, -1, @dob1)
		end
	set @year = year(@dob1) - year(@dob2)
	declare @age nvarchar(50)
	set @age = cast(@year as nvarchar) + ' years ' + cast(@month as nvarchar) + ' months ' + cast(@day as nvarchar) + ' days'
	return @age
end

select ID, [Name], [Date Of Birthday], dbo.ageDifference(getDate(), [Date Of Birthday]) as [Age] from DateOfBirth
where dbo.ageYear(getDate(), [Date Of BirthDay]) < 20

create function ageYear(@dob1 date, @dob2 date)
returns nvarchar(50)
as
begin
	declare @tempDate date, @year int, @month int, @day int
	if(day(@dob1) >= day(@dob2))
		begin
			set @day =  day(@dob1) - day(@dob2)
		end
	else
		begin
			if(day(EoMonth(dateadd(month, -1, @dob1))) = 31)
				begin
					set @day = 31 + day(@dob1)
				end
			else if (day(EoMonth(dateadd(month, -1, @dob1))) = 30)
				begin
					set @day = 30 + day(@dob1)
				end
			else if (day(EoMonth(dateadd(month, -1, @dob1))) = 28)
				begin
					set @day = 28 + day(@dob1)
				end
			else
				begin
					set @day = 29 + day(@dob1)			-- if leap year februay month = 29
				end

			set @day = @day - day(@dob2)
			set @dob1 = dateadd(month, -1, @dob1)
		end

	if(month(@dob1) >= month(@dob2))
		begin
			set @month = month(@dob1) - month(@dob2)
		end
	else
		begin
			set @month = 12 + month(@dob1) - month(@dob2)
			set @dob1 = dateAdd(year, -1, @dob1)
		end
	set @year = year(@dob1) - year(@dob2)
	--declare @age nvarchar(50)
	--set @age = cast(@year as nvarchar) + ' years ' + cast(@month as nvarchar) + ' months ' + cast(@day as nvarchar) + ' days'
	--return @age
	return @year
end

create table tbl_Person
(
[ID] int identity(1, 1) primary key,
[Name] nvarchar(50),
[Date Of Birth] Date,
[Gender] nvarchar(20),
[DepartmentID] int
)

insert into tbl_Person values('redwan', '02/12/1999', 'male', 1)
insert into tbl_Person values('masuda', '11/22/1995', 'female', 1)
insert into tbl_Person values('ramij', '09/26/1997', 'male', 3)
insert into tbl_Person values('Joya', '01/01/2000', 'female', 1)
insert into tbl_Person values('shihab', '11/01/1998', 'male', 2)

select * from tbl_Person

create table tbl_Department
(
[ID] int identity(1, 1) primary key,
[Department Name] nvarchar(50),
[Location] nvarchar(50),
[Department Head Name] nvarchar(50)
)

insert into tbl_Department values('IT', 'Bangladesh', 'Reza Nabi')
insert into tbl_Department values('Accounting', 'Usa', 'Yousuf Jamil')
insert into tbl_Department values('Architecture', 'London', 'Kella Foteh')

select * from tbl_Department

-- Inline table function

alter function EmployeesByGender(@gender nvarchar(20))
returns Table
as
return (select [Id], [Name], [Gender], [DepartmentID] from tbl_Person where Gender = @gender)

select * from EmployeesByGender('male')		-- inline table valued function k ai vabe e call korte hoy
-- * sign deoyar por o [Date of Birth] colomn ta ashbe na. cs, aita EmployeesByGender function er kothao declare kora hoyni.

select [Name], [Gender] from EmployeesByGender('male')	-- ai khane kintu shudhu name r gender tai ashbe.. jotoi function a shob kisu declare kora thak.

--select [Name], [Gender], [Date Of Birth], [Department Name] from EmployeesByGender('male') E		-- [Date Of Birth] dile error dibe. cs, aita function er vitore nai.
select [Name], [Gender], [DepartmentID], [Department Name] from EmployeesByGender('male') E	
join tbl_Department D
on E.DepartmentID = D.[Dept ID]


-- multi-statement table-valued function

create function multiStatement()
returns @table Table(Id int, [Name] nvarchar(50), [Gender] nvarchar(50), [Year] int)
as
begin
	insert into @table
	select ID, [Name], [Gender], Year([Date Of Birth]) as [Year] from tbl_Person
	return
end

select * from dbo.multiStatement()

alter FUNCTION multiStatement_gender(@gender nvarchar(10))
RETURNS @AuthorsByState table (id int, [name] Varchar(30), Gender nVarchar(20))
AS
BEGIN
	INSERT INTO @AuthorsByState
	SELECT  id, [name], Gender FROM tbl_Person WHERE Gender = @gender
 
	IF (@gender = 'male')
	BEGIN
		INSERT INTO @AuthorsByState VALUES ('', 'No Authors Found', 'hijra')
	END
 
	RETURN
END

select * from dbo.multiStatement_gender('female')
select * from multiStatement_gender('male')
select * from tbl_Person

create function inlineTable()
returns table
as
return (select * from tbl_Person)

select * from inlineTable() order by [Name] asc
update inlineTable() set [Name] = 'redwan' where [Name] = 'pagli'		-- but, ai ta multiple statement table er jonno hobe na.

create function SchemabindingTable()
returns table
with Schemabinding		-- schemabinding kora thakle er vitore jei table ase oi thake delete kora jabe na but, modify kora jabe.
as
--return (select * from dbo.tbl_Person)		-- Syntax '*' is not allowed in schema-bound objects.
return (select [name] from dbo.tbl_Person)

drop table tbl_Person		-- Cannot DROP TABLE 'tbl_Person' because it is being referenced by object 'SchemabindingTable'.
update tbl_Person set Name = 'pagli' where name = 'redwan'

select * from tbl_Person

alter function WithEncryption(@name nvarchar(50))
returns nvarchar(50)
with Encryption
as
begin
	return (select @name as [Name])
end

select * from dbo.WithEncryption('Redwan')	-- aita dile hobe na.. cs, amader kono table nai.

select  dbo.WithEncryption('Redwan')

sp_helptext WithEncryption


-- temporary table create

-- local
create table #tempTable		-- akta  # dile local temp. r ai ta store hoy tempdb database er temporary tables a.. r ai sql file ta jokhon ami kete dibo tokhon
(							-- ai table ta automatic delete hoye jabe.
ID int,
[Name] nvarchar(50)
)

insert into #tempTable values(1, 'Redwan Hossain')
insert into #tempTable values(2, 'Masudur Rahman')

select * from #tempTable

select * from tempdb..sysobjects where [name] like '#tempTable%'		-- temporary function er all details diye dibe.
select [name] from tempdb..sysobjects where [name] like '#tempTable%'		-- temporary function er name diye dibe.

drop table #tempTable

-- global
create table ##tempTable		-- duita  # dile global temp. r ai ta store hoy tempdb database er temporary tables a.. r ai sql file ta jokhon ami kete dibo tokhon
(							-- ai table ta automatic delete hoye jabe. jehetu aita global so, ai tar access ami jekono session a pabo.
ID int,
[Name] nvarchar(50)
)

insert into ##tempTable values(1, 'Redwan Hossain')
insert into ##tempTable values(2, 'Masudur Rahman')

select * from ##tempTable

create procedure temptableProcedure
as
begin

create table #tempTable			--ai procedure er kaj jokhon shesh hoye jabe ai table tokhon automatic delete hoye jabe.
(								-- ai procedure er bahire ai table k access kora jabe na. cs, aita local table. global hoile jaito.
ID int,
[Name] nvarchar(50)
)
insert into #tempTable values(1, 'Redwan Hossain')
insert into #tempTable values(2, 'Masudur Rahman')
select * from #tempTable

end

execute temptableProcedure
select * from #tempTable		-- access kora jabe na.