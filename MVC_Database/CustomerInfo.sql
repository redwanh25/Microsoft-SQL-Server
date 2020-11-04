create table CustomerInfo
(
	Id int primary key identity,
	[CustomerName] nvarchar(50),
	[Status] bit
)

select name, is_broker_enabled from sys.databases

insert into [dbo].[CustomerInfo] values ('Redwan Hossain', 0)
select * from [dbo].[CustomerInfo]

update [dbo].[CustomerInfo] set CustomerName = 'redwan' where Id = 42
update [dbo].[CustomerInfo] set Status = 0 where Id = 41

--delete from [dbo].[CustomerInfo]

select * from [dbo].[tblEmployee]

SELECT [Id],[CustomerName],[Status] FROM [dbo].[CustomerInfo] WHERE [Status] != 0