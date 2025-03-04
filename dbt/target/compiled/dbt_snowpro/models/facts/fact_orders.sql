

SELECT
    orders.OrderID,
    orderdetails.orderdetailid,
    orderdetails.productID,
    products.productName,
    orders.customerID,
    customers.customerName,
    orders.orderDate,
    orders.status,
    orderdetails.quantity,
    orderdetails.price AS unitprice,
    orders.totalamount
FROM
    dbt_dwh.source.orders AS orders
JOIN
    dbt_dwh.source.orderdetails AS orderdetails  ON orders.OrderID = orderdetails.OrderID
LEFT JOIN
    dbt_dwh.curated.dim_customers AS customers  ON orders.CustomerID = customers.CustomerID
LEFT JOIN
    dbt_dwh.curated.dim_products AS products  ON orderdetails.ProductID = products.ProductID


WHERE orders.orderDate >= (SELECT MAX(orderDate) FROM dbt_dwh.curated.fact_orders)
