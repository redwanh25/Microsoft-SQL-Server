-- proc / procedure

select * from tblEmployee

-- procedure create kora

create procedure tblEmployee_print
as
begin
	select * from tblEmployee
end

Execute tblEmployee_print			-- Execute dile o hobe na dile o hobe

-- procedure name same rekhe ager procedure k replace kore onno procedure set kora

alter procedure tblEmployee_print
as
begin
	select * from tblEmployee order by [Name]
end

Execute tblEmployee_print
tblEmployee_print

create procedure tblEmployee_parameter
@gender nvarchar(50),
@departmentId int
as
begin
	select [ID], [Name], [Gender], [DepartmentID] from tblEmployee where [Gender] = @gender and [DepartmentID] = @departmentId
end

execute tblEmployee_parameter 'male', 1
-- execute tblEmployee_parameter  1, 'male'							-- error hobe
execute tblEmployee_parameter @departmentId = 1, @gender = 'male'	-- error hobe na. cause parameter ullekh kore disi
select * from tblEmployee

sp_helpText tblEmployee_parameter

drop proc tblEmployee_parameter
drop procedure tblEmployee_parameter

create proc tblEmployee_parameter
@gender nvarchar(50),
@departmentId int
with Encryption
as
begin
	select [ID], [Name], [Gender], [DepartmentID] from tblEmployee where Gender = @gender and DepartmentID = @departmentId
end

sp_helpText tblEmployee_parameter		-- Encryption korar pore r code dekha jabe na. mane ai helptext ta kaj korbe na

-- remove Encryption					-- remove korar pore dekha jabe
alter procedure tblEmployee_parameter
@gender nvarchar(50),
@departmentId int
as
begin
	select [ID], [Name], [Gender], [DepartmentID] from tblEmployee where [Gender] = @gender and [DepartmentID] = @departmentId
end

-- output parameter

create procedure tblEmployee_outputParameter
@id int,
@name nvarchar(50) out							-- out / output dui tar jekono akta likhle e hobe
as
begin
	select @name = [Name] from tblEmployee where ID = @id
end

select * from tblEmployee

Declare @text nvarchar(50)
execute tblEmployee_outputParameter 3, @text out		-- out / output dui tar jekono akta likhle e hobe
print @text

Declare @text nvarchar(50)
execute tblEmployee_outputParameter @name = @text out, @id = 1
print @text

Declare @text nvarchar(50)
execute tblEmployee_outputParameter 1, @text		-- out na likhle null ashle.. mane kisu e ashbe na.
if(@text is null)
	begin				-- amra jemon multiple line er kisu likhle { } er moddhe likhi. sql a begin theke end er moddhe likhte hoy.
		print 'null'
		print 'print'
		print 'hobe'
	end
else 
	print @text

select * from tblEmployee

sp_help tblEmployee_outputParameter
sp_depends tblEmployee_outputParameter
sp_depends tblEmployee

print 'amr shonar bangla ami 2may valobashi'

-- difference between return and output 

create procedure tblEmployee_output
@id int out,
@gender nvarchar(50),
@salary int out
as
begin
	select @id = count(id), @salary = sum(salary) from tblEmployee where [Gender] = @gender		-- output parameter er jonno char type return hote pare and multiple data o return korte pare. 
end

declare @PersonID int, @PersonSalary int
execute tblEmployee_output @PersonID out, 'male', @PersonSalary out
print 'ID           = ' + cast(@PersonID as nvarchar(50))
print 'Total salary = ' + cast(@PersonSalary as nvarchar(50)) + ' taka'
print 'Salary = ' + @PersonSalary		-- emne likhle hobe na.


select * from tblEmployee

create procedure tblEmployee_return
@gender nvarchar(50)
as
begin
	return(select count(ID) from tblEmployee where Gender = @gender)		-- return type always akta hobe. onek gula hote parbe na.
end

Declare @id int
execute @id = tblEmployee_return 'female'
print 'count = ' + cast(@id as nvarchar(50))

create procedure tblEmployee_return1
@id int
as
begin
	return(select [Name] from tblEmployee where ID = @id)		-- return type always int type hobe. char type hole error hobe.
end

Declare @name nvarchar(50)
execute @name = tblEmployee_return1 2
print 'Name = ' + @name