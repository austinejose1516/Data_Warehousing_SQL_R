# Clear everything in workspace

rm(list=ls())

# Adding library RODBC

library(RODBC)

# Setting up SQL Server connection

Conn = odbcDriverConnect("driver={SQL Server}; server=DESKTOP-KPLGL3D\\SQLEXPRESS;
database=SalesInvention_DW; trusted_connection=true;")

# Inserting data from Fact_Sales into a variable called data1

data1 <- sqlQuery(Conn, "SELECT Year, Quarter, OrderQty, UnitPrice FROM Fact_Sales
inner join Dim_Calendar on [dbo].[Fact_Sales].CalendarKey = [dbo]. [Dim_Calendar].CalendarKey
GROUP BY Year, Quarter, OrderQty, UnitPrice")

# Adding "Total" column which is the product of quantity and price

data1$Total <- data1$OrderQty * data1$UnitPrice head(data1)

# Creating new data frame called newdata1 with years and the revenue generated

x1 <- data1[data1$Year == 2011, ]
x2 <- data1[data1$Year == 2012, ]
x3 <- data1[data1$Year == 2013, ]
x4 <- data1[data1$Year == 2014, ]
newdata1 <- data.frame("Year" = c(2011, 2012, 2013, 2014), "SalesTotal" = c(sum(x1$Total),sum(x2$Total),sum(x3$Total),sum(x4$Total)))

# Plotting a barplot shows the total sales over the years 2011 to 2014

barplot(newdata1$SalesTotal,
names.arg = c(2011, 2012, 2013, 2014),
main = "Total Revenue of AdventureWorks Ltd.", xlab = "Year",
ylab = "Revenue in $",
col = c("darkred", "blue", "yellow", “red"))

# Connections are the same

# Inserting data from Fact_Retailer into a variable called data2

data2 <- sqlQuery(Conn, "SELECT Name, OrderQty, UnitPrice, ReceivedQty FROM Fact_Retail
inner join Dim_Vendor on [dbo].[Dim_Vendor].VendorKey = [dbo]. [Fact_Retail].VendorKey
GROUP BY Name, OrderQty, UnitPrice, ReceivedQty, RejectedQty “)

# Adding columns "Missed" and "Loss" using arithmetic operations

data2$Missed <- data2$OrderQty-data2$ReceivedQty data2$Loss <- data2$Missed*data2$UnitPrice
data2 <- data2[data2$Missed != 0, ] data2[order(data2$Loss, decreasing = TRUE), ]

# Creating new data frame with requirement

y1 <- data2[data2$Name == "Superior Bicycles", ] y2 <- data2[data2$Name == "Bicycle Specialists", ]
y3 <- data2[data2$Name == "Inline Accessories", ] y4 <- data2[data2$Name == "Proseware, Inc.", ]
y5 <- data2[data2$Name == "Vision Cycles, Inc.", ]

# Creating new dataframe named newdata 2 that contains top 5 vendors and their loss

newdata2 <- newdata1 <- data.frame("Vendor" = c("Superior Bicycles", "Bicycle Specialists", "Inline Accessories", "Proseware, Inc.", "Vision Cycles, Inc."), "TotalLoss" = c(sum(y1$Loss),sum(y2$Loss),sum(y3$Loss),sum(y4$Loss),sum(y5$Lo ss)))

# Plotting a barplot shows which the loss of revenue due to missing purchase orders by vendors

barplot(newdata2$TotalLoss,
names.arg = c("Superior Bicycles", "Bicycle Specialists", "Inline Accessories", "Proseware, Inc.", "Vision Cycles, Inc."),
main = "Revenue Loss by Vendors (Top 5)",
xlab = "Vendors",
ylab = "Revenue loss in $",
col = c("darkred", "blue", "yellow", "red", “violet"))

# Connections are the same

# Inserting data from Fact_Retailer into a variable called data3

data3 <- sqlQuery(Conn, "SELECT Name, OrderQty FROM Fact_Sales INNER JOIN Dim_Product ON [dbo].
[Dim_Product].ProductKey = [dbo].[Fact_Sales].ProductKey GROUP BY Name, OrderQty”)

# Combining same products and arranging according to descending order to find top 5 porducts that sold in quantity and copying it to a new variable called newdata3

library(plyr)
data3 <- ddply(data3, "Name", numcolwise(sum))
data3 <- data3[order(data3$OrderQty, decreasing = TRUE), ] newdata3 <- head(data3, 5)

# Plotting a barplot that shows the top 5 sold products based on the quantity

barplot(newdata3$OrderQty,
names.arg = c("Finger Gloves", "MountainShorts L", "Classic Vest", "MountainShorts S", "Racing Socks"),
main = "Top 5 Sold Units”,
xlab = "Products",
ylab = "Quantity Sold",
col = c("darkgreen", "purple", "orange", "skyblue", "red"))

# Inserting data from Fact_Retailer into a variable called data4

data4 <- sqlQuery(Conn, "SELECT Name, RejectedQty FROM Fact_Retail
INNER JOIN [dbo].[Dim_Vendor] ON [dbo]. [Fact_Retail].VendorKey = [dbo].[Dim_Vendor].VendorKey
GROUP BY Name, RejectedQty")

# Rearranging dataframe according to the decreasing order to find the top 5 and transferring it to a new variable called newdata4

data4 <- data4[order(data4$RejectedQty, decreasing = TRUE), ] newdata4 <- head(data4, 5)


# Plotiing a barplot that shows the top 5 vendors with hight rejection rate
barplot(newdata4$RejectedQty,
names.arg = c("SUPERSALES INC.", "Victory Bikes", "Sport
Playground", "International Bicycles", "Premier Sport Inc."), main = "Top Vendors with High Rejection Rate",
xlab = "Vendors",
ylab = "Quantity Rejected",
col = c("lightblue", "grey", "brown", "blue", “darkred"))
