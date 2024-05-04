--Sử dụng INNER JOIN
--Từ bảng Products và Categories, hãy in ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Mã sản phẩm
--Tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;


--Sử dụng INNER JOIN
--Từ bảng Products và Categories, hãy đưa ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Số lượng sản phẩm
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) as ProductCount
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

--Sử dụng INNER JOIN, hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên công ty khách hàng
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

--Sử dụng INNER JOIN, LEFT JOIN
--Từ bảng Products và Categories, hãy đưa ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
LEFT JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID)
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID)
FROM [dbo].[Categories] c
LEFT JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;


--Sử dụng RIGHT JOIN, hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên công ty khách hàng
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

SELECT  c.CompanyName, COUNT(o.OrderID)
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

SELECT  c.CompanyName, COUNT(o.OrderID)
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

--Sử dụng FULL OUTER JOIN
--Từ bảng Products và Categories, hãy in ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Mã sản phẩm
--Tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
FULL JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

-- Assignment 
-- Bài tập 1 (INNER JOIN): Liệt kê tên sản phẩm và tên nhà cung cấp
-- của các sản phẩm đã được đặt hàng trong bảng "Order Details". 
-- Sử dụng INNER JOIN để kết hợp bảng "Order Details" với các bảng 
-- liên quan để lấy thông tin sản phẩm và nhà cung cấp.
SELECT DISTINCT od.ProductID, p.ProductName, s.CompanyName
FROM [dbo].[Order Details] od
INNER JOIN [dbo].[Products] p
ON od.ProductID = p.ProductID
INNER JOIN [dbo].[Suppliers] s
ON p.SupplierID = s.SupplierID;

-- Bài tập 2 (LEFT JOIN): Liệt kê tên khách hàng và tên 
-- nhân viên phụ trách của các đơn hàng trong bảng "Orders". 
-- Bao gồm cả các đơn hàng không có nhân viên phụ trách.
-- Sử dụng LEFT JOIN để kết hợp bảng "Orders" với bảng "Employees" 
-- để lấy thông tin về khách hàng và nhân viên phụ trách.
SELECT o.OrderID, e.FirstName, e.LastName, c.CompanyName
FROM [dbo].[Orders] o
LEFT JOIN [dbo].[Employees] e
ON o.EmployeeID = e.EmployeeID
LEFT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

-- Bài tập 3 (RIGHT JOIN):
SELECT o.OrderID, e.FirstName, e.LastName, c.CompanyName
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Employees] e
ON o.EmployeeID = e.EmployeeID
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

-- Bai tap 4:
-- Bài tập 4 (FULL JOIN): Liệt kê tên danh mục và tên 
-- nhà cung cấp của các sản phẩm trong bảng "Products". 
-- Bao gồm cả các danh mục và nhà cung cấp không có sản phẩm. 
-- Sử dụng FULL JOIN hoặc kết hợp LEFT JOIN và RIGHT JOIN để lấy  
-- thông tin về danh mục và nhà cung cấp.
SELECT p.ProductID, p.ProductName, s.CompanyName, c.CategoryName
FROM [dbo].[Products] p
FULL JOIN [dbo].[Suppliers] s
ON p.SupplierID = s.SupplierID
FULL JOIN [dbo].[Categories] c
ON p.CategoryID = c.CategoryID;