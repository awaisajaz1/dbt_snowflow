


select 
    CustomerID,
    CustomerName, 
    ContactPerson, 
    Address, 
    City,
    PostalCode,
    Country
from 
dbt_dwh.staging.customers_stage