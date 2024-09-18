﻿/*
	1. Copy nội dung trong file Stronghold.txt dán vào của sổ New Query trong SQL Server 2008.
	2. Nhấn Execute hay phím F5 để tạo database.
*/
--Kiểm tra xem StrongHold có tồn tại thì xoá đi.
USE master
GO
if exists(SELECT * FROM master..sysdatabases WHERE name='StrongHold')
DROP DATABASE StrongHold
GO

--Tạo database mang tên StrongHold
create  database StrongHold

GO
USE StrongHold
GO
--Tạo bảng Customer 
CREATE TABLE Customer(
	CCode nvarchar(3) CONSTRAINT PK_CCode PRIMARY KEY,
	CName nvarchar(50),
	CAddress nvarchar(50),
	CPhone nvarchar(10)
)
GO
--Tạo bảng OrderMaster
CREATE TABLE OrderMaster(
	OrderNo nvarchar(10) CONSTRAINT PK_OrderNo PRIMARY KEY,
	OrderDate datetime,
	CCode nvarchar(3) NOT NULL CONSTRAINT FK_CCode FOREIGN KEY REFERENCES Customer(CCode)
)
--Tạo bảng Item
CREATE TABLE Item(
	ICode nvarchar(20) CONSTRAINT PK_ICode PRIMARY KEY,
	ItemName nvarchar(50),
	Rate int
)
GO
--Tạo bảng OrderDetails
CREATE TABLE OrderDetails(
	SrNo int IDENTITY(1,1),
	OrderNo nvarchar(10) NOT NULL CONSTRAINT FK_OrderNo FOREIGN KEY REFERENCES OrderMaster(OrderNo),
	ItemCode nvarchar(20) NOT NULL CONSTRAINT FK_ICode FOREIGN KEY REFERENCES Item(Icode),
	Qty int,
	CONSTRAINT PK_SrNo_OrderNo PRIMARY KEY(SrNo, OrderNo)
)
GO
--Insert data vào bảng Customer
INSERT INTO Customer VALUES ('BCL','Beach Caravan Ltd.','46,Beverly Hills, California','213-45-71'),
							('BGL','Bright Getaways Ltd.','58, Green Park, NY-31','213-45-71'),
							('GHL','Great Holidays Ltd.','1, Lydia''s Avenue, Durham-41','115-72-43'),
							('JLT','Just _Like That Services','12, Major Dome Road, NY','231-21-34'),
							('TLT','Travelite Ltd.','22, Rodeo Drive, Manhattan-11','443-22-51'),
							('ULS','United Luggage Services','14, Park Avenue, NY-27','123-56-34')
GO
--Insert data vào bảng OrderMaster
INSERT INTO OrderMaster VALUES	('0083/98', '12/03/1998', 'TLT'), -- Default format mm/dd/yyyy
								('0084/99', '02/06/1999', 'BGL'),
								('0195/99', '10/04/1999', 'TLT'),
								('0256/99', '10/06/1999', 'ULS'),
								('0300/99', '05/06/1999', 'BGL'),
								('0343/99', '06/06/1999', 'ULS'),
								('0430/99', '07/01/1999', 'GHL'),
								('0441/99', '07/03/1999', 'BCL'),
								('0703/99', '10/15/1999', 'TLT'),
								('0704/99', '10/15/1999', 'ULS'),
								('0856/99', '10/09/1999', 'TLT')
--Insert data vào bảng Item
INSERT INTO Item VALUES	('RKSK-B', 'Rucksack-Brown', 450),
						('RKSK-T', 'Rucksack-Tan', 500),
						('STCS-18-M-I', 'Suitcase 18", Moulded, Ivory', 1075),
						('STCS-18-S-T', 'Suitcase 18", Soft, Tan', 1575),
						('STCS-24-S-DB', 'Suitcase 24", Soft, Dark Brown', 1575),
						('STCS-28-S-B', 'Suitcase 28", Soft, Blue', 1790)
GO
--Insert data vào bảng OrderDeatils
INSERT INTO OrderDetails	(OrderNo, ItemCode, Qty) VALUES('0083/98', 'RKSK-T', 100),
							('0083/98', 'STCS-18-S-T', 50),
							('0083/98', 'STCS-24-S-DB', 100),
							('0084/99', 'RKSK-T', 120),
							('0084/99', 'RKSK-B', 200),
							('0195/99', 'STCS-18-S-T', 100),
							('0195/99', 'RKSK-B', 75),
							('0256/99', 'STCS-24-S-DB', 50),
							('0256/99', 'STCS-18-S-T', 70),
							('0300/99', 'RKSK-B', 100),
							('0343/99', 'STCS-18-S-T', 50),
							('0343/99', 'RKSK-B', 60),
							('0430/99', 'STCS-24-S-DB', 120),
							('0430/99', 'RKSK-T', 70),
							('0430/99', 'RKSK-B', 130),
							('0441/99', 'STCS-18-S-T', 40),
							('0441/99', 'STCS-24-S-DB', 100),
							('0703/99', 'RKSK-T', 70),
							('0703/99', 'STCS-24-S-DB', 30),
							('0704/99', 'RKSK-T', 20),
							('0704/99', 'RKSK-B', 50),
							('0856/99', 'RKSK-T', 120),
							('0856/99', 'RKSK-B', 100),
							('0856/99', 'STCS-18-M-I', 20)