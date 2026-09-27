-- Bước 1: Chọn cơ sở dữ liệu classicmodels để làm việc
USE classicmodels;

-- Bước 2: Kiểm tra hiệu năng truy vấn KHI CHƯA ĐÁNH INDEX
-- Kết quả dự kiến: type = ALL (quét toàn bộ bảng), key = NULL, rows lớn
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- Bước 3: Thêm chỉ mục (Index) đơn cho cột customerName
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- Kiểm tra lại hiệu năng SAU KHI ĐÃ ĐÁNH INDEX
-- Kết quả dự kiến: type = ref, key = idx_customerName, rows = 1 (hoặc rất ít)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- Bước 4: Thêm chỉ mục phức hợp (Composite Index) cho cặp cột contactFirstName và contactLastName
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- Kiểm tra hiệu năng khi truy vấn theo cột trong chỉ mục phức hợp
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- Bước 5: Thực hành xóa chỉ mục khi không còn sử dụng
ALTER TABLE customers DROP INDEX idx_full_name;
ALTER TABLE customers DROP INDEX idx_customerName;