SELECT p.ProductID, p.ProductName --2
FROM [dbo].[Products] p; --1

SELECT p.ProductID, p.ProductName --3
FROM [dbo].[Products] p --1
WHERE p.CategoryID = 1; --2

SELECT p.CategoryID, Count(p.ProductID) as [TotalProducts] --4
FROM [dbo].[Products] p --1
WHERE p.CategoryID IN (1,2,3) --2
GROUP BY p.CategoryID; --3


SELECT p.CategoryID, Count(p.ProductID) as [TotalProducts]
FROM [dbo].[Products] p --1
WHERE p.CategoryID IN (1,2,3) --2
GROUP BY p.CategoryID --3
HAVING [TotalProducts]>=13; --4 [TotalProducts] chua ton tai 

SELECT p.CategoryID, Count(p.ProductID) as [TotalProducts] --5
FROM [dbo].[Products] p --1
WHERE p.CategoryID IN (1,2,3) --2
GROUP BY p.CategoryID --3
HAVING Count(p.ProductID)>=13; --4 [TotalProducts] chua ton tai 


SELECT p.CategoryID, Count(p.ProductID) as [TotalProducts] --5
FROM [dbo].[Products] p --1
WHERE p.CategoryID IN (1,2,3,4,5,6,7) --2
GROUP BY p.CategoryID --3
HAVING Count(p.ProductID)>=10 --4 [TotalProducts] chua ton tai 
ORDER BY [TotalProducts] ASC; --6 [TotalProducts] da ton tai 

-------------------------- Assignment -----------------------------
SELECT TOP 3--10 
p.ProductID, o.Discount, o2.ShipCountry--8
FROM [dbo].[Products] p -- 1
INNER JOIN [dbo].[Order Details] o --2
ON p.ProductID = o.ProductID --4
INNER JOIN [dbo].[Orders] o2 --3
ON o.OrderID = o2.OrderID --5
WHERE o.Discount=0.25 and o2.ShipCountry='Germany'--6
ORDER BY p.ProductID DESC;--9