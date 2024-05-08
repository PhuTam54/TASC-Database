CREATE VIEW MothlySales AS
SELECT 
  YEAR([OrderDate]) as "Year",
  MONTH([OrderDate]) as "Month",
  COUNT([OrderID]) as "Number of Orders"
FROM
  [dbo].[Orders]
GROUP BY YEAR([OrderDate]), MONTH([OrderDate]);

-- GET --
Select * from MothlySales