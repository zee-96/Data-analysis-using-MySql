USE world;
-- Count Cities in USA: Scenario
SELECT country.Name,  COUNT(*) AS CitiesInUSA
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'United States';

-- Country with Highest Life Expectancy

select Name, LifeExpectancy
from country
WHERE LifeExpectancy = ( SELECT MAX(LifeExpectancy) FROM country);

-- New Year Promotion: Featuring Cities with 'New 
select city.Name
from city
where Name like "New %";

-- the first 10 cities by population from the database. 

select *
from city
order by Population DESC limit 10;

-- Cities with Population Larger than 2,000,000:
select *
from city
where Population > 2000000;

-- Cities Beginning with 'Be' Prefix

SELECT city.Name AS CityName, country.Name AS CountryName, city.Population
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE city.Name LIKE 'Be%'
ORDER BY city.Name;

-- Cities with Population Between 500,000-1,000,000:
select *
from city
where Population between 500000 and 1000000;

-- Display Cities Sorted by Name in Ascending Order

select name as CityName
from city
order by Name asc;
-- Most Populated City
SELECT city.Name AS CityName, country.Name AS CountryName, city.Population
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE city.Population = ( SELECT MAX(Population) FROM city);

-- City Name Frequency Analysis
SELECT Name AS CityName, COUNT(*) AS NameCount
FROM city
GROUP BY Name
ORDER BY CityName ASC;

-- City with the Lowest Population: 
SELECT city.Name AS CityName, country.Name AS CountryName, city.Population
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE city.Population = ( SELECT MIN(Population) FROM city);

-- Country with Largest Population
select Name as Country_Name, Population as Country_Population
from country
where Population = ( SELECT Max(Population) FROM country);

-- Capital of Spain:
SELECT city.Name AS CapitalCity, country.Name AS CountryName
FROM country
JOIN city ON country.Capital = city.ID /*The country.Capital column stores the ID of the capital city from the city table.
So this is a foreign key relationship.*/
WHERE country.Name = 'Spain';

-- Cities in Europe

select city.Name as CityName, country.Name as CountryName, country.Continent
from city
join country on city.CountryCode = country.Code
where Continent = "Europe";

-- calculating the average population for each country
SELECT country.Name AS CountryName, AVG(city.Population) AS AverageCityPopulation
FROM city
JOIN country ON city.CountryCode = country.Code
GROUP BY country.Name
ORDER BY AverageCityPopulation DESC;

-- Capital Cities Population Comparison

SELECT country.Name AS CountryName, city.Name AS CapitalCity, city.Population AS CapitalPopulation
FROM country
JOIN city ON country.Capital = city.ID
ORDER BY city.Population DESC;

-- Countries with Low Population Density 
SELECT Name AS CountryName, Continent, (Population / SurfaceArea) AS PopulationDensity -- Population Density = Population ÷ SurfaceArea
FROM country
ORDER BY PopulationDensity ASC
LIMIT 10;


-- Cities with High GDP per Capita

SELECT city.Name AS CityName, country.Name AS CountryName, (country.GNP / country.Population) AS GNPperCapita
FROM city
JOIN country ON city.CountryCode = country.Code
WHERE (country.GNP / country.Population) > ( SELECT AVG(country.GNP / country.Population) FROM country )
ORDER BY GNPperCapita DESC;

-- Display Columns with Limit (Rows 31-40)

SELECT city.Name AS CityNamecity, Population
FROM city
ORDER BY city.Population DESC
LIMIT 10 OFFSET 30;

















