-- ==========================================
-- NatureNest SQL Retail Analytics Project
-- File: 02_Create_Tables.sql
-- Description: Creates all database tables.
-- ==========================================

USE NatureNest;

-- ==========================================
-- Categories Table
-- ==========================================

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

-- ==========================================
-- Membership Table
-- ==========================================

CREATE TABLE Membership (
    MembershipID INT PRIMARY KEY,
    MembershipName VARCHAR(50) NOT NULL,
    DiscountPercentage DECIMAL(5,2),
    AnnualFee DECIMAL(10,2),
    ValidityMonths INT
);

-- ==========================================
-- Products Table
-- ==========================================

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    SellingPrice DECIMAL(10,2),
    CostPrice DECIMAL(10,2),
    StockQuantity INT,
    Brand VARCHAR(100),

    CONSTRAINT FK_Product_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);

-- ==========================================
-- Customers Table
-- ==========================================

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    RegistrationDate DATE,
    MembershipID INT,

    CONSTRAINT FK_Customer_Membership
        FOREIGN KEY (MembershipID)
        REFERENCES Membership(MembershipID)
);

-- ==========================================
-- Orders Table
-- ==========================================

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    PaymentMethod VARCHAR(30),
    OrderStatus VARCHAR(30),

    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- ==========================================
-- OrderDetails Table
-- ==========================================

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SellingPrice DECIMAL(10,2),

    CONSTRAINT FK_OrderDetails_Order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Product
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
