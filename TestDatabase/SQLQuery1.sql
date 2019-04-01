create table dbo.QRCodeString_tbl
(
	[Id] int identity primary key,
	[Date] DateTime,
	[QRCodeImage] varbinary(max),
	[QRCodeString] nvarchar(1000)
)


select * from QRCodeString_tbl

insert into QRCodeString_tbl values(getdate(), @QRCodeImage, @QRCodeString)

delete from QRCodeString_tbl where id between 1 and 2