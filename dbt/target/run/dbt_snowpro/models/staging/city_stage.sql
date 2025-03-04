-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into dbt_dwh.staging.city_stage as DBT_INTERNAL_DEST
        using dbt_dwh.staging.city_stage__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.CityID = DBT_INTERNAL_DEST.CityID))

    
    when matched then update set
        "CITYID" = DBT_INTERNAL_SOURCE."CITYID","POSTALCODE" = DBT_INTERNAL_SOURCE."POSTALCODE","COUNTRY" = DBT_INTERNAL_SOURCE."COUNTRY"
    

    when not matched then insert
        ("CITYID", "POSTALCODE", "COUNTRY")
    values
        ("CITYID", "POSTALCODE", "COUNTRY")

;
    commit;