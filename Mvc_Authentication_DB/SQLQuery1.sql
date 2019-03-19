create table tblEmployee
(
Id int primary key identity,
Name nvarchar(50),
)

insert into tblEmployee values('Mark')
insert into tblEmployee values('John')
insert into tblEmployee values('Mary')
insert into tblEmployee values('Mike')

select * from tblEmployee

select * from AspNetUsers

truncate table [dbo].[__MigrationHistory]

alter table AspNetUsers add UserId int

delete AspNetUsers where Id = '37284451-489f-42a6-a775-2e454eb7aa42'

select UserId from AspNetUsers

create procedure tblUserProc
as
begin
	select UserId from AspNetUsers
end

select UserId from AspNetUsers where id = 'd3f7100d-224b-44b1-903e-100ce0a29009'
