
Step 1

To Create the comment box, we need to add some tables and stored procedures.

Create a UserTable:
..................................
CREATE TABLE [dbo].[UserTable](  
    [UserName] [varchar](50) NOT NULL,  
    [Password] [varchar](50) NULL,  
 CONSTRAINT [PK_UserTable] PRIMARY KEY CLUSTERED   
(  
    [UserName] ASC  
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]  
) ON [PRIMARY]  
  
GO  
_________________________________



Create a ParentComment Table:
................................................

CREATE TABLE [dbo].[ParentComment](  
    [CommentID] [int] IDENTITY(1,1) NOT NULL,  
    [UserName] [varchar](50) NULL,  
    [CommentMessage] [varchar](300) NULL,  
    [CommentDate] [date] NULL,  
 CONSTRAINT [PK_ParentComment] PRIMARY KEY CLUSTERED   
(  
    [CommentID] ASC  
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]  
) ON [PRIMARY]  
  
GO  
  
SET ANSI_PADDING OFF  
GO  
  
ALTER TABLE [dbo].[ParentComment]  WITH CHECK ADD  CONSTRAINT [FK_ParentComment_UserTable] FOREIGN KEY([UserName])  
REFERENCES [dbo].[UserTable] ([UserName])  
GO  
  
ALTER TABLE [dbo].[ParentComment] CHECK CONSTRAINT [FK_ParentComment_UserTable]  
GO  
_____________________________________





Create a ChildComment Table:
....................................................

CREATE TABLE [dbo].[ChildComment](  
    [CommentID] [int] IDENTITY(1,1) NOT NULL,  
    [UserName] [varchar](50) NULL,  
    [CommentMessage] [varchar](300) NULL,  
    [CommentDate] [date] NULL,  
    [ParebCommentID] [int] NULL,  
 CONSTRAINT [PK_ChildComment] PRIMARY KEY CLUSTERED   
(  
    [CommentID] ASC  
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]  
) ON [PRIMARY]  
  
GO  
  
SET ANSI_PADDING OFF  
GO  
  
ALTER TABLE [dbo].[ChildComment]  WITH CHECK ADD  CONSTRAINT [FK_ChildComment_ParentComment] FOREIGN KEY([UserName])  
REFERENCES [dbo].[UserTable] ([UserName])  
GO  
  
ALTER TABLE [dbo].[ChildComment] CHECK CONSTRAINT [FK_ChildComment_ParentComment]  
GO  
  
ALTER TABLE [dbo].[ChildComment]  WITH CHECK ADD  CONSTRAINT [FK_ChildCommentID_ChildCommentID] FOREIGN KEY([ParebCommentID])  
REFERENCES [dbo].[ParentComment] ([CommentID])  
GO  
  
ALTER TABLE [dbo].[ChildComment] CHECK CONSTRAINT [FK_ChildCommentID_ChildCommentID]  
GO   

------------------------------------------



Step 2

Create a stored procedure for comments session so as to check credentials of the User.
.............................
create proc spCheckUserCredentials  
(@UserName varchar(25))  
as  
Begin  
Select *from UserTable where UserName=@UserName   
End   
--------------------------------



Insert comment for ParentComment.
...................................
create proc spCommentInsert  
(@UserName varchar(25),  
@CommanetMessage varchar(300))  
as  
Begin  
Insert into ParentComment(UserName,CommentMessage,CommentDate)values(@UserName,@CommanetMessage,GETDATE())  
End   
..........................




Insert reply comment for ChildComment
..................
create proc spCommentReplyInsert(@UserName varchar(25),  
@CommentMessage varchar(300),  
@ParentCommentID int)  
as  
Begin  
Insert into ChildComment(UserName,CommentMessage,CommentDate,ParebCommentID)  
values(@UserName,@CommentMessage,GETDATE(),@ParentCommentID)  
End  
...................................




Get Data Comment from database.
.........................
create Proc spGetParetComment  
as  
Begin  
Select *from ParentComment  
End  
create proc spGetParentCommentByParentCommnetID(@ParentCommnetID int)  
as  
Begin  
select *from ChildComment where ParebCommentID=@ParentCommnetID  
End  
............................