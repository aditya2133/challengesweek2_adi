-- Movielens

use movielens;

-- Q1 List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date FROM movies
WHERE release_date BETWEEN '1983-01-01' AND '1993-12-31'
ORDER BY release_date DESC
;


-- Q2 Without using LIMIT, list the titles of the movies with the lowest average rating.   ?????
SELECT m.title, avg(r.rating) FROM movies m
	JOIN ratings r ON m.id = r.movie_id
    GROUP BY m.title
 --    HAVING min(r.rating) 
    ORDER BY AVG(r.rating) ASC
    
--   SELECT title, AVG(rating) AS average_rating
	-- FROM movies
	-- JOIN ratings ON movies.id = ratings.movie_id
	-- GROUP BY movies.title
	-- HAVING average_rating = (
			-- SELECT MIN(avg_rating)
			-- FROM (
					-- SELECT AVG(rating) AS avg_rating
					-- FROM ratings
					-- GROUP BY movie_id
			-- ) AS table1
	-- )
-- ORDER BY average_rating;
    
    ;

-- Q3 List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT DISTINCT m.title FROM movies m
	JOIN genres_movies gm ON m.id = gm.movie_id
	JOIN genres g ON g.id = gm.genre_id
	JOIN ratings r ON m.id = r.movie_id
	JOIN users u ON u.id = r.user_id
	JOIN occupations o ON o.id = u.occupation_id
    WHERE u.gender = 'M' AND u.age = '24' AND r.rating = 5 AND g.name = 'Sci-Fi'
    ORDER BY m.title ASC

;


-- Q4 List the unique titles of each of the movies released on the most popular release day. ??? 
 SELECT title, release_date FROM movies
 WHERE release_date = (  
		SELECT release_date FROM movies
        GROUP BY release_date
        HAVING COUNT(id)
        ORDER BY COUNT(id) DESC
        LIMIT 1
        
	)


;

-- Q5 Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT g.name, COUNT(m.title)  FROM movies m
	JOIN genres_movies gm ON m.id = gm.movie_id
	JOIN genres g ON g.id = gm.genre_id
    GROUP BY g.name
    HAVING COUNT(m.title)
    ORDER BY COUNT(m.title) ASC
    
    
    ;