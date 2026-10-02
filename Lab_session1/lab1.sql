-- 1. Tạo cơ sở dữ liệu LibraryDB nếu chưa tồn tại
create database if not exists LibraryDB;

-- 2. Chọn cơ sở dữ liệu để thao tác
use LibraryDB;

-- 3. Tạo bảng Books với các ràng buộc theo yêu cầu
create table if not exists Books (
	BookID int auto_increment primary key,
    Title varchar(255) not null,
    Author varchar(100),
    PublishedYear int
);
-- 4. Lệnh kiểm tra lại cấu trúc bảng vừa tạo
describe Books;

-- BƯỚC 1: THÊM CÙNG LÚC 3 CUỐN SÁCH VÀO BẢNG
insert into Books (Title, Author, PublishedYear) 
values 
	('To Kill a Mockingbird', 'Harper Lee', 1960),
    ('1984', 'George Orwell', 1949), 
    ('The Great Gatsby', 'F. Scott Fitzgerald', 1925);
    
-- Đối chiếu dữ liệu ngay sau khi INSERT
select * from Books;

-- BƯỚC 2: CẬP NHẬT NĂM XUẤT BẢN THEO BOOKID
-- Xem dữ liệu của bản ghi trước khi cập nhật
select * from Books where BookID = 2;
-- Cập nhật PublishedYear của cuốn sách có BookID = 2 thành 1950
update Books 
set PublishedYear = 1959
where BookID = 2;

-- BƯỚC 3: XÓA MỘT CUỐN SÁCH CỤ THỂ KHỎI BẢNG
-- Xóa cuốn sách có BookID = 3
delete from Books
where BookID = 3;

truncate table Books;

insert into Books (Title, Author, PublishedYear) VALUES
('Lập trình C cơ bản', 'Tran Van B', 2021),
('Học máy ứng dụng', 'Nguyen Van A', 2019),
('Lập trình Web với NodeJS', 'Le Van C', 2023),
('Cấu trúc dữ liệu và giải thuật', 'Pham Van D', 2018),
('Lập trình Python nâng cao', 'Nguyen Van A', 2023),
('Trí tuệ nhân tạo', 'Nguyen Van A', 2024);

-- 1. Tìm các cuốn sách xuất bản sau năm 2020
select * from Books where PublishedYear > 2020; 
-- 2. Sách của tác giả 'Nguyen Van A' HOẶC tiêu đề bắt đầu bằng 'Lập trình'
 select * from Books where Author = 'Nguyen Van A' or Title like 'Lập trình%'; 
 -- 3. Sắp xếp giảm dần theo năm, tăng dần theo tiêu đề và giới hạn 2 bản ghi
 select * from Books order by PublishedYear desc, Title asc limit 2;
 
 -- BƯỚC 1: THÊM CỘT PRICE VÀO BẢNG
 alter table Books add column Price decimal(10,2);
 -- BƯỚC 2: NÂNG CẤP CHIỀU DÀI CỘT AUTHOR LÊN VARCHAR(255)
 alter table Books modify column Author varchar(225);
 describe Books;
 select * from Books;
 
 
 
 