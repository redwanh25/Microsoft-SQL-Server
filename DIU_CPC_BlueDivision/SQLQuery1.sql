select * from AspNetUsers

delete from AspNetUsers where JoinSemester is Null

create table Problems
(
Id int primary key identity,
ProblemName nvarchar(1000),
ProblemLink nvarchar(3000),
Comment nvarchar(3000),
BlueSheetId int foreign key references BlueSheets(Id)
)

drop table Problems
drop table BlueSheet

create table Students
(
Id nvarchar(1000) primary key,
UserName nvarchar(100),
StudentId nvarchar(100),
FullName nvarchar(100),
EmailAddress nvarchar(100),
PhoneNumber nvarchar(100),
Semester nvarchar(50),
SolveCount int,
CodeForcesId nvarchar(100)
)

drop table Students

create table ProblemsStudents
(
Comment nvarchar(3000),
IsSolved nvarchar(50),
ProblemId int foreign key references Problems(Id),
StudentId nvarchar(1000) foreign key references Students(Id)
primary key (ProblemId, StudentID)
)

alter trigger StudentsTrigger
on [dbo].[AspNetUsers]
for Insert
as
begin
	declare @id nvarchar(128), @email nvarchar(256), @userName nvarchar(256), @semester nvarchar(100)
	select @id = [Id] from inserted
	select @email = [Email] from inserted
	select @userName = [UserName] from inserted
	select @semester = [JoinSemester] from inserted
	if ( @semester != '.....')
	begin
		insert into Students (Id, EmailAddress, UserName, Semester) values(@id, @email, @userName, @semester)
	end
end

drop trigger StudentsTrigger

select * from Students
select * from AspNetUsers

create table BlueSheets
(
Id int primary key identity,
BlueSheetName nvarchar(100),
[Date] date,
CreatedBy nvarchar(50)
)

alter table BlueSheets
add constraint BlueSheets_BlueSheetName_UKC
Unique(BlueSheetName)

--create table ProblemsBlueSheet
--(
--BlueSheetId int foreign key references BlueSheet(Id),
--ProblemsId int foreign key references Problems(Id),
--primary key (BlueSheetId, ProblemsId)
--)

--drop table ProblemsBlueSheet

select * from Problems
select * from BlueSheets
select * from Students

delete from Students

create table Blog_tbl
(
	Id int identity primary key,
	Title VARCHAR(max),
	[Date] DateTime,
	[BlogImage] varbinary(max),
	[Text] VARCHAR(max),
	[BlogDivId] nvarchar(1000),
)

select * from Blog_tbl


insert into Problems values('redwan', 'male', 1)
insert into Problems values('masuda', 'female', 1)
insert into Problems values('jamila', 'female', 2)
insert into Problems values('ramij', 'male', 3)
insert into Problems values('Joya', 'female', 1)
insert into Problems values('shihab', 'male', 2)


insert into BlueSheets values('Spring-20', GETDATE(), 'Foteh')
insert into BlueSheets values('Fall-19', GETDATE(), 'Kella Foteh')
insert into BlueSheets values('Summer-19', GETDATE(), 'Reza Nabi')
insert into BlueSheets values('Spring-19', GETDATE(), 'Yousuf Jamil')

select * from Problems
select * from BlueSheets
select * from ProblemsStudents

delete from ProblemsStudents

select P.Id, P.BlueSheetId, B.BlueSheetName from Problems as P
inner join BlueSheets as B
on P.BlueSheetId = B.Id

select P.Id, P.BlueSheetId, B.BlueSheetName from Problems P, BlueSheets B
where P.BlueSheetId = B.Id

select P.Id, P.ProblemName, PS.IsSolved, PS.Comment, S.UserName from Problems P, ProblemsStudents PS, Students S
where P.Id = PS.ProblemId and S.Id = PS.StudentId


select B.Id, B.BlueSheetName, P.Id, P.ProblemName, P.BlueSheetId, PS.IsSolved, PS.Comment, PS.ProblemId, PS.StudentId, S.Id, S.UserName, S.Semester
from BlueSheets B, Problems P, ProblemsStudents PS, Students S
where B.Id = P.BlueSheetId and P.Id = PS.ProblemId and S.Id = PS.StudentId


-- for BlueSheet Delete
create procedure Delete_ProblemsStudentAndProblems_Procedure
@blueSheetId int
as
begin
begin try
	begin transaction
		delete from ProblemsStudents where ProblemId in (select Id from Problems where BlueSheetId in (select Id from BlueSheets where Id = @bluesheetId))
		delete from Problems where BlueSheetId in (select Id from BlueSheets where Id = @bluesheetId)
		commit transaction
end try
begin catch
	rollback transaction
end catch
end


-- for Problem Delete
create procedure Delete_ProblemsStudents_Procedure
@problemId int
as
begin
	delete from ProblemsStudents where ProblemId = @problemId
end



