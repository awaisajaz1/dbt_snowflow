-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into dbt_dwh.curated.dim_products as DBT_INTERNAL_DEST
        using dbt_dwh.curated.dim_products__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.ProductID = DBT_INTERNAL_DEST.ProductID))

    
    when matched then update set
        "PRODUCTID" = DBT_INTERNAL_SOURCE."PRODUCTID","PRODUCTNAME" = DBT_INTERNAL_SOURCE."PRODUCTNAME","SUPPLIER" = DBT_INTERNAL_SOURCE."SUPPLIER","CATEGORY" = DBT_INTERNAL_SOURCE."CATEGORY","PRICE" = DBT_INTERNAL_SOURCE."PRICE","STOCK" = DBT_INTERNAL_SOURCE."STOCK"
    

    when not matched then insert
        ("PRODUCTID", "PRODUCTNAME", "SUPPLIER", "CATEGORY", "PRICE", "STOCK")
    values
        ("PRODUCTID", "PRODUCTNAME", "SUPPLIER", "CATEGORY", "PRICE", "STOCK")

;
    commit;