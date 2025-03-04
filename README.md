# dbt Snowflake Project

## Overview
This project sets up a **Snowflake Data Warehouse** using dbt and Airflow. It includes:
- Creating a warehouse, database, roles, and schemas
- Defining tables and inserting sample data
- Configuring a dbt project for Snowflake
- Running dbt models within Airflow

## 1️⃣ Create Warehouse, Database, Role, and Schemas
```sql
CREATE WAREHOUSE compute_wh WITH WAREHOUSE_SIZE='X-SMALL';

CREATE DATABASE dbt_dwh;
CREATE ROLE dbt_role;

GRANT USAGE ON WAREHOUSE compute_wh TO ROLE dbt_role;
GRANT ROLE dbt_role TO USER AWAISAJAZ1;
GRANT ALL ON DATABASE dbt_dwh TO ROLE dbt_role;

USE ROLE dbt_role;
CREATE SCHEMA source;
CREATE SCHEMA staging;
CREATE SCHEMA curated;
```

## 2️⃣ Create Tables and Insert Sample Data
```sql
-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(100)
);

-- City Table
CREATE TABLE City (
    CityID VARCHAR(100) PRIMARY KEY,
    PostalCode VARCHAR(20),
    Country VARCHAR(100)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
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
    Status VARCHAR(20) DEFAULT 'Pending',
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Order Details Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

### Insert Sample Data
```sql
INSERT INTO Customers VALUES (1, 'Acme Corps', 'John Doe', '123 Elm St', 'New York');
INSERT INTO City VALUES ('New York', '10001', 'USA');
INSERT INTO Products VALUES (1, 'Laptop', 'Tech Distributors', 'Electronics', 899.99, 50);
INSERT INTO Orders VALUES (1, 1, '2025-02-15', 'Shipped', 1399.98);
INSERT INTO OrderDetails VALUES (1, 1, 1, 1, 899.99);
```

## 3️⃣ Setup dbt Project
### Install dbt for Snowflake
```bash
python -m venv venv
source venv/bin/activate  # (On Windows use `venv\Scripts\activate`)
pip install dbt-snowflake
```

### Initialize dbt Project
```bash
dbt init dbt_snowflake
```
Follow the prompts to configure:
```
account: <your_snowflake_account>
user: <your_username>
password: <your_password>
role: dbt_role
warehouse: compute_wh
database: dbt_dwh
schema: staging
threads: 10
```

### Install dbt Packages
Create `packages.yml`:
```yaml
packages:
  - package: dbt-labs/dbt_utils
    version: 1.3.0
```
Install dependencies:
```bash
dbt deps
```

## 4️⃣ Running dbt Models
Run dbt models:
```bash
dbt run --models staging
```

## 5️⃣ Deploy with Docker & Airflow
### Build & Start Services
```bash
docker-compose build
docker-compose up -d
```

### Access Airflow
Login at: [http://localhost:8080](http://localhost:8080)
```
Username: airflow
Password: airflow
```

Now, you're ready to orchestrate dbt workflows with Airflow! 🚀
