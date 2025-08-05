-- Section B: Subqueries & Common Table Expressions (CTEs)
-- ==========================================================

-- 1. Find the ProductName of the product with the highest UnitPrice
SELECT ProductName
FROM dbo.Products
WHERE UnitPrice = (
    SELECT MAX(UnitPrice)
    FROM dbo.Products
);

-- 2. List customers who have purchased 'Laptop Pro X'
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS FullName
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IN (
    SELECT OrderID
    FROM dbo.OrderItems
    WHERE ProductID = (
        SELECT ProductID
        FROM dbo.Products
        WHERE ProductName = 'Laptop Pro X'
    )
);

-- 3. Find orders that contain more than 1 unique product
SELECT o.OrderID, o.OrderDate, o.OrderStatus
FROM dbo.Orders o
JOIN (
    SELECT OrderID, COUNT(DISTINCT ProductID) AS UniqueProductCount
    FROM dbo.OrderItems
    GROUP BY OrderID
    HAVING COUNT(DISTINCT ProductID) > 1
) AS MultipleProducts ON o.OrderID = MultipleProducts.OrderID;

-- 4. Calculate the average order value
-- (Subquery version)
SELECT AVG(OrderValue) AS AvgOrderValue
FROM (
    SELECT OrderID, SUM(Quantity * ItemPrice) AS OrderValue
    FROM dbo.OrderItems
    GROUP BY OrderID
) AS OrdersTotal;

-- (CTE version)
WITH OrdersTotal AS (
    SELECT OrderID, SUM(Quantity * ItemPrice) AS OrderValue
    FROM dbo.OrderItems
    GROUP BY OrderID
)
SELECT AVG(OrderValue) AS AvgOrderValue
FROM OrdersTotal;

-- 5. Find the top 3 most expensive products
SELECT TOP 3 ProductName
FROM dbo.Products
ORDER BY UnitPrice DESC;

-- 6. Using a CTE, find all employees who earn more than the average salary of their department
WITH AvgDeptSal AS (
    SELECT Department, AVG(Salary) AS AvgSalary
    FROM dbo.Employees
    GROUP BY Department
)
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
FROM dbo.Employees e
JOIN AvgDeptSal d ON e.Department = d.Department
WHERE e.Salary > d.AvgSalary;

-- 7. Find customers who placed orders with total value > $500 (using a CTE)
WITH OrderTotals AS (
    SELECT OrderID, SUM(Quantity * ItemPrice) AS TotalOrderValue
    FROM dbo.OrderItems
    GROUP BY OrderID
),
HighValueOrders AS (
    SELECT OrderID, TotalOrderValue
    FROM OrderTotals
    WHERE TotalOrderValue > 500.00
)
SELECT DISTINCT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerFullName
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
JOIN HighValueOrders hvo ON o.OrderID = hvo.OrderID
ORDER BY CustomerFullName;
