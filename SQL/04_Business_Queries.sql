-- ============================================================
-- NatureNest SQL Retail Analytics Project
-- File: 04_Business_Analytics_Queries.sql
-- Author: Suvarna Kanuparthi
--
-- Description:
-- This file contains real-world business analysis queries
-- written using MySQL. The queries answer common retail
-- business questions related to customers, products,
-- sales, revenue, brands, payment methods, and categories.
--
-- SQL Concepts Demonstrated:
-- • SELECT
-- • WHERE
-- • ORDER BY
-- • GROUP BY
-- • HAVING
-- • INNER JOIN
-- • LEFT JOIN
-- • Aggregate Functions
-- • Subqueries
-- • Correlated Subqueries
-- • Derived Tables
-- • Business Analytics
-- ============================================================

USE NatureNest;



/*==============================================================
Business Problem 01
Find the most frequently used payment method.
==============================================================*/

SELECT
    o.PaymentMethod,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders AS o
GROUP BY
    o.PaymentMethod
ORDER BY
    TotalOrders DESC;




/*==============================================================
Business Problem 02
Find the city with the highest number of customer orders.
==============================================================*/

SELECT
    c.City,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.City
ORDER BY
    TotalOrders DESC;



/*==============================================================
Business Problem 03
Identify the Top 5 customers based on total spending.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    SUM(od.Quantity * od.SellingPrice) AS TotalSpent
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
GROUP BY
    c.CustomerID,
    c.FullName
ORDER BY
    TotalSpent DESC
LIMIT 5;


/*==============================================================
Business Problem 04
Find brands that generated the highest revenue.
==============================================================*/

SELECT
    p.Brand,
    SUM(od.Quantity * od.SellingPrice) AS TotalRevenue
FROM Products AS p
INNER JOIN OrderDetails AS od
    ON p.ProductID = od.ProductID
GROUP BY
    p.Brand
ORDER BY
    TotalRevenue DESC;





/*==============================================================
Business Problem 05
Find products that have never been ordered.
==============================================================*/

SELECT
    p.ProductID,
    p.ProductName,
    p.Brand
FROM Products AS p
LEFT JOIN OrderDetails AS od
    ON p.ProductID = od.ProductID
WHERE
    od.ProductID IS NULL
ORDER BY
    p.ProductName;





/*==============================================================
Business Problem 06
Find the month that generated the highest revenue.
==============================================================*/

SELECT
    MONTHNAME(o.OrderDate) AS Month,
    SUM(od.Quantity * od.SellingPrice) AS TotalRevenue
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
GROUP BY
    MONTHNAME(o.OrderDate)
ORDER BY
    TotalRevenue DESC
LIMIT 1;





/*==============================================================
Business Problem 07
Find products priced above the overall average selling price.
==============================================================*/

SELECT
    p.ProductID,
    p.ProductName,
    p.SellingPrice,
    p.Brand
FROM Products AS p
WHERE
    p.SellingPrice >
    (
        SELECT AVG(SellingPrice)
        FROM Products
    )
ORDER BY
    p.SellingPrice DESC;





/*==============================================================
Business Problem 08
Find categories whose average selling price is higher
than the overall average selling price.
==============================================================*/

SELECT
    c.CategoryName,
    AVG(p.SellingPrice) AS AverageSellingPrice
FROM Categories AS c
INNER JOIN Products AS p
    ON c.CategoryID = p.CategoryID
GROUP BY
    c.CategoryName
HAVING
    AVG(p.SellingPrice) >
    (
        SELECT AVG(SellingPrice)
        FROM Products
    )
ORDER BY
    AverageSellingPrice DESC;





/*==============================================================
Business Problem 09
Find customers who placed more orders than the
average number of orders placed by all customers.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName
HAVING
    TotalOrders >
    (
        SELECT AVG(OrderCount)
        FROM
        (
            SELECT
                CustomerID,
                COUNT(OrderID) AS OrderCount
            FROM Orders
            GROUP BY CustomerID
        ) AS AverageOrders
    )
ORDER BY
    TotalOrders DESC;





/*==============================================================
Business Problem 10
Find products that generated above-average revenue.
==============================================================*/

SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity * od.SellingPrice) AS TotalRevenue
FROM Products AS p
INNER JOIN OrderDetails AS od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
HAVING
    TotalRevenue >
    (
        SELECT AVG(ProductRevenue)
        FROM
        (
            SELECT
                SUM(Quantity * SellingPrice) AS ProductRevenue
            FROM OrderDetails
            GROUP BY ProductID
        ) AS RevenueData
    )
ORDER BY
    TotalRevenue DESC;




/*==============================================================
Business Problem 11
Find customers whose total spending is greater than the
average spending of all customers.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    SUM(od.Quantity * od.SellingPrice) AS TotalSpent
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
GROUP BY
    c.CustomerID,
    c.FullName
HAVING
    TotalSpent >
    (
        SELECT AVG(CustomerTotal)
        FROM
        (
            SELECT
                c.CustomerID,
                SUM(od.Quantity * od.SellingPrice) AS CustomerTotal
            FROM Customers AS c
            INNER JOIN Orders AS o
                ON c.CustomerID = o.CustomerID
            INNER JOIN OrderDetails AS od
                ON o.OrderID = od.OrderID
            GROUP BY
                c.CustomerID
        ) AS CustomerSpending
    )
ORDER BY
    TotalSpent DESC;





/*==============================================================
Business Problem 12
Find categories that contain more than five products.
==============================================================*/

SELECT
    c.CategoryID,
    c.CategoryName,
    COUNT(p.ProductID) AS TotalProducts
FROM Categories AS c
INNER JOIN Products AS p
    ON c.CategoryID = p.CategoryID
GROUP BY
    c.CategoryID,
    c.CategoryName
HAVING
    COUNT(p.ProductID) > 5
ORDER BY
    TotalProducts DESC;





/*==============================================================
Business Problem 13
Find customers who have never placed an order.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    c.City
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE
    o.OrderID IS NULL
ORDER BY
    c.FullName;





/*==============================================================
Business Problem 14
Find customers who purchased products from
more than one category.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    COUNT(DISTINCT p.CategoryID) AS CategoriesPurchased
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY
    c.CustomerID,
    c.FullName
HAVING
    CategoriesPurchased > 1
ORDER BY
    CategoriesPurchased DESC;





/*==============================================================
Business Problem 15
Find the average order value for each payment method.
==============================================================*/

SELECT
    Final.PaymentMethod,
    AVG(Final.OrderValue) AS AverageOrderValue
FROM
(
    SELECT
        o.PaymentMethod,
        od.OrderID,
        SUM(od.Quantity * od.SellingPrice) AS OrderValue
    FROM Orders AS o
    INNER JOIN OrderDetails AS od
        ON o.OrderID = od.OrderID
    GROUP BY
        o.PaymentMethod,
        od.OrderID
) AS Final
GROUP BY
    Final.PaymentMethod
ORDER BY
    AverageOrderValue DESC;





/*==============================================================
Business Problem 16
Find the customer(s) who spent the highest total amount.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    SUM(od.Quantity * od.SellingPrice) AS TotalSpent
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
GROUP BY
    c.CustomerID,
    c.FullName
HAVING
    TotalSpent =
    (
        SELECT MAX(CustomerTotal)
        FROM
        (
            SELECT
                c.CustomerID,
                SUM(od.Quantity * od.SellingPrice) AS CustomerTotal
            FROM Customers AS c
            INNER JOIN Orders AS o
                ON c.CustomerID = o.CustomerID
            INNER JOIN OrderDetails AS od
                ON o.OrderID = od.OrderID
            GROUP BY
                c.CustomerID
        ) AS CustomerTotals
    )
ORDER BY
    TotalSpent DESC;





/*==============================================================
Business Problem 17
Show monthly sales revenue.
==============================================================*/

SELECT
    MONTH(o.OrderDate) AS MonthNumber,
    MONTHNAME(o.OrderDate) AS Month,
    SUM(od.Quantity * od.SellingPrice) AS Revenue
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
GROUP BY
    MONTH(o.OrderDate),
    MONTHNAME(o.OrderDate)
ORDER BY
    MonthNumber;





/*==============================================================
Business Problem 18
Find brands that sell products in more than one category.
==============================================================*/

SELECT
    p.Brand,
    COUNT(DISTINCT p.CategoryID) AS CategoriesCovered
FROM Products AS p
GROUP BY
    p.Brand
HAVING
    CategoriesCovered > 1
ORDER BY
    CategoriesCovered DESC,
    p.Brand ASC;





/*==============================================================
Business Problem 19
Find customers who placed orders in more than one month.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    COUNT(DISTINCT MONTH(o.OrderDate)) AS MonthsPurchased
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName
HAVING
    MonthsPurchased > 1
ORDER BY
    MonthsPurchased DESC,
    c.FullName ASC;





/*==============================================================
Business Problem 20
Show every customer and the total number of orders
they have placed, including customers with no orders.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    c.City,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName,
    c.City
ORDER BY
    TotalOrders DESC,
    c.FullName ASC;




/*==============================================================
Business Problem 21
Find the most expensive product in each category.
==============================================================*/

SELECT
    c.CategoryName,
    p.ProductName,
    p.SellingPrice
FROM Products AS p
INNER JOIN Categories AS c
    ON p.CategoryID = c.CategoryID
WHERE
    p.SellingPrice =
    (
        SELECT MAX(p2.SellingPrice)
        FROM Products AS p2
        WHERE p2.CategoryID = p.CategoryID
    )
ORDER BY
    c.CategoryName,
    p.SellingPrice DESC;





/*==============================================================
Business Problem 22
Show every category and the number of products it
contains, including categories with no products.
==============================================================*/

SELECT
    c.CategoryID,
    c.CategoryName,
    COUNT(p.ProductID) AS TotalProducts
FROM Categories AS c
LEFT JOIN Products AS p
    ON c.CategoryID = p.CategoryID
GROUP BY
    c.CategoryID,
    c.CategoryName
ORDER BY
    TotalProducts DESC,
    c.CategoryName ASC;





/*==============================================================
Business Problem 23
Find the payment method that generated the
highest total revenue.
==============================================================*/

SELECT
    o.PaymentMethod,
    SUM(od.Quantity * od.SellingPrice) AS TotalRevenue
FROM Orders AS o
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
GROUP BY
    o.PaymentMethod
HAVING
    TotalRevenue =
    (
        SELECT MAX(Revenue)
        FROM
        (
            SELECT
                SUM(od.Quantity * od.SellingPrice) AS Revenue
            FROM Orders AS o
            INNER JOIN OrderDetails AS od
                ON o.OrderID = od.OrderID
            GROUP BY
                o.PaymentMethod
        ) AS PaymentRevenue
    )
ORDER BY
    TotalRevenue DESC;





/*==============================================================
Business Problem 24
Find customers who have used more than one
payment method.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    COUNT(DISTINCT o.PaymentMethod) AS PaymentMethodsUsed
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName
HAVING
    PaymentMethodsUsed > 1
ORDER BY
    PaymentMethodsUsed DESC,
    c.FullName ASC;





/*==============================================================
Business Problem 25
Find the highest revenue-generating product
within each category.
==============================================================*/

SELECT
    t.CategoryName,
    t.ProductName,
    t.TotalRevenue
FROM
(
    SELECT
        c.CategoryName,
        p.CategoryID,
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity * od.SellingPrice) AS TotalRevenue
    FROM Categories AS c
    INNER JOIN Products AS p
        ON c.CategoryID = p.CategoryID
    INNER JOIN OrderDetails AS od
        ON p.ProductID = od.ProductID
    GROUP BY
        c.CategoryName,
        p.CategoryID,
        p.ProductID,
        p.ProductName
) AS t
WHERE
    t.TotalRevenue =
    (
        SELECT MAX(t2.TotalRevenue)
        FROM
        (
            SELECT
                p.CategoryID,
                p.ProductID,
                SUM(od.Quantity * od.SellingPrice) AS TotalRevenue
            FROM Products AS p
            INNER JOIN OrderDetails AS od
                ON p.ProductID = od.ProductID
            GROUP BY
                p.CategoryID,
                p.ProductID
        ) AS t2
        WHERE t2.CategoryID = t.CategoryID
    )
ORDER BY
    t.CategoryName,
    t.TotalRevenue DESC;





/*==============================================================
Business Problem 26
Find customers who have purchased products
from every available category.
==============================================================*/

SELECT
    c.CustomerID,
    c.FullName,
    COUNT(DISTINCT p.CategoryID) AS CategoriesPurchased
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN Products AS p
    ON od.ProductID = p.ProductID
GROUP BY
    c.CustomerID,
    c.FullName
HAVING
    CategoriesPurchased =
    (
        SELECT COUNT(*)
        FROM Categories
    )
ORDER BY
    c.FullName ASC;





/*==============================================================
Business Problem 27
Find brands that generated above-average revenue.
==============================================================*/

SELECT
    p.Brand,
    SUM(od.Quantity * od.SellingPrice) AS TotalRevenue
FROM Products AS p
INNER JOIN OrderDetails AS od
    ON p.ProductID = od.ProductID
GROUP BY
    p.Brand
HAVING
    TotalRevenue >
    (
        SELECT AVG(BrandRevenue)
        FROM
        (
            SELECT
                SUM(od.Quantity * od.SellingPrice) AS BrandRevenue
            FROM Products AS p
            INNER JOIN OrderDetails AS od
                ON p.ProductID = od.ProductID
            GROUP BY
                p.Brand
        ) AS AverageRevenue
    )
ORDER BY
    TotalRevenue DESC,
    p.Brand ASC;






















