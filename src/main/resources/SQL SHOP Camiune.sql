-- =============================================
--  TẠO DATABASE web bán hàng camiune
-- =============================================
CREATE DATABASE WebBanAoCamiune;
GO
USE WebBanAoCamiune;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[birth_day] [datetime2](7) NULL,
	[code] [varchar](255) NULL,
	[create_date] [datetime2](7) NULL,
	[email] [varchar](255) NULL,
	[is_non_locked] [bit] NOT NULL,
	[password] [varchar](255) NULL,
	[update_date] [datetime2](7) NULL,
	[customer_id] [bigint] NOT NULL,
	[role_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address_shipping](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](150) NOT NULL,
	[customer_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[amount] [float] NULL,
	[billing_address] [nvarchar](255) NULL,
	[code] [varchar](50) NOT NULL,
	[create_date] [datetime2](7) NULL,
	[invoice_type] [varchar](255) NULL,
	[promotion_price] [float] NOT NULL,
	[return_status] [bit] NULL,
	[status] [varchar](255) NULL,
	[update_date] [datetime2](7) NULL,
	[customer_id] [bigint] NULL,
	sales_channel VARCHAR(50) NULL,
	[discount_code_id] [bigint] NULL,
	[payment_method_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_detail](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[moment_price] [float] NULL,
	[quantity] [int] NULL,
	[return_quantity] [int] NULL,
	[bill_id] [bigint] NULL,
	[product_detail_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[status] [int] NOT NULL,
	[delete_flag] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[create_date] [datetime2](7) NULL,
	[quantity] [int] NOT NULL,
	[update_date] [datetime2](7) NULL,
	[account_id] [bigint] NULL,
	[product_detail_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[status] [int] NOT NULL,
	[delete_flag] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[color](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[delete_flag] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[phone_number] [varchar](255) NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[discount_code](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](255) NULL,
	[delete_flag] [bit] NOT NULL,
	[detail] [nvarchar](255) NULL,
	[discount_amount] [float] NULL,
	[end_date] [datetime2](7) NULL,
	[maximum_amount] [int] NULL,
	[maximum_usage] [int] NULL,
	[minimum_amount_in_cart] [float] NULL,
	[percentage] [int] NULL,
	[start_date] [datetime2](7) NULL,
	[status] [int] NOT NULL,
	[type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[image](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[create_date] [datetime2](7) NULL,
	[file_type] [varchar](255) NULL,
	[link] [varchar](255) NULL,
	[name] [nvarchar](255) NULL,
	product_detail_id BIGINT NULL,
	[update_date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[material](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[status] [int] NOT NULL,
	[delete_flag] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[amount] [varchar](255) NULL,
	[order_id] [varchar](255) NULL,
	[order_status] [varchar](255) NULL,
	[payment_date] [datetime2](7) NULL,
	[status_exchange] [int] NULL,
	[bill_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_method](
	[id] [bigint] NOT NULL,
	[name] [varchar](255) NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[create_date] [datetime2](7) NULL,
	[delete_flag] [bit] NOT NULL,
	[describe] [nvarchar](255) NULL,
	[gender] [int] NOT NULL,
	[name] [nvarchar](255) NULL,
	[price] [float] NOT NULL,
	[status] [int] NOT NULL,
	[updated_date] [datetime2](7) NULL,
	[brand_id] [bigint] NULL,
	[category_id] [bigint] NULL,
	[material_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_detail](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[barcode] [varchar](255) NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
	[color_id] [bigint] NULL,
	[product_id] [bigint] NULL,
	[size_id] [bigint] NULL,
	[image_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_discount](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[closed] [bit] NOT NULL,
	[discounted_amount] [float] NULL,
	[end_date] [datetime2](7) NULL,
	[start_date] [datetime2](7) NULL,
	[product_detail_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[create_date] [datetime2](7) NULL,
	[name] [varchar](50) NOT NULL,
	[update_date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[size](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[delete_flag] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[verification_code](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NULL,
	[expiry_time] [datetime2](7) NULL,
	[account_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[account] ON 

INSERT [dbo].[account] ([id], [birth_day], [code], [create_date], [email], [is_non_locked], [password], [update_date], [customer_id], [role_id]) VALUES (100, CAST(N'2002-12-12T00:00:00.0000000' AS DateTime2), N'TK0100', CAST(N'2023-12-22T00:00:00.0000000' AS DateTime2), N'admin@gmail.com', 1, N'$2a$10$emQmmA3Iw.8UANBm9mNTkeAHh96NOrMYW1fkjXc0vZd96Jxfs8Zym', NULL, 100, 1)
SET IDENTITY_INSERT [dbo].[account] OFF
GO
SET IDENTITY_INSERT [dbo].[customer] ON 

INSERT [dbo].[customer] ([id], [code], [email], [name], [phone_number]) VALUES (100, N'KH0001', NULL, N'Hồ Văn Trình ', N'09999999')
SET IDENTITY_INSERT [dbo].[customer] OFF
GO
INSERT [dbo].[payment_method] ([id], [name], [status]) VALUES (1, N'TIEN_MAT', 1)
INSERT [dbo].[payment_method] ([id], [name], [status]) VALUES (3, N'CHUYEN_KHOAN', 1)
INSERT [dbo].[payment_method] ([id], [name], [status]) VALUES (4, N'THE', 1)
GO
SET IDENTITY_INSERT [dbo].[role] ON 

INSERT [dbo].[role] ([id], [create_date], [name], [update_date]) VALUES (1, NULL, N'ROLE_ADMIN', NULL)
INSERT [dbo].[role] ([id], [create_date], [name], [update_date]) VALUES (2, NULL, N'ROLE_EMPLOYEE', NULL)
INSERT [dbo].[role] ([id], [create_date], [name], [update_date]) VALUES (3, NULL, N'ROLE_USER', NULL)
SET IDENTITY_INSERT [dbo].[role] OFF
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[account] ADD UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[account]  WITH CHECK ADD  CONSTRAINT [FK_account_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([id])
GO
ALTER TABLE [dbo].[account] CHECK CONSTRAINT [FK_account_customer]
GO
ALTER TABLE [dbo].[account]  WITH CHECK ADD  CONSTRAINT [FK_account_role] FOREIGN KEY([role_id])
REFERENCES [dbo].[role] ([id])
GO
ALTER TABLE [dbo].[account] CHECK CONSTRAINT [FK_account_role]
GO
ALTER TABLE [dbo].[address_shipping]  WITH CHECK ADD  CONSTRAINT [FK_address_shipping_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([id])
GO
ALTER TABLE [dbo].[address_shipping] CHECK CONSTRAINT [FK_address_shipping_customer]
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_bill_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([id])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_bill_customer]
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_bill_discount_code] FOREIGN KEY([discount_code_id])
REFERENCES [dbo].[discount_code] ([id])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_bill_discount_code]
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_bill_payment_method] FOREIGN KEY([payment_method_id])
REFERENCES [dbo].[payment_method] ([id])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_bill_payment_method]
GO
ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK_bill_detail_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([id])
GO
ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK_bill_detail_bill]
GO
ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK_bill_detail_product_detail] FOREIGN KEY([product_detail_id])
REFERENCES [dbo].[product_detail] ([id])
GO
ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK_bill_detail_product_detail]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_account] FOREIGN KEY([account_id])
REFERENCES [dbo].[account] ([id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_account]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_product_detail] FOREIGN KEY([product_detail_id])
REFERENCES [dbo].[product_detail] ([id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_product_detail]
GO
ALTER TABLE [dbo].[payment]  WITH CHECK ADD  CONSTRAINT [FK_payment_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([id])
GO
ALTER TABLE [dbo].[payment] CHECK CONSTRAINT [FK_payment_bill]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_brand] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brand] ([id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_brand]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_category]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_material] FOREIGN KEY([material_id])
REFERENCES [dbo].[material] ([id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_material]
GO
ALTER TABLE [dbo].[product_detail]  WITH CHECK ADD  CONSTRAINT [FK_product_detail_color] FOREIGN KEY([color_id])
REFERENCES [dbo].[color] ([id])
GO
ALTER TABLE [dbo].[product_detail] CHECK CONSTRAINT [FK_product_detail_color]
GO
ALTER TABLE [dbo].[product_detail]  WITH CHECK ADD  CONSTRAINT [FK_product_detail_image] FOREIGN KEY([image_id])
REFERENCES [dbo].[image] ([id])
GO
ALTER TABLE [dbo].[product_detail] CHECK CONSTRAINT [FK_product_detail_image]
GO
ALTER TABLE [dbo].[product_detail]  WITH CHECK ADD  CONSTRAINT [FK_product_detail_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[product_detail] CHECK CONSTRAINT [FK_product_detail_product]
GO
ALTER TABLE [dbo].[product_detail]  WITH CHECK ADD  CONSTRAINT [FK_product_detail_size] FOREIGN KEY([size_id])
REFERENCES [dbo].[size] ([id])
GO
ALTER TABLE [dbo].[product_detail] CHECK CONSTRAINT [FK_product_detail_size]
GO
ALTER TABLE [dbo].[product_discount]  WITH CHECK ADD  CONSTRAINT [FK_product_discount_product_detail] FOREIGN KEY([product_detail_id])
REFERENCES [dbo].[product_detail] ([id])
GO
ALTER TABLE [dbo].[product_discount] CHECK CONSTRAINT [FK_product_discount_product_detail]
GO
ALTER TABLE [dbo].[verification_code]  WITH CHECK ADD  CONSTRAINT [FK_verification_code_account] FOREIGN KEY([account_id])
REFERENCES [dbo].[account] ([id])
GO
ALTER TABLE [dbo].[verification_code] CHECK CONSTRAINT [FK_verification_code_account]
GO


select * from account

INSERT INTO brand(code, name, status, delete_flag) VALUES
('BR001', N'Canifa', 1, 0),
('BR002', N'Việt Tiến', 1, 0),
('BR003', N'Routine', 1, 0);

INSERT INTO category(code, name, status, delete_flag) VALUES
('CAT001', N'Áo thun', 1, 0),
('CAT002', N'Áo sơ mi', 1, 0),
('CAT003', N'Quần jean', 1, 0);

INSERT INTO material(code, name, status, delete_flag) VALUES
('MT01', N'Cotton', 1, 0),
('MT02', N'Polyester', 1, 0),
('MT03', N'Kaki', 1, 0);

INSERT INTO color(code, name, delete_flag) VALUES
('CL01', N'Đen', 0),
('CL02', N'Trắng', 0),
('CL03', N'Xanh', 0);

INSERT INTO size(code, name, delete_flag) VALUES
('S', N'S', 0),
('M', N'M', 0),
('L', N'L', 0);

INSERT INTO image (create_date, file_type, link, name, update_date, product_detail_id)
VALUES
('2025-07-08 11:26:16.690', 'jpg', '1751515193002-products_1.jpg', N'Áo sơ mi trắng nam', NULL, 2),
('2025-07-08 11:26:16.690', 'jpg', '1751515393547-products_2.jpg', N'Áo thun nam', NULL, 3),
('2025-07-08 11:26:16.690', 'jpg', '1751531247148-products_4.jpg', N'Áo khoác nam', NULL, 4),
('2025-07-08 11:26:16.690', 'jpg', '1751515193002-products_1.jpg', N'Áo sơ mi nam xanh navy', NULL, 5),
('2025-07-08 11:26:16.690', 'jpg', '1751515193002-products_6.jpg', N'Áo thun trơn nam ngắn tay', NULL, 6),
('2025-07-13 22:08:04.1614667', 'jpg', '1751515193002-products_7.jpg', NULL, NULL, 7),
('2025-07-17 10:43:15.1389316', 'jpg', '1751515193002-products_1.jpg', NULL, NULL, 8);



INSERT INTO product(code, create_date, delete_flag, describe, gender, name, price, status, brand_id, category_id, material_id)
VALUES
('P001', GETDATE(), 0, N'Áo thun chất liệu cotton', 1, N'Áo thun nam', 199000, 1, 1, 1, 1),
('P002', GETDATE(), 0, N'Áo sơ mi trắng', 1, N'Áo sơ mi nam', 299000, 1, 2, 2, 2),
('P003', GETDATE(), 0, N'Quần jean xanh', 1, N'Quần jean nam', 399000, 1, 3, 3, 3);

INSERT INTO product_detail(barcode, price, quantity, color_id, product_id, size_id, image_id)
VALUES
('BAR001', 199000, 50, 1, 1, 1, 1),
('BAR002', 199000, 30, 2, 1, 2, 2),
('BAR003', 299000, 40, 1, 2, 3, 3);

INSERT INTO discount_code(code, delete_flag, detail, discount_amount, end_date,
                          maximum_amount, maximum_usage, minimum_amount_in_cart,
                          percentage, start_date, status, type)
VALUES
('KM10', 0, N'Giảm 10k đơn từ 200k', 10000, '2025-12-31', 20000, 100, 200000, 0, GETDATE(), 1, 1),
('SALE20', 0, N'Giảm 20%', NULL, '2025-12-31', NULL, 100, 0, 20, GETDATE(), 1, 2);

INSERT INTO bill(amount, billing_address, code, create_date, invoice_type,
                 promotion_price, return_status, status,
                 customer_id, sales_channel, discount_code_id, payment_method_id)
VALUES
(500000, N'Hà Nội', 'HD001', GETDATE(), 'RETAIL', 10000, 0, 'PAID', 100, 'OFFLINE', 1, 1),
(300000, N'Hồ Chí Minh', 'HD002', GETDATE(), 'RETAIL', 0, 0, 'PAID', 100, 'ONLINE', 2, 4);
select * from bill
INSERT INTO bill_detail(moment_price, quantity, return_quantity, bill_id, product_detail_id)
VALUES
(199000, 2, 0, 1, 1),
(299000, 1, 0, 2, 3);

INSERT INTO cart(create_date, quantity, update_date, account_id, product_detail_id)
VALUES
(GETDATE(), 1, GETDATE(), 100, 1),
(GETDATE(), 2, GETDATE(), 100, 2);

INSERT INTO product_discount(closed, discounted_amount, end_date, start_date, product_detail_id)
VALUES
(0, 20000, '2025-12-31', GETDATE(), 1),
(0, 50000, '2025-12-31', GETDATE(), 3);

INSERT INTO address_shipping(address, customer_id)
VALUES
(N'123 Nguyễn Trãi, Hà Nội', 100),
(N'45 Lê Lợi, TP HCM', 100);

INSERT INTO payment(amount, order_id, order_status, payment_date, status_exchange, bill_id)
VALUES
('500000', 'ORD001', 'SUCCESS', GETDATE(), 1, 1),
('300000', 'ORD002', 'SUCCESS', GETDATE(), 1, 2);

INSERT INTO verification_code(code, expiry_time, account_id)
VALUES
('ABC123', DATEADD(HOUR, 1, GETDATE()), 100),
('XYZ789', DATEADD(HOUR, 1, GETDATE()), 100);
SELECT * FROM bill;


