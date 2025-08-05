--  Section C: Window Functions
-- ==============================

-- 1. Rank products by UnitPrice within each Category (using RANK and DENSE_RANK)
SELECT 
    ProductName, 
    Category,
    UnitPrice,
    RANK() OVER (PARTITION BY Category ORDER BY UnitPrice DESC) AS Rank_,
    DENSE_RANK() OVER (PARTITION BY Category ORDER BY UnitPrice DESC) AS Dense_Rank_
FROM dbo.Products
ORDER BY Category, UnitPrice DESC;

-- 2. Find the second most expensive product in each Category
WITH RankedProducts AS (
    SELECT 
        ProductName, 
        Category,
        UnitPrice,
        DENSE_RANK() OVER (PARTITION BY Category ORDER BY UnitPrice DESC) AS Dense_Rank_
    FROM dbo.Products
)
SELECT 
    ProductName, 
    Category
FROM RankedProducts
WHERE Dense_Rank_ = 2;

-- 3. Running total of OrderAmount for each customer, ordered by OrderDate
WITH OrderTotals AS (
    SELECT 
        OrderID,
        SUM(Quantity * ItemPrice) AS TotalOrderValue
    FROM dbo.OrderItems
    GROUP BY OrderID
),
CustomerOrdersWithValues AS (
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.OrderDate,
        ot.TotalOrderValue
    FROM dbo.Customers c
    JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderTotals ot ON o.OrderID = ot.OrderID
)
SELECT
    cov.CustomerID,
    CONCAT(cov.FirstName, ' ', cov.LastName) AS CustomerFullName,
    cov.OrderID,
    cov.OrderDate,
    cov.TotalOrderValue,
    SUM(cov.TotalOrderValue) OVER (
        PARTITION BY cov.CustomerID
        ORDER BY cov.OrderDate, cov.OrderID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotalOrderValue
FROM CustomerOrdersWithValues cov
ORDER BY cov.CustomerID, cov.OrderDate, cov.OrderID;

-- 4. For each order, show the OrderID, OrderDate, and the PreviousOrderDate for that customer
SELECT 
    OrderID,
    OrderDate,
    LAG(OrderDate, 1) OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate ASC
    ) AS PreviousOrderDate
FROM dbo.Orders;

-- 5. Calculate average Salary for each employee's department (without grouping)
SELECT 
    CONCAT(FirstName, ' ', LastName) AS EmployeeName,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary
FROM dbo.Employees;

-- 6. Identify orders where the total quantity of items > average quantity across all orders
WITH OrderTotalQuantities AS (
    SELECT 
        OrderID,
        SUM(Quantity) AS TotalQuantityInOrder
    FROM dbo.OrderItems
    GROUP BY OrderID
)
SELECT
    o.OrderID,
    o.OrderDate,
    otq.TotalQuantityInOrder
FROM dbo.Orders o
JOIN OrderTotalQuantities otq ON o.OrderID = otq.OrderID
WHERE otq.TotalQuantityInOrder > (
    SELECT AVG(TotalQuantityInOrder)
    FROM OrderTotalQuantities
)
ORDER BY o.OrderID;
