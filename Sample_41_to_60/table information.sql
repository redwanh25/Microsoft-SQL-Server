select * from tbl_Person select * from tbl_Department
select * from tbl_Person; select * from tbl_Department

select * from INFORMATION_SCHEMA.TABLES
select * from INFORMATION_SCHEMA.VIEWS
select * from INFORMATION_SCHEMA.ROUTINES
select * from INFORMATION_SCHEMA.COLUMNS

use [Sample_41_to_60]
if(Exists(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'tblProduct'))
	Print 'ase'
else print 'nai'

select * from sysobjects
select * from sysobjects where xtype = 'U'		-- user define table
select * from sysobjects where xtype = 'V'		-- view
select * from sysobjects where xtype = 'P'		-- stored procedure

select distinct xtype from sysobjects

--U 
--SQ
--PK
--V 
--S 
--TR
--IT

select * from sys.tables
select * from sys.views
select * from sys.procedures

if(not Exists(select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'tblJustForTest'))
begin
	create table tblJustForTest
	(
	[Id] int Primary key,
	[Name] nvarchar(50)
	)
end
else
	print 'Table is Exists'


if object_id('tblJustForTest') is not null
begin
	drop table tblJustForTest
	print 'delete'
end
else
begin
	create table tblJustForTest
	(
	[Id] int Primary key,
	[Name] nvarchar(50)
	)
	print 'create'
end

select * from tblJustForTest

if(not Exists(select * from INFORMATION_SCHEMA.columns where COLUMN_NAME = 'Gender' and TABLE_NAME = 'tblJustForTest' and TABLE_SCHEMA = 'dbo'))
begin
	alter table tblJustForTest
	add Gender nvarchar(10)
end
else
	print 'column is already Exists'


if(Exists(select * from INFORMATION_SCHEMA.columns where COLUMN_NAME = 'Gender' and TABLE_NAME = 'tblJustForTest' and TABLE_SCHEMA = 'dbo'))
begin
	alter table tblJustForTest
	drop column Gender
end
else
	print 'column is already Exists'



if(Exists(select * from INFORMATION_SCHEMA.columns where COLUMN_NAME = 'Gender' and TABLE_NAME = 'tblJustForTest' and TABLE_SCHEMA = 'dbo'))
begin
	alter table tblJustForTest
	alter column Gender int		-- datatype change nvarchar to int
end
else
	print 'column is not Exists'



if(COL_LENGTH('tblJustForTest', 'Gender') != null)
begin
	print 'column is already Exists'
end
else
	print 'column does not Exists'