-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(10)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) UNIQUE,
    Category VARCHAR(50),
    UnitPrice DECIMAL(10, 2) CHECK (UnitPrice > 0),
    StockQuantity INT CHECK (StockQuantity >= 0)
);

-- Orders Table
-- This table tracks each individual order placed by a customer
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderStatus VARCHAR(50) -- e.g., 'Pending', 'Shipped', 'Delivered', 'Cancelled'
    -- TotalAmount DECIMAL(10, 2) -- Can be calculated from OrderItems
);

-- OrderItems Table
-- This table tracks individual items within an order
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    ItemPrice DECIMAL(10, 2) -- Price of the product at the time of order
);

-- Employees Table (for understanding hierarchical queries and self-joins)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    HireDate DATE,
    JobTitle VARCHAR(100),
    Salary DECIMAL(10, 2),
    ManagerID INT, -- Self-referencing foreign key for hierarchy
    Department VARCHAR(50)
);

-- Returns Table (for understanding outer joins, specific scenarios)
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    OrderItemID INT UNIQUE, -- Foreign key to OrderItems
    ReturnDate DATE,
    Reason VARCHAR(255),
    RefundAmount DECIMAL(10, 2)
);

-- Sample Data Inserts (Enough to get started with basic queries)

-- Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address, City, State, ZipCode) VALUES
(1, 'Alice', 'Smith', 'alice.s@example.com', '555-1001', '123 Main St', 'Anytown', 'CA', '90210'),
(2, 'Bob', 'Johnson', 'bob.j@example.com', '555-1002', '456 Oak Ave', 'Springfield', 'IL', '62704'),
(3, 'Charlie', 'Brown', 'charlie.b@example.com', '555-1003', '789 Pine Ln', 'Anytown', 'CA', '90210'),
(4, 'Diana', 'Prince', 'diana.p@example.com', '555-1004', '101 Wonder Rd', 'Themyscira', 'GA', '30303'),
(5, 'Eve', 'Davis', 'eve.d@example.com', '555-1005', '222 River St', 'Anytown', 'CA', '90210');

-- Products
INSERT INTO Products (ProductID, ProductName, Category, UnitPrice, StockQuantity) VALUES
(101, 'Laptop Pro X', 'Electronics', 1200.00, 50),
(102, 'Mechanical Keyboard', 'Electronics', 150.00, 100),
(103, 'Wireless Mouse', 'Electronics', 50.00, 200),
(104, 'Desk Chair Ergonomic', 'Furniture', 300.00, 30),
(105, 'Coffee Mug (Ceramic)', 'Home Goods', 15.00, 500),
(106, 'Smartphone Z', 'Electronics', 800.00, 75);

-- Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderStatus) VALUES
(1001, 1, '2024-01-15', 'Delivered'),
(1002, 2, '2024-01-17', 'Shipped'),
(1003, 1, '2024-02-01', 'Delivered'),
(1004, 3, '2024-02-05', 'Pending'),
(1005, 4, '2024-02-10', 'Delivered'),
(1006, 2, '2024-03-01', 'Cancelled'),
(1007, 5, '2024-03-05', 'Shipped');

-- OrderItems
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, ItemPrice) VALUES
(1, 1001, 101, 1, 1200.00),
(2, 1001, 103, 2, 50.00),
(3, 1002, 104, 1, 300.00),
(4, 1003, 102, 1, 150.00),
(5, 1003, 105, 3, 15.00),
(6, 1004, 101, 1, 1200.00),
(7, 1005, 106, 1, 800.00),
(8, 1005, 103, 1, 50.00),
(9, 1006, 105, 2, 15.00),
(10, 1007, 102, 1, 150.

-- Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, HireDate, JobTitle, Salary, ManagerID, Department) VALUES
(1, 'John', 'Doe', 'john.d@company.com', '2020-01-01', 'CEO', 150000.00, NULL, 'Executive'),
(2, 'Jane', 'Smith', 'jane.s@company.com', '2020-03-15', 'CTO', 120000.00, 1, 'Technology'),
(3, 'Peter', 'Jones', 'peter.j@company.com', '2020-06-01', 'Data Analyst', 70000.00, 2, 'Technology'),
(4, 'Sarah', 'Lee', 'sarah.l@company.com', '2021-01-10', 'Data Engineer', 90000.00, 2, 'Technology'),
(5, 'Mike', 'Wang', 'mike.w@company.com', '2021-05-20', 'Sales Manager', 85000.00, 1, 'Sales'),
(6, 'Emily', 'Chen', 'emily.c@company.com', '2022-02-01', 'Sales Rep', 60000.00, 5, 'Sales');

-- Returns
INSERT INTO Returns (ReturnID, OrderItemID, ReturnDate, Reason, RefundAmount) VALUES
(201, 2, '2024-01-20', 'Customer changed mind', 100.00),
(202, 9, '2024-03-05', 'Damaged item', 30.00);