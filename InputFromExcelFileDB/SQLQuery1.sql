select * from dbo.ContestTable
select * from dbo.ContestantsTable
select * from dbo.ContestContestants

delete from dbo.ContestContestants
delete from dbo.ContestTable
delete from dbo.ContestantsTable


create table ContestTracker
(
Id int primary key identity,
[ContestYear] nvarchar(100),
[Date] date,
CreatedBy nvarchar(50)
)

select * from ContestTracker

create table dbo.ContestTable
(
Id int primary key identity,
ContestName nvarchar(1000),
ContestLink nvarchar(3000),
[Date] date,
NumberOfProblems int,
Participation int,
--ContestTrackerId int Foreign key references ContestTracker(Id)
)

--alter table dbo.ContestTable add Constraint ContestTrackerIdForeignKey Foreign key (ContestTrackerId) references ContestTracker(Id)
--update ContestantsTable set ContestTrackerId = 1 where ContestTrackerId is null

create table dbo.ContestantsTable
(
Id int Primary key identity,
ContestantsName nvarchar(500),
StudentId nvarchar(500),
CFHandle nvarchar(500),
CFHandleLink nvarchar(500),
Score numeric(10, 2),
TotalSolve int,
TotalParticipation int,
OnlineParticipation int,
SolveCountOnsite int,
SolveCountUpsolves int,
AverageSolvePerContest numeric(5, 2),
--ContestTrackerId int Foreign key references ContestTracker(Id)
)

select * from dbo.ContestantsTable

create table dbo.ContestContestants
(
Id int primary key identity,
ContestId int foreign key references ContestTable(Id),
ContestantId int foreign key references ContestantsTable(Id),
ContestTimeSolve nvarchar(50),
UpSolve nvarchar(50),
)

drop table dbo.ContestContestants
select * from dbo.ContestContestants