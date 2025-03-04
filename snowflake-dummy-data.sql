---- Now we have created warehouse, Database, Role and Schemas
-- Create tables and insert some data

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT  PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(100)
);


-- Customers Table
CREATE TABLE City (
    CityID VARCHAR(100)  PRIMARY KEY,
    PostalCode VARCHAR(20),
    Country VARCHAR(100)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT  PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Supplier VARCHAR(255),
    Category VARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20) DEFAULT 'Pending',  -- Use VARCHAR instead of ENUM
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Order Details Table (for many-to-many relationship between Orders and Products)
CREATE TABLE OrderDetails (
    OrderDetailID INT  PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Sample Customers
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Address, City) VALUES
(1, 'Acme Corps', 'John Doe', '123 Elm St', 'New York'),
(2, 'Tech Solutions', 'Alice Johnson', '456 Maple Ave', 'Los Angeles'),
(3, 'Global Traders', 'Mohammed Khan', '789 Oak Dr', 'London');

-- TRUNCATE table source.customers; -- to test delta data
-- INSERT INTO Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country) VALUES
-- (1, 'Acme Corp updated', 'John Doe', '123 Elm St', 'New York', '10001', 'USA'),
-- (4, 'Qore Solutions', 'Alice Johnson', '456 Maple Ave', 'Los Angeles', '90001', 'USA')

-- Insert Sample City
INSERT INTO City (CityID, PostalCode, Country) VALUES
('New York', '10001', 'USA'),
('Los Angeles', '90001', 'USA'),
('London', 'SW1A 1AA', 'UK');


-- Insert Sample Products
INSERT INTO Products (ProductID, ProductName, Supplier, Category, Price, Stock) VALUES
(1, 'Laptop', 'Tech Distributors', 'Electronics', 899.99, 50),
(2, 'Smartphone', 'Mobile World', 'Electronics', 499.99, 100),
(3, 'Office Chair', 'Furniture Co.', 'Furniture', 149.99, 30);

-- Insert Sample Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Status, TotalAmount) VALUES
(1, 1, '2025-02-15', 'Shipped', 1399.98),
(2, 2, '2025-02-16', 'Pending', 499.99),
(3, 3, '2025-02-17', 'Delivered', 149.99);

-- Insert Sample Order Details
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 899.99),  -- 1 Laptop for Order 1
(2, 1, 2, 1, 499.99),  -- 1 Smartphone for Order 1
(3, 2, 2, 1, 499.99),  -- 1 Smartphone for Order 2
(4, 3, 3, 1, 149.99);  -- 1 Office Chair for Order 3