Create table tblIndianCustomers
(
id int identity(1, 1) primary key,
Name nvarchar(50),
Email nvarchar(50)
)

insert into tblIndianCustomers values ('Raj', 'R@R.com')
insert into tblIndianCustomers values ('Sam', 'S@S.com')

delete from tblIndianCustomers
delete from	tblUKCustomers

dbcc checkident (tblUKCustomers, reseed, 0)
dbcc checkident (tblIndianCustomers, reseed, 0)

select * from tblIndianCustomers

create table tblUKCustomers
(
id int identity(1, 1) primary key,
Name nvarchar(50),
Email nvarchar(50)
)

insert into tblUKCustomers values ('Ben', 'B@B.com')
insert into tblUKCustomers values ('Sam', 'S@S.com')

select * from tblIndianCustomers
select * from tblUKCustomers

select * from tblIndianCustomers
union
select * from tblUKCustomers

-- for union output will be

1	Sam	S@S.com			|		1	Raj	R@R.com
2	Raj	R@R.com			|		2	Sam	S@S.com	
						|
1	Ben	B@B.com			|		1	Ben	B@B.com
2	Sam	S@S.com			|		2	Sam	S@S.com
						|
1	Ben	B@B.com			|		1	Ben	B@B.com
1	Sam	S@S.com			|		1	Raj	R@R.com
2	Raj	R@R.com			|		2	Sam	S@S.com
2	Sam	S@S.com			|

select * from tblIndianCustomers
union all
select* from tblUKCustomers

select id, name, email from tblIndianCustomers		 
union all
select id, email, name from tblUKCustomers			-- nvarchar() = nvarchar() hote hobe. int = nvarchar() hole error dibe
order by [name] desc

