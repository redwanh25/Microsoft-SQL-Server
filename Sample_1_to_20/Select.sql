select * from INFORMATION_SCHEMA.ROUTINES

select * from tblPerson
select [id], [Name] from [sample_1_to_20].[dbo].[tblPerson]
select Distinct [name] from tblPerson
select * from tblPerson where [name] = 'joy'
select * from tblPerson where [name] != 'joy'
select * from tblPerson where [name] <> 'joy'
select * from tblPerson where ([id] = 4 or [id] = 5) or [name] = 'joy'
select * from tblPerson where ([id] = 4 or [id] = 5) and [name] = 'joy'
select * from tblPerson where ([id] = 4 or [id] = 5) and salary > 1000
select * from tblPerson where [id] in (3, 4, 20)
select * from tblPerson where [id] between 4 and 7
select * from tblPerson where [name] like 'jo%'		-- % mane onek character thakte pare
select * from tblPerson where [email] like '%@%'
select * from tblPerson where [email] not like '%@%'
select * from tblPerson where [email] like '___@_____.com'		-- akta _ er jonno akta character
select * from tblPerson where [email] not like '%@%'
select * from tblPerson where [email] like '[RSn]%'		-- r s n ai 3 ta letter jar namer shuru te ase tader name print korbe 
select * from tblPerson where [email] like '[^RSn]%'	-- ^ mane bad sign. oi gula bad diye baki gulo print korbe
select * from tblPerson order by [Name]					-- ascending
select * from tblPerson order by [Name] desc			-- descending
select * from tblPerson order by [Name] desc, [GenderId] asc
select top 5 * from tblPerson
select top 3 [name], [Email] from tblPerson
select top 70 percent * from tblPerson

select * from tblPerson
select distinct [Name] from tblPerson