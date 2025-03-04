
  
    

        create or replace transient table dbt_dwh.curated.customer_dimension
         as
        (


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
        );
      
  