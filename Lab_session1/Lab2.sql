-- 1. TẠO VÀ CHỌN CƠ SỞ DỮ LIỆU
create database if not exists SalesDB;
use SalesDB;

-- 2. TẠO BẢNG CUSTOMERS (BẢNG CHA - PARENT TABLE)
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(255)
);
-- 3. TẠO BẢNG ORDERS (BẢNG CON - CHILD TABLE) VỚI KHÓA NGOẠI
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    CustomerID INT NOT NULL,
    -- Thiết lập ràng buộc khóa ngoại
    CONSTRAINT FK_Orders_Customers 
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);
-- 4. CHÈN DỮ LIỆU MẪU
INSERT INTO Customers (FullName, Email) 
VALUES 
    ('Nguyễn Văn An', 'an.nguyen@example.com'),
    ('Trần Thị Bình', 'binh.tran@example.com');

-- Thêm 3 đơn hàng vào bảng Orders:
-- Khách hàng ID = 1 có 2 đơn hàng, Khách hàng ID = 2 có 1 đơn hàng
INSERT INTO Orders (OrderDate, CustomerID) 
VALUES 
    ('2026-10-01 09:30:00', 1),
    ('2026-10-02 14:15:00', 1),
    ('2026-10-02 16:45:00', 2);
    
-- 5. TRUY VẤN DỮ LIỆU KẾT HỢP (JOIN) THEO YÊU CẦU
SELECT 
    Orders.OrderID AS [Mã đơn hàng],
    Orders.OrderDate AS [Ngày đặt hàng],
    Customers.FullName AS [Tên khách hàng]
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
ORDER BY Orders.OrderID ASC;