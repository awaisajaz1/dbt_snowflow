
  
    

        create or replace transient table dbt_dwh.staging.customers_view
         as
        (SELECT 
*
FROM
dbt_dwh.source.customers
        );
      
  