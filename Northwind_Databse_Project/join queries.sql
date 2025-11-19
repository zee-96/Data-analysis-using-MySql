  /*Write a query to list the employees who handled each order, along with the order date.*/
 
 select FirstName, LastName, OrderID, OrderDate
 from employees
 inner join orders on orders.employeeID = employees.employeeID;
 
 /*Write a query to find all orders shipped by a specific shipper (e.g., ShipperName = 'Speedy Express').
*/
select *
from orders
inner join shippers
on orders.ShipperID = shippers.ShipperID
where ShipperName = "Speedy Express";

/*Write a query to display all products along with their category names.*/

select ProductName, CategoryName
from products
inner join categories on products.CategoryID = categories.CategoryID;

select firstname,lastname,orders.orderid,orders.orderdate 
from employees 
inner join orders 
on orders.employeeid = employees.employeeid; 

 SELECT * FROM orders 
INNER JOIN shippers 
ON orders.shipperid = shippers.shipperid 
WHERE ShipperName = 'United Package';

SELECT ProductName, CategoryName 
FROM Products 
INNER JOIN Categories 
ON Products.CategoryID = Categories.CategoryID;

/*Write a query to list all products and their quantities for each order.*/

select products.productid, products.productname, order_details.quantity 
from products 
inner join order_details 
on products.productid = order_details.productid;


/* all rows returned from employees table, 
only matching rows from orders table.
If there is no match , null values returned.*/

SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;



SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;

/*Return only missing values*/
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
where orderid is null;
/* customers with no orders*/

/* alisaing*/
SELECT c.CustomerName, o.OrderID
FROM Customers as c -- rename as c
LEFT JOIN Orders as o -- rename as o
ON c.CustomerID = o.CustomerID
where orderid is null;

SELECT count(*)
FROM Customers
CROSS JOIN Orders;
/* there are 91 rows in customers
multiplied by 196 rows in orders*/

	SELECT COUNT(CustomerID), Country
	FROM Customers
	GROUP BY Country;
    
/* The following SQL statement lists the number of orders sent by each shipper*/
-- 1) combine shippers to orders details
-- 2) group by shippers
-- 3) count number of orders
select count(orderid) as totalorders, shippername
from shippers as s
left join orders as o
on s.shipperid = o.shipperid
group by shippername;


/*Write SQL query to list the number of customers in each country.*/
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;

/*Write a query to list each product category and the total quantity of products sold in that category.*/

select categoryname, sum(quantity) as totalquanity
from categories as c
join products as p
on c.categoryid = p.categoryid
join order_details as od
on od.productid = p.productid
group by categoryname;


select firstname, lastname, count(orderid) as totalorders
from employees as e
join orders as o
on e.employeeid = o.employeeid
group by firstname, lastname;

select concat_ws(", ", firstname, lastname) as employee,
count(orderid) as totalorders
from employees as e
join orders as o
on e.employeeid = o.employeeid
group by firstname, lastname;