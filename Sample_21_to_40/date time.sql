use [Sample_21_to_40]
go

create table tblDateTime
(
[No] int identity(1, 1) primary key,
[Time] time(7),
[Date] date,
[SmallDateTime] SmallDateTime,
[DateTime] DateTime,
[DateTime2] DateTime2(7),				-- 7 that means nanno second presetion .3452234
[DateTimeOffSet] DateTimeOffSet(4)		-- 4 that means nanno second presetion .3452
)

Drop table tblDateTime

select * from tblDateTime

insert into tblDateTime values (getDate(), getDate(), getDate(), getDate(), getDate(), getDate())
insert into tblDateTime values (getDate(), getDate(), getDate(), getDate(), getDate(), SysDateTimeOffSet())
insert into tblDateTime values (GetDate(), GetDate(),SysDateTime(),SysDateTime(), SysDateTime(), SysDateTimeOffSet())

delete from tblDateTime
where [No] = 4 or [No] = 5

select GetDate() as [GetDate()]
select CURRENT_TIMESTAMP as [Current_TimeStamp]
select SYSDATETIME() as [SysDateTime]
select sysDateTimeOffSet() as [sysDateTimeOffSet]
select GETUTCDATE() as [getUTCDate]
select sysUTCDateTime() as [sysUTCDateTime]

select isdate(getDate())					-- return 1
select isdate('redwan')						-- return 0
select isdate('12/03/2018 21:12:39')		-- return 1
select isdate('12/03/2018 21:12:39.123')	-- return 1
select isdate('12/03/2018 21:12:39.1234')	-- return 0		[DateTime2] include na

select day(getDate())
select day('12/23/2018 21:12:39')

print month(getDate())
print month('12/23/2018 21:12:39')

print year(getDate())
print year('12/23/2018 21:12:39')

select dateName(day, '08/06/2018 21:12:39')			-- int a return korbe 6
select dateName(weekDay, '08/06/2018 21:12:39')		-- oi din ta string a return korbe. (Monday)
select dateName(month, '08/06/2018 21:12:39')		-- oi month ta string a return korbe. (August)
select dateName(hour, '08/06/2018 21:12:39')
select dateName(minute, '08/06/2018 21:12:39')
select dateName(second, '08/06/2018 21:12:39')

create table DateOfBirth
(
ID int identity(1, 1) primary key,
[Name] nvarchar(50),
[Date Of Birthday] SmallDateTime
)

DBCC CHECKIDENT (DateOfBirth, RESEED, 0)

insert into DateOfBirth values('redwan', '02/12/1999 21:12:39')
insert into DateOfBirth values('ramij', '09/26/1997 11:12:39')
insert into DateOfBirth values('shihab', '11/01/1998 05:12:39')

delete from DateOfBirth

select * from DateOfBirth

select [ID], [Name], dateName(weekday, [Date Of Birthday]) as [Day], Month([Date Of Birthday]) as [Month],
	   dateName(month, [Date Of Birthday]) as [Month Name], year([Date Of Birthday]) as [Year]
from DateOfBirth