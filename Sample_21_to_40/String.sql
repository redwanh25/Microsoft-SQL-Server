use [Sample_21_to_40]
go

create table tbl_name
(
	Id int identity(1, 1) primary key,
	[First Name] nvarchar(50),
	[Middle Name] nvarchar(50),
	[Last Name] nvarchar(50)
)

insert into tbl_name values('  Sam  ', '   Kala  ', '   Boba  ')
insert into tbl_name values('  Ramij  ', '   Boba  ', '   Kala  ')
insert into tbl_name values('  Redwan  ', '   Good  ', '   Boba  ')

update tbl_name
set [First Name] = '       Redwan     ', [Middle Name] = '     Good  ', [Last Name] = '         Boba  '
where id = 3

select * from tbl_name
select LTRIM([first name]) as [first], Rtrim(Ltrim([last name])) as [last], len(Rtrim(Ltrim([first name]))) as [len] from tbl_name

-- len() hosse space keo count kore.

print 'redwan'

select ASCII('A')
select char(65)
select LTRIM('            redwa  n  ')		-- left er shob space gulo remove kore dibe
select RTRIM('            redwa  n  ')		-- right er shob space gulo remove kore dibe
select lower('ABCD abCD')
select upper('abcd ABcD')
select reverse('redwan')
select len('redwan')
select len('689768568')

select reverse(lower(Rtrim('            ReDwa  N            ')))

declare @start int
set @start = 65
while(@start >= 65 and @start <= 90)
begin
	print char(@start) + ' = ' + cast(@start as nvarchar(50))
	--set @start = @start + 1
	set @start += 1
end

select left('abcdefGHIJ', 5)
select right('abcdefGHIJ', 5)
select charindex('@', 'redwanh@gmail.com')
select charindex('@', 'redwanh25@gamil.com', 2)
select SUBSTRING('redwanh25@gmail.com', 11, 9)

use [Sample_1_to_20]
go
select * from tblperson

select substring(email, charIndex('@', email)+1, len(email)-charIndex('@', email)) as [Email Type], count(id) as count from tblPerson
group by substring(email, charIndex('@', email)+1, len(email)-charIndex('@', email))

select replicate('*', 5)
select space(6)
select email, patindex('%@gmail.com', email) from tblPerson
select Replace (email, '.com', '.net') as Email from tblPerson
select stuff(email, 2, 3, '**') as Email from tblPerson
select stuff(email, 2, 3, replicate('*', 2)) as Email from tblPerson

select [Name], stuff([Email], 2, Patindex('%@%', email)-2, replicate('*', patindex('%@%', email)-1)), [GenderID], [Salary] from tblPerson