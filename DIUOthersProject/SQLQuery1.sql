
create database DIUOthersProject

create table QRCodeString_tbl
(
Id int primary key identity,
[Date] Datetime,
QRCodeImage varbinary(max),
QRCodeString nvarchar(1000)
)

select * from QRCodeString_tbl

create table ZipFileStorAndDownload_tbl
(
Id int primary key identity,
[Date] Datetime,
ZipFile varbinary(max),
ZipFileName nvarchar(1000)
)

select * from ZipFileStorAndDownload_tbl