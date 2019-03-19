create Database Software_CompanyDB

use [Software_CompanyDB]
go

create table PersonMessage_tbl
(
	[Id] int primary key identity,
	[Name] nvarchar(50),
	[Phone Number] nvarchar(20),
	[Email] nvarchar(50),
	[Address] nvarchar(100),
	[Message] nvarchar(4000),
	[Date] DateTime
)
drop table PersonMessage_tbl

delete from PersonMessage_tbl

select * from PersonMessage_tbl

create procedure PersonMessageProcedure
@Name nvarchar(50),
@PhoneNumber nvarchar(20),
@Email nvarchar(50),
@Address nvarchar(100),
@Message nvarchar(4000)
as
begin
	Declare @Datetime nvarchar(50)
	--set @Datetime = CONVERT(nvarchar, GETDATE(), 113)
	insert into PersonMessage_tbl values(@Name, @PhoneNumber, @Email, @Address, @Message, GETDATE())
	--insert into PersonMessage_tbl values(LTRIM(RTRIM(@Name)), LTRIM(RTRIM(@PhoneNumber)), LTRIM(RTRIM(@Email)), LTRIM(RTRIM(@Address)),LTRIM(RTRIM(@Message)), LTRIM(RTRIM(@Datetime)))
end

drop procedure PersonMessageProcedure

select * from PersonMessage_tbl

select * from AspNetUsers

create procedure tblPersonProc
as
begin
	select * from PersonMessage_tbl order by id desc
end

execute tblPersonProc

ALTER TABLE PersonMessage_tbl DROP COLUMN IsSeen

delete from PersonMessage_tbl where id = 1003


create table Blog_tbl
(
	Id int identity primary key,
	Title VARCHAR(max),
	[Date] DateTime,
	[BlogImage] varbinary(max),
	[Text] VARCHAR(max),
	[BlogDivId] nvarchar(1000),
)

insert into Blog_tbl values('table jodi faka thake taile kintu ExecuteScalar a exception throw korbe karon', GETDATE(), null, 'table jodi faka thake taile kintu ExecuteScalar a exception throw korbe karontable jodi faka thake taile kintu ExecuteScalar a exception throw korbe karon','BlogDivId_1')
alter table Blog_tbl add BlogDivId nvarchar(1000)
alter table Blog_tbl alter column BlogDivId nvarchar(1000)
drop table Blog_tbl
delete from Blog_tbl
ALTER TABLE Blog_tbl DROP COLUMN BlogDivId

select * from Blog_tbl

create proc BlogTableProcedure
as
begin

	select * from Blog_tbl order by Id desc
end

create procedure BlogTableProcedureMainPage
as
begin
	select top 4 * from Blog_tbl order by id desc 
end
BlogTableProcedureMainPage
BlogTableProcedure 2

delete from Blog_tbl where [id] between 1 and 14

update Blog_tbl set BlogImage = CAST(0x424d42000000000000003e0000002800000001000000010000000100010000000000040000000000000000000000000000000000000000000000ffffff008000000000 as varbinary(max))
where id = 33


--Title colomn er length bere dilam noile 500 er beshi charecter hole post create korar shomoy nicher ai error ta show korbe
--Ask a Question All Questions All Unanswered FAQ Validation failed for one or more entities. See entityvalidationerrors property for more details.
--BlogPostUpdateVersionController.cs file er 72 no line a db.SaveChanges(); te alta error dibe.
ALTER TABLE Blog_tbl ALTER COLUMN [Text] nvarchar(max)
ALTER TABLE Blog_tbl ALTER COLUMN [Text] nvarchar
truncate table Blog_tbl

create table Gallery_tbl
(
	Id int identity primary key,
	GalleryImage varbinary(max) not null
)
drop table Gallery_tbl
select * from Gallery_tbl

create proc GalleryTableProcedure
as
begin

	select * from Gallery_tbl order by Id desc
end

GalleryTableProcedure

select * from AspNetUsers
update AspNetUsers set EmailConfirmed = 1 where Id = '7bb850a1-1693-4ceb-8550-d09f5a652654'

delete from AspNetUsers where [id] = '7980d0e9-830e-4bea-a793-aee9b8ad42c4'

update Blog_tbl set BlogDivId = 'BlogDivId_6' where id = 6

select * from [dbo].[Blog_tbl]
select top 1 id from Blog_tbl order by id desc

create table EmployeeInformation
(
	[Id] nvarchar(128) primary key not null,
	[Email] nvarchar(256),
	[PhoneNumber] nvarchar(max),
	[UserName] nvarchar(256),
	[Address] nvarchar(max),
	[EmployeeImage] varbinary(max),
	[DateOfBirth] nvarchar(max),
	[FullName] nvarchar(max),
	[Gender] nvarchar(max),
	[MaritalStatus] nvarchar(max),
	[BloodGroup] nvarchar(max),
	[Religion] nvarchar(max),
	[Nationality] nvarchar(max),
	[AboutYou] nvarchar(max),
	[AlternativeEmail] nvarchar(max),
	[PostOffice] nvarchar(max),
	[District] nvarchar(max),
	[Country] nvarchar(max),
	[ZipCode] nvarchar(max),
	[PassportNo] nvarchar(max),
	[Designation] nvarchar(max),
	[JobExperience] nvarchar(max),
)
ALTER TABLE EmployeeInformation ALTER COLUMN [DateOfBirth] nvarchar(100)
drop table EmployeeInformation

go

create trigger EmployeeInformationTrigger
on [Software_CompanyDB].[dbo].[AspNetUsers]
for Insert
as
begin
	declare @id nvarchar(128), @email nvarchar(256), @phoneNumber nvarchar(max), @userName nvarchar(256)
	select @id = [Id] from inserted
	select @email = [Email] from inserted
	select @phoneNumber = [PhoneNumber] from inserted
	select @userName = [UserName] from inserted
	insert into EmployeeInformation (Id, Email, PhoneNumber, UserName) values(@id, @email, @phoneNumber, @userName)
end

select * from EmployeeInformation
select * from AspNetUsers

create trigger AspNetUsersTrigger
on EmployeeInformation
for Update
as
begin
	declare @id nvarchar(128), @phoneNumber nvarchar(max)
	select @id = [Id] from inserted
	select @phoneNumber = [PhoneNumber] from inserted
	update AspNetUsers set [PhoneNumber] = @phoneNumber where Id = @id
end

update EmployeeInformation set [PhoneNumber] = '00000000000' where Id = '88fc475b-52ba-4c1e-8026-dbba170af63d'

update EmployeeInformation set [Email] = 'redwanh28@gmail.com' where Id = '88fc475b-52ba-4c1e-8026-dbba170af63d'
update EmployeeInformation set [UserName] = 'redwanH28' where Id = '88fc475b-52ba-4c1e-8026-dbba170af63d'

select EmployeeImage from EmployeeInformation where id = '6e62f364-5dab-4174-9bf7-257d15a2b1d8'

CREATE TABLE JobCVPdf_tbl(
    [Id] int primary key identity,  
	[Name] nvarchar(50),
	[PhoneNumber] nvarchar(20),
	[Email] nvarchar(50),
	[Date] Datetime,
    [FileName] nvarchar(500),  
    [ContentType] nvarchar(200),  
    [DataCV] varbinary(max)  
)
drop table JobCVPdf_tbl

ALTER TABLE JobCVPdf_tbl Alter Column [Date] nvarchar(100)
delete from JobCVPdf_tbl

select * from JobCVPdf_tbl

create table FoundationDayTShirtDistribution
(
ID int primary key identity,
StudentID nvarchar(50) unique,
TokenNumber nvarchar(1000),
TShirtSize nvarchar(50),
QRCode nvarchar(2000),
)

delete from FoundationDayTShirtDistribution

select * from FoundationDayTShirtDistribution
delete FoundationDayTShirtDistribution where id = 50 or id = 51 or id = 54

create table OurTeam
(
[Id] int primary key identity,
[Name] nvarchar(50),
[Designation] nvarchar(50),
[EmployeeImage] varbinary(max),
[WorkingSince] nvarchar(50)
)
alter table OurTeam add EmployeeImage varbinary(max)
alter table ourteam alter column [WorkingSince] nvarchar(50)

select * from OurTeam