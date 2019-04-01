select * from AspNetUsers

delete from AspNetUsers where JoinSemester is Null

create table dbo.Students
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

create table dbo.BlueSheets
(
Id int primary key identity,
BlueSheetName nvarchar(100),
[Date] date,
CreatedBy nvarchar(50)
)

create table dbo.Problems
(
Id int primary key identity,
ProblemName nvarchar(1000),
ProblemLink nvarchar(3000),
Comment nvarchar(3000),
ProblemSolverCount int,
uploadFromWhere nvarchar(100),
BlueSheetId int foreign key references BlueSheets(Id)
)

create table dbo.ProblemsStudents
(
Comment nvarchar(3000),
IsSolved nvarchar(50),
SolutionLink nvarchar(2000),
ShareSolutionLink nvarchar(200),
ProblemId int foreign key references Problems(Id),
StudentId nvarchar(1000) foreign key references Students(Id)
primary key (ProblemId, StudentID)
)
select * from Problems

delete from Problems where BlueSheetId is null

drop table Problems
drop table BlueSheet


drop table Students

alter table Problems add ProblemSolverCount int

select * from ProblemsStudents
delete from ProblemsStudents

create trigger dbo.StudentsTrigger
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
		insert into dbo.Students (Id, EmailAddress, UserName, Semester, SolveCount) values(@id, @email, @userName, @semester, 0)
	end
end

create trigger dbo.problemsTrigger
on dbo.problems
for insert
as
begin
	update dbo.problems set problemSolverCount = 0 where problemSolverCount is null
end

select * from problems

delete from problems where BlueSheetId is null or problemSolverCount is null

update problems
set problemSolverCount = 0 where problemSolverCount is null

drop trigger StudentsTrigger

select * from Students
select * from AspNetUsers



alter table dbo.BlueSheets
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
select * from ProblemsStudents

delete from Students

create table dbo.Blog_tbl
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
create procedure dbo.Delete_ProblemsStudentAndProblems_Procedure
@blueSheetId int
as
begin
begin try
	begin transaction
		delete from dbo.ProblemsStudents where ProblemId in (select Id from dbo.Problems where BlueSheetId in (select Id from dbo.BlueSheets where Id = @bluesheetId))
		delete from dbo.Problems where BlueSheetId in (select Id from dbo.BlueSheets where Id = @bluesheetId)
		commit transaction
end try
begin catch
	rollback transaction
end catch
end


-- for Problem Delete
create procedure dbo.Delete_ProblemsStudents_Procedure
@problemId int
as
begin
	delete from dbo.ProblemsStudents where ProblemId = @problemId
end

update problems set problemSolverCount =
 
select * from problems where id in
(
select problemId from ProblemsStudents
where IsSolved = 'Accepted'
group by ProblemId
)

select * from problems

----------

create procedure dbo.solveCountForProblems_Procedure
@isSolved nvarchar(50),
@blueSheetId int
as
begin
	update dbo.Problems set problemSolverCount = 0 where BlueSheetId = @blueSheetId 

	select P.Id, B.BlueSheetName , count(*) as probCount into #TempTable1
	from dbo.Problems P, dbo.BlueSheets B, dbo.ProblemsStudents PS
	where PS.ProblemId = P.Id and P.BlueSheetId = B.Id and PS.IsSolved = @isSolved
	group by P.Id, B.BlueSheetName
	while(exists(select Id from #TempTable1))
		begin
			declare @val as varchar(50)
			select top 1 @val = Id from #TempTable1		
			update dbo.Problems set problemSolverCount = (select probCount from #TempTable1 where Id = @val)
			where Id = @val
			delete from #TempTable1 where Id = @val
		end
	drop table #TempTable1
end

drop proc solveCountForProblems
----------

select problemSolverCount from Problems

select P.Id, B.BlueSheetName , count(*) as probCount into #TempTable1
from Problems P, BlueSheets B, ProblemsStudents PS
where PS.ProblemId = P.Id and P.BlueSheetId = B.Id and PS.IsSolved = 'Accepted'
group by P.Id, B.BlueSheetName

select * from #TempTable1
drop table #TempTable1

select * from BlueSheets

select * from ProblemsStudents
update ProblemsStudents set IsSolved = 'Accepted' where IsSolved = 'WrongAnswer' and ProblemId = 39


update problems set problemSolverCount = 0 where problemSolverCount in (1, 2)

select * from students

--create procedure solveCountWithOrder
--@isSolved nvarchar(50),
--@semester nvarchar(50)
--as
--begin
--	select count(*) as SolveCount, S.userName, S.Semester from Students S, ProblemsStudents PS
--	where PS.StudentId = S.Id and PS.IsSolved = @isSolved and S.Semester = @semester
--	group by S.UserName, S.Semester order by SolveCount desc
--end

create procedure dbo.solveCountWithOrder_Procedure
@isSolved nvarchar(50),
@semester nvarchar(50)
as
begin
	update dbo.Students set solveCount = 0 where semester = @semester 

	select count(*) as SolveCount, S.userName, S.Semester into #TempTable
	from dbo.Students S, dbo.ProblemsStudents PS
	where PS.StudentId = S.Id and PS.IsSolved = @isSolved and S.Semester = @semester
	group by S.userName, S.Semester
	while(exists(select userName from #TempTable))
		begin
			declare @val as varchar(50)
			select top 1 @val = userName from #TempTable		
			update dbo.Students set solveCount = (select solveCount from #TempTable where userName = @val)
			where userName = @val
			delete from #TempTable where userName = @val
		end
	drop table #TempTable
end

drop proc solveCountWithOrder

execute solveCountWithOrder_Procedure @isSolved = 'Accepted', @semester = 'Fall-20'


execute solveCountWithOrder @isSolved = 'Accepted', @semester = 'summer-20'
execute solveCountWithOrder @isSolved = 'WrongAnswer', @semester = 'Summer-20'

select count(*) as SolveCount, S.userName, S.Semester into #TempTable
from Students S, ProblemsStudents PS
where PS.StudentId = S.Id and PS.IsSolved = 'Accepted' and S.Semester = 'Fall-20'
group by S.UserName, S.Semester 
select * from #TempTable order by SolveCount desc
drop table #TempTable

select userName from #TempTable

select * from #TempTable

select * from students

declare @a nvarchar(50)
set @a =  select userName from #TempTable





update Students set solveCount = 0 where solveCount in (1, 2)

create trigger dbo.deleteAspNetUserStudent
on dbo.AspNetUsers
for delete
as
begin
	declare @userName nvarchar(50), @studentId nvarchar(50)
	select @userName = UserName from deleted
	select @studentId = Id from deleted
	delete from dbo.problemsStudents where StudentId = @studentId
	delete from dbo.students where userName = @userName
end

select * from students
select * from AspNetUsers
select * from ProblemsStudents

delete from ProblemsStudents where studentId = '63bb8f7d-f631-4b80-b808-b4c0ab7786dd'

select BlueSheetId from problems where Id = 78

create table dbo.DayAndProblemSet
(
Id int primary key identity,
[SetDay] int,
[SetProblem] int,
[Date] nvarchar(300),
[BlueSheetId] int
)

drop table DayAndProblemSet


insert into DayAndProblemSet values(0, 0, getDate(), 2)

update DayAndProblemSet set setDay = 2, setProblem = 5, [Date] = DATEADD(MINUTE, 6, getDate()), [BlueSheetId] = 9 where id = 1
select * from DayAndProblemSet

select DATEADD(MINUTE, 1, getDate())
select getDate() as [dateTime]

select 
case
	when(Exists(select blueSheetId from DayAndProblemSet where blueSheetId = 30))
	then 1 else 0
end
from DayAndProblemSet

if(Exists(select blueSheetId from DayAndProblemSet where blueSheetId = 30))
	Print 'ase'
else print 'nai'

select case when(Exists(select blueSheetId from DayAndProblemSet where BlueSheetId = @blueSheetId)) then 1 else 0 end from DayAndProblemSet

select count(*) from DayAndProblemSet where blueSheetId = 9

create trigger dbo.DayAndProblemSetTriggerInsert
on dbo.BlueSheets
for insert
as
begin
	declare @blueSheetId int
	select @blueSheetId = [Id] from inserted
	insert into dbo.DayAndProblemSet values(0, 0, getDate(), @blueSheetId)
end

create trigger dbo.DayAndProblemSetTriggerDelete
on dbo.BlueSheets
for delete
as
begin
	declare @blueSheetId int
	select @blueSheetId = [Id] from deleted
	delete from dbo.DayAndProblemSet where BlueSheetId = @blueSheetId 
end

create table dbo.CutOffStudents
(
Id int primary key identity,
UserId nvarchar(1000),
UserName nvarchar(100),
Semester nvarchar(50),
SolveCount int,
EmailAddress nvarchar(100),
StudentId nvarchar(100),
FullName nvarchar(100),
PhoneNumber nvarchar(100),
CodeForcesId nvarchar(100)
)

select * from CutOffStudents

drop table CutOffStudents

select * from problems

select count(*) from problems where uploadFromWhere is not null

alter table dbo.Problems add uploadFromWhere nvarchar(100)

