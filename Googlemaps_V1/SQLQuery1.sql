create table SchoolInfo
(
SchoolId nchar(10) primary key not null, 
SchoolName nchar(10) null,
GeoLocation Geography null
)

INSERT INTO SchoolInfo 
VALUES ('s2', 'scchomkd', geography::STPointFromText('POINT(' + convert(nvarchar(25), 90.412521) +' ' + convert(nvarchar(25), 23.810331) + ')', 4326));  
INSERT INTO SchoolInfo 
VALUES ('s3', 'scchomkd', geography::STPointFromText('POINT(' + convert(nvarchar(25), 121.563700) +' ' + convert(nvarchar(25), 25.038410) + ')', 4326));
INSERT INTO SchoolInfo 
VALUES ('s4', 'inrobit', geography::STPointFromText('POINT(' + convert(nvarchar(25), 78.962883) +' ' + convert(nvarchar(25), 20.593683) + ')', 4326));
INSERT INTO SchoolInfo 
VALUES ('school1', 'JainTodmkd', geography::STPointFromText('POINT(' + convert(nvarchar(25), 67.001137) +' ' + convert(nvarchar(25), 24.860735) + ')', 4326));
delete from SchoolInfo

select * from SchoolInfo