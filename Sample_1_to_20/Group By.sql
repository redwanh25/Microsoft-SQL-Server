use [Sample_1_to_20]
go
select * from tblnew

create table tblnew
(
Id int Identity(1000, 1) primary key,
Product_Name nvarchar(50) 
)
select * from tblnew

insert into tblnew values ('nipu')

create procedure StoredProcedure
@ProductName nvarchar(50)
as
begin
	select * from tblnew
	where [Product_Name] like @ProductName + '%'
end

StoredProcedure 'red'

update tblPerson
set salary = 3010
where id = 3

select sum(salary) from tblPerson
select min(salary) from tblPerson
select max(salary) from tblPerson

select [name], genderId, sum(salary) as [Total Salary], count(id) as [Total employee]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
group by [name], genderid

select [name], genderId, sum(salary) as [Total Salary], count(id) as [Total employee]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
where genderid = 2
group by [name], genderid

select [name], genderId, sum(salary) as [Total Salary], count(id) as [Total employee]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
group by [name], genderid
having genderid = 2

select [name], genderId, sum(salary) as [Total Salary], count(id) as [Total employee]	-- space jodi dite chai taile amader [] er moddhe use korte hobe
from tblPerson
group by [name], genderid
having sum(salary) > 3000		-- sum(salary) > 3000 jodi where a dei taile kaj korbe na. karon 2 jekhane jekhane ase shei data gulo tule ene group kore fele
								-- r "having" hosse age group kore fele and kaj shesh hoyegele check kore dekhe {sum(salary) > 3000}

select * from tblPerson
order by [name]

select [name], sum(salary) as [total salary]
from tblPerson
group by [name], genderId