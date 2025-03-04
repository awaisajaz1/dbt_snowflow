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
