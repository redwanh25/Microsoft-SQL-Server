create table [Sample_Table]
(
ID int primary key,
Salary int
)

create table [Sample_Table]
(
ID int,
Salary int
)

insert into Sample_Table values (0, 3000)
insert into Sample_Table values (3, 1000)
insert into Sample_Table values (2, 2000)

insert into Sample_Table values (1, 1000)
insert into Sample_Table values (1, 2000)

select * from Sample_Table

delete from Sample_Table
drop table Sample_Table

alter table Sample_Table
add constraint Sample_Table_Constraint
unique clustered(ID)

alter table Sample_Table
add constraint Sample_Table_Constraint
unique (ID)		-- unique nonclustered(ID)		ai dui tai same kotha

sp_helpindex Sample_Table

create index sample_index_asc		-- if you do not right anything it will be nonclustered by default
on Sample_Table(ID asc)

create clustered index sample_index_asc_clustered
on Sample_Table(ID asc)

create clustered index sample_index_asc_clustered_asc_desc
on Sample_Table(ID asc, salary desc)		-- clustered index aktai thake but, multiple colomn niye thakte pare.

select * from Sample_Table

create nonclustered index sample_index_nonclustered
on Sample_Table(ID asc)				-- asc na dile o asc kore ney difault.

create unique nonclustered index sample_index_unique_clustered
on Sample_Table(ID)