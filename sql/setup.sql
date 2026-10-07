CREATE DATABASE ECommerceDB;
GO

USE ECommerceDB;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL
);
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus NVARCHAR(20) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentMethod NVARCHAR(30) NOT NULL,
    PaymentStatus NVARCHAR(20) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
(1, 'Ali Khan', 'ali@example.com'),
(2, 'Sara Ahmed', 'sara@example.com'),
(3, 'John Smith', 'john@example.com'),
(4, 'Ayesha Malik', 'ayesha@example.com'),
(5, 'Hamza Ali', 'hamza@example.com');
GO

INSERT INTO Products (ProductID, ProductName, Price, StockQuantity)
VALUES
(1, 'Laptop', 1200.00, 10),
(2, 'Mouse', 25.00, 50),
(3, 'Keyboard', 45.00, 30),
(4, 'Monitor', 300.00, 15),
(5, 'Headphones', 80.00, 25);
GO

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderStatus)
VALUES
(1, 1, '2026-01-01', 'Pending'),
(2, 2, '2026-01-02', 'Shipped'),
(3, 3, '2026-01-03', 'Completed');
GO

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 1, 1200.00),
(2, 1, 2, 2, 25.00),
(3, 2, 3, 1, 45.00),
(4, 3, 4, 1, 300.00);
GO

INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES
(1, 1, 'Credit Card', 'Pending'),
(2, 2, 'Debit Card', 'Paid'),
(3, 3, 'Cash on Delivery', 'Paid');
GO
EOFcat > sql/setup.sql <<'EOF'
CREATE DATABASE ECommerceDB;
GO

USE ECommerceDB;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL
);
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus NVARCHAR(20) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentMethod NVARCHAR(30) NOT NULL,
    PaymentStatus NVARCHAR(20) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
(1, 'Ali Khan', 'ali@example.com'),
(2, 'Sara Ahmed', 'sara@example.com'),
(3, 'John Smith', 'john@example.com'),
(4, 'Ayesha Malik', 'ayesha@example.com'),
(5, 'Hamza Ali', 'hamza@example.com');
GO

INSERT INTO Products (ProductID, ProductName, Price, StockQuantity)
VALUES
(1, 'Laptop', 1200.00, 10),
(2, 'Mouse', 25.00, 50),
(3, 'Keyboard', 45.00, 30),
(4, 'Monitor', 300.00, 15),
(5, 'Headphones', 80.00, 25);
GO

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderStatus)
VALUES
(1, 1, '2026-01-01', 'Pending'),
(2, 2, '2026-01-02', 'Shipped'),
(3, 3, '2026-01-03', 'Completed');
GO

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 1, 1200.00),
(2, 1, 2, 2, 25.00),
(3, 2, 3, 1, 45.00),
(4, 3, 4, 1, 300.00);
GO

INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentStatus)
VALUES
(1, 1, 'Credit Card', 'Pending'),
(2, 2, 'Debit Card', 'Paid'),
(3, 3, 'Cash on Delivery', 'Paid');
GO
