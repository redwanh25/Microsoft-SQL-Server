create database ImportExcelDataToMVC_DB

create table Problems
(
Id int primary key identity,
ProblemName nvarchar(1000),
ProblemLink nvarchar(3000),
Comment nvarchar(3000)
)

select * from Problems

delete from Problems