
create table tblProduct
(
ProductId int primary key,
[Name] nvarchar(50),
UnitPrice int,
QtyAvailable int
)

select * from tblProduct

insert into tblProduct values (1, 'Laptop', 2340, 90)
insert into tblProduct values (2, 'Desktops', 3467, 50)

-- @Error
begin transaction
update tblProduct set QtyAvailable = 900 where ProductId = 1
insert into tblProduct values (2, 'Mobile', 2340, 10)
if(@@Error != 0)
begin
	rollback transaction
	raiserror ('rollback transaction',  16, 1)
end
else
begin
	commit tran
	print 'commit tran'
end

-- becareful
update tblProduct set QtyAvailable = 100 where ProductId = 1
insert into tblProduct values (2, 'Mobile', 2340, 10)
select abs(-78)
if(@@Error != 0)		-- error hosse immediate uporer line ta thik hoise kina dekhe jodi vul hoy taile error == jekono akta value hoy.
	print 'Error hoyese'	-- noile uporer line thik thakle error = 0 hoye jay
else
	print 'hoyni'

-- try catch
begin try
	begin transaction
		update tblProduct set QtyAvailable = 90 where ProductId = 1
		insert into tblProduct values (2, 'Mobile', 2340, 10)
		select abs(-78)
		commit tran
		select 'commit tran'
end try
begin catch
	rollback transaction
	select		-- ai gula catch er bahire hobe na. error dibe
		Error_Line() as ErrorLine, 
		Error_Number() as ErrorNumber,
		Error_Message() as ErrorMessage,
		Error_State() as ErrorState,
		Error_Severity() as ErrorSeverity,
		Error_Procedure() as ErrorProcedure
	select 'Error hoyese'
end catch

