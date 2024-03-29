SELECT DISTINCT x.BusinessEntityID, x.ProductID, y.Name FROM AdventureWorks2014.Purchasing.ProductVendor x, AdventureWorks2014.Purchasing.Vendor y 
WHERE x.BusinessEntityID = y.BusinessEntityID

SELECT a.PurchaseOrderDetailID, a.ProductID, x.BusinessEntityID, y.Name FROM AdventureWorks2014.Purchasing.PurchaseOrderDetail a, AdventureWorks2014.Purchasing.ProductVendor x, AdventureWorks2014.Purchasing.Vendor y
WHERE a.ProductID = x.ProductID AND x.BusinessEntityID = y.BusinessEntityID 

SELECT p.ProductID , q.BusinessEntityID, q.Name FROM 
AdventureWorks2014.Purchasing.ProductVendor p 
inner join AdventureWorks2014.Purchasing.Vendor q  on  p.BusinessEntityID = q.BusinessEntityID 

SELECT a.SalesOrderDetailID, a.ProductID, a.OrderQty, a.UnitPrice, b.OrderDate FROM AdventureWorks2014.Sales.SalesOrderDetail a inner join AdventureWorks2014.Sales.SalesOrderHeader b ON a.SalesOrderID = b.SalesOrderID

SELECT * FROM SalesInvention_DW.dbo.Fact_Retail

SELECT Year, Quarter, OrderQty, UnitPrice FROM Fact_Sales
inner join Dim_Calendar on [dbo].[Fact_Sales].CalendarKey = [dbo].[Dim_Calendar].CalendarKey
GROUP BY Year, Quarter, OrderQty, UnitPrice 

SELECT Name, OrderQty, UnitPrice, ReceivedQty, RejectedQty FROM Fact_Retail
inner join Dim_Vendor on [dbo].[Dim_Vendor].VendorKey = [dbo].[Fact_Retail].VendorKey
GROUP BY Name, OrderQty, UnitPrice, ReceivedQty, RejectedQty


