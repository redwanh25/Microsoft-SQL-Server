
-- user 2
Insert into tblRedwan values ('user-2')
select SCOPE_IDENTITY()
select @@IDENTITY

create table tbl_Table1
(
ID int primary key,
Email nvarchar(50)
)

alter table tbl_Table1
add constraint tbl_Tabel1_Email
Unique(Email)

insert into tbl_Table1 values (3, 'x@gmail.com')

select * from tbl_Table1
select * from tbl_Table1 Order by Id

select count(ID) from tbl_Table1
select * from tblPerson