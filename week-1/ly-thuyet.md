# Tuần 1: Kiến thức về Cơ sở dữ liệu và Lập trình hướng đối tượng

---

## Phần 1: Database (CSDL quan hệ)

### 1. DBMS: Supabase.

### 2. SQL cơ bản
<!-- - Tạo 1 CSDL cho bài toán cụ thể (quản lý giải đấu, quản lý thư viện,...)
- DDL: CREATE TABLE, ALTER TABLE, DROP TABLE
- DML: SELECT, INSERT, UPDATE, DELETE
- Query: WHERE, JOIN (INNER, LEFT, RIGHT), GROUP BY, HAVING, ORDER BY
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX -->

- **Bài toán**: Xây dựng cơ sở dữ liệu quản lí sách trong một thư viện, bao gồm: tên sách, tác giả, chủ đề/phân loại, nhà xuất bản, năm xuất bản.



### 3. Index
**Index (chỉ mục)** là một cấu trúc dữ liệu đặc biệt đi kèm với một bảng. Nó giúp DBMS tìm kiếm và truy xuất dữ liệu trên bảng đó nhanh hơn, thay vì phải quét qua tất cả các dòng để tìm kiếm.

**Tác dụng**:
 + Tăng tốc độ truy vấn (`SELECT`) - tìm kiếm nhanh hơn.
 + Hỗ trợ tối ưu hoá `JOIN` và `ORDER BY` - kết nối các bảng nhanh hơn, sắp xếp dữ liệu không cần tốn tài nguyên sắp xếp lại từ đầu.
 + Đảm bảo tính duy nhất (`UNIQUE`/`PRIMARY KEY`) - ngăn việc trùng lặp dữ liệu.

**Nên dùng Index khi**:
 + Bảng có dung lượng lớn, có tỷ lệ đọc (`SELECT`) cao hơn nhiều so với ghi (`INSERT`/`UPDATE`).
 + Các cột thường xuyên xuất hiện trong mệnh đề `WHERE`; khoá ngoại; thường xuyên được sắp xếp (`ORDER BY`) hoặc nhóm (`GROUP BY`). 

**Không nên dùng Index khi**:
 + Bảng có kích thước quá nhỏ (khoảng vài chục dòng): Việc quét toàn bộ bảng đôi khi còn nhanh hơn đi qua Index.
 + Bảng có tần suất ghi cao: Mỗi lần dữ liệu thay đổi, index phải được tính toán và cập nhật lại, làm giảm hiệu suất ghi.
 + Các cột có độ phân tán thấp (ví dụ: `gender` - chỉ có hai giá trị `male` / `female`).

<!-- - Thực hành: tạo index, so sánh tốc độ query trước và sau khi đánh index// -->

### 4. Phân trang (Pagination)
**Phân trang**: chia lượng lớn dữ liệu ra thành các phần nhỏ khác nhau.

**Tác dụng**:
- Tối ưu hiệu suất: Giảm tải cho DB khi không phải truy xuất và truyền tải hàng triệu bản ghi qua mạng trong một câu lệnh `SELECT`.
- Tiết kiệm bộ nhớ: Giảm áp lực về RAM cho cả Server (backend) và Client (browser, app) khi xử lý và hiển thị dữ liệu.
- Tăng trải nghiệm người dùng (UX): Giao diện gọn gàng, không phải cuộn trang vô tận hoặc chờ đợi lâu để tải dữ liệu.

**Offset-based pagination: `LIMIT` + `OFFSET`**: Cách truyền thống và phổ biến nhất.

**Cursor-based pagination: `WHERE id > last_id LIMIT N`**: Phương pháp hiện đại, thường dùng cho các hệ thống lớn (Newsfeed) hoặc Infinite scroll.

**So sánh Offset-based và Cursor-based**:
|  | Offset-based | Cursor-based |
| -------- | -------- | -------- |
| **Khả năng nhảy trang** | Có (nhảy đến trang bất kỳ) | Không (chỉ hỗ trợ cont/prev) |
| **Hiệu suất với bảng lớn** | Kém (Chậm dần khi trang càng sâu) | Nhanh, ổn định |
| **Độ bền vững dữ liệu** | Dễ lệch (trùng/sót) khi có dữ liệu mới | An toàn tuyệt đối, không bị lệch |
| **Độ khó khi xây dựng** | Dễ cài đặt và tư duy | Phức tạp hơn khi triển khai |
| **Trường hợp sử dụng** | - Xây dựng trang quản trị - nơi người dùng không cần nhảy cóc đến một trang cụ thể.<br>- Quy mô dữ liệu nhỏ hoặc vừa (< vài chục nghìn dòng) | - Newsfeed, danh sách sản phẩm thương mại điện tử, Infinite Scroll<br>- Hệ thống có lượng dữ liệu lớn và yêu cầu hiệu suất tối ưu từng mili-giây. |


### 5. Locking trong Database
**Locking trong DB** dùng để kiểm soát quyền truy cập, đảm bảo tính toàn vẹn và cô lập dữ liệu.

**Optimistic Locking**: 
- **Nguyên lí**: Ít xảy ra xung đột dữ liệu &rarr; Hệ thống không khoá dữ liệu khi đọc. Thay vào đó, nó sử dụng một cột `version` hoặc `timestamp`.
- **Cách hoạt động**: `UPDATE` &rarr; Kiểm tra `version` (khớp với lúc đọc ban đầu) ? Cho phép cập nhât && `version`++ : Từ chối giao dịch && báo lỗi xung đột để người dùng thao tác lại.
  
**Pessimistic Locking**:
- **Nguyên lý**: Xung đột chắc chắn sẽ xảy ra &rarr; Hệ thống khoá ngay từ lúc đọc &rarr; Ngăn không cho bất kì thay đổi nào khác đọc hoặc sửa cho đến khi thao tác hiện tại kết thúc.

**So sánh Optimistic Locking và Pessimistic Locking**:
|  | Optimistic Locking | Pessimistic Locking |
| -------- | -------- | -------- |
| **Môi trường phù hợp** | Hệ thống có lượng đọc (`SELECT`) lớn - ghi (`UPDATE`) ít - ít khả năng tranh chấp dữ liệu cùng lúc | Hệ thống có lượng tranh chấp cao (đặt vé máy bay, chuyển khoản ngân hàng,...) |
| **Hiệu suất** | Cao (không tốn tài nguyên giữ khoá) | Thấp hơn (dễ nghẽn/chờ đợi) |
| **Trải nghiệm lỗi** | Xử lý lỗi khi có xung đột lúc lưu giữ liệu | Giao dịch sau phải chờ giao dịch trước giải phóng khoá |

<!-- - Demo: chạy 2 transaction đồng thời để thấy lock hoạt động -->

### 6. Transaction
**Transaction**: 
- Tập hợp các câu lệnh SQL thực hiện một nhóm thao tác thay đổi dữ liệu liên tiếp.
- 4 tính chất **ACID**: Atomicity, Consistency, Isolation (cô lập), Durability.

**Gom nhiều thao tác vào 1 transaction**: Khi một nghiệp vụ thực tế gồm _nhiều bước nhỏ phụ thuộc lẫn nhau_. Nếu một bước bất kỳ bị lỗi, toàn bộ các bước trước đó phải được huỷ bỏ để tránh tình trạng dữ liệu bị sai lệch (dữ liệu nữa vời).

Các lệnh điều khiển Transaction:
- `START TRANSACTION` / `BEGIN`: Bắt đầu.
- `COMMIT`: Lưu vĩnh viễn vào DB.
- `ROLLBACK`: Huỷ bỏ toàn bộ thay đổi từ lúc bắt đầu nếu có lỗi xảy ra.

  _Ví dụ_: chuyển tiền — trừ tài khoản A + cộng tài khoản B phải thành công cùng nhau, fail thì rollback cả hai

---

<!-- ## Phần 2: OOP

### 1. OOP trong Java
- Các tính chất: Encapsulation, Inheritance, Polymorphism, Abstraction
- Class, Abstract Class, Interface — khi nào dùng cái nào?

<!-- ### 2. Dependency Injection (DI) & Inversion of Control (IoC)
- Khái niệm, ví dụ bằng Java thuần (không dùng framework)
- Tại sao DI giúp code dễ test, dễ thay đổi?
- Tìm hiểu thêm: DI/IoC được ứng dụng thế nào trong Spring

---

## Output

- Trình bày lý thuyết
- Database có dữ liệu mẫu, chạy được các query (JOIN, GROUP BY)
- Demo được sự khác nhau giữa có index và không có index
- Demo được locking: chạy 2 transaction đồng thời, cho thấy lock hoạt động
-->
