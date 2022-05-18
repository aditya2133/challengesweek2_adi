-- WORLD
use world;

-- Q1 - Using COUNT, get the number of cities in the USA.
SELECT count(name) FROM city WHERE countrycode='USA';


-- Q2 - Find out the population and life expectancy for people in Argentina.
SELECT name, population, lifeexpectancy FROM country WHERE country.name = 'argentina'; 


-- Q3 - Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT name, lifeexpectancy FROM country
WHERE lifeexpectancy IS NOT NULL 
ORDER BY lifeexpectancy DESC
LIMIT 1;


-- Q4 - Using JOIN ... ON, find the capital city of Spain.

	SELECT city.name FROM city 
		JOIN country ON country.code = city.countrycode
        WHERE city.id = (
			SELECT capital FROM country WHERE name = 'spain');


-- Q5 - Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.

SELECT cl.language, c.name FROM countrylanguage cl
 	JOIN country c ON c.code = cl.countrycode
	WHERE  c.region = 'southeast asia';
	

-- Q6 - Using a single query, list 25 cities around the world that start with the letter F.
SELECT `name` FROM city where city.name LIKE 'F%' LIMIT 25;


-- Q7 - Using COUNT and JOIN ... ON, get the number of cities in China.

SELECT Count(k.name) AS number_of_cities FROM country c
	JOIN city k ON c.code = k.countrycode
    WHERE c.name= 'china';


-- Q8 - Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT country.name, country.population FROM country 
	WHERE population > 0 
    AND population IS NOT NULL
    ORDER BY population ASC
    LIMIT 10;


-- Q9 - Using aggregate functions, return the number of countries the database contains.
Create VIEW countryunique AS
SELECT DISTINCT name AS countries FROM country;


SELECT COUNT(countries) FROM countryunique;




-- Q10 - What are the top ten largest countries by area?
SELECT country.name, country.surfacearea FROM country 
	ORDER BY surfacearea DESC
    LIMIT 10;



-- Q11 - List the five largest cities by population in Japan.
SELECT k.name FROM city k
	JOIN country c ON k.countrycode = c.code
	WHERE c.name = 'japan'
    ORDER BY c.population DESC
    LIMIT 5
;




-- Q12 - List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
SELECT country.name FROM country WHERE headofstate= 'Elizabeth II'; 
		-- look to see if I can find ElizabethII

SELECT country.name, country.code FROM country WHERE headofstate LIKE 'El% II';  -- 
		-- searching for something similar


SET SQL_SAFE_UPDATES = 0;  -- turning off safe update
UPDATE country 
SET headofstate = 'Elisabeth II' WHERE headofstate = "Elizabeth II";
  -- fixing mistake
  
SET SQL_SAFE_UPDATES = 1;  -- turning on safe update


-- Q13 - List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.

SELECT population/surfacearea AS population_to_area_ratio FROM country
WHERE population/surfacearea !=0
ORDER BY population/surfacearea ASC
LIMIT 10;
-- Create a view of data with the 0s in.. then search for top 10 excluding the 0s

-- ANOTHER WAY TO DO IT

-- CREATE  VIEW  pop_to_sa
-- AS  
-- SELECT population/surfacearea AS population_to_area_ratio FROM country
-- ORDER BY population_to_area_ratio ASC
-- LIMIT 100;
-- SELECT population_to_area_ratio FROM pop_to_sa 
-- WHERE population_to_area_ratio !=0
-- ORDER BY population_to_area_ratio ASC 
-- LIMIT 10;



-- Q14 - List every unique world language.   
SELECT DISTINCT `language` FROM countrylanguage
ORDER BY `language` ASC;





-- Q15 - List the names and GNP of the world's top 10 richest countries.
SELECT name, GNP FROM country
ORDER BY GNP DESC
LIMIT 10;



-- Q16 - List the names of, and number of languages spoken by, the top ten most multilingual countries.   
SELECT c.name, COUNT(cl.language) FROM country c
	JOIN countrylanguage cl ON c.code = cl.countrycode
    GROUP BY c.name
    ORDER BY COUNT(cl.language)
    LIMIT 10
;




-- Q17 - List every country where over 50% of its population can speak German.

SELECT c.`name` FROM country c
	JOIN countrylanguage cl ON cl.countrycode = c.code
-- SELECT * FROM countrylanguage 
	WHERE `language` = 'german' AND percentage >50;



-- Q18 - Which country has the worst life expectancy? Discard zero or null values.  

SELECT * FROM country
WHERE lifeexpectancy >0 AND lifeexpectancy IS NOT NULL
ORDER BY lifeexpectancy ASC 
LIMIT 1
;


-- Q19 - List the top three most common government forms.  
SELECT governmentform, COUNT(governmentform) FROM country
GROUP BY governmentform
ORDER BY COUNT(governmentform) DESC
LIMIT 3;



-- Q20 - How many countries have gained independence since records began?
SELECT COUNT(name) FROM country
WHERE indepyear IS NOT NULL;