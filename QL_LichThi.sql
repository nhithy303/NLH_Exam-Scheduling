﻿CREATE DATABASE QL_LichThi
go
USE QL_LichThi
go
CREATE TABLE KyThi
(
	NamHoc		VARCHAR (20),
	HocKy		INTEGER			CHECK (HocKy in (1, 2, 3)),
	NgayBatDau	DATE,
	NgayKetThuc	DATE,
	CONSTRAINT PK_KyThi PRIMARY KEY (NamHoc, HocKy)
)
go
CREATE TABLE Khoa
(
	MaKhoa		VARCHAR (20)	CONSTRAINT PK_Khoa PRIMARY KEY,
	TenKhoa		NVARCHAR (100)	UNIQUE
)
go
CREATE TABLE SinhVien
(
	MSSV		VARCHAR (20)	CONSTRAINT PK_SinhVien PRIMARY KEY,
	HoSV		NVARCHAR (100)	NOT NULL,
	TenSV		NVARCHAR (20)	NOT NULL,
	NgaySinh	DATE			CHECK (YEAR(GETDATE()) - YEAR(NgaySinh) >= 18),
	GioiTinh	NVARCHAR(4)		CHECK (GioiTinh IN(N'Nam', N'Nữ')),
	MaKhoa		VARCHAR (20)	CONSTRAINT FK_SinhVien FOREIGN KEY REFERENCES Khoa(MaKhoa)
)
go
-- TenDangNhap = MSSV (except admin)
CREATE TABLE TaiKhoan
(
	TenDangNhap	VARCHAR (20)	CONSTRAINT PK_TaiKhoan PRIMARY KEY,
	MatKhau		VARCHAR (20)	NOT NULL,
	QuanTriVien	INTEGER			CHECK (QuanTriVien IN (0, 1)) DEFAULT (0)
)
go
CREATE TABLE CaThi
(
	MaCa		VARCHAR (20)	CONSTRAINT PK_CaThi PRIMARY KEY,
	NgayThi		DATE,
	BuoiThi		NVARCHAR (10)	CHECK (BuoiThi IN(N'Sáng', N'Chiều'))
)
go
CREATE TABLE MonThi
(
	MaMon		VARCHAR (20)	CONSTRAINT PK_MonThi PRIMARY KEY,
	TenMon		NVARCHAR (100)	NOT NULL,
	SoLuongSV	INTEGER,
	SoPhong		INTEGER,
	MaCa		VARCHAR (20)	CONSTRAINT FK_MonThi FOREIGN KEY REFERENCES CaThi(MaCa)
)
go
CREATE TABLE PhongThi
(
	MaPhong		VARCHAR (20)	CONSTRAINT PK_PhongThi PRIMARY KEY,
	SucChua		INTEGER			CONSTRAINT DF_PhongThi DEFAULT (25)
)
go
CREATE TABLE PhanBoPhongThi
(
	MaMon		VARCHAR (20)	CONSTRAINT FK_PhanBoPhongThi_MaMon FOREIGN KEY REFERENCES MonThi(MaMon),
	MaPhong		VARCHAR (20)	CONSTRAINT FK_PhanBoPhongThi_MaPhong FOREIGN KEY REFERENCES PhongThi(MaPhong),
	CONSTRAINT PK_PhanBoPhongThi PRIMARY KEY (MaMon, MaPhong)
)
go
CREATE TABLE ThamGiaThi
(
	MSSV		VARCHAR (20)	CONSTRAINT FK_ThamGiaThi_MSSV FOREIGN KEY REFERENCES SinhVien(MSSV),
	MaMon		VARCHAR (20)	CONSTRAINT FK_ThamGiaThi_MaMon FOREIGN KEY REFERENCES MonThi(MaMon),
	MaPhong		VARCHAR (20)	CONSTRAINT FK_ThamGiaThi_MaPhong FOREIGN KEY REFERENCES PhongThi(MaPhong),
	CONSTRAINT PK_ThamGiaThi PRIMARY KEY (MSSV, MaMon)
)

-- NHẬP DỮ LIỆU Khoa
INSERT INTO Khoa VALUES
	('COMP', N'Công nghệ Thông tin'),
	('GEOG', N'Địa lý'),
	('POLI', N'Giáo dục Chính trị'),
	('SPEC', N'Giáo dục Đặc biệt'),
	('EARC', N'Giáo dục Mầm non'),
	('PHYL', N'Giáo dục Thể chất'),
	('PRIM', N'Giáo dục Tiểu học'),
	('CHEM', N'Hóa học'),
	('EDUC', N'Khoa học Giáo dục'),
	('HIST', N'Lịch sử'),
	('LITR', N'Ngữ văn'),
	('BIOL', N'Sinh học'),
	('PSYC', N'Tâm lý học'),
	('ENGL', N'Tiếng Anh'),
	('KORE', N'Tiếng Hàn Quốc'),
	('RUSS', N'Tiếng Nga'),
	('JAPN', N'Tiếng Nhật'),
	('FRAN', N'Tiếng Pháp'),
	('CHIN', N'Tiếng Trung'),
	('MATH', N'Toán - Tin học'),
	('PHYS', N'Vật lý')

-- NHẬP DỮ LIỆU SinhVien
INSERT INTO SinhVien VALUES
	('47.01.104.040',N'Nguyễn Khánh',N'An','2003-05-29',N'Nữ','COMP'),
	('47.01.104.122',N'Ngô Thị Yến',N'Linh','2003-08-17',N'Nữ','COMP'),
	('47.01.104.096',N'Hoàng Thụy Quỳnh',N'Hương','2003-05-01',N'Nữ','COMP'),
	('47.01.104.152',N'Trần Hoàng Yến',N'Nhi','2003-03-30',N'Nữ','COMP'),
	('47.01.104.146',N'Lê Phú',N'Nhân','2003-01-24',N'Nam','COMP'),
	('47.01.103.033',N'Lê Huỳnh',N'Đức','2003-03-04',N'Nam','COMP'),
	('47.01.103.064',N'Nguyễn Cẩm',N'Ly','2003-06-20',N'Nữ','COMP'),
	('47.01.103.072',N'Huỳnh Trọng',N'Nghĩa','2003-09-05',N'Nam','COMP'),
	('47.01.103.079',N'Nguyễn Tấn',N'Phát','2003-10-08',N'Nam','COMP'),
	('47.01.103.100',N'Nguyễn Lâm Trúc',N'Trúc','2003-05-20',N'Nữ','COMP'),
	('47.01.101.111',N'Trần Hồ Nhựt',N'Phát','2003-10-15',N'Nam','MATH'),
	('47.01.101.001',N'Lương Thị Phương',N'An','2003-01-01',N'Nữ','MATH'),
	('47.01.101.013',N'Nguyễn Thái',N'Hưng','2003-04-07',N'Nam','MATH'),
	('47.01.101.032',N'Cáp Ngọc Bảo',N'Phương','2003-12-12',N'Nữ','MATH'),
	('47.01.101.048',N'Lương Minh',N'Triết','2003-05-01',N'Nam','MATH'),
	('47.01.101.055',N'Lâm Tường',N'Vy','2003-08-18',N'Nữ','MATH'),
	('47.01.101.086',N'Lê Tuấn',N'Khải','2003-09-08',N'Nam','MATH'),
	('47.01.101.075',N'Châu Cẩm',N'Hào','2003-03-06',N'Nam','MATH'),
	('47.01.101.119',N'Nguyễn Thị Mỹ',N'Quyên','2003-07-07',N'Nữ','MATH'),
	('47.01.101.130',N'Nguyễn Thị Anh',N'Thư','2003-12-11',N'Nữ','MATH'),
	('47.01.102.007',N'Đàm Mỹ',N'Hoa','2003-11-14',N'Nữ','PHYS'),
	('47.01.102.053',N'Lê Nguyễn Ngọc',N'Duy','2003-10-10',N'Nam','PHYS'),
	('47.01.102.047',N'Nguyễn Huỳnh',N'Biểu','2003-04-23',N'Nam','PHYS'),
	('47.01.102.055',N'Lê Thị Ngọc',N'Hà','2003-11-29',N'Nữ','PHYS'),
	('47.01.102.088',N'Trần Nhật',N'Nam','2003-02-24',N'Nam','PHYS')

-- NHẬP DỮ LIỆU TaiKhoan
INSERT INTO TaiKhoan(TenDangNhap, MatKhau) VALUES
	('admin', 'hcmue123'),
	('47.01.104.040','4701104040'),
	('47.01.104.122','4701104122'),
	('47.01.104.096','4701104096'),
	('47.01.104.152','4701104152'),
	('47.01.104.146','4701104146'),
	('47.01.103.033','4701103033'),
	('47.01.103.064','4701103064'),
	('47.01.103.072','4701103072'),
	('47.01.103.079','4701103079'),
	('47.01.103.100','4701103100'),
	('47.01.101.111','4701101111'),
	('47.01.101.001','4701101001'),
	('47.01.101.013','4701101013'),
	('47.01.101.032','4701101032'),
	('47.01.101.048','4701101048'),
	('47.01.101.055','4701101055'),
	('47.01.101.086','4701101086'),
	('47.01.101.075','4701101075'),
	('47.01.101.119','4701101119'),
	('47.01.101.130','4701101130'),
	('47.01.102.007','4701102007'),
	('47.01.102.053','4701102053'),
	('47.01.102.047','4701102047'),
	('47.01.102.055','4701102055'),
	('47.01.102.088','4701102088')
UPDATE TaiKhoan SET QuanTriVien = 1 WHERE TenDangNhap = 'admin'

-- NHẬP DỮ LIỆU MonThi
INSERT INTO MonThi VALUES
	('2211COMP1701',N'Lí thuyết đồ thị',150,6,null),
	('2211COMP1016',N'Cấu trúc dữ liệu',125,5,null),
	('2211COMP1011',N'Kiến trúc máy tính',150,6,null),
	('2211MILI2703',N'Quân sự chung',250,10,null),
	('2211ENGL2402',N'Tiếng Anh học phần II',275,11,null),
	('2211MATH1410',N'Tôbô đại cương',100,4,null),
	('2211MATH1710',N'Cấu trúc đại số',150,6,null),
	('2211MATH1411',N'Hình học cao cấp',75,3,null),
	('2211PHYS1405',N'Hàm biến số phức',125,5,null),
	('2211PHYS1408',N'Điện tử học',150,6,null),
	('2211PHYS1409',N'Quang học',75,3,null)

--NHẬP DỮ LIỆU PhongThi
INSERT INTO PhongThi(MaPhong) VALUES
	('B101'), ('B102'), ('B103'), ('B104'), ('B105'), ('B106'), ('B107'), ('B108'), ('B109'), ('B110'),
	('B201'), ('B202'), ('B203'), ('B204'), ('B205'), ('B206'), ('B207'), ('B208'), ('B209'), ('B210')

--NHẬP DỮ LIỆU ThamGiaThi
INSERT INTO ThamGiaThi(MSSV, MaMon) VALUES
	('47.01.104.040','2211COMP1701'),
	('47.01.104.040','2211COMP1016'),
	('47.01.104.040','2211COMP1011'),
	('47.01.104.040','2211MILI2703'),
	('47.01.104.040','2211ENGL2402'),

	('47.01.104.122','2211COMP1701'),
	('47.01.104.122','2211COMP1016'),
	('47.01.104.122','2211COMP1011'),
	('47.01.104.122','2211MILI2703'),
	('47.01.104.122','2211ENGL2402'),

	('47.01.104.096','2211COMP1701'),
	('47.01.104.096','2211COMP1016'),
	('47.01.104.096','2211COMP1011'),
	('47.01.104.096','2211ENGL2402'),

	('47.01.104.152','2211COMP1701'),
	('47.01.104.152','2211COMP1011'),
	('47.01.104.152','2211ENGL2402'),

	('47.01.104.146','2211COMP1701'),
	('47.01.104.146','2211COMP1016'),
	('47.01.104.146','2211COMP1011'),
	('47.01.104.146','2211MILI2703'),

	('47.01.103.033','2211COMP1701'),
	('47.01.103.033','2211COMP1016'),
	('47.01.103.033','2211COMP1011'),
	('47.01.103.033','2211MILI2703'),
	('47.01.103.033','2211ENGL2402'),

	('47.01.103.064','2211COMP1016'),
	('47.01.103.064','2211COMP1011'),
	('47.01.103.064','2211MILI2703'),
	('47.01.103.064','2211ENGL2402'),

	('47.01.103.072','2211COMP1701'),
	('47.01.103.072','2211COMP1016'),
	('47.01.103.072','2211COMP1011'),
	('47.01.103.072','2211MILI2703'),
	('47.01.103.072','2211ENGL2402'),

	('47.01.103.079','2211COMP1701'),
	('47.01.103.079','2211MILI2703'),
	('47.01.103.079','2211ENGL2402'),

	('47.01.103.100','2211COMP1701'),
	('47.01.103.100','2211COMP1016'),
	('47.01.103.100','2211COMP1011'),

	('47.01.101.111','2211MATH1410'),
	('47.01.101.111','2211MATH1710'),
	('47.01.101.111','2211MATH1411'),
	('47.01.101.111','2211MILI2703'),
	('47.01.101.111','2211ENGL2402'),
	
	('47.01.101.001','2211MATH1410'),
	('47.01.101.001','2211MATH1710'),
	('47.01.101.001','2211MATH1411'),
	('47.01.101.001','2211MILI2703'),
	('47.01.101.001','2211ENGL2402'),

	('47.01.101.013','2211MATH1410'),
	('47.01.101.013','2211MATH1710'),
	('47.01.101.013','2211MATH1411'),
	('47.01.101.013','2211MILI2703'),
	('47.01.101.013','2211ENGL2402'),

	('47.01.101.032','2211MATH1410'),
	('47.01.101.032','2211MATH1710'),
	('47.01.101.032','2211MATH1411'),

	('47.01.101.048','2211MATH1411'),
	('47.01.101.048','2211MILI2703'),
	('47.01.101.048','2211ENGL2402'),

	('47.01.101.055','2211MATH1410'),
	('47.01.101.055','2211MATH1710'),
	('47.01.101.055','2211ENGL2402'),

	('47.01.101.086','2211MATH1410'),
	('47.01.101.086','2211MATH1710'),
	('47.01.101.086','2211MATH1411'),
	('47.01.101.086','2211ENGL2402'),

	('47.01.101.119','2211MATH1410'),
	('47.01.101.119','2211MATH1710'),
	('47.01.101.119','2211MATH1411'),
	('47.01.101.119','2211MILI2703'),
	('47.01.101.119','2211ENGL2402'),

	('47.01.101.130','2211MATH1410'),
	('47.01.101.130','2211MATH1710'),
	('47.01.101.130','2211MATH1411'),
	('47.01.101.130','2211MILI2703'),

	('47.01.102.007','2211PHYS1405'),
	('47.01.102.007','2211PHYS1408'),
	('47.01.102.007','2211PHYS1409'),
	('47.01.102.007','2211MILI2703'),
	('47.01.102.007','2211ENGL2402'),

	('47.01.102.053','2211PHYS1405'),
	('47.01.102.053','2211PHYS1408'),
	('47.01.102.053','2211MILI2703'),
	('47.01.102.053','2211ENGL2402'),

	('47.01.102.047','2211PHYS1408'),
	('47.01.102.047','2211PHYS1409'),
	('47.01.102.047','2211MILI2703'),
	('47.01.102.047','2211ENGL2402'),

	('47.01.102.055','2211PHYS1405'),
	('47.01.102.055','2211PHYS1409'),
	('47.01.102.055','2211MILI2703'),
	('47.01.102.055','2211ENGL2402'),

	('47.01.102.088','2211PHYS1405'),
	('47.01.102.088','2211PHYS1408'),
	('47.01.102.088','2211PHYS1409')

select * from KyThi
select * from Khoa
select * from SinhVien
select * from TaiKhoan
select * from CaThi
select * from MonThi
select * from PhongThi
select * from PhanBoPhongThi
select * from ThamGiaThi