select * 
from products
where productname like "%choco%"
order by price;

select min(price)
from products;

select min(price)
from products;

select max(price)
from products;

select min(productname)
from products;

select max(productname)
from products;

select min(orderdate)
from orders;

select max(orderdate)
from orders;

select customerid as ID, customername as Customers
from customers;

SELECT CustomerName, CONCAT_WS(', ', Address, PostalCode, City, Country) AS Address
FROM Customers;

SELECT *
from customers;

SELECT CustomerName, City
from customers;

SELECT DISTINCT City 
FROM Customers;

/*Write a SQL query to retrieve all columns from the Products table where the Price is greater than 50.*/

select *
from products
where Price > 50
order by Price;

SELECT *
FROM customers
WHERE COuntry = "USA" OR Country = "UK";

/*Write a SQL query All columns from the Orders table, sorted by OrderDate in descending order.*/
SELECT *
FROM orders
order by OrderDate desc;
 
 select *
 From products
 WHERE Price between 20 and 50
 order by Price desc;
 
 select *
 from customers
 where Country = "USA" and City ="Portland" or City = "Kirkland"
 order by CustomerName asc;
 
 select *
 from customers
 where Country = "UK" or City = "London"
 order by CustomerName desc;
 
 select *
 From products
 WHERE CategoryID = 1 or CategoryID = 2
 order by ProductName asc;