


SELECT 
    products.ProductID,
    products.ProductName, 
    products.SUPPLIER, 
    products.CATEGORY,
    products.PRICE,
    products.STOCK
FROM
dbt_dwh.source.products as products