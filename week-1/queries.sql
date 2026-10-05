-- PHẦN 1: DATABASE

-- TẠO BẢNG LƯU THÔNG TIN CÁC CUỐN SÁCH
CREATE TABLE authors (
  au_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  au_name VARCHAR(50)
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

