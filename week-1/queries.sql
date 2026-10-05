-- PHẦN 1: DATABASE

-- TẠO BẢNG LƯU THÔNG TIN CÁC CUỐN SÁCH
CREATE TABLE authors (
  au_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  author VARCHAR(50)
);

CREATE TABLE categories (
  cat_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  category VARCHAR(50)
);

CREATE TABLE publishers (
  pub_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publisher VARCHAR(50)
);

CREATE TABLE books (
  book_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
  title VARCHAR(225),
  au_id INT,
  cat_id INT,
  pub_id INT,
  pub_year INT,
  FOREIGN KEY (au_id) REFERENCES authors(au_id),
  FOREIGN KEY (cat_id) REFERENCES categories(cat_id),
  FOREIGN KEY (pub_id) REFERENCES publishers(pub_id)
);


-- THÊM DỮ LIỆU VÀO CÁC BẢNG
-- Thêm tác giả
INSERT INTO authors (author) VALUES 
('Nguyễn Nhật Ánh'),
('J.K. Rowling'),
('Dan Brown'),
('Yuval Noah Harari'),
('Paulo Coelho'),
('Dale Carnegie'),
('Robert C. Martin');

-- Thêm chủ đề
INSERT INTO categories (category) VALUES 
('Văn học'),
('Giả tưởng'),
('Trinh thám'),
('Khoa học'),
('Triết lý'),
('Kỹ năng sống'),
('Công nghệ thông tin');

-- Thêm nhà xuất bản
INSERT INTO publishers (publisher) VALUES 
('NXB Trẻ'),
('NXB Hội Nhà Văn'),
('NXB Thế Giới'),
('NXB Văn Học'),
('NXB Tổng Hợp TP.HCM'),
('NXB Lao Động');

-- Thêm sách
INSERT INTO books (title, au_id, cat_id, pub_id, pub_year) VALUES 
('Mắt Biếc', 1, 1, 1, 2019),
('Cho Tôi Xin Một Vé Đi Tuổi Thơ', 1, 1, 1, 2008),
('Harry Potter và Hòn Đá Phù Thủy', 2, 2, 1, 2020),
('Harry Potter và Phòng Chứa Bí Mật', 2, 2, 1, 2020),
('Mật Mã Da Vinci', 3, 3, 2, 2017),
('Hỏa Ngục', 3, 3, 2, 2013),
('Sược Gốc: Lược Sử Loài Người', 4, 4, 3, 2017),
('Nhà Giả Kim', 5, 5, 4, 2020),
('Đắc Nhân Tâm', 6, 6, 5, 2016),
('Clean Code: Mã Sạch', 7, 7, 6, 2015);

-- CẬP NHẬT TÊN MỘT CUỐN SÁCH 
UPDATE books SET title = 'Ticket to Childhood'
  WHERE title = 'Cho Tôi Xin Một Vé Đi Tuổi Thơ';

/* Khi INSERT cuốn sách A với id = 11, rồi lại xoá cuốn sách đó đi, thêm một cuốn sách B thì cuốn sách B sẽ có id = 12 thay vì 11 */

-- HIỂN THỊ TOÀN BỘ CÁC CUỐN SÁCH VÀ THÔNG TIN CỦA CHÚNG...
SELECT book_id, title, author, category, publisher, pub_year FROM books 
  INNER JOIN authors ON books.au_id = authors.au_id
  INNER JOIN categories ON books.cat_id = categories.cat_id
  INNER JOIN publishers ON books.pub_id = publishers.pub_id;
