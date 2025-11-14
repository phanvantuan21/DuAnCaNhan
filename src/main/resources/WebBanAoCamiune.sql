-- =============================================
--  TẠO DATABASE web bán hàng camiune
-- =============================================
CREATE DATABASE WebBanAoCamiune;
GO
USE WebBanAoCamiune;
GO

-- =============================================
--  DANH MỤC CƠ BẢN
-- =============================================

CREATE TABLE VaiTro (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_vai_tro NVARCHAR(50) NOT NULL
);

CREATE TABLE ThuongHieu (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_thuong_hieu NVARCHAR(100) NOT NULL,
    mo_ta NVARCHAR(255)
);

CREATE TABLE ChatLieu (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_chat_lieu NVARCHAR(100) NOT NULL
);

CREATE TABLE DanhMuc (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_danh_muc NVARCHAR(100) NOT NULL
);

CREATE TABLE MauSac (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_mau NVARCHAR(50) NOT NULL
);

CREATE TABLE KichThuoc (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_kich_thuoc NVARCHAR(20) NOT NULL
);

-- =============================================
--  TÀI KHOẢN & NGƯỜI DÙNG
-- =============================================

CREATE TABLE TaiKhoan (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_dang_nhap NVARCHAR(100) UNIQUE NOT NULL,
    mat_khau NVARCHAR(255) NOT NULL,
    email NVARCHAR(255),
    so_dien_thoai NVARCHAR(20),
    id_vai_tro INT NOT NULL,
    trang_thai BIT DEFAULT 1,
    FOREIGN KEY (id_vai_tro) REFERENCES VaiTro(id)
);

CREATE TABLE KhachHang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_khach_hang NVARCHAR(100) NOT NULL,
    ngay_sinh DATE,
    gioi_tinh BIT,
    so_dien_thoai NVARCHAR(20),
    email NVARCHAR(255),
    id_tai_khoan INT,
    FOREIGN KEY (id_tai_khoan) REFERENCES TaiKhoan(id)
);

CREATE TABLE NhanVien (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_nhan_vien NVARCHAR(100) NOT NULL,
    ma_nv NVARCHAR(50),
    so_dien_thoai NVARCHAR(20),
    email NVARCHAR(255),
    id_tai_khoan INT,
    FOREIGN KEY (id_tai_khoan) REFERENCES TaiKhoan(id)
);

-- =============================================
--  SẢN PHẨM
-- =============================================

CREATE TABLE SanPham (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ma_san_pham NVARCHAR(50) UNIQUE NOT NULL,
    ten_san_pham NVARCHAR(255) NOT NULL,
    mo_ta NVARCHAR(MAX),
    id_danh_muc INT,
    id_thuong_hieu INT,
    id_chat_lieu INT,
    trang_thai BIT DEFAULT 1,
    FOREIGN KEY (id_danh_muc) REFERENCES DanhMuc(id),
    FOREIGN KEY (id_thuong_hieu) REFERENCES ThuongHieu(id),
    FOREIGN KEY (id_chat_lieu) REFERENCES ChatLieu(id)
);

CREATE TABLE SanPhamChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_san_pham INT NOT NULL,
    id_mau_sac INT NOT NULL,
    id_kich_thuoc INT NOT NULL,
    so_luong INT DEFAULT 0,
    gia DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (id_san_pham) REFERENCES SanPham(id),
    FOREIGN KEY (id_mau_sac) REFERENCES MauSac(id),
    FOREIGN KEY (id_kich_thuoc) REFERENCES KichThuoc(id)
);

CREATE TABLE AnhSanPham (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_san_pham_chi_tiet INT NOT NULL,
    link_anh NVARCHAR(255),
    FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES SanPhamChiTiet(id)
);

-- =============================================
--  GIỎ HÀNG
-- =============================================

CREATE TABLE GioHang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_khach_hang INT NOT NULL,
    ngay_tao DATETIME2 DEFAULT SYSDATETIME(),
    trang_thai BIT DEFAULT 1,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

CREATE TABLE GioHangChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_gio_hang INT NOT NULL,
    id_san_pham_chi_tiet INT NOT NULL,
    so_luong INT DEFAULT 1,
    FOREIGN KEY (id_gio_hang) REFERENCES GioHang(id),
    FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES SanPhamChiTiet(id)
);

-- =============================================
--  HÓA ĐƠN
-- =============================================

CREATE TABLE TrangThaiHoaDon (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_trang_thai NVARCHAR(50)
);

CREATE TABLE HoaDon (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ma_hoa_don NVARCHAR(50) UNIQUE NOT NULL,
    id_khach_hang INT,
    id_nhan_vien INT,
    tong_tien DECIMAL(18,2),
    ngay_tao DATETIME2 DEFAULT SYSDATETIME(),
    id_trang_thai INT,
    loai_hoa_don NVARCHAR(20) CHECK (loai_hoa_don IN ('Online','TaiQuay')),
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id),
    FOREIGN KEY (id_trang_thai) REFERENCES TrangThaiHoaDon(id)
);

CREATE TABLE HoaDonChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_hoa_don INT NOT NULL,
    id_san_pham_chi_tiet INT NOT NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id),
    FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES SanPhamChiTiet(id)
);

CREATE TABLE LSHoaDon (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_hoa_don INT NOT NULL,
    hanh_dong NVARCHAR(100),
    ngay_thuc_hien DATETIME2 DEFAULT SYSDATETIME(),
    id_nhan_vien INT,
    ghi_chu NVARCHAR(255),
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id)
);

-- =============================================
--  THANH TOÁN & VOUCHER
-- =============================================

CREATE TABLE HinhThucThanhToan (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_hinh_thuc NVARCHAR(100)
);

CREATE TABLE ThanhToan (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_hoa_don INT NOT NULL,
    id_hinh_thuc INT NOT NULL,
    so_tien DECIMAL(18,2) NOT NULL,
    ngay_thanh_toan DATETIME2 DEFAULT SYSDATETIME(),
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id),
    FOREIGN KEY (id_hinh_thuc) REFERENCES HinhThucThanhToan(id)
);

CREATE TABLE Voucher (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ma_voucher NVARCHAR(50) UNIQUE NOT NULL,
    ten_voucher NVARCHAR(100),
    giam_gia DECIMAL(5,2),
    ngay_bat_dau DATETIME2,
    ngay_ket_thuc DATETIME2,
    trang_thai BIT DEFAULT 1
);

CREATE TABLE SanPhamGiamGia (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_san_pham INT NOT NULL,
    id_voucher INT NOT NULL,
    FOREIGN KEY (id_san_pham) REFERENCES SanPham(id),
    FOREIGN KEY (id_voucher) REFERENCES Voucher(id)
);

-- =============================================
--  ĐỊA CHỈ
-- =============================================

CREATE TABLE DiaChiKhachHang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_khach_hang INT NOT NULL,
    dia_chi NVARCHAR(255),
    phuong_xa NVARCHAR(100),
    quan_huyen NVARCHAR(100),
    tinh_thanh NVARCHAR(100),
    mac_dinh BIT DEFAULT 0,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);


--Insert dữ liệu

INSERT INTO VaiTro (ten_vai_tro) VALUES 
(N'Admin'),
(N'Nhân viên'),
(N'Khách hàng');

-- Tài khoản
INSERT INTO TaiKhoan (ten_dang_nhap, mat_khau, email, so_dien_thoai, id_vai_tro, trang_thai)
VALUES 
('admin', '123456', 'admin@web.com', '0900000001', 1, 1),
('nhanvien1', '123456', 'nv1@web.com', '0900000002', 2, 1),
('khach1', '123456', 'kh1@web.com', '0900000003', 3, 1);

-- Nhân viên
INSERT INTO NhanVien (ten_nhan_vien, ma_nv, so_dien_thoai, email, id_tai_khoan)
VALUES 
(N'Nguyễn Văn A', 'NV001', '0900000002', 'nv1@web.com', 2);

-- Khách hàng
INSERT INTO KhachHang (ten_khach_hang, ngay_sinh, gioi_tinh, so_dien_thoai, email, id_tai_khoan)
VALUES 
(N'Lê Thị B', '2000-02-20', 0, '0900000003', 'kh1@web.com', 3);

-- Danh mục
INSERT INTO DanhMuc (ten_danh_muc) VALUES 
(N'Áo thun'),
(N'Áo sơ mi'),
(N'Áo khoác');

-- Thương hiệu
INSERT INTO ThuongHieu (ten_thuong_hieu, mo_ta) VALUES
(N'CoolMate', N'Thương hiệu thời trang nam Việt Nam'),
(N'Routine', N'Thời trang công sở nam');

-- Chất liệu
INSERT INTO ChatLieu (ten_chat_lieu) VALUES
(N'Cotton'),
(N'Polyester'),
(N'Vải thun lạnh');

-- Màu sắc
INSERT INTO MauSac (ten_mau) VALUES 
(N'Trắng'),
(N'Đen'),
(N'Xanh');

-- Kích thước
INSERT INTO KichThuoc (ten_kich_thuoc) VALUES
(N'S'),
(N'M'),
(N'L'),
(N'XL');

-- Sản phẩm
INSERT INTO SanPham (ma_san_pham, ten_san_pham, mo_ta, id_danh_muc, id_thuong_hieu, id_chat_lieu, trang_thai)
VALUES
('SP001', N'Áo thun nam trơn trắng', N'Áo thun cotton thoáng mát', 1, 1, 1, 1),
('SP002', N'Áo sơ mi nam đen tay dài', N'Sơ mi đen công sở lịch lãm', 2, 2, 2, 1);

-- Sản phẩm chi tiết
INSERT INTO SanPhamChiTiet (id_san_pham, id_mau_sac, id_kich_thuoc, so_luong, gia)
VALUES
(1, 1, 2, 50, 150000),
(1, 2, 3, 30, 150000),
(2, 2, 3, 40, 250000);

-- Ảnh sản phẩm
INSERT INTO AnhSanPham (id_san_pham_chi_tiet, link_anh) VALUES
(1, N'ao_thun_trang.jpg'),
(2, N'ao_thun_den.jpg'),
(3, N'so_mi_den.jpg');

-- Giỏ hàng
INSERT INTO GioHang (id_khach_hang, ngay_tao, trang_thai)
VALUES (1, SYSDATETIME(), 1);

-- Giỏ hàng chi tiết
INSERT INTO GioHangChiTiet (id_gio_hang, id_san_pham_chi_tiet, so_luong)
VALUES
(1, 1, 2),
(1, 3, 1);

-- Trạng thái hóa đơn
INSERT INTO TrangThaiHoaDon (ten_trang_thai) VALUES
(N'Chờ thanh toán'),
(N'Đã thanh toán'),
(N'Đang giao hàng'),
(N'Hoàn tất'),
(N'Hủy');

-- Hóa đơn
INSERT INTO HoaDon (ma_hoa_don, id_khach_hang, id_nhan_vien, tong_tien, id_trang_thai, loai_hoa_don)
VALUES
('HD001', 1, 1, 450000, 2, 'Online'),
('HD002', 1, 1, 300000, 1, 'TaiQuay');

-- Hóa đơn chi tiết
INSERT INTO HoaDonChiTiet (id_hoa_don, id_san_pham_chi_tiet, so_luong, don_gia)
VALUES
(1, 1, 2, 150000),
(1, 3, 1, 150000),
(2, 2, 2, 150000);

-- Lịch sử hóa đơn
INSERT INTO LSHoaDon (id_hoa_don, hanh_dong, id_nhan_vien, ghi_chu)
VALUES
(1, N'Tạo hóa đơn', 1, N'Hóa đơn online'),
(1, N'Thanh toán', 1, N'Thanh toán thành công'),
(2, N'Tạo hóa đơn tại quầy', 1, N'Khách thanh toán sau');

-- Hình thức thanh toán
INSERT INTO HinhThucThanhToan (ten_hinh_thuc) VALUES
(N'Tiền mặt'),
(N'Chuyển khoản'),
(N'Ví điện tử');

-- Thanh toán
INSERT INTO ThanhToan (id_hoa_don, id_hinh_thuc, so_tien)
VALUES
(1, 1, 450000),
(2, 2, 300000);

-- Voucher
INSERT INTO Voucher (ma_voucher, ten_voucher, giam_gia, ngay_bat_dau, ngay_ket_thuc)
VALUES
('SALE10', N'Giảm 10%', 10, '2025-01-01', '2025-12-31'),
('FREESHIP', N'Miễn phí vận chuyển', 0, '2025-01-01', '2025-12-31');

-- Sản phẩm giảm giá
INSERT INTO SanPhamGiamGia (id_san_pham, id_voucher)
VALUES
(1, 1),
(2, 2);

-- Địa chỉ khách hàng
INSERT INTO DiaChiKhachHang (id_khach_hang, dia_chi, phuong_xa, quan_huyen, tinh_thanh, mac_dinh)
VALUES
(1, N'123 Nguyễn Trãi', N'Phường 5', N'Quận 5', N'TP. Hồ Chí Minh', 1);

