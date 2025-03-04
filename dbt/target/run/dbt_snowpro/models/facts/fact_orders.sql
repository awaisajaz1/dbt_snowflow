-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
        
    

    

    merge into dbt_dwh.curated.fact_orders as DBT_INTERNAL_DEST
        using dbt_dwh.curated.fact_orders__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.OrderID = DBT_INTERNAL_DEST.OrderID
                ) and (
                    DBT_INTERNAL_SOURCE.orderdetailid = DBT_INTERNAL_DEST.orderdetailid
                )

    
    when matched then update set
        "ORDERID" = DBT_INTERNAL_SOURCE."ORDERID","ORDERDETAILID" = DBT_INTERNAL_SOURCE."ORDERDETAILID","PRODUCTID" = DBT_INTERNAL_SOURCE."PRODUCTID","PRODUCTNAME" = DBT_INTERNAL_SOURCE."PRODUCTNAME","CUSTOMERID" = DBT_INTERNAL_SOURCE."CUSTOMERID","CUSTOMERNAME" = DBT_INTERNAL_SOURCE."CUSTOMERNAME","ORDERDATE" = DBT_INTERNAL_SOURCE."ORDERDATE","STATUS" = DBT_INTERNAL_SOURCE."STATUS","QUANTITY" = DBT_INTERNAL_SOURCE."QUANTITY","UNITPRICE" = DBT_INTERNAL_SOURCE."UNITPRICE","TOTALAMOUNT" = DBT_INTERNAL_SOURCE."TOTALAMOUNT"
    

    when not matched then insert
        ("ORDERID", "ORDERDETAILID", "PRODUCTID", "PRODUCTNAME", "CUSTOMERID", "CUSTOMERNAME", "ORDERDATE", "STATUS", "QUANTITY", "UNITPRICE", "TOTALAMOUNT")
    values
        ("ORDERID", "ORDERDETAILID", "PRODUCTID", "PRODUCTNAME", "CUSTOMERID", "CUSTOMERNAME", "ORDERDATE", "STATUS", "QUANTITY", "UNITPRICE", "TOTALAMOUNT")

;
    commit;