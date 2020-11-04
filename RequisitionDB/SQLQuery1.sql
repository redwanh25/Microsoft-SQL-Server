--TBLE-A:: itemInventory

CREATE TABLE [dbo].[ itemInventory](
	[catID] [int] NOT NULL,
	[itemName] [nvarchar](250) NULL,
	[itemType] [nvarchar](250) NULL
) ON [PRIMARY]
GO

--TBLE-B:: requisitionDetails
CREATE TABLE [dbo].[requisitionDetails](
	[requisitionID] [int] NOT NULL,
	[itemName] [nvarchar](250) NULL,
	[itemType] [nvarchar](250) NULL,
	[Qty] [int] NULL,
	[rate] [nvarchar](250) NULL,
	[status] [nvarchar](250) NULL
) ON [PRIMARY]
GO

--TBLE-C:: requisitionMaster
CREATE TABLE [dbo].[requisitionMaster](
	[requisitionID] [int] IDENTITY(1,1) NOT NULL,
	[RequBy] [nvarchar](250) NOT NULL,
	[RequisitionDate] [date] NULL,
	[reviewBy] [nvarchar](250) NULL,
	[reviewDate] [date] NULL,
	[reviewStatus] [nchar](10) NULL,
	[orderedBy] [nvarchar](250) NULL,
	[orderedDate] [date] NULL,
	[payment] [nchar](10) NULL,
	[shipmentDate] [nchar](10) NULL,
	[purchaseID] [nchar](10) NULL,
	[vendorID] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[requisitionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--TBLE-D:: users
CREATE TABLE [dbo].[users](
	[userID] [int] NOT NULL,
	[FullName] [nvarchar](250) NULL,
	[Designation] [nvarchar](250) NULL,
	[DeptProjectOffice] [nvarchar](250) NULL,
	[userRole] [nvarchar](250) NULL,
	[status] [nvarchar](250) NULL
) ON [PRIMARY]
GO
