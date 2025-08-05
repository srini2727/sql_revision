-- Section D: Data Manipulation & Advanced Concepts
-- ===================================================

-- 1. Find customers who have placed an order AND returned an item
SELECT DISTINCT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerFullName
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
JOIN dbo.OrderItems oi ON o.OrderID = oi.OrderID
JOIN dbo.Returns r ON oi.OrderItemID = r.OrderItemID
ORDER BY CustomerFullName;

-- 2. List all customers and their OrderID (if any)
-- Include customers who have not placed any orders
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    o.OrderID
FROM dbo.Customers c
LEFT JOIN dbo.Orders o ON c.CustomerID = o.CustomerID;

-- 3. List all products and their ReturnDate (if returned)
-- Include products that have never been returned
SELECT 
    p.ProductName, 
    r.ReturnDate
FROM dbo.Products p
LEFT JOIN dbo.OrderItems o ON p.ProductID = o.ProductID
LEFT JOIN dbo.Returns r ON r.OrderItemID = o.OrderItemID
ORDER BY p.ProductName, r.ReturnDate;

-- 4. Find OrderItems that were part of a Cancelled order
SELECT 
    oi.OrderItemID,
    oi.OrderID,
    oi.ProductID,
    oi.Quantity,
    oi.ItemPrice,
    o.OrderDate,
    o.OrderStatus
FROM dbo.OrderItems oi
JOIN dbo.Orders o ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Cancelled';

-- 5. Identify duplicate Email addresses in the Customers table
-- Useful if UNIQUE constraint is not enforced
SELECT Email
FROM dbo.Customers
GROUP BY Email
HAVING COUNT(Email) > 1;

-- 6. Find gaps in OrderIDs if they were meant to be sequential
-- Using LEAD() window function
SELECT
    CurrentOrderID AS GapStartsAfterID,
    NextOrderID AS GapEndsBeforeID,
    (NextOrderID - CurrentOrderID - 1) AS NumberOfMissingIDs
FROM (
    SELECT
        OrderID AS CurrentOrderID,
        LEAD(OrderID, 1) OVER (ORDER BY OrderID ASC) AS NextOrderID
    FROM dbo.Orders
) AS OrderedOrders
WHERE
    NextOrderID IS NOT NULL
    AND (NextOrderID - CurrentOrderID) > 1
ORDER BY CurrentOrderID;
