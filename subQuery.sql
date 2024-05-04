-- Liet ke ra toan bo san pham
SELECT  [ProductID], [ProductName], [UnitPrice]
FROM [dbo].[Products];

-- Tim gia trung binh cua cac san pham
SELECT AVG([UnitPrice])
FROM [dbo].[Products];

-- Loc nhung san pham co gia > gia trung binh
SELECT  [ProductID], [ProductName], [UnitPrice]
FROM [dbo].[Products]
WHERE [UnitPrice] > 28.4962;

-- Sub query
SELECT  [ProductID], [ProductName], [UnitPrice]
FROM [dbo].[Products]
WHERE [UnitPrice] > (
	SELECT AVG([UnitPrice])
	FROM [dbo].[Products]
);

-- Loc ra nhung khach hang co so don hang > 10
SELECT c.CustomerID, c.CompanyName, count(o.OrderId) as [TotalOrders]
FROM [dbo].[Customers] c
LEFT JOIN [dbo].[Orders] o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING count(o.OrderId) > 10;

-- Sub query
SElECT *
FROM [dbo].[Customers]
WHERE [CustomerID] IN (
		SELECT [CustomerID]
		FROM [dbo].[Orders]
		GROUP BY [CustomerID]
		HAVING COUNT(OrderId)>10
);

-- Tinh tong tien cho tung don hang
SELECT o.*, (
		SELECT SUM(od.Quantity*od.UnitPrice)
		FROM [dbo].[Order Details] od
		WHERE o.OrderID = od.OrderID
	) AS [Total]
FROM [dbo].[Orders] o;


-- Loc ra ten san pham va tong so don hang cua san pham
SELECT ProductName, TotalOrders
FROM 
	(SELECT p.ProductID, p.ProductName, (
				SELECT COUNT(*)
				FROM [dbo].[Order Details] od
				WHERE od.ProductID = p.ProductID
			) as [TotalOrders]
	FROM [dbo].[Products] p) AS Temp;

-- Assignment
-- Liet ke cac don hang co 
-- ngay dat hang gan nhat
SELECT * 
FROM [dbo].[Orders] o
WHERE o.OrderDate = (
	SELECT MAX([OrderDate])
	FROM [dbo].[Orders]
);

-- Liệt kê tất cả các sản phẩm (ProductName)
-- mà không có đơn đặt hàng nào đặt mua chúng.
SELECT *
FROM [dbo].[Products] p
WHERE p.ProductID NOT IN (
	SELECT DISTINCT [ProductID]
	FROM [dbo].[Order Details]
);

-- Lấy thông tin về các đơn hàng, và tên các sản phẩm 
-- thuộc các đơn hàng chưa được giao cho khách.
SELECT o.OrderID, p.ProductName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN [dbo].[Products] p
ON od.ProductID = p.ProductID
WHERE o.OrderID IN (
			SELECT [OrderID]
			FROM [dbo].[Orders]
			WHERE [ShippedDate] IS NULL);

-- Lấy thông tin về các sản phẩm có số lượng tồn kho 
--- ít hơn số lượng tồn kho trung bình của tất cả các sản phẩm
SELECT *
FROM [dbo].[Products] p
WHERE p.UnitsInStock>(
	SELECT AVG([UnitsInStock])
	FROM [dbo].[Products]);

----------------- Assignment ---------------------
-- Lấy thông tin về các khách hàng có tổng giá trị đơn hàng lớn nhất
SELECT c.*
FROM [dbo].[Customers] c
WHERE [CustomerID] = (
    SELECT TOP 1 [CustomerID]
    FROM (
        SELECT o.CustomerID, SUM(od.Quantity * od.UnitPrice) AS TotalPrice
        FROM [dbo].[Orders] o
        JOIN [dbo].[Order Details] od ON o.OrderID = od.OrderID
        GROUP BY o.CustomerID
    ) AS SubQuery
	ORDER BY TotalPrice DESC
);
