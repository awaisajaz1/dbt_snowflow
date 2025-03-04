SELECT 
    customers.CustomerID,
    customers.CustomerName, 
    customers.ContactName as ContactPerson, 
    customers.Address, 
    customers.City,
    city.PostalCode,
    city.Country
FROM
dbt_dwh.source.customers as customers
left JOIN
dbt_dwh.staging.city_stage as city
on customers.City = city.CityID