--Creating Database named "SalesInvention_DW

CREATE DATABASE SalesInvention_DW

-- Creating dimension table called "Dim_Sales" also dropping if it exists earlier

USE SalesInvention_DW
IF OBJECT_ID('tempdb..Dim_Sales', 'U') IS NOT NULL
DROP TABLE Dim_Sales
CREATE TABLE Dim_Sales (
[SalesKey][int] NOT NULL IDENTITY,
[SalesOrderDetailID] [int] NOT NULL,
[OrderQty] [smallint] NOT NULL,
[UnitPrice] [money] NOT NULL,
[ProductID] [int] NOT NULL,
PRIMARY KEY (SalesKey));
GO

-- Creating dimension table called "Dim_Retail" also dropping if it exists earlier

USE SalesInvention_DW
IF OBJECT_ID('tempdb..Dim_Retail', 'U') IS NOT NULL
DROP TABLE Dim_Retail
CREATE TABLE Dim_Retail (
[RetailKey] [int] NOT NULL IDENTITY,
[PurchaseOrderDetailID] [int] NOT NULL,
[ProductID] [int] NOT NULL,
[OrderQty] [smallint] NOT NULL,
[UnitPrice] [money] NOT NULL,
[ReceivedQty] [decimal](8, 2) NOT NULL,
[RejectedQty] [decimal](8, 2) NOT NULL,
PRIMARY KEY (RetailKey));
GO
-- Creating dimension table called "Dim_Product" also dropping if it
 exists earlier
USE SalesInvention_DW
IF OBJECT_ID('tempdb..Dim_Product', 'U') IS NOT NULL
DROP TABLE Dim_Product
CREATE TABLE Dim_Product (
[ProductKey][int] NOT NULL IDENTITY,
[ProductID] [int] NOT NULL,
[Name] [nvarchar](50) NOT NULL,
[BusinessEntityID] [int] NOT NULL,
PRIMARY KEY (ProductKey));
GO

-- Creating dimension table called "Dim_VendorHistory" also dropping if it exists earlier

USE SalesInvention_DW
IF OBJECT_ID('tempdb..Dim_Vendor', 'U') IS NOT NULL
DROP TABLE Dim_Vendor
CREATE TABLE Dim_Vendor (
[VendorKey] [int] NOT NULL IDENTITY,
[ProductID] [int] NOT NULL,
[BusinessEntityID] [int] NOT NULL,
[Name] [nvarchar](50) NOT NULL,
PRIMARY KEY (VendorKey));
GO
USE SalesInvention_DW
IF OBJECT_ID('tempdb..Dim_Calendar', 'U') IS NOT NULL
DROP TABLE Dim_Calendar
CREATE TABLE Dim_Calendar (
[CalendarKey] INT NOT NULL IDENTITY,
[FullDate] DATETIME,
[Quarter] CHAR(20),
[Year] [INT],
PRIMARY KEY(CalendarKey));
GO

-- Creating dimension table called "Fact_Sales" also dropping if it exists earlier

USE SalesInvention_DW
IF OBJECT_ID('tempdb..Fact_Sales', 'U') IS NOT NULL
DROP TABLE Fact_Sales
CREATE TABLE Fact_Sales (
[SalesKey] [int],
[ProductKey] [int],
[CalendarKey] [int],
[OrderQty] [smallint] NOT NULL,
[UnitPrice] [money] NOT NULL,
FOREIGN KEY (SalesKey) REFERENCES Dim_Sales (SalesKey),
FOREIGN KEY (ProductKey) REFERENCES Dim_Product
(ProductKey),
FOREIGN KEY (CalendarKey) REFERENCES Dim_Calendar
(CalendarKey));
GO

-- Creating dimension table called "Fact_Retail" also dropping if it exists earlier

USE SalesInvention_DW
IF OBJECT_ID('tempdb..Fact_Retail', 'U') IS NOT NULL
DROP TABLE Fact_Retail
CREATE TABLE Fact_Retail (
[RetailKey] [int],
[VendorKey] [int],
[ProductKey] [int],
[OrderQty] [smallint] NOT NULL,
[UnitPrice] [money] NOT NULL,
[ReceivedQty] [decimal](8, 2) NOT NULL,
[RejectedQty] [decimal](8, 2) NOT NULL,
FOREIGN KEY (RetailKey) REFERENCES Dim_Retail (RetailKey),
FOREIGN KEY (VendorKey) REFERENCES Dim_Vendor
(VendorKey),
FOREIGN KEY (ProductKey) REFERENCES Dim_Product
(ProductKey));
GO
