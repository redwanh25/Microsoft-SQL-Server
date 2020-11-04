--note : query gulo case sensitive na. soto hater borohater dui ta dile e kaj korbe.

--create database
create database Sample1
--rename database
Alter Database Sample1 Modify Name = Sample2
--rename database
Execute sp_renameDB 'Sample2', 'Sample1'
--delete database
Drop Database Sample1
--delete table
Drop Table tbl_Gender

--select database context
Use [Sample]
Go

--create table
Create Table tblPerson
(
ID int NOT NULL Primary Key,
Name nvarchar(50) NOT NULL,
Email nvarchar(50) NOT NULL,
GenderID int NULL
)

Create Table tblGender
(
ID int NOT NULL Primary Key,
Gender nvarchar(50) NOT NULL
)

--foreign key
Alter Table tblPerson Add constraint tblPerson_GenderID_FK Foreign Key (GenderID) references tblGender(ID)

--table show
Select * from tblPerson
Select * from tblGender

--delete the constraint
Alter table tblPerson Drop constraint DF_tblPerson_GenderID

--add constraint value (default value)
Alter table tblPerson Add constraint DF_tblPerson_GenderID Default 3 for GenderID

--insert data in the table
Insert into tblGender (ID, Gender) values (3, 'unknown')
Insert into tblPerson (ID, Name, Email) values (5, 'Shihab', 'shihab@gmail.com')
Insert into tblPerson ( ID, Name, Email, GenderID) values (4, 'Nipu', 'nipu@gmail.com', 2)
Insert into tblPerson values (10, 'nayma', 'nayma@gmail.com', 2)	-- column name specify kore na dile shob column fill kore dite hobe noile error hobe

--add column
Alter table tblPerson Add month nvarchar(50) NOT NULL

--add column with contraint value in the table
Alter table tblPerson Add Salary int NOT NULL Constraint DF_tblPerson_Salary Default 2000

--delete row
Delete from tblGender where ID = 3
--delete all row
Delete from tblGender

--update data in table
Update tblPerson Set GenderId = 2, Name = 'redwan' Where ID = 6 or id = 9

--check constraint
Alter table tblPerson Add constraint CK_tblPerson_Salary Check (Salary > 0 and Salary < 3000)

--create table with identity
create table tblRedwan
(
	ID int Identity(1000, 2) not null primary key,			-- identity(Identity seed, identity increment)
	Name nvarchar(50) not null 
)

--Set Identity Insert ON
Set Identity_Insert tblRedwan ON		-- jodi amra id nije insert korte chai taile amader Identity_Insert ON kore dite hobe
Insert into tblRedwan (Id, Name) values (2, 'a')	     		

--Set Identity Insert OFF
Set Identity_Insert tblRedwan OFF		-- r jodi amra id identity value diye insert korte chai taile amader Indentity_Insert OFF kore dite hobe
Insert into tblRedwan values ('b')			

--reset by Identity seed
DBCC CHECKIDENT (tblRedwan, RESEED, 1000)		-- Identity seed = 1000

--create Trigger
Create Trigger tblTrigger
on tblRedwan
for Insert
as
Begin
	insert into tblBiva values ('bal bal bal')
End

Create Trigger tblTrigger2
on tblRedwan
for insert
as
Begin
	insert into tblPerson (ID, name, Email, GenderID) values (8, 'Joy', 'joy@gmail.com', 2)
End

--get last element same session and same scop
select SCOPE_IDENTITY()		-- jei code ta ami last a execute korbo oitar shesh row ta amk return kore dibe
--get last element same session and across any scop
select @@IDENTITY
--get last element specific table across any session and scop
select Ident_Current('tblRedwan')

Delete Trigger
drop trigger tblTrigger

--unique constraint
alter table tbl_Table1 add constraint tbl_Tabel1_Email Unique(Email)	-- akta table a primary key aktai thakte pare. but, unique key onek gulo thakte pare.

-- select

select * from tblPerson
select [id], [Name] from [sample].[dbo].[tblPerson]
select Distinct [name] from tblPerson
select * from tblPerson where [name] = 'joy'
select * from tblPerson where [name] != 'joy'
select * from tblPerson where [name] <> 'joy'	-- <> not
select * from tblPerson where ([id] = 4 or [id] = 5) or [name] = 'joy'
select * from tblPerson where ([id] = 4 or [id] = 5) and [name] = 'joy'
select * from tblPerson where ([id] = 4 or [id] = 5) and salary > 1000
select * from tblPerson where [id] in (3, 4, 5)
select * from tblPerson where [id] between 4 and 7
select * from tblPerson where [name] like 'jo%'			-- % mane onek character thakte pare
select * from tblPerson where [email] like '%@%'
select * from tblPerson where [email] not like '%@%'
select * from tblPerson where [email] like '___@_____.com'	-- akta _ er jonno akta character
select * from tblPerson where [email] not like '%@%'
select * from tblPerson where [email] like '[RSn]%'		-- r s n ai 3 ta letter jar namer shuru te ase tader name print korbe 
select * from tblPerson where [email] like '[^RSn]%'		-- ^ mane bad sign. oi gula bad diye baki gulo print korbe
select * from tblPerson order by [Name]				-- ascending
select * from tblPerson order by [Name] desc			-- descending
select * from tblPerson order by [Name] desc, [GenderId] asc
select top 5 * from tblPerson
select top 5 [name], [Email] from tblPerson
select top 70 percent * from tblPerson

-- select

--count number of colomn
select count(ID) from tbl_Table1

--sum of the table salary
select SUM(salary) from tblPerson
--min of the table salary
select MIN(salary) from tblPerson
--max of the table salary
select MAX(salary) from tblPerson

--Stored Procedure
create procedure getStoredProcedure
@ProductName nvarchar(50)
as
begin
	select * from tblnew
	where [Product_Name] like @ProductName + '%'
end

--StoreProcedure query
getStoredProcedure 'red'

--show StoreProcedure code 
sp_helptext getStoredProcedure

--group by
select [name], sum(salary) as [Total Salary]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
group by [name]

--group by
select [name], genderId, sum(salary) as [Total Salary]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
group by [name], genderid

--"where" is used after "from"
select [name], genderId, sum(salary) as [Total Salary], count(id) as [Total employee]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
where genderid = 2
group by [name], genderid

--"having" is used after "group"
select [name], genderId, sum(salary) as [Total Salary], count(id) as [Total employee]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
group by [name], genderid
having genderid = 2