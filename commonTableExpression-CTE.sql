-- Xây dựng một CTE để tạo một danh sách các khách hàng có số lượng đơn hàng lớn hơn 10
WITH HighVolumeCustomers AS (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(OrderID) > 10
)
-- Sử dụng CTE để lấy thông tin chi tiết của các khách hàng có số lượng đơn hàng lớn hơn 10
SELECT Customers.CustomerID, Customers.ContactName, HighVolumeCustomers.OrderCount, HighVolumeCustomers.OrderCount / 2 as Nothing
FROM HighVolumeCustomers
JOIN Customers ON Customers.CustomerID = HighVolumeCustomers.CustomerID;

-- Bài 3: Sử dụng CTE tính tổng doanh số bán hàng theo năm từ bảng "Orders" và "Order Details"
with TotalSales as (
	select od.OrderID, sum(od.Quantity * od.UnitPrice) as "TotalPrice"
	from [Order Details] od
	group by od.OrderID
	)

select year(o.OrderDate) as "Year",
	   sum(ts.TotalPrice) as "TotalSalesPerYear"
from Orders o
join TotalSales ts on o.OrderID = ts.OrderID
group by year(o.OrderDate)
order by year(o.OrderDate) asc;

-------------------------------- Assignment ----------------------------------
-- Ví dụ
WITH bangTamThoi AS (
	SELECT [EmployeeID], [LastName], [FirstName]
	FROM [dbo].[Employees]
),
bangTamThoiSo2 AS (
	SELECT [ProductID]
	FROM [dbo].[Products]
)
SELECT *
FROM bangTamThoi;

-- Lấy thông tin về các sản phẩm (Products) có cùng thể loại với một sản phẩm cụ thể
WITH ProductCategory AS(
	SELECT [ProductName],[CategoryID]
	FROM [dbo].[Products]
	WHERE [ProductName]='Chai'
)
SELECT P.[ProductName],P.[CategoryID]
FROM [dbo].[Products] as P
JOIN ProductCategory as PC 
ON P.CategoryID=PC.CategoryID;


-- 
WITH OrderTotals AS ( 
	SELECT [OrderID], SUM([UnitPrice]*[Quantity]) AS TotalPrice
	FROM [dbo].[Order Details]
	GROUP BY [OrderID]
) 
SELECT od.[OrderID], od.[OrderDate], od.[Freight], ot.TotalPrice, ot.TotalPrice/od.Freight AS ratio
FROM [dbo].[Orders] od
JOIN OrderTotals ot ON od.OrderID=ot.OrderID;
