-- ROW_NUMBER: Hàm ROW_NUMBER() gán một số thứ tự duy nhất cho mỗi hàng trong kết quả dựa trên 
-- thứ tự của các hàng được xác định bởi mệnh đề ORDER BY
WITH RankedEmployees AS (
    SELECT EmployeeID, FirstName, LastName,
           ROW_NUMBER() OVER (ORDER BY Extension DESC) AS RowNumber
    FROM Employees
)
SELECT EmployeeID, FirstName, LastName, RowNumber
FROM RankedEmployees;

-- RANK: Hàm RANK() gán cùng một số thứ tự cho các hàng có giá trị giống nhau trong kết quả, 
-- và bỏ qua các số tiếp theo.
WITH RankedEmployees AS (
    SELECT EmployeeID, FirstName, LastName,
           RANK() OVER (ORDER BY Extension DESC) AS Rank
    FROM Employees
)
SELECT EmployeeID, FirstName, LastName, Rank
FROM RankedEmployees;

-- DENSE_RANK: Hàm DENSE_RANK() gán các số thứ tự cho các hàng có giá trị giống nhau trong kết quả,
-- nhưng không bỏ qua số nào.
WITH RankedEmployees AS (
    SELECT EmployeeID, FirstName, LastName,
           DENSE_RANK() OVER (ORDER BY Extension DESC) AS DenseRank
    FROM Employees
)
SELECT EmployeeID, FirstName, LastName, DenseRank
FROM RankedEmployees;

----------------------------- Assignment --------------------------------------
Use NORTHWND
-- Xep hang san pham theo gia giam dan tren toan bo table
SELECT
	[ProductID],
	[ProductName],
	[CategoryID],
	[UnitPrice],
	RANK() OVER (ORDER BY [UnitPrice] DESC) as Ranking
FROM [dbo].[Products]

-- Xep hang san pham theo gia giam dan tren the loai
SELECT
	[ProductID],
	[ProductName],
	[CategoryID],
	[UnitPrice],
	RANK() OVER (PARTITION BY [CategoryID] ORDER BY [UnitPrice] DESC) as Ranking
FROM [dbo].[Products]


-- Vi du 3
-- Tạo bảng "sinh_vien"
CREATE TABLE [sinh_vien] (
    [ma_sinh_vien] INT PRIMARY KEY,
    [ho_ten] NVARCHAR(255),
    [diem_trung_binh] DECIMAL(3, 2),
    [ma_lop_hoc] INT
);

-- Chèn 20 dòng dữ liệu thực tế vào bảng
INSERT INTO [sinh_vien] ([ma_sinh_vien], [ho_ten], [diem_trung_binh], [ma_lop_hoc])
VALUES
    (1, N'Nguyễn Văn A', 3.75, 101),
    (2, N'Trần Thị B', 3.88, 102),
    (3, N'Phạm Văn C', 3.75, 101),
    (4, N'Huỳnh Thị D', 3.92, 103),
    (5, N'Lê Văn E', 3.60, 102),
    (6, N'Ngô Thị F', 3.78, 101),
    (7, N'Trịnh Văn G', 3.65, 102),
    (8, N'Võ Thị H', 3.80, 103),
    (9, N'Đặng Văn I', 3.55, 101),
    (10, N'Hoàng Thị K', 3.95, 102),
    (11, N'Mai Thị L', 3.70, 103),
    (12, N'Lý Thị M', 3.62, 101),
    (13, N'Chu Thị N', 3.85, 102),
    (14, N'Đỗ Thị P', 3.58, 103),
    (15, N'Dương Văn Q', 3.72, 101),
    (16, N'Lâm Thị R', 3.85, 102),
    (17, N'Nguyễn Văn S', 3.68, 101),
    (18, N'Nguyễn Thị T', 3.75, 103),
    (19, N'Nguyễn Văn U', 3.93, 102),
    (20, N'Nguyễn Thị V', 3.67, 101);



-- Xếp hạng sinh viên toàn trường dựa trên điểm tb giảm dần
SELECT 
	[ma_sinh_vien],
	[ho_ten], 
	[diem_trung_binh],
	[ma_lop_hoc],
	RANK() OVER(ORDER BY [diem_trung_binh] DESC) as "xep_hang"
FROM [dbo].[sinh_vien]

-- Xếp hạng sinh viên theo từng lớp học dựa trên điểm tb giảm dần
SELECT 
  [ma_sinh_vien],
  [ho_ten],
  [diem_trung_binh],
  [ma_lop_hoc],
	Rank() OVER (PARTITION BY [ma_lop_hoc] ORDER BY [diem_trung_binh] DESC) as XepHang
FROM [dbo].[sinh_vien]

-- Xếp hạng sinh viên theo từng lớp học dựa trên điểm tb giảm dần, không nhảy hạng
SELECT 
  [ma_sinh_vien],
  [ho_ten],
  [diem_trung_binh],
  [ma_lop_hoc],
  DENSE_RANK() OVER (PARTITION BY [ma_lop_hoc] ORDER BY [diem_trung_binh] DESC) as XepHang
FROM [dbo].[sinh_vien]

-- Xếp hạng sinh viên theo từng lớp học dựa trên điểm tb giảm dần, không bị trùng hạng
SELECT 
  [ma_sinh_vien],
  [ho_ten],
  [diem_trung_binh],
  [ma_lop_hoc],
  ROW_NUMBER() OVER (PARTITION BY [ma_lop_hoc] ORDER BY [diem_trung_binh] DESC) as XepHang
FROM [dbo].[sinh_vien]

-- Chúng ta sẽ sử dụng hàm LAG() lấy thông tin về đơn đặt hàng 
-- và ngày đặt hàng của đơn đặt hàng trước đó cho mỗi khách hàng.
SELECT
	[CustomerID],
	[OrderID],
	[OrderDate],
	LAG([OrderDate]) OVER (PARTITION BY [CustomerID] ORDER BY [OrderDate] ASC) AS PreviousOrderDate
FROM [dbo].[Orders]
ORDER BY [CustomerID], [OrderDate];