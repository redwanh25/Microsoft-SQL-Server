
-- generate random number
declare @lo as int = 1, @up as int = 5
select round(((@up - @lo) * rand() + @lo), 0)

create table tbl_Pivot_withID
(
ID int identity,
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

create table tbl_Pivot_withoutID
(
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

delete from tbl_Pivot_withoutID
select * from tbl_Pivot_withoutID

declare @i as int = 1
while(@i <= 20)
begin
	declare @lo as int = 1, @up as int = 3, @random int
	set @random = round(((@up - @lo) * rand() + @lo), 0)
	if(@random = 1)
	begin
		declare @lo1 as int = 1, @up1 as int = 3, @random1 int
		set @random1 = round(((@up - @lo) * rand() + @lo), 0)

		if(@random1 = 1)
		begin
			declare @lo4 as int = 1, @up4 as int = 3, @random4 int
			set @random4 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('Tom', 'UK', power(5, @random4))
		end
		else if(@random1 = 2)
		begin
			declare @lo5 as int = 1, @up5 as int = 3, @random5 int
			set @random5 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('Tom', 'US', power(6, @random5))
		end
		else if(@random1 = 3)
		begin
			declare @lo6 as int = 1, @up6 as int = 3, @random6 int
			set @random6 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('Tom', 'India', power(7, @random6))
		end
	end
	else if(@random = 2)
	begin
		declare @lo2 as int = 1, @up2 as int = 3, @random2 int
		set @random2 = round(((@up - @lo) * rand() + @lo), 0)

		if(@random2 = 1)
		begin
			declare @lo7 as int = 1, @up7 as int = 3, @random7 int
			set @random7 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('David', 'UK', power(6, @random7))
		end
		else if(@random2 = 2)
		begin
			declare @lo8 as int = 1, @up8 as int = 3, @random8 int
			set @random8 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('David', 'US', power(7, @random8))
		end
		else if(@random2 = 3)
		begin
			declare @lo9 as int = 1, @up9 as int = 3, @random9 int
			set @random9 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('David', 'India', power(5, @random9))
		end
	end
	else if(@random = 3)
	begin
		declare @lo3 as int = 1, @up3 as int = 3, @random3 int
		set @random3 = round(((@up - @lo) * rand() + @lo), 0)

		if(@random3 = 1)
		begin
			declare @lo10 as int = 1, @up10 as int = 3, @random10 int
			set @random10 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('Jhon', 'UK', power(7, @random10))
		end
		else if(@random3 = 2)
		begin
			declare @lo11 as int = 1, @up11 as int = 3, @random11 int
			set @random11 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('Jhon', 'US', power(5, @random11))
		end
		else if(@random3 = 3)
		begin
			declare @lo12 as int = 1, @up12 as int = 3, @random12 int
			set @random12 = round(((@up - @lo) * rand() + @lo), 0)
			insert into tbl_Pivot_withoutID values('Jhon', 'India', power(6, @random12))
		end
	end
	set @i = @i + 1
end

select SalesCountry, SalesAgent, sum(SalesAmount) as Total
from tbl_Pivot_withoutID
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent

-- pivot without id

select SalesAgent, India, US, UK from tbl_Pivot_withoutID
pivot
(
	sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as pivotTable

-- pivot with id

select SalesAgent, India, US, UK from tbl_Pivot_withID
pivot
(
	sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as pivotTable

-- so, amra ja bujhlam ta holo pivot a id thaka jabe na. jodi thake taile onno process a jete hobe. follow this process.

select SalesAgent, India, US, UK
from
(
	select SalesAgent, SalesCountry, SalesAmount from tbl_Pivot_withID
) as sourceTable
pivot
(
	sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as pivotTable

