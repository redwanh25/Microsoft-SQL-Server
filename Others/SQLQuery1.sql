
Alter Table tblPerson add constraint tblPerson_GenderID_FK
Foreign Key (GenderID) references tblGender(ID)

Use [Sample_1_to_20]
Go
Select * from tblPerson
Select * from tblGender

Alter table tblPerson
Add constraint DF_tblPerson_GenderID
Default 3 for GenderID

Insert into tblGender (ID, Gender) values (3, 'unknown')
Insert into tblPerson (ID, Name, Email) values (5, 'Shihab', 'shihab@gmail.com')
Insert into tblPerson (ID, Name, Email, GenderID) values (6, 'Nipu', 'nipu@gmail.com', 2)

Alter table tblPerson
Drop constraint DF_tblPerson_GenderID

Alter table tblPerson
Add Salary int NOT NULL
Constraint DF_tblPerson_Salary Default 2000

Select * from tblPerson
Select * from tblGender
Delete from tblGender where ID = 2

Insert into tblGender (ID, Gender) values (2, 'Female')

Update tblPerson set GenderId = 2, Name = 'redwan' where ID = 6

Insert into tblPerson values(8, 'nayma', 'nayma@gmail.com', 2, 1000)
update tblPerson
set salary = 567
where id = 7

Insert into tblPerson values (10, 'nayma', 'nayma@gmail.com', 2, 5000)

Alter table tblPerson
Drop Constraint CK_tblPerson_Salary

Alter table tblPerson
Add constraint CK_tblPerson_Salary
Check (Salary > 0 and Salary < 3000)

Select * from tblPerson
Delete from tblPerson where id = 9
Delete from tblPerson where id = 7

select * from Table_1

Insert into Table_1 values (2, 'a')

DBCC CHECKIDENT (tblRedwan, RESEED, 1000)

Set Identity_Insert tblRedwan OFF
Set Identity_Insert tblRedwan ON

Insert into tblRedwan (Id, Name) values (50, 'g')
Insert into tblRedwan values ('i')
select * from tblRedwan

delete from tblRedwan

drop table tblRedwan

DBCC checkident (tblRedwan, Reseed, 20)

create table tblRedwan
(
ID int Identity(1000, 1) Primary key,
Name nvarchar(50)
)

create table tblBiva
(
ID int Identity(1000, 1) Primary key,
Name nvarchar(50)
)

declare @id int
select @id = id from tblRedwan
print @id

select * from tblRedwan
select * from tblBiva
select * from tblPerson

Insert into tblRedwan values('ami')
insert into tblRedwan values ('tumake')
insert into tblRedwan values ('valobashi')

Insert into tblBiva values('ami')
insert into tblBiva values ('tumake')
insert into tblBiva values ('valobashi')
insert into tblBiva values ('na')

delete from tblRedwan where id = 1010


-- jokhon ami "tblRedwan" table a insert korbo tokhon e ai "trigger" ta kaj korbe. otherwise korbe na. cs, ai trigger ta "Insert" er jonno kora.
-- suppose ami kono kisu "delete" korsi "tblRedwan" table theke taile korbe na.

Create Trigger tblTrigger on tblRedwan for Insert
as
Begin
	insert into tblBiva values ('bal bal bal')
End

Create Trigger tblTrigger2 on tblRedwan for insert
as
Begin
	insert into tblPerson (ID, name, Email, GenderID) values (9, 'Joy', 'joy@gmail.com', 2)
End


Alter table tblRedwan
drop trigger tblTrigger

delete from tblRedwan where ID = 1005
delete from tblRedwan where ID = 1006
delete from tblRedwan where ID = 1007
delete from tblRedwan where ID = 1008
delete from tblRedwan where ID = 1009
delete from tblRedwan where ID = 1013

DBCC checkIdent(tblRedwan, reseed, 1004)
DBCC checkIdent(tblBiva, reseed, 1000)

Insert into tblRedwan values ('user-1')
select SCOPE_IDENTITY()
select @@IDENTITY
select Ident_Current('tblRedwan')

select * from tblRedwan
select * from tblBiva
select * from tblPerson
delete from tblBiva