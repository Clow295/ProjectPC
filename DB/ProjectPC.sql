USE [master]
GO
/****** Object:  Database [PCStore]    Script Date: 5/30/2024 4:12:02 PM ******/
CREATE DATABASE [PCStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PCStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PCStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PCStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PCStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PCStore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PCStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PCStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PCStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PCStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PCStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PCStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [PCStore] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PCStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PCStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PCStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PCStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PCStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PCStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PCStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PCStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PCStore] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PCStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PCStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PCStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PCStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PCStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PCStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PCStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PCStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PCStore] SET  MULTI_USER 
GO
ALTER DATABASE [PCStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PCStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PCStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PCStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PCStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PCStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PCStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [PCStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PCStore]
GO
/****** Object:  Table [dbo].[brands]    Script Date: 5/30/2024 4:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brands](
	[bid] [int] NOT NULL,
	[bname] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detail]    Script Date: 5/30/2024 4:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cpu] [nvarchar](255) NULL,
	[mainboard] [nvarchar](255) NULL,
	[ram] [nvarchar](255) NULL,
	[storage] [nvarchar](255) NULL,
	[vga] [nvarchar](255) NULL,
	[psu] [nvarchar](255) NULL,
	[PCcase] [nvarchar](255) NULL,
	[air_cooling] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 5/30/2024 4:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[id] [int] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[image] [nvarchar](255) NULL,
	[price] [decimal](10, 2) NULL,
	[mota] [nvarchar](255) NULL,
	[bid] [int] NULL,
	[uid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usages]    Script Date: 5/30/2024 4:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usages](
	[uid] [int] NOT NULL,
	[uname] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[brands] ([bid], [bname]) VALUES (1, N'MSI')
INSERT [dbo].[brands] ([bid], [bname]) VALUES (2, N'ASUS')
INSERT [dbo].[brands] ([bid], [bname]) VALUES (3, N'DELL')
INSERT [dbo].[brands] ([bid], [bname]) VALUES (4, N'ACER')
INSERT [dbo].[brands] ([bid], [bname]) VALUES (5, N'Apple')
INSERT [dbo].[brands] ([bid], [bname]) VALUES (6, N'HP')
INSERT [dbo].[brands] ([bid], [bname]) VALUES (7, N'Lenovo')
GO
SET IDENTITY_INSERT [dbo].[detail] ON 

INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (1, N'	AMD Ryzen 7 5800X', N'AMD X570', N'16GB DDR4-3200 LO-DIMM', N'1TB M.2 NVMe PCIe 4.0 SSD', N'NVIDIA GeForce RTX3070 8GB DDR6', N'ASUS TUF GAMING 750W BRONZE ', N'ROG Strix GA35DX', N'TẢN NHIỆT NƯỚC AIO AIGO AC240 V2 WHITE ARGB
')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (2, N'	Ryzen 5 5600G', N'AMD B550', N'8GB DDR4 (tối đa 64GB)', N'	512GB M.2 NVMe™ PCIe® 3.0 SSD', N'	GTX1660ti 6GB', N'ASUS TUF GAMING 650W BRONZE', N'ASUS ROG STRIX G10DK', N'TẢN NHIỆT KHÍ JONSBO CR-1000 EVO ARGB BLACK')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (3, N'Intel Core i5 13400

', N'B660', N'16GB DDR4 3200Mhz

 (tối đa 64GB)', N'512GB PCIe NVMe SSD

', N'VGA onboard', N'AIGO CK450 PRO - 450W ', N'Vostro 3020

', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (4, N'Intel Core i7-12700', N'ASROCK H510M-H/M.2 SE', N'8GB DDR4 ', N'512GB SSD', N'VGA onboard', N'AIGO CK450 PRO - 450W ', N'VERITON X2690G', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (5, N'Intel Core i5-11400
', N'Intel B560
', N'16GB DDR4 3200Mhz SODIMM (8GB*2)
', N'512GB PCIe NVMe™
', N'GTX 1660 Super 6GB
', N'ASUS TUF GAMING 750W BRONZE', N'MSI CREATOR P50', N'TẢN NHIỆT KHÍ JONSBO CR-1000 EVO ARGB BLACK')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (6, N'Intel Core i9-12900
', N'W680', N'16GB RAM', N'512GB SSD
', N'VGA onboard', N'ASUS TUF GAMING 750W BRONZE ', N'E500 ', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (7, N'Intel Core i7-11700K', N'MSI Z590 PRO WIFI', N'Klevv CRAS X RGB 16GB (2x8GB) DDR4 Bus 3200', N'Klevv CRAS C700 RGB 240GB M2 NVME Gen3x4 – LED RGB', N'MSI GTX 1660 SUPER GAMING X', N'MSI MPG A650GF 650W – 80 Plus Gold – Full Modular', N' MSI MAG FORGE 100R', N'MSI MAG CORELIQUID 240R')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (8, N'Intel Core i7 13700K', N'MSI MAG B760M MORTAR WIFI', N'Corsair LPX 16GB (1x16GB) DDR5 5200MHz', N': SSD Crucial P3 Plus 500GB NVMe PCIe Gen4x4', N'ASUS DUAL RTX 3060 OC 12G', N'Segotep GM850W 850W 80 Plus Gold PCIE 5.0', N'Segotep Gank 360 (No Fan)', N'Tản Nhiệt Nước ID-COOLING ZOOMFLOW 360 XT ARGB')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (9, N'AMD Ryzen 9 7900X3D', N'MSI PRO X670-P WIFI', N'Kingston 32GB 5600MT/s DDR5 CL40 DIMM (Kit of 2) Beast RGB', N'MSI SPATIUM M450 1TB M2 Gen 4×4', N'MSI RTX 4070 Ti SUPER 16G GAMING X SLIM', N' MSI MPG A850G PCIE5 850W – 80 Plus Gold – Full Modular', N'MSI MPG VELOX 100P AIRFLOW (4 FAN)', N'Tản Nhiệt Nước Thermaltake TH360 ARGB Sync Black')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (10, N'AMD Ryzen 9 7950X3D', N'MSI PRO X670-P WIFI', N'Kingston 32GB 5600MT/s DDR5 CL40 DIMM (Kit of 2) Beast RGB', N'MSI SPATIUM M450 1TB M2 Gen 4×4', N'MSI RTX 4070 Ti SUPER 16G GAMING X SLIM', N' MSI MPG A850G PCIE5 850W – 80 Plus Gold – Full Modular', N'Thermaltake View 51 TG Snow ARGB Edition', N'Tản Nhiệt Nước Thermaltake TH360 ARGB Sync Black')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (11, N'Intel Core i5-12400F', N'MSI MAG B760M MORTAR WIFI', N'2 x 8GB bus 3200MHz', N'512GB SSD NVMe PCIe Gen4', N'Nvidia RTX 3060ti 8GB GDDR6', N'ASUS TUF GAMING 750W BRONZE ', N'ASUS ROG STRIX G15CF', N'TẢN NHIỆT KHÍ JONSBO CR-1000 EVO ARGB BLACK
')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (12, N'Intel Core i7-12700F', N'MSI MAG B760M MORTAR WIFI', N'2 x 8GB bus 3200MHz', N'512GB SSD NVMe PCIe Gen4', N' Nvidia RTX 3070 8GB GDDR6', N'ASUS TUF GAMING 750W BRONZE ', N'ASUS ROG STRIX G15CF', N'TẢN NHIỆT KHÍ THERMALRIGHT DUAL-TOWER FROST COMMANDER 140 WHITE
')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (13, N'Intel Core i5 12600K
', N'Intel W680
', N'8 GB DDR5  4800
 Tối đa lên tới 128GB UDIMM
', N'1TB HDD
', N'VGA onboard', N'300W Gold
', N'E500G9', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (14, N'Intel Core i7 12700
', N'Intel W680
', N'16GB Hynix_DDR5 4800 MHz
 Tối đa lên tới 128GB UDIMM
', N'512GB SSD PCIE Gen4/ 512G M.2 2280
', N'VGA onboard
', N'550W Gold
', N'E500G9', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (15, N'Intel Core i7-10700K', N'Intel W680
', N'16GB Hynix_DDR5 4800 MHz
 Tối đa lên tới 128GB UDIMM
', N'512GB SSD PCIE Gen4/ 512G M.2 2280
', N' Nvidia RTX 3070 8GB GDDR6', N'MSI MPG A650GF 650W – 80 Plus Gold – Full Modular', N'E500 G6', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (16, N'CPU Intel Core i7-14700K', N'Mainboard ASUS ROG STRIX Z790-F GAMING WIFI II	', N'Ram Desktop Corsair DOMINATOR PLATINUM RGB Black (CMT64GX5M2B5600C40) 64GB (2x32GB) DDR5 5600MHz	', N'Ổ cứng SSD Samsung 990 PRO 1TB PCIe NVMe 4.0x4 (Đọc 7450MB/s - Ghi 6900MB/s) - (MZ-V9P1T0BW)	', N'Card màn hình NVIDIA RTX A4000ADA (20GB GDDR6) (Leadtek)	', N'Nguồn máy tính Corsair CX750 (80 Plus Bronze/ Màu Đen)	', N'Case Thermaltake View 200 TG ARGB Black (ATX/Mid Tower/ 4Fan ARGB)	', N'Tản nhiệt nước Thermaltake TH240 V2 Ultra black')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (17, N'Intel Core i3-10110', N'Barebone mainboard', N'Chưa có', N'Chưa có', N'VGA onboard', N'300W Gold
', N'CUBI B183', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (18, N'Intel Core i3-10110', N'Barebone mainboard', N'Chưa có', N'Chưa có', N'VGA onboard', N'300W Gold
', N'CUBI B183', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (19, N'Intel Pentium N200', N'Barebone mainboard', N'4GB DDR4 2933 (1*4GB)

', N'128GB M2 SSD

', N'Intel® Iris® Xe Graphics

', N'300W Gold
', N'CUBI B183', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (20, N'Apple M2 8-core CPU with 4 performance cores and 4 efficiency cores; 10-core GPU', N'', N'16GB', N'512GB SSD

', N'Apple GPU with 10-core

', N'', N'Mac Mini', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (21, N'Apple M2 8-core CPU with 4 performance cores and 4 efficiency cores; 10-core GPU

', N'', N'16GB', N'256GB SSD', N'Apple GPU with 10-core

', N'', N'Mac Mini', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (22, N'Apple M1 chip
8-core CPU / 8-core GPU', N'', N'8GB
', N'256GB SSD
', N'Apple GPU with 8-core

', N'', N'iMac MGPH3SA/A
', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (23, N'Apple M1 Max chip with 10-core CPU and 24-core GPU, 16-core Neural Engine

', N'', N'32GB 

', N'512GB SSD 

', N'Apple GPU with 24 core

', N'', N'Mac Studio

', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (24, N'Intel Core i7 12700', N'Intel H670
', N'16Gb', N'512GB SSD', N'Intel UHD Graphics 770
', N'300W Gold
', N'Pro Tower G9', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (25, N'Intel Core i5-13400
', N'Intel H670
', N'8Gb
 DDR4
 3200 MHz
', N'256GB SSD M.2 PCIe NVMe
', N'Intel UHD Graphics 730
', N'300W Gold
', N'Pavilion TP01', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (26, N'Intel Core i5 12500', N'Intel Q670
', N'8 GB DDR4-3200 MHz RAM (1 x 8 GB)
', N'256GB PCIe NVMe M.2 SSD', N'Intel UHD Graphics 770
', N'550W Gold
', N'HP Pro 400', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (27, N'Intel Core i3 12100', N'Intel H670
', N'8 GB DDR4-3200 MHz RAM (1 x 8 GB)
', N'256GB SSD M.2 PCIe NVMe
', N'Intel UHD Graphics 770
', N'300W Gold
', N'THINKCENTRE M70T', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (28, N'Intel Core i5-12400', N'Intel H670
', N'4GB DDR4-3200MHz
', N'256GB SSD M.2 PCIe NVMe
', N'Intel UHD Graphics 770
', N'300W Gold
', N'THINKCENTRE NEO 50S', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (29, N'Intel Core i7-12700', N'Intel Q670
', N'8 GB DDR4-3200 MHz RAM (1 x 8 GB)
', N'512GB SSD', N'Intel UHD Graphics 770
', N'550W Gold
', N'THINKCENTRE M70T ', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (30, N'Intel Core i3-1005G1', N'Intel H670
', N'8 GB DDR4-3200 MHz RAM (1 x 8 GB)
', N'128GB SSD + 1TB HDD', N'Intel UHD Graphics 770
', N'300W Gold
', N'	
Aspire All In One C22-963', N'Stock')
INSERT [dbo].[detail] ([id], [cpu], [mainboard], [ram], [storage], [vga], [psu], [PCcase], [air_cooling]) VALUES (31, N'Intel Core i7-12700', N'Intel Q670
', N'8 GB DDR4-3200 MHz RAM (1 x 8 GB)
', N'512GB SSD', N'Intel UHD Graphics 770
', N'550W Gold
', N'VERITON X2690G', N'Stock')
SET IDENTITY_INSERT [dbo].[detail] OFF
GO
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (1, N'PC ASUS ROG STRIX G35DX', N'https://hanoicomputercdn.com/media/product/64370_g35dx_vn003w_01.jpg', CAST(26999000.00 AS Decimal(10, 2)), N'R7-5800X/16GB RAM/1TB SSD/RTX3070 8GB/WL+BT/WIN 11', 2, 2)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (2, N'PC ASUS ROG STRIX G10DK', N'https://hanoicomputercdn.com/media/product/64933_pc_asus_rog_strix_g10dk_850x850.jpg', CAST(13999000.00 AS Decimal(10, 2)), N'R5 5600G/8GB RAM/512GB SSD/GTX1660TI/WL+BT5/WIN 11', 2, 2)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (3, N'PC DELL VOSTRO 3020SFF', N'https://hanoicomputercdn.com/media/product/78877_pc_dell_vostro_3020sff_sffi52018w1_16g_512g_1a.jpg', CAST(15099000.00 AS Decimal(10, 2)), N'I5 13400 16GB RAM/512GB SSD/WL+BT/K+M/ WIN11', 3, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (4, N'PC ACER VERITON X2690G', N'https://hanoicomputercdn.com/media/product/77081_pc_acer_veriton_x2690g_i7_12700_8g_850x850_5.jpg', CAST(20165000.00 AS Decimal(10, 2)), N'I7 12700/8GB/512G SSD/WL/K+M/BLACK/DOS', 4, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (5, N'PC MSI CREATOR P50', N'https://hanoicomputercdn.com/media/product/65774_pc_msi_creator_p50_850x850_1.jpg', CAST(27499000.00 AS Decimal(10, 2)), N'I5-11400/16GB (2X8GB)/512GB SSD/GTX1660S/WL+BT', 1, 3)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (6, N'MÁY TRẠM ASUS E500 G9', N'https://hanoicomputercdn.com/media/product/76439_may_tram_asus_e500_g9_i9_12900_850x850_2.jpg', CAST(32999000.00 AS Decimal(10, 2)), N'I9-12900/16GB RAM/W680/512GB SSD/750W/KB&M/DVD-RW', 2, 4)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (7, N'PC MSI SP279', N'https://songphuong.vn/Content/uploads/2022/10/Case-MSI-MEG-PROSPECT-700R-songphuong.vn-01.jpg', CAST(53680000.00 AS Decimal(10, 2)), N'i9 13900K/ Z790/ Ram 32GB / RTX 4070/ SSD 1TB/ 850W/ DOS', 1, 2)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (8, N'PC MSI i7 13700K ', N'https://songphuong.vn/Content/uploads/2023/05/SP-PC-INTEL-i7-13700K-1.jpg', CAST(32210000.00 AS Decimal(10, 2)), N'i7 13700K/ B760/ Ram 16GB / RTX 3060 /SSD 500GB/ 850W/ DOS', 1, 2)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (9, N'PC MSI AMD 7900X3D', N'https://songphuong.vn/Content/uploads/2023/05/SP-PC-AMD-7900X3D-1.jpg', CAST(63550000.00 AS Decimal(10, 2)), N'R9 7900X3D/ X670/ Ram 32GB/ RTX 4070TiS / SSD 1TB/ 850W/ DOS', 1, 2)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (10, N'PC MSI AMD 7950X3D', N'https://songphuong.vn/Content/uploads/2023/05/SP-PC-AMD-7950X3D-1.jpg', CAST(68410000.00 AS Decimal(10, 2)), N'R9 7950X3D/ X670/ Ram 32GB/ RTX 4070TiS / SSD 1TB/ 850W/ DOS', 1, 3)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (11, N'PC ASUS ROG STRIX G15CF I5-12400F', N'https://hanoicomputercdn.com/media/product/66605_pc_asus_rog_strix_g15cf_i5_12400f_16gb_ram_512gb_ssd_rtx3060ti_wl_bt_win_11_g15cf_51240f141w.jpg', CAST(24999000.00 AS Decimal(10, 2)), N'I5-12400F/16GB RAM/512GB SSD/RTX3060TI/WL+BT/WIN 11', 2, 2)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (12, N'PC ASUS ROG STRIX G15CF I7-12700F', N'https://hanoicomputercdn.com/media/product/66606_pc_asus_rog_strix_g15cf_850x850_2.jpg', CAST(44699000.00 AS Decimal(10, 2)), N'I7-12700F/16GB RAM/512GB SSD/RTX3070/WL+BT/WIN 11', 2, 2)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (13, N'MÁY TRẠM ASUS E500G9-1260K002Z', N'https://hanoicomputercdn.com/media/product/82207_may_tram_asus_e500g9_1260k002z_1.jpg', CAST(22499000.00 AS Decimal(10, 2)), N'I5-1260K/8GD5/1TB-HDD/2*INTEL LAN/W680/300W/KB&M/DVD-RW/NOS/ĐEN', 2, 4)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (14, N'MÁY TRẠM ASUS E500G9-12700029Z', N'https://hanoicomputercdn.com/media/product/82206_may_tram_asus_e500g9_12700029z_1.jpg', CAST(29999000.00 AS Decimal(10, 2)), N' I7-12700/16GD5/512GB-PCIE/2*INTEL LAN/W680/550W/KB&M/NOS/ĐEN', 2, 4)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (15, N'WORKSTATION ASUS PRO E500 G6 1070K 022Z', N'https://hanoicomputercdn.com/media/product/65355_workstation_asus_pro_e500_g6_850x850_3.jpg', CAST(51499000.00 AS Decimal(10, 2)), N'I7-10700K/16GB RAM/512GB SSD/RTX3070', 2, 4)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (16, N'PC AI INTERMEDIATE V3', N'https://hanoicomputercdn.com/media/product/82892_pc_hacom_ai_intermediate_v3_1.jpg', CAST(82899000.00 AS Decimal(10, 2)), N'I7-14700K/Z790/64GB RAM/1TB SSD/A4000ADA /750W', 2, 4)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (17, N'PC MINI MSI CUBI B183', N'https://hanoicomputercdn.com/media/product/66251_pc_mini_msi_cubi_b183_850x850_1.jpg', CAST(7149000.00 AS Decimal(10, 2)), N'I3-10110U/BAREBONE/WL+BT/NO OS', 1, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (18, N'PC MINI MSI CUBI 5 ', N'https://hanoicomputercdn.com/media/product/73325_pc_msi_cubi_5_12m_080vn_b51235u8gs51x11pa_850x850_1.jpg', CAST(22099000.00 AS Decimal(10, 2)), N'I5 1235U 8GB RAM/512GB SSD/WL+BT/WIN 11 PRO/ĐEN', 1, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (19, N'PC MSI CUBI N', N'https://hanoicomputercdn.com/media/product/73326_pc_msi_pro_dp21_adl_017xvn_bn2004gs12xxa_850x850_6.jpg', CAST(6999000.00 AS Decimal(10, 2)), N'PENTIUM N200 4GB RAM/128GB SSD/WL+BT/DOS/ĐEN', 1, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (20, N'APPLE MAC MINI (Z16K0005U) ', N'https://hanoicomputercdn.com/media/product/70907_apple_mac_mini__z16k__850x850_3.jpg', CAST(19799000.00 AS Decimal(10, 2)), N'APPLE M2 8C CPU/10C GPU/16G RAM/256GB SSD/MAC OS/BẠC', 5, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (21, N'APPLE MAC MINI (Z16K0005Y)', N'https://hanoicomputercdn.com/media/product/70908_apple_mac_mini__z16l__850x850_1.jpg', CAST(24999000.00 AS Decimal(10, 2)), N'APPLE M2 8C CPU/10C GPU/16G RAM/512GB SSD/MAC OS/BẠC', 5, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (22, N'PC APPLE IMAC M1 ', N'https://hanoicomputercdn.com/media/product/60138_imac_24_touch_id_green_gallery_1.jpg', CAST(33699000.00 AS Decimal(10, 2)), N'8 CORE CPU/8 CORE GPU/8GB RAM/256GB SSD/24 INCH 4.5K/GREEN/MAC OS', 5, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (23, N'PC APPLE MAC STUDIO M1 MAX', N'https://hanoicomputercdn.com/media/product/64457_mac_studio_max_850x850.jpg', CAST(53999000.00 AS Decimal(10, 2)), N'10 CORE CPU/24 CORE GPU/32GBRAM/512GB SSD/MAC OS/BẠC', 5, 3)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (24, N'PC HP 280 PRO TOWER G9 (9H9C2PT)', N'https://hanoicomputercdn.com/media/product/80652_pc_hp_280_pro_tower_g9_9h9c2pt_1.jpg', CAST(18399000.00 AS Decimal(10, 2)), N'I7-12700/16GB RAM/512GB SSD/WL+BT/K+M/WIN11', 6, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (25, N'PC HP PAVILION TP01-4010D 8C5T2PA', N'https://hanoicomputercdn.com/media/product/78417_pc_hp_pavilion_tp01_4010d_8c5t2pa_850x850_1.jpg', CAST(13299000.00 AS Decimal(10, 2)), N'I5 13400/8GB RAM/256GB SSD/WL+BT/K+M/WIN 11/TRẮNG', 6, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (26, N'PC HP PRO 400 G9 SFF ', N'https://hanoicomputercdn.com/media/product/68276_pc_hp_pro_400_g9_sff_72l09pa_1a.jpg', CAST(12899000.00 AS Decimal(10, 2)), N'I5-12500/8GB RAM/256GB SSD/WL+BT/K+M/WIN11', 6, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (27, N'PC LENOVO THINKCENTRE M70T GEN 3 ', N'https://hanoicomputercdn.com/media/product/74495_pc_lenovo_thinkcentre_m70t_gen3_i3_1a.jpg', CAST(7999000.00 AS Decimal(10, 2)), N'I3-12100/8GB RAM/256GB SSD/WL+BT/K+M/NO OS', 7, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (28, N'PC LENOVO THINKCENTRE NEO 50S GEN 3', N'https://hanoicomputercdn.com/media/product/73664_pc_lenovo_thinkcentre_neo_50s_11t000axva_850x850_2.jpg', CAST(10499000.00 AS Decimal(10, 2)), N'I5 12400/4GB RAM/256GB SSD/WL+BT/K+M/NO OS', 7, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (29, N'PC LENOVO THINKCENTRE M70T GEN 3', N'https://hanoicomputercdn.com/media/product/74494_pc_lenovo_thinkcentre_m70t_gen3_3.jpg', CAST(16499000.00 AS Decimal(10, 2)), N'I7-12700/8GB RAM/512GB SSD/WL+BT/K+M/NO OS', 7, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (30, N'PC ACER AS ALL IN ONE C22-963', N'https://hanoicomputercdn.com/media/product/56788_pc_acer_as_c22.jpg', CAST(15699000.00 AS Decimal(10, 2)), N'I3-1005G1/8GB RAM/1TB HDD+128GB SSD/21.5 INCH FHD/WL+BT/K+M/WIN 10', 4, 1)
INSERT [dbo].[product] ([id], [name], [image], [price], [mota], [bid], [uid]) VALUES (31, N'PC ACER VERITON X2690G', N'https://hanoicomputercdn.com/media/product/77081_pc_acer_veriton_x2690g_i7_12700_8g_850x850_5.jpg', CAST(20165000.00 AS Decimal(10, 2)), N'I7 12700/8GB/512G SSD/WL/K+M/BLACK/DOS', 4, 1)
GO
INSERT [dbo].[usages] ([uid], [uname]) VALUES (1, N'Văn phòng')
INSERT [dbo].[usages] ([uid], [uname]) VALUES (2, N'Học tập, chơi game')
INSERT [dbo].[usages] ([uid], [uname]) VALUES (3, N'Đồ họa')
INSERT [dbo].[usages] ([uid], [uname]) VALUES (4, N'Máy trạm')
GO
ALTER TABLE [dbo].[detail]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[brands] ([bid])
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([uid])
REFERENCES [dbo].[usages] ([uid])
GO
USE [master]
GO
ALTER DATABASE [PCStore] SET  READ_WRITE 
GO
