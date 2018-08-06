create database [Chat_Application]

use [Chat_Application]
go

create table Person
(
ID int identity(1, 1) primary key,
[Name] nvarchar(50),
)

create table Details
(
ID int identity(1, 1) primary key,
[First Name] nvarchar(50),
[Last Name] nvarchar(50),
[Message] int,
[Friends] int
)

create table [Message]
(
ID int identity(1, 1) primary key,
[Friends Id] nvarchar(50),
)

create table Sms
(
ID int identity(1, 1) primary key,
[Name] nvarchar(50),
)

