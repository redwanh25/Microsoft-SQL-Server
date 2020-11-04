Create Database TestDatabase

create table dbo.testTable
(
	[Id] int identity primary key,
	[NameId] int,
	[QRString] nvarchar(1000)
)

create table dbo.testTable_1
(
	[Id] bigint identity primary key,
	[NameId] bigint,
	[QRString] nvarchar(1000)
)

create table dbo.Table_
(
	[Id] int identity primary key,
	[NameId] int,
	[QRString] nvarchar(1000)
)

create table dbo.Table_1
(
	[Id] int identity primary key,
	[NameId] int,
	[QRString] nvarchar(1000),
	[Table_Id] int foreign key references dbo.Table_(Id)
)

--drop table dbo.Table_

ALTER TABLE dbo.Table_ DROP CONSTRAINT [PK__testTabl__3214EC07CB4B18F2]   
GO  

alter table dbo.Table_ alter column [Id] bigint

alter table dbo.Table_ add primary key ([Id])


ALTER TABLE testTable ALTER COLUMN [NameId] bigint

select * from dbo.Table_
select * from dbo.Table_1

insert into dbo.Table_ values(101, 'redwan')
insert into dbo.Table_ values(102, 'hossain')
insert into dbo.Table_ values(103, 'ebrahim')
insert into dbo.Table_ values(104, 'hossain')

insert into dbo.Table_1 values(101, 'redwan', 1)
insert into dbo.Table_1 values(102, 'hossain', 1)
insert into dbo.Table_1 values(103, 'ebrahim', 2)
insert into dbo.Table_1 values(104, 'hossain', 3)


create table dbo.Table_2
(
	[Id] int identity primary key,
	[String] nvarchar(1000)
)

Declare @text nvarchar(1000)
set @text = N'বাংলা English'
INSERT INTO Table_2 VALUEs(@text);

select * from Table_2