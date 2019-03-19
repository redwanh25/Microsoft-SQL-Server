create table Customer
(
customerNo1 int not null,
customerNo2 int not null,
[Name] nvarchar(20),
Email nvarchar(50)
);

select * from Customer

ALTER TABLE Customer
ADD CONSTRAINT PK_redwan PRIMARY KEY CLUSTERED (customerNo1, customerNO2);

alter table Customer drop constraint PK_redwan