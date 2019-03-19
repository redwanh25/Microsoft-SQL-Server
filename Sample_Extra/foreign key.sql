create table tblPerson
(
PersonID int primary key,
[Name] nvarchar(50),
[Gender] nvarchar(50),
[DepartmentID] int foreign key references tblDepartment(DeptID)
)

-- age ai  table create korte hobe. cs, oi table a foreign key ase.
create table tblDepartment
(
[DeptID] int primary key,
[Department Name] nvarchar(50),
[Department Head Name] nvarchar(50)
)

Alter table tblPerson
Add constraint DF_tblPerson_DepartmentID
Default 3 for DepartmentID

Alter Table tblPerson
Add constraint tblPerson_DepartmentID_FK
Foreign Key (DepartmentID) references tblDepartment(DeptID)

select * from tblPerson
select * from tblDepartment

insert into tblPerson values(1, 'redwan', 'male', 1)
insert into tblPerson values(2, 'masuda', 'female', 1)
insert into tblPerson values(3, 'jamila', 'female', 2)
insert into tblPerson values(4, 'ramij', 'male', 3)
insert into tblPerson values(5, 'Joya', 'female', 1)
insert into tblPerson values(6, 'shihab', 'male', 2)


insert into tblDepartment values(1, 'IT', 'Reza Nabi')
insert into tblDepartment values(2, 'Accounting', 'Yousuf Jamil')
insert into tblDepartment values(3, 'CSE', 'Kella Foteh')
