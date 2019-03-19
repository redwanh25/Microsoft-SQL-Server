select * from tbl_Person
select * from tbl_Department

select ID, [Name], [Gender] from tbl_Person
where ID not in (select DeptID from tbl_Department)

select [Name], (select count(DeptID) from tbl_Department) as totalDeptID from tbl_Person