-- ==========================================
-- NatureNest SQL Retail Analytics Project
-- File: 03_Insert_Data.sql
-- Description: Inserts master data into the database.
-- ==========================================

USE NatureNest;

-- ==========================================
-- Categories
-- ==========================================

INSERT INTO Categories (CategoryID, CategoryName)
VALUES
(1,'Nuts'),
(2,'Hair Care'),
(3,'Health Care'),
(4,'Skin Care'),
(5,'Organic Grocery'),
(6,'Herbal Tea'),
(7,'Dry Fruits'),
(8,'Natural Sweeteners'),
(9,'Healthy Seeds'),
(10,'Personal Care');

-- ==========================================
-- Membership
-- ==========================================

INSERT INTO Membership
VALUES
(1,'Silver',5,499,12),
(2,'Gold',10,999,12),
(3,'Platinum',15,1999,12);

-- ==========================================
-- Products
-- ==========================================
INSERT INTO Products
VALUES
(101,'Almonds',1,500,350,50,'NatureNest'),
(102,'Cashews',1,700,520,40,'NatureNest'),
(103,'Herbal Shampoo',2,350,220,80,'NatureNest'),
(104,'Hair Oil',2,250,150,100,'NatureNest'),
(105,'Immunity Booster',3,450,300,60,'NatureNest'),
(106,'Hair Mask',2,300,180,45,'NatureNest');


INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(107,'Pistachios',1,850.00,650.00,35,'NatureNest'),
(108,'Walnuts',1,900.00,700.00,30,'Organic India'),
(109,'Peanuts',1,180.00,120.00,120,'24 Mantra'),
(110,'Mixed Nuts',1,950.00,720.00,25,'True Elements'),
(111,'Brazil Nuts',1,1200.00,950.00,20,'Nutraj');

INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(112,'Hair Conditioner',2,320.00,220.00,70,'Himalaya'),
(113,'Hair Serum',2,450.00,320.00,50,'Mamaearth'),
(114,'Herbal Hair Cream',2,280.00,180.00,60,'Patanjali'),
(115,'Onion Hair Shampoo',2,390.00,270.00,75,'WOW'),
(116,'Anti Hair Fall Oil',2,350.00,240.00,65,'Dabur');
INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(117,'Multivitamin Tablets',3,650.00,480.00,55,'Himalaya'),
(118,'Amla Juice',3,280.00,180.00,80,'Patanjali'),
(119,'Moringa Powder',3,420.00,290.00,45,'Organic India'),
(120,'Aloe Vera Juice',3,350.00,240.00,70,'Dabur'),
(121,'Vitamin C Tablets',3,550.00,390.00,60,'HealthKart');

  
  INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(122,'Aloe Vera Gel',4,250.00,160.00,90,'Patanjali'),
(123,'Neem Face Wash',4,320.00,210.00,75,'Himalaya'),
(124,'Rose Water',4,180.00,110.00,120,'Dabur'),
(125,'Vitamin C Face Serum',4,650.00,450.00,40,'Mamaearth'),
(126,'Charcoal Face Scrub',4,380.00,260.00,55,'WOW');

INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(127,'Organic Wheat Flour',5,180.00,120.00,100,'24 Mantra'),
(128,'Organic Rice',5,650.00,480.00,80,'Organic India'),
(129,'Organic Jaggery Powder',5,220.00,150.00,90,'NatureLand'),
(130,'Organic Moong Dal',5,320.00,230.00,70,'Pro Nature'),
(131,'Organic Toor Dal',5,380.00,280.00,60,'24 Mantra');


INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(132,'Tulsi Green Tea',6,280.00,180.00,70,'Organic India'),
(133,'Ginger Herbal Tea',6,250.00,160.00,65,'Typhoo'),
(134,'Chamomile Tea',6,420.00,300.00,45,'Twinings'),
(135,'Lemon Herbal Tea',6,300.00,200.00,60,'Lipton'),
(136,'Mint Herbal Tea',6,270.00,170.00,75,'Tetley');

INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(137,'Premium Raisins',7,320.00,220.00,85,'Nutraj'),
(138,'Dried Apricots',7,680.00,500.00,40,'Urban Platter'),
(139,'Dried Figs',7,750.00,560.00,35,'Happilo'),
(140,'Dates Premium',7,420.00,300.00,90,'Lion Dates'),
(141,'Black Raisins',7,380.00,260.00,70,'Farmley');

INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(142,'Organic Honey',8,450.00,320.00,80,'Dabur'),
(143,'Wild Forest Honey',8,650.00,480.00,55,'Patanjali'),
(144,'Natural Jaggery Syrup',8,280.00,180.00,70,'24 Mantra'),
(145,'Date Syrup',8,520.00,380.00,45,'NatureLand'),
(146,'Palm Jaggery',8,350.00,240.00,60,'Organic India');
INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(147,'Chia Seeds',9,480.00,340.00,75,'True Elements'),
(148,'Flax Seeds',9,220.00,150.00,100,'Nutraj'),
(149,'Pumpkin Seeds',9,520.00,390.00,60,'Happilo'),
(150,'Sunflower Seeds',9,260.00,180.00,90,'Farmley'),
(151,'Mixed Seeds',9,580.00,420.00,50,'True Elements');

INSERT INTO Products
(ProductID, ProductName, CategoryID, SellingPrice, CostPrice, StockQuantity, Brand)
VALUES
(152,'Herbal Soap',10,180.00,110.00,120,'Medimix'),
(153,'Natural Toothpaste',10,140.00,90.00,150,'Dabur'),
(154,'Body Lotion',10,380.00,260.00,70,'Nivea'),
(155,'Hand Wash',10,220.00,150.00,100,'Dettol');
  

-- ==========================================
-- Transaction Data
-- ==========================================
--
-- Large transactional datasets are provided
-- separately as CSV files inside the Data folder.
--
-- Files:
-- • NatureNest_Customers.csv
-- • NatureNest_Orders.csv
-- • NatureNest_OrderDetails.csv
--
-- These files can be imported into MySQL Workbench
-- using the Table Data Import Wizard.
--
-- ==========================================






















