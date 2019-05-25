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
where [No] = 10 or [No] = 5

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

-- (sunday	 - 1)
-- (monday	 - 2)
--	 .........
--	 .........
-- (saturday - 7)

select DatePart(weekday, '12/30/2018')		-- 1		(nicher ta r aitar moddhe difference hosse ai j ai ta integer a return kore.)
select DateName(weekday, '12/30/2018')		-- sunday	(r aita nvarchar a return kore)
select DatePart(month, '12/30/2018')
select DateName(month, '12/30/2018')

select DateAdd(month, 2, '2018/05/30')		-- 2018-07-02 00:00:00.000
select DateAdd(day, 10, '12/30/2018')		-- 2019-01-09 00:00:00.000
select dateAdd(year, -5, '12/30/2018')
select dateAdd(month, -1, '01/31/2018')
select DATEADD(MINUTE, 1, getDate())
select getDate() as [dateTime]

select dateDiff(year, '12/30/2018', getDate())
select dateDiff(year, '03/30/2018', getDate())
select dateDiff(year, getDate(), '03/30/2014')
select dateDiff(year, '03/30/2014', getDate())
select dateDiff(day, '11/30/2005', '01/31/2006')		-- 62
select dateDiff(month, '11/30/2005', '01/31/2006')		-- 2

select dateDiff(year, '11/30/2005', '01/31/2006')		-- 1. but, 1 hobar kotha na.. cs, 1 bosor full hoyni. 0 howya uchit silo. er jonno calculate
														-- korte hobe. result should be 0.

SELECT EOMONTH('07/28/2005')			-- EoMonth return the last date of this month like 07/31/2005
select Day(EoMonth('07/28/2005'))		-- return the last day. like 31

Declare @day int, @month int, @year1 date, @year2 date
set @year1 =  '11/30/2005'
set @year2 = '01/31/2006'
select dateDiff(year, @year1, @year2) -
		case
			when (Month(@year1) > Month(@year2)) or ((Month(@year1) = Month(@year2)) and (day(@year1) > day(@year2)))
			then 1 else 0
		End

drop function ageDifference
print dbo.ageDifference('01/30/2006', '11/30/2005')

select * from DateOfBirth
select ID, [Name], [Date Of Birthday], dbo.ageDifference(getDate(), [Date Of Birthday]) as [Age] from DateOfBirth

create function ageDifference(@dob1 date, @dob2 date)
returns nvarchar(50)
as
begin
	declare @tempDate date, @year int, @month int, @day int
	if(day(@dob1) >= day(@dob2))
		begin
			set @day =  day(@dob1) - day(@dob2)
		end
	else
		begin
			if(day(EoMonth(dateadd(month, -1, @dob1))) = 31)
				begin
					set @day = 31 + day(@dob1)
				end
			else if (day(EoMonth(dateadd(month, -1, @dob1))) = 30)
				begin
					set @day = 30 + day(@dob1)
				end
			else if (day(EoMonth(dateadd(month, -1, @dob1))) = 28)
				begin
					set @day = 28 + day(@dob1)
				end
			else
				begin
					set @day = 29 + day(@dob1)			-- if leap year februay month = 29
				end

			set @day = @day - day(@dob2)
			set @dob1 = dateadd(month, -1, @dob1)
		end

	if(month(@dob1) >= month(@dob2))
		begin
			set @month = month(@dob1) - month(@dob2)
		end
	else
		begin
			set @month = 12 + month(@dob1) - month(@dob2)
			set @dob1 = dateAdd(year, -1, @dob1)
		end
	set @year = year(@dob1) - year(@dob2)
	declare @age nvarchar(50)
	set @age = cast(@year as nvarchar) + ' years ' + cast(@month as nvarchar) + ' months ' + cast(@day as nvarchar) + ' days'
	return @age
end


declare @dob1 datetime, @dob2 datetime, @tempDate datetime, @year int, @month int, @day int
set @dob1 = '11/30/2005'
set @dob2 = '12/29/2006'
--set @dob1 = '04/30/2005'
--set @dob2 = '12/29/2006'
--set @dob1 = '11/30/2005'
--set @dob2 = '01/31/2006'

set @tempDate = @dob1
select @year = dateDiff(year, @tempDate, @dob2) - 
	case
		when (month(@dob1) > month(@dob2)) or  ((month(@dob1) = month(@dob2)) and (day(@dob1) > day(@dob2)))
		then 1 else 0
	end

select @tempDate = dateAdd(year, @year, @dob1)
select @month = dateDiff(month, @tempDate, @dob2) 
	if(day(@dob1) = 31 and day(@dob2) = 30)
		set @month = @month - 0
	else if(day(@dob1) > day(@dob2))
		set @month = @month - 1

select @tempDate = dateAdd(month, @month, @tempDate)
select @day = dateDiff(day, @tempDate, @dob2)
	if(Day(EoMonth(@dob1)) = 31 and Day(EoMonth(@dob2)) = 30 and day(@dob1) != 31)
		set @day = @day + 1
	else if(Day(EoMonth(@dob1)) = 30 and Day(EoMonth(@dob2)) = 31 and day(@dob2) = 31)
		set @day = @day - 1
print cast(@year as nvarchar) + ' years ' + cast(@month as nvarchar) + ' months ' + cast(@day as nvarchar) + ' days'

select cast([smallDateTime] as Date ) as [Date], count(No) as [Count] from tblDateTime
group by cast([smallDateTime] as Date)

select cast([smallDateTime] as nvarchar) as [Date], count(No) as [Count] from tblDateTime
group by cast([smallDateTime] as nvarchar)

select convert(nvarchar, [smallDateTime]) as [Date], count(No) as [Count] from tblDateTime
group by convert(nvarchar, [smallDateTime])

select convert(nvarchar, [smallDateTime], 106) as [Date], count(No) as [Count] from tblDateTime		-- 106 hosse style. style part ta hosse optional.
group by convert(nvarchar, [smallDateTime], 106)													-- chaile dite o pari nao dite pari.

select * from tblDateTime


select convert(nvarchar, getDate(), 113)
select convert(nvarchar, getDate(), 103)

print GetDate()
print CURRENT_TIMESTAMP
print SYSDATETIME()
print sysDateTimeOffSet()
print GETUTCDATE()
print sysUTCDateTime()

print DATEADD(hour, +6, GETUTCDATE())   -- local time