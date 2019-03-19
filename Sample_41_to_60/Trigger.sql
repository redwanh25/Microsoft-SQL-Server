
create table tbl_Person
(
[ID] int primary key,
[Name] nvarchar(50),
[Date Of Birth] Date,
[Gender] nvarchar(20),
[DepartmentID] int
)

insert into tbl_Person values(1, 'redwan', '02/12/1999', 'male', 1)
insert into tbl_Person values(2, 'masuda', '11/22/1995', 'female', 1)
insert into tbl_Person values(3, 'jamila', '05/15/1995', 'female', 2)
insert into tbl_Person values(4, 'ramij', '09/26/1997', 'male', 3)
insert into tbl_Person values(5, 'Joya', '01/01/2000', 'female', 1)
insert into tbl_Person values(6, 'shihab', '11/01/1998', 'male', 2)

select * from tbl_Person

create table tbl_Department
(
[DeptID] int primary key,
[Department Name] nvarchar(50),
[Location] nvarchar(50),
[Department Head Name] nvarchar(50)
)

insert into tbl_Department values(1, 'IT', 'Bangladesh', 'Reza Nabi')
insert into tbl_Department values(2, 'Accounting', 'Usa', 'Yousuf Jamil')
insert into tbl_Department values(3, 'Architecture', 'London', 'Kella Foteh')

select * from tbl_Department

create table tbl_Person_AuditData
(
ID int identity(1, 1) primary key,
AuditData nvarchar(100)
)


-- For insert

alter trigger tbl_Person_ForInsert
on tbl_Person
for insert
as
begin
	-- "inserted" hosse akta special table. this table just work inside the trigger. but, if we want to use outside the trigger. we will get
	-- an error. when we insert any data into the tbl_Person table, then it will be also insert into the "inserted" table. but, remember it is
	-- only accessable inside the trigger.

	declare @id int
	select @id = Id from inserted

	-- one way
	-- insert into tbl_Person_AuditData(AuditData) select cast(id as nvarchar(50)) + ' ' + [name] from inserted

	-- another way
	-- select * into #temptable from inserted		-- aikhane mone hoy temporary table sara nibe na.. not sure
	-- insert into tbl_Person_AuditData(AuditData) select cast(id as nvarchar(50)) + ' ' + [name] from #temptable

	insert into tbl_Person_AuditData
	values('New employee with id = ' + cast(@id as nvarchar(50)) + ' is added at ' + cast(getDate() as nvarchar(50)))
	-- convert(nvarchar, getDate(), 113))
end

insert into tbl_Person values(25, 'zzzzzz', '11/01/1998', 'male', 2)

select * from tbl_Person
select * from tbl_Person_AuditData


-- For delete

alter trigger tbl_Person_ForDelete
on tbl_Person
for delete
as
begin
	declare @id int, @audit nvarchar(100)
	select * into #tempTable from deleted
	set @audit = 'delete employee id = '
	while(exists(select id from #tempTable))	-- if table is empty then id will be null
		begin
		--	select top 1 @id = id from #tempTable				--	1st theke delete kore dibe.
			select top 1 @id = id from #tempTable order by id	--  sort kore top e jei value ase oi ta delete kore dibe.
			set @audit += cast(@id as nvarchar(10)) + '   '
			delete from #tempTable where id = @id
		end
	set @audit += ' at ' + cast(getDate() as nvarchar(50))
	insert into tbl_Person_AuditData values(@audit)

	--insert into tbl_Person_AuditData
	--values('delete employee id = ' + cast(@id as nvarchar(50)) + ' at ' + cast(getDate() as nvarchar(50)))
	-- convert(nvarchar, getDate(), 113))
end

delete from tbl_Person where id in (20, 21, 22)

select * from tbl_Person
select * from tbl_Person_AuditData

alter trigger tbl_Person_ForUpdate
on tbl_Person
for update
as
begin
	declare @id int
	declare @oldName nvarchar(50), @newName nvarchar(50)
	declare @oldDateOfBirth date, @newDateOfBirth date
	declare @oldGender nvarchar(50), @newGender nvarchar(50)
	declare @oldDepartmentId int, @newDepartmentId int

	declare @audit nvarchar(500)
	select @id = id from inserted

	set @audit = 'Change Id ' + cast(@id as nvarchar(50)) + ' with ==> '

	select @oldName = [name], @oldDateOfBirth = [Date Of Birth], @oldGender = Gender, @oldDepartmentId = DepartmentId from deleted
	select @newName = [name], @newDateOfBirth = [Date Of Birth], @newGender = Gender, @newDepartmentId = DepartmentId from inserted

	if(@oldName != @newName)
		set @audit += 'Name from ' + @oldName + ' to ' +  @newName + ' & '

	if(@oldDateOfBirth != @newDateOfBirth)
		set @audit += 'DateOfBirth from ' + convert(nvarchar, @oldDateOfBirth, 103) + ' to ' +  convert(nvarchar, @newDateOfBirth, 103) + ' & '

	if(@oldGender != @newGender)
		set @audit += 'Gender from ' + @oldGender + ' to ' +  @newGender + ' & '

	if(@oldDepartmentId != @newDepartmentId)
		set @audit += 'DepartmentId from ' + cast(@oldDepartmentId as nvarchar(50)) + ' to ' +  cast(@newDepartmentId as nvarchar(50)) + ' & '

	insert into tbl_Person_AuditData values(@audit)
end

update tbl_Person set [Name] = 'redwan', [Date Of Birth] = '1999-02-12', gender = 'male', DepartmentId = 1 where id = 1

select * from tbl_Person
select * from tbl_Department
select * from tbl_Person_AuditData

create view tbl_Person_Department_View
as
select ID, [Name], [Date Of Birth], Gender, [Department Name]
from tbl_Person P
inner join tbl_Department D
on P.DepartmentID = D.DeptID

select * from tbl_Person_Department_View

-- trigger a "instead of insert" use korle ai insert into ai comment er poriborte trigger ta use hobe.
insert into tbl_Person_Department_View values (23, 'keya', '05/15/1995', 'female', 'IeT')
-- if you don't use trigger, insert into line will not be acceptable. because the modification affects multiple base tables.

alter trigger tbl_Person_Department_insteadOfInsert
on tbl_Person_Department_View
instead of insert
as
begin
	declare @deptId int

--	check if there is a valid department name which you have inserted
--  if insert v then @deptId will be null
	select @deptId = deptID
	from tbl_Department D
	inner join inserted I
	on D.[Department Name] = I.[Department Name]

	if(@deptId is null)
	begin
		raiserror('invalid department name. system terminate', 16, 1)
		return		-- return dile she ai khane e full code ta execute kora stop kore dibe.. r "raiserror" just error show koranor jonno.
	end				-- remember return na dile kintu code choltee thakbe.

	insert into tbl_Person (id, [Name], [Date Of Birth], Gender, DepartmentID)
	select id, [Name], [Date Of Birth], Gender, @deptId from inserted

	-- remember for this "insert into" statement another trigger will be executed. which name is "tbl_Person_ForInsert". you have created
	-- above (please check).
end

alter trigger tbl_Person_Department_insteadOfUpdate
on tbl_Person_Department_View
instead of update
as
begin
	declare @id int
	declare @Name nvarchar(50), @DateOfBirth date, @Gender nvarchar(50)
	select @id = id from inserted
	select @Name = [name], @DateOfBirth = [Date Of Birth], @Gender = Gender from inserted

	if(update([ID]))
	begin
		raiserror('id can not be changed', 16, 1)
		return
	end
	
	if(update([Name]))
	begin
		--update tbl_Person set [Name] = @Name where id = @id	-- just ai akta line dile e hobe. nicher oi update na dileo hobe.

		update tbl_Person set [Name] = inserted.[Name]	-- "inserted.Name" ai multi part bound kore dite hobe. inner join diye. noile error hobe.
		from inserted
		inner join tbl_Person
		on inserted.id = tbl_Person.id
	end

	if(update([Date of Birth]))
	begin
		--update tbl_Person set [Date of Birth] = @DateOfBirth where id = @id		

		update tbl_Person set [Date of Birth] = inserted.[Date of Birth]
		from inserted
		inner join tbl_Person
		on inserted.id = tbl_Person.id
	end

	if(update([Gender]))
	begin
		--update tbl_Person set [Gender] = @Gender where id = @id

		update tbl_Person set [Gender] = inserted.[Gender]
		from inserted
		inner join tbl_Person
		on inserted.id = tbl_Person.id
	end

	if(update([Department Name]))
	begin
		declare @deptId int
		select @deptId = deptId
		from tbl_Department D
		join inserted I
		on D.[Department Name] = I.[Department Name]

		if(@deptId is null)
		begin
			raiserror('invalid department name. system terminate', 16, 1)
			return
		end

		--update tbl_Person set [DepartmentID] = @deptId where id = @id

		update tbl_Person set [DepartmentID] = @deptId
		from inserted
		inner join tbl_Person
		on inserted.id = tbl_Person.id
	end
end

update tbl_Person_Department_View
set [Name] = 'redwan', [Date Of Birth] = '02/12/1999', Gender = 'male', [Department Name] = 'IT'
where id = 1

select * from tbl_Person
select * from tbl_Department
select * from tbl_Person_AuditData
select * from tbl_Person_Department_View

alter trigger tbl_Person_Department_insteadOfDelete
on tbl_Person_Department_View
instead of delete
as
begin
	--delete from tbl_Person where id in (select id from deleted)

	delete tbl_Person
	from tbl_Person
	join deleted
	on deleted.id = tbl_Person.id
end

delete from tbl_Person_Department_View where id in (24, 25)