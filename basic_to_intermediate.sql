-- Section A: Basic to Intermediate SQL Queries
-- ==============================================

-- 1. Retrieve all customer details
SELECT * 
FROM dbo.Customers;

-- 2. List products in the 'Electronics' category
SELECT ProductName, UnitPrice
FROM dbo.Products
WHERE Category = 'Electronics';

-- 3. Find orders placed in February 2024 (Method 1 - using MONTH/YEAR)
SELECT OrderID, CustomerID, OrderDate 
FROM dbo.Orders
WHERE MONTH(OrderDate) = 2 AND YEAR(OrderDate) = 2024;

-- (Method 2 - using DATENAME)
SELECT OrderID, CustomerID, OrderDate 
FROM dbo.Orders
WHERE DATENAME(MONTH, OrderDate) = 'February' AND YEAR(OrderDate) = 2024;

-- 4. Calculate the total number of products in stock for each category
SELECT Category, SUM(StockQuantity) AS TotalStock
FROM dbo.Products
GROUP BY Category;

-- 5. Find customers who have placed more than 1 order
SELECT CustomerID, COUNT(OrderID) AS NoOfOrders
FROM dbo.Orders 
GROUP BY CustomerID
HAVING COUNT(OrderID) > 1;

-- 6. List all products that cost more than $100 and have more than 50 units in stock
SELECT ProductName
FROM dbo.Products
WHERE UnitPrice > 100 AND StockQuantity > 50;

-- 7. Get the names of customers and the IDs of orders they placed
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS FullName, o.OrderID
FROM dbo.Customers c
JOIN dbo.Orders o ON o.CustomerID = c.CustomerID;

-- 8. List all product names along with the number of times they've been ordered
-- (Include products that have never been ordered)
SELECT p.ProductName, COUNT(o.ProductID) AS NoOfTimesOrdered
FROM dbo.Products p 
LEFT JOIN dbo.OrderItems o ON p.ProductID = o.ProductID
GROUP BY p.ProductName;

-- 9. Find the total revenue generated from each product category
SELECT p.Category, SUM(o.Quantity * o.ItemPrice) AS Revenue
FROM dbo.Products p 
LEFT JOIN dbo.OrderItems o ON p.ProductID = o.ProductID
GROUP BY p.Category;

-- 10. Determine the total amount spent by each customer
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    SUM(oi.Quantity * oi.ItemPrice) AS TotalSpent
FROM dbo.Customers c
JOIN dbo.Orders o ON o.CustomerID = c.CustomerID
JOIN dbo.OrderItems oi ON oi.OrderID = o.OrderID
GROUP BY CONCAT(c.FirstName, ' ', c.LastName);

-- 11. List all employees and their managers' names
-- (Include employees who don't have a manager - e.g., CEO)
SELECT 
    CONCAT(e1.FirstName, ' ', e1.LastName) AS EmployeeName,
    CONCAT(e2.FirstName, ' ', e2.LastName) AS ManagerName
FROM dbo.Employees e1
LEFT JOIN dbo.Employees e2 ON e1.ManagerID = e2.EmployeeID;
