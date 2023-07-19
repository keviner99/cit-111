USE world;

-- Query 1
-- Write a query to show the country and population of all countries with
-- population smaller than 5 million. Sort the list by population with the
-- largest population first.

SELECT Name, Population
FROM country
WHERE Population < 5000000
ORDER BY Population DESC;


-- Query 2
-- Write a query to show a list of the unique languages in the
-- countrylanguage table. Sort the list in alphabetical order.

SELECT DISTINCT Language
FROM countrylanguage
ORDER BY Language;


-- Query 3
-- Write a query to list the continents and the number of countries in each continent.

SELECT Continent, COUNT(Name)
FROM country
GROUP BY Continent;

-- Query 4
-- Write a query that shows the columns (with specified labels):
-- Country - the name of the country
-- Avg_Population_of_Cities - the average population of the cities of that country
-- Sort the results by the largest population average first.

SELECT country.Name AS Country, AVG(city.Population) AS AVG_Population_of_Cities
FROM country 
	JOIN city 
    ON city.CountryCode = country.Code
GROUP BY country.Name
ORDER BY AVG_Population_of_Cities DESC;


