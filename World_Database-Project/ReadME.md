# 🌍 World Database SQL Portfolio

This repository contains SQL queries written using the **MySQL World database**.  
The queries range from beginner to advanced, demonstrating skills in data analysis, joins, subqueries, aggregates, window functions, and economic/demographic insights.

---

## 📌 Database Schema (World Database ERD)

<img width="535" height="340" alt="image" src="https://github.com/user-attachments/assets/cd6410d3-7aca-47b8-9f9c-94b3bd25b16b" />

---

# 📊 SQL Queries & Explanations

Below is a complete list of SQL queries I created during my analysis of the **World** dataset.

---

## 🟦 Basic & Intermediate Queries

### 1. Count Total Cities in the United States  
```sql
SELECT country.Name, COUNT(*) AS CitiesInUSA
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'United States';
```
Counts how many cities belong to the US — useful for geographical reporting.

---

### 2. Country With the Highest Life Expectancy  
```sql
SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy = (SELECT MAX(LifeExpectancy) FROM country);
```
Identifies the country with the longest-living population.

---

### 3. Cities Starting With “New”  
```sql
SELECT city.Name
FROM city
WHERE Name LIKE 'New %';
```
Common query for location-based content (e.g., "New York", "New Delhi").

---

### 4. Top 10 Most Populated Cities  
```sql
SELECT *
FROM city
ORDER BY Population DESC
LIMIT 10;
```
Retrieves the largest cities by population.

---

### 5. Cities With Population > 2,000,000  
```sql
SELECT *
FROM city
WHERE Population > 2000000;
```
Filters high-density global cities.

---

### 6. Cities Starting With "Be"  
```sql
SELECT city.Name AS CityName, country.Name AS CountryName, city.Population
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE city.Name LIKE 'Be%'
ORDER BY city.Name;
```
Matches cities with prefix “Be” (e.g., Berlin, Beirut).

---

### 7. Cities With Population Between 500k and 1M  
```sql
SELECT *
FROM city
WHERE Population BETWEEN 500000 AND 1000000;
```
Captures medium-sized urban populations.

---

### 8. Cities Sorted Alphabetically  
```sql
SELECT Name AS CityName
FROM city
ORDER BY Name ASC;
```
Basic alphabetical sorting for UI/data listing.

---

### 9. Most Populated City  
```sql
SELECT city.Name AS CityName, country.Name AS CountryName, city.Population
FROM city
JOIN coun
```
---
# 🔥 Additional Advanced & Insightful SQL Queries 
---

## 🟥 1. Top 10 Countries Whose Cities Contribute the MOST to Their Total Population  
*(City Population ÷ Country Population)*  
Shows countries where population is highly concentrated in cities rather than rural areas.

```sql
SELECT co.Name AS CountryName,
       SUM(ci.Population) AS TotalCityPopulation,
       co.Population AS CountryPopulation,
       ROUND((SUM(ci.Population) / co.Population) * 100, 2) AS UrbanizationRate
FROM country co
JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Code
HAVING UrbanizationRate IS NOT NULL
ORDER BY UrbanizationRate DESC
LIMIT 10;
```

---

## 🟥 2. Global Correlation Between Life Expectancy and GDP Per Capita  
```sql
SELECT 
    SUM((LifeExpectancy - (SELECT AVG(LifeExpectancy) FROM country)) *
        ((GNP/Population) - (SELECT AVG(GNP/Population) FROM country))) /
    ( (SELECT STD(LifeExpectancy) FROM country) * 
      (SELECT STD(GNP/Population) FROM country) * 
      (SELECT COUNT(*) FROM country) ) AS Correlation_LifeExp_GDPperCapita;
```

This calculates if **wealthier countries tend to live longer**.

---

## 🟥 3. Ranking Countries by Average City GDP Contribution  
GDP contribution inferred from weighted distribution across cities .

```sql
WITH CityGDP AS (
    SELECT 
        ci.ID,
        ci.Name AS CityName,
        co.Name AS CountryName,
        ci.Population,
        co.GNP,
        co.Population AS CountryPopulation,
        (ci.Population / co.Population) * co.GNP AS EstimatedCityGDP
    FROM city ci
    JOIN country co ON ci.CountryCode = co.Code
)
SELECT CountryName,
       SUM(EstimatedCityGDP) AS TotalEstimatedCityGDP,
       RANK() OVER (ORDER BY SUM(EstimatedCityGDP) DESC) AS GDP_Rank
FROM CityGDP
GROUP BY CountryName
ORDER BY TotalEstimatedCityGDP DESC
LIMIT 15;
```

Shows how much cities economically contribute.

---

## 🟥 4. Countries Whose Life Expectancy Is Higher Than the Continent Average  
A more complex comparative analysis using window functions.

```sql
WITH ContinentAverages AS (
    SELECT Continent,
           AVG(LifeExpectancy) AS AvgLifeExp
    FROM country
    GROUP BY Continent
)
SELECT c.Name AS CountryName,
       c.Continent,
       c.LifeExpectancy,
       ca.AvgLifeExp,
       (c.LifeExpectancy - ca.AvgLifeExp) AS DifferenceFromContinent
FROM country c
JOIN ContinentAverages ca ON c.Continent = ca.Continent
WHERE c.LifeExpectancy > ca.AvgLifeExp
ORDER BY DifferenceFromContinent DESC;
```

Shows which countries outperform their region.

---

## 🟥 5. Most Economically Dominant Cities in Each Country  
Cities ranked by GDP share (inferred using weighted GNP).

```sql
WITH CityGDP AS (
    SELECT ci.Name AS CityName,
           co.Name AS CountryName,
           ci.Population,
           co.GNP,
           ROUND((ci.Population / co.Population) * co.GNP, 2) AS EstimatedGDP
    FROM city ci
    JOIN country co ON ci.CountryCode = co.Code
)
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY CountryName ORDER BY EstimatedGDP DESC) AS CityRank
    FROM CityGDP
) ranked
WHERE CityRank = 1
ORDER BY EstimatedGDP DESC
LIMIT 20;
```

This identifies each country’s **single most economically influential city**.

---

## 🟥 6. Top 15 Countries With the Fastest Growing Populations (Based on Population vs. Previous Year Estimate)  
Uses GNP as a proxy for economic capacity + population dynamics.

```sql
SELECT Name AS CountryName,
       Population,
       GNP,
       GNPOld,
       (GNP - GNPOld) AS GNP_Growth,
       ROUND((Population / SurfaceArea), 2) AS PopulationDensity
FROM country
WHERE GNPOld IS NOT NULL
ORDER BY GNP_Growth DESC
LIMIT 15;
```

Shows which countries economically expanded the fastest.

---

## 🟥 7. Largest Cities Per Continent (Window Function)  
Identifies the biggest city in each continent.

```sql
WITH CityContinent AS (
    SELECT ci.Name AS CityName,
           ci.Population,
           co.Continent,
           RANK() OVER (PARTITION BY co.Continent ORDER BY ci.Population DESC) AS rnk
    FROM city ci
    JOIN country co ON ci.CountryCode = co.Code
)
SELECT *
FROM CityContinent
WHERE rnk = 1;
```

Gives the top city per continent.

---

## 🟥 8. Languages Ranked by Total Global Speakers (Weighted by Country Population)  
```sql
SELECT cl.Language,
       SUM((cl.Percentage / 100) * co.Population) AS TotalSpeakers,
       RANK() OVER (ORDER BY SUM((cl.Percentage / 100) * co.Population) DESC) AS SpeakerRank
FROM countrylanguage cl
JOIN country co ON cl.CountryCode = co.Code
GROUP BY cl.Language
ORDER BY TotalSpeakers DESC
LIMIT 15;
```

Shows globally dominant languages based on real population data.

---

## 🟥 9. Countries With the Smallest GDP Per Capita but Highest Life Expectancy  
Shows countries that "punch above their weight" in health outcomes.

```sql
SELECT Name AS CountryName,
       (GNP / Population) AS GDPperCapita,
       LifeExpectancy
FROM country
WHERE LifeExpectancy > (SELECT AVG(LifeExpectancy) FROM country)
ORDER BY GDPperCapita ASC
LIMIT 15;
```

Insightful for socio-economic research.

---

## 🟥 10. Population-Weighted Life Expectancy Per Continent  
```sql
WITH Weighted AS (
    SELECT Continent,
           LifeExpectancy,
           Population,
           LifeExpectancy * Population AS WeightedLife
    FROM country
)
SELECT Continent,
       SUM(WeightedLife) / SUM(Population) AS WeightedLifeExpectancy
FROM Weighted
GROUP BY Continent
ORDER BY WeightedLifeExpectancy DESC;
```

---



