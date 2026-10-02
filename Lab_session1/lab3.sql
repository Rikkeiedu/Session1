-- 1. Tạo cơ sở dữ liệu quanly_sinhvien (sử dụng bảng mã utf8mb4 hỗ trợ tiếng Việt đầy đủ)
CREATE DATABASE IF NOT EXISTS quanly_sinhvien
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 2. Chỉ định sử dụng cơ sở dữ liệu vừa tạo
USE quanly_sinhvien;

-- 3. Tạo bảng sinh_vien với các cột, kiểu dữ liệu và ràng buộc phù hợp
CREATE TABLE IF NOT EXISTS sinh_vien (
    id INT AUTO_INCREMENT PRIMARY KEY,          -- Khóa chính, tự động tăng giá trị
    ho_ten VARCHAR(100) NOT NULL,               -- Chuỗi tối đa 100 ký tự, không được để trống
    ngay_sinh DATE,                             -- Kiểu ngày (YYYY-MM-DD)
    diem_gpa DECIMAL(3, 2),                     -- Điểm số thực (tối đa 3 chữ số, 2 số thập phân: ví dụ 3.85, 4.00)
    CONSTRAINT chk_gpa CHECK (diem_gpa >= 0.0 AND diem_gpa <= 4.0) -- Ràng buộc điểm hợp lệ theo thang 4
);

-- 4. Lệnh kiểm tra lại cấu trúc bảng sau khi tạo
DESCRIBE sinh_vien;



USE quanly_sinhvien;

-- ========================================================
-- 1. CHÈN 1 DÒNG DỮ LIỆU ĐƠN LẺ
-- ========================================================
-- Bỏ qua cột id vì đây là cột AUTO_INCREMENT (MySQL tự sinh giá trị)
INSERT INTO sinh_vien (ho_ten, ngay_sinh, diem_gpa)
VALUES ('Nguyễn Văn An', '2004-05-15', 3.45);


-- ========================================================
-- 2. CHÈN CÙNG LÚC NHIỀU DÒNG (5 DÒNG) BẰNG 1 CÂU LỆNH
-- ========================================================
-- Các bộ giá trị phân tách nhau bởi dấu phẩy, kết thúc lệnh bằng dấu chấm phẩy
INSERT INTO sinh_vien (ho_ten, ngay_sinh, diem_gpa)
VALUES 
    ('Trần Thị Bích', '2004-11-20', 3.75),
    ('Lê Hoàng Nam',  '2003-08-10', 2.90),
    ('Phạm Thu Trang', '2004-02-28', 3.92),
    ('Đỗ Minh Quân',  '2003-12-05', 3.10),
    ('Vũ Hải Yến',    '2004-09-18', 3.65);


-- ========================================================
-- 3. KIỂM TRA TOÀN BỘ BẢNG DỮ LIỆU VỪA CHÈN
-- ========================================================
SELECT * FROM sinh_vien;

USE quanly_sinhvien;

-- ========================================================
-- BƯỚC 0: KIỂM TRA TRẠNG THÁI BAN ĐẦU
-- ========================================================
-- 1. Xem cấu trúc ban đầu
DESCRIBE sinh_vien;

-- 2. Xem dữ liệu hiện có (6 bản ghi từ Bài 2)
SELECT * FROM sinh_vien;


-- ========================================================
-- BƯỚC 1: THÊM CỘT email (KIỂU CHUỖI)
-- ========================================================
-- Thêm cột email kiểu VARCHAR(100) vào sau cột ho_ten (hoặc cuối bảng)
ALTER TABLE sinh_vien 
ADD COLUMN email VARCHAR(100);

-- Kiểm tra lại cấu trúc: xuất hiện thêm trường email (Null: YES, Default: NULL)
DESCRIBE sinh_vien;

-- Kiểm tra dữ liệu: tất cả các dòng cũ sẽ tự động nhận giá trị NULL ở cột email
SELECT * FROM sinh_vien;


-- ========================================================
-- BƯỚC 2: ĐỔI KIỂU DỮ LIỆU CỘT diem_gpa (MODIFY COLUMN)
-- ========================================================
-- Chuyển từ DECIMAL(3, 2) sang FLOAT (hoặc DECIMAL(4, 2) để tương thích thang điểm rộng hơn)
-- Khi MODIFY, cần viết lại đầy đủ tên cột và kiểu mới
ALTER TABLE sinh_vien 
MODIFY COLUMN diem_gpa FLOAT;

-- Kiểm tra lại cấu trúc: Type của diem_gpa đổi thành float
DESCRIBE sinh_vien;

-- Kiểm tra dữ liệu: các giá trị GPA cũ (3.45, 3.75, 3.92,...) vẫn nguyên vẹn
SELECT * FROM sinh_vien;


-- ========================================================
-- BƯỚC 3: XÓA CỘT KHÔNG CẦN THIẾT (DROP COLUMN)
-- ========================================================
-- Xóa vĩnh viễn cột ngay_sinh khỏi bảng
ALTER TABLE sinh_vien 
DROP COLUMN ngay_sinh;

-- Kiểm tra lại cấu trúc: cột ngay_sinh đã biến mất hoàn toàn
DESCRIBE sinh_vien;

-- Kiểm tra dữ liệu cuối cùng: các cột còn lại giữ nguyên vẹn, mất cột ngay_sinh
SELECT * FROM sinh_vien;

-- ========================================================
-- YÊU CẦU 1: CHỌN CỘT CỤ THỂ VÀ ĐẶT BÍ DANH (ALIAS VỚI AS)
-- ========================================================
-- Lấy các cột cần thiết và đổi tên hiển thị tiếng Việt có dấu
SELECT 
    id AS 'Mã sinh viên',
    ho_ten AS 'Họ và tên',
    diem_gpa AS 'Điểm GPA'
FROM sinh_vien;


-- ========================================================
-- YÊU CẦU 2: LỌC DỮ LIỆU BẰNG TOÁN TỬ SO SÁNH VÀ LOGIC (AND/OR)
-- ========================================================
-- Tìm sinh viên có học lực Giỏi/Xuất sắc (GPA >= 3.6) HOẶC đạt mức Khá giỏi nhưng có mã id nhỏ hơn 3
SELECT 
    id, 
    ho_ten, 
    diem_gpa
FROM sinh_vien
WHERE diem_gpa >= 3.6 
   OR (diem_gpa >= 3.2 AND id < 3);


-- ========================================================
-- YÊU CẦU 3: TÌM KIẾM GẦN ĐÚNG BẰNG TOÁN TỬ LIKE VÀ KÝ TỰ %
-- ========================================================
-- 1. Tìm tất cả sinh viên mang họ 'Nguyễn' (bắt đầu bằng chuỗi 'Nguyễn')
SELECT id, ho_ten, diem_gpa
FROM sinh_vien
WHERE ho_ten LIKE 'Nguyễn%';

-- 2. Tìm tất cả sinh viên có tên hoặc tên đệm chứa chữ 'Thu' (xuất hiện ở bất kỳ vị trí nào)
SELECT id, ho_ten, diem_gpa
FROM sinh_vien
WHERE ho_ten LIKE '%Thu%';


-- ========================================================
-- YÊU CẦU 4: SẮP XẾP GIẢM DẦN VÀ GIỚI HẠN SỐ BẢN GHI (TOP 3 GPA)
-- ========================================================
-- Sắp xếp sinh viên có GPA cao nhất xuống thấp dần và chỉ lấy 3 người dẫn đầu
SELECT 
    id, 
    ho_ten, 
    diem_gpa
FROM sinh_vien
ORDER BY diem_gpa DESC
LIMIT 3;

- 1.1. BẮT BUỘC: Kiểm tra đúng bản ghi mục tiêu trước khi sửa
SELECT id, ho_ten, email 
FROM sinh_vien 
WHERE id = 1;

-- 1.2. Thực hiện cập nhật email cho sinh viên có id = 1
UPDATE sinh_vien 
SET email = 'an.nguyen@email.com' 
WHERE id = 1;

-- 1.3. Đối chiếu lại kết quả sau khi cập nhật
SELECT id, ho_ten, email 
FROM sinh_vien 
WHERE id = 1;


-- =============================================================================
-- BƯỚC 2: XÓA (DELETE) MỘT BẢN GHI CỤ THỂ DỰA VÀO KHÓA CHÍNH (id)
-- =============================================================================

-- 2.1. Kiểm tra chính xác sinh viên sắp bị xóa (ví dụ: id = 5)
SELECT id, ho_ten, diem_gpa 
FROM sinh_vien 
WHERE id = 5;

-- 2.2. Tiến hành xóa bản ghi id = 5
DELETE FROM sinh_vien 
WHERE id = 5;

-- 2.3. Kiểm tra lại để xác nhận bản ghi đã không còn tồn tại
SELECT id, ho_ten 
FROM sinh_vien 
WHERE id = 5;


-- =============================================================================
-- BƯỚC 3: XÓA (DELETE) NHIỀU BẢN GHI THEO ĐIỀU KIỆN (GPA DƯỚI NGƯỠNG)
-- =============================================================================

-- 3.1. Rà soát danh sách tất cả sinh viên có điểm GPA < 3.00 trước khi xóa
SELECT id, ho_ten, diem_gpa 
FROM sinh_vien 
WHERE diem_gpa < 3.00;

-- 3.2. Thực thi xóa hàng loạt các sinh viên thỏa mãn điều kiện
DELETE FROM sinh_vien 
WHERE diem_gpa < 3.00;

-- 3.3. Kiểm tra lại điều kiện lọc (kết quả trả về phải rỗng)
SELECT id, ho_ten, diem_gpa 
FROM sinh_vien 
WHERE diem_gpa < 3.00;

-- 3.4. Xem toàn bộ bảng dữ liệu hiện tại sau tất cả thao tác
SELECT * FROM sinh_vien;