Create Table Countries
(
     Country nvarchar(50),
     City nvarchar(50)
)
GO

Insert into Countries values ('USA','New York')
Insert into Countries values ('USA','Houston')
Insert into Countries values ('USA','Dallas')

Insert into Countries values ('India','Hyderabad')
Insert into Countries values ('India','Bangalore')
Insert into Countries values ('India','New Delhi')

Insert into Countries values ('UK','London')
Insert into Countries values ('UK','Birmingham')
Insert into Countries values ('UK','Manchester')

select * from Countries

Select Country, City1, City2, City3
From
(
  Select Country, City,
    'City'+
      cast(row_number() over(partition by Country order by Country)
             as varchar(10)) as ColumnSequence
  from Countries
) Temp
pivot
(
  max(City)
  for ColumnSequence in (City1, City2, City3)
) Piv

drop table #yourtable

CREATE table yourtable
    ([Id] int, [Value] varchar(6), [Value1] varchar(6), [ColumnName] varchar(13))
;
    
INSERT INTO yourtable ([Id], [Value], [Value1], [ColumnName])
VALUES
    (1, 'John', 'John', 'FirstName'),
    (2, '2.4','John', 'Amount'),
    (3, 'ZH1E4A','John', 'PostalCode'),
    (4, 'Fork','John', 'LastName'),
    (5, '857685','John', 'AccountNumber')
;

select * from yourtable

DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX)

select @cols = STUFF((SELECT ',' + QUOTENAME(ColumnName) 
                    from yourtable
                    group by ColumnName, id
                    order by id
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @query = N'SELECT ' + @cols + N' from 
             (
                select value, ColumnName
                from yourtable
            ) x
            pivot 
            (
                max(value)
                for ColumnName in (' + @cols + N')
            ) p '

exec sp_executesql @query;

Create Table Courses
(
     CourseID int identity primary key,
     CourseName nvarchar(50)
)
GO

Create Table Students
(
     StudentID int identity primary key,
     StudentName nvarchar(50)
)
GO

Create Table StudentCourses
(
     StudentID int not null foreign key references Students(StudentID),
     CourseID int not null foreign key references Courses(CourseID)
     primary key (StudentID, CourseID)
)
GO

Insert into Courses values ('C#')
Insert into Courses values ('ASP.NET')
Insert into Courses values ('SQL Server')
Insert into Courses values ('WCF')
GO

Insert into Students values ('Mike')
Insert into Students values ('John')
GO

Insert into StudentCourses values (1, 1)
Insert into StudentCourses values (1, 2)
Insert into StudentCourses values (2, 1)
Insert into StudentCourses values (2, 2)
Insert into StudentCourses values (2, 3)
GO

select * from Students
select * from Courses
select * from StudentCourses

  Select StudentID, CourseID,
    'City'+
      cast(row_number() over(partition by CourseID order by CourseID)
             as varchar(10)) as ColumnSequence
  from StudentCourses

Select CourseID, City1, City2, City3
From
(
  Select StudentID, CourseID,
    'City'+
      cast(row_number() over(partition by CourseID order by CourseID)
             as varchar(10)) as ColumnSequence
  from StudentCourses
) Temp
pivot
(
  max(StudentID)
  for ColumnSequence in (City1, City2, City3)
) Piv