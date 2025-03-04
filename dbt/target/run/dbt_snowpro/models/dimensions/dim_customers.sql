-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into dbt_dwh.curated.dim_customers as DBT_INTERNAL_DEST
        using dbt_dwh.curated.dim_customers__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.CustomerID = DBT_INTERNAL_DEST.CustomerID))

    
    when matched then update set
        "CUSTOMERID" = DBT_INTERNAL_SOURCE."CUSTOMERID","CUSTOMERNAME" = DBT_INTERNAL_SOURCE."CUSTOMERNAME","CONTACTPERSON" = DBT_INTERNAL_SOURCE."CONTACTPERSON","ADDRESS" = DBT_INTERNAL_SOURCE."ADDRESS","CITY" = DBT_INTERNAL_SOURCE."CITY","POSTALCODE" = DBT_INTERNAL_SOURCE."POSTALCODE","COUNTRY" = DBT_INTERNAL_SOURCE."COUNTRY"
    

    when not matched then insert
        ("CUSTOMERID", "CUSTOMERNAME", "CONTACTPERSON", "ADDRESS", "CITY", "POSTALCODE", "COUNTRY")
    values
        ("CUSTOMERID", "CUSTOMERNAME", "CONTACTPERSON", "ADDRESS", "CITY", "POSTALCODE", "COUNTRY")

;
    commit;