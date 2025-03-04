


SELECT 
    customers.CustomerID,
    customers.CustomerName, 
    ContactPerson, 
    customers.Address, 
    customers.City,
    city.PostalCode,
    city.Country
FROM
dbt_dwh.staging.customers_stage as customers
left JOIN
dbt_dwh.staging.city_stage as city
on city.CityID = customers.City