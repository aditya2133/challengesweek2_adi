-- SAKILA challenge

USE sakila;

-- Q1 List all actors.
SELECT CONCAT (first_name, ' ', last_name) FROM actor;


-- Q2 Find the surname of the actor with the forename 'John'.
SELECT first_name, last_name FROM actor 
WHERE first_name = 'John';


-- Q3 Find all actors with surname 'Neeson'.
SELECT first_name, last_name FROM actor 
WHERE last_name = 'Neeson';


-- Q4 Find all actors with ID numbers divisible by 10.
SELECT first_name FROM actor
WHERE actor_id LIKE '%0'
;


-- Q5 What is the description of the movie with an ID of 100?
SELECT `description` FROM film 
WHERE film_id = '100'
;

-- Q6 Find every R-rated movie.
SELECT film.title FROM film 
WHERE rating = 'R'
;


-- Q7 Find every non-R-rated movie.
SELECT film.title FROM film 
WHERE rating != 'R'
;


-- Q8 Find the ten shortest movies.



-- Q9 Find the movies with the longest runtime, without using LIMIT.
SELECT title, MAX(length) FROM film
;


-- Q10 Find all movies that have deleted scenes.
SELECT title, special_features FROM film
WHERE special_features LIKE '%Deleted Scenes%'
;


-- Q11 Using HAVING, reverse-alphabetically list the last names that are not repeated.        
SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1 
ORDER BY last_name DESC
;



-- Q12 Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>1
ORDER BY COUNT(last_name) DESC
;


-- Q13 Which actor has appeared in the most films?
SELECT a.first_name, a.last_name, count(film_id) AS number_of_films FROM actor a
	JOIN film_actor fa ON fa.actor_id = a.actor_id
    GROUP BY a.actor_id
    HAVING COUNT(film_id)
	ORDER BY COUNT(film_id) DESC 
    LIMIT 1
    ;


-- Q14 When is 'Academy Dinosaur' due?



-- Q15 What is the average runtime of all films?
SELECT AVG(length) FROM film;


-- Q16 List the average runtime for every film category.
SELECT c.name, AVG(f.length) AS Avg_runtime FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON c.category_id = fc.category_id
    GROUP BY c.name 
    HAVING AVG(f.length)
    ORDER BY AVG(f.length) ASC
    
    ;


-- Q17 List all movies featuring a robot.
SELECT title, description FROM film 
WHERE `description` LIKE '%robot%'
;

-- Q18 How many movies were released in 2010?
SELECT COUNT(release_year) FROM  film 
WHERE release_year = 2010
;

-- Q19 Find the titles of all the horror movies.
SELECT f.title, c.name FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON c.category_id = fc.category_id
    WHERE c.name = 'Horror'
    ;


-- Q20 List the full name of the staff member with the ID of 2.
SELECT CONCAT(first_name,' ', last_name) AS full_name FROM staff
WHERE staff_id = 2
;


-- Q21 List all the movies that Fred Costner has appeared in.
SELECT f.title FROM actor a
	JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON f.film_id = fa.film_id
    WHERE a.first_name = 'Fred' AND a.last_name = 'Costner'
    ;


-- Q22 How many distinct countries are there?
SELECT DISTINCT COUNT(country) FROM country;


-- Q23 List the name of every language in reverse-alphabetical order.
SELECT name FROM `language`
ORDER BY `name` DESC
;


-- Q24 List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%son' 
ORDER BY first_name
;


-- Q25 Which category contains the most films?
SELECT c.name, COUNT(fc.film_id) FROM category c
	JOIN film_category fc ON c.category_id = fc.category_id
    GROUP BY c.category_id
    HAVING COUNT(fc.film_id)
    ORDER BY COUNT(fc.film_id) DESC
    LIMIT 1
    
    ;
