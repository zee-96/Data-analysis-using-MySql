# Northwind SQL Portfolio

This repository showcases SQL queries completed using the **Northwind Traders** database. It includes beginner, intermediate, and advanced SQL tasks demonstrating skills in querying, joining tables, analysing data, and solving business problems.

---

## 📌 Database Schema (ERD)

<img width="560" height="331" alt="image" src="https://github.com/user-attachments/assets/66b048af-b1ab-4252-8eef-c2c102604773" />

---

# 🧭 SQL Queries & Explanations

## SQL Fundamentals

### 1. Retrieve Full Customer Data  
```sql
SELECT * FROM Customers;
```
Retrieves all columns from the Customers table for reporting.

### 2. Customer Names and Cities  
```sql
SELECT CustomerName, City FROM Customers;
```
Used for targeted marketing based on customer location.

### 3. Unique Cities With Customers  
```sql
SELECT DISTINCT City FROM Customers;
```
Shows all unique cities where customers are located — useful for delivery network planning.

### 4. High-Value Products (Price > 50)  
```sql
SELECT * FROM Products
WHERE Price > 50;
```
Extracts premium products for pricing and inventory analysis.

### 5. Customers in USA or UK  
```sql
SELECT * FROM Customers
WHERE Country IN ('USA', 'UK');
```
Filters customers for geo-targeted campaigns.

### 6. Most Recent Orders  
```sql
SELECT * FROM Orders
ORDER BY OrderDate DESC;
```
Lists orders from newest to oldest — essential for trend analysis.

### 7. Mid-Range Products (£20–£50)  
```sql
SELECT * FROM Products
WHERE Price BETWEEN 20 AND 50
ORDER BY Price DESC;
```
Retrieves mid-range products in descending price order.

### 8. Customers in Portland or Kirkland (USA)  
```sql
SELECT * FROM Customers
WHERE Country = 'USA' AND City IN ('Portland', 'Kirkland')
ORDER BY CustomerName ASC;
```
Filters customers for localized outreach.

### 9. Customers From UK or London  
```sql
SELECT * FROM Customers
WHERE Country = 'UK' OR City = 'London'
ORDER BY CustomerName DESC;
```
Finds customers for promotional email lists.

### 10. Products in Category 1 or 2  
```sql
SELECT * FROM Products
WHERE CategoryID IN (1, 2)
ORDER BY ProductName ASC;
```
Displays products belonging to selected categories.

---

##  Intermediate JOIN Queries

### 1. Products With Their Supplier  
```sql
SELECT ProductName, ProductID, SupplierName
FROM Products AS p
JOIN Suppliers AS s
ON p.SupplierID = s.SupplierID;
```
Shows supplier information for each product.

### 2. Products With Their Category  
```sql
SELECT ProductName, CategoryName
FROM Products AS p
JOIN Categories AS c
ON p.CategoryID = c.CategoryID;
```
Displays category associations for each product.

### 3. Meat/Poultry Products  
```sql
SELECT ProductName, CategoryName
FROM Products AS p
JOIN Categories AS c
ON p.CategoryID = c.CategoryID
WHERE CategoryName = 'Meat/Poultry';
```
Filters and lists products belonging to Meat/Poultry.

### 4. Detailed Order Overview  
```sql
SELECT o.OrderID, o.OrderDate, c.CustomerName, e.FirstName, e.LastName
FROM Orders AS o
JOIN Employees AS e
ON o.EmployeeID = e.EmployeeID
JOIN Customers AS c
ON c.CustomerID = o.CustomerID;
```
Shows order details with employee and customer information.

### 5. Product + Category + Supplier Overview  
```sql
SELECT ProductName, CategoryName, SupplierName
FROM Products AS p
JOIN Suppliers AS s
ON p.SupplierID = s.SupplierID
JOIN Categories AS c
ON c.CategoryID = p.CategoryID;
```
Full product information including supply chain details.

### 6. Orders From 1996  
```sql
SELECT OrderDate, CustomerName
FROM Orders AS o
JOIN Customers AS c
ON o.CustomerID = c.CustomerID
WHERE OrderDate BETWEEN '1996-01-01' AND '1996-12-31';
```
Extracts customer orders placed in 1996.

### 7. Product Count by Category  
```sql
SELECT CategoryName,
       COUNT(ProductName) AS TotalProducts
FROM Products AS p
JOIN Categories AS c
ON p.CategoryID = c.CategoryID
GROUP BY CategoryName
ORDER BY TotalProducts DESC;
```
Counts how many products exist in each category.

### 8. Sales Volume Breakdown  
```sql
SELECT p.ProductID,
       p.Price,
       SUM(od.Quantity) AS TotalQuantity
FROM Products AS p
JOIN Order_Details AS od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.Price;
```
Shows order quantity and price per product.

---

# 🚀 Advanced SQL Queries

### A. Top 5 Revenue-Generating Products  
```sql
SELECT p.ProductName,
       SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Order_Details od
JOIN Products p
  ON od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY TotalRevenue DESC
LIMIT 5;
```
Ranks products based on highest revenue earned.

### B. Employee Sales Ranking (Window Function)  
```sql
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Employee,
       SUM(od.Quantity * od.UnitPrice) AS TotalSales,
       RANK() OVER (ORDER BY SUM(od.Quantity * od.UnitPrice) DESC) AS SalesRank
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID;
```
Ranks employees by total sales using window functions.

### C. Average Order Value (Subquery)  
```sql
SELECT OrderID,
       (SELECT SUM(UnitPrice * Quantity)
        FROM Order_Details od
        WHERE od.OrderID = o.OrderID) AS OrderValue
FROM Orders o;
```
Calculates monetary value per order.

### D. Country-Level Customer Counts (CTE)  
```sql
WITH CountryCounts AS (
    SELECT Country,
           COUNT(*) AS TotalCustomers
    FROM Customers
    GROUP BY Country
)
SELECT *
FROM CountryCounts
ORDER BY TotalCustomers DESC;
```
Shows how many customers exist in each country.

### E. Products Never Ordered (Anti-Join)  
```sql
SELECT ProductName
FROM Products p
LEFT JOIN Order_Details od
ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL;
```
Finds products that have never been sold.
