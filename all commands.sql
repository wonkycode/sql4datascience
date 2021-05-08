-- setting up environment
SHOW DATABASES;
CREATE DATABASE imdb;
USE imdb;
SOURCE c:\users.....\imdb.sql;
SHOW TABLES;
DESCRIBE movies;
DROP DATABASE imdb; -- this deletes database

-- SELECT SQL COMMAND
SELECT * FROM actors;
SELECT first_name, gender FROM actors;
SELECT gender, first_name FROM actors;

-- LIMIT and OFFSET
SELECT * FROM movies;
SELECT * FROM movies LIMIT 5, 10;
SELECT * FROM movies LIMIT 5;
SELECT * FROM movies LIMIT 5 OFFSET 3;
SELECT * FROM movies LIMIT 5 OFFSET 10;

-- ORDER BY
SELECT * FROM movies;
SELECT * FROM movies ORDER BY year DESC LIMIT 20;
SELECT * FROM movies ORDER BY year LIMIT 20;

-- DISTINCT
SELECT * FROM movies_genres;
SELECT DISTINCT genre FROM movies_genres;
SELECT DISTINCT first_name, last_name FROM directors ORDER BY first_name;

-- WHERE Clause
SELECT * FROM movies;
SELECT * FROM movies WHERE rankscore > 7;
SELECT * FROM movies WHERE rankscore > 7 ORDER BY rankscore DESC LIMIT 20;
SELECT * FROM movies_genres WHERE genre='thriller';
SELECT * FROM movies_genres WHERE genre <> 'romance';
SELECT * FROM movies WHERE rankscore=NULL;  -- (DOES NOT WORK)
SELECT * FROM movies WHERE rankscore IS NULL LIMIT 20;
SELECT * FROM movies WHERE rankscore IS NOT NULL LIMIT 20;

-- LOGICAL OPERATORS
SELECT * FROM movies WHERE rankscore > 7 AND year > 2000;
SELECT * FROM movies WHERE NOT year <= 2005 LIMIT 20; 
SELECT name, year, rankscore FROM movies WHERE rankscore > 7 OR year > 2005;

SELECT * FROM movies WHERE year BETWEEN 2000 AND 2005;
SELECT * FROM movies WHERE year BETWEEN 2005 AND 2000; -- doesn't work

SELECT * FROM directors_genres WHERE genre IN ('action', 'thriller');
SELECT * FROM directors_genres WHERE genre NOT IN ('action', 'thriller');

SELECT * FROM movies WHERE name LIKE 'Go%';
SELECT * FROM actors WHERE first_name LIKE '%er';
SELECT * FROM actors WHERE first_name NOT LIKE '%er';
SELECT * FROM actors WHERE first_name LIKE '%fa%';
SELECT * FROM movies WHERE name LIKE 'Av_tar';
SELECT * FROM actors WHERE first_name LIKE 'R%%' AND first_name NOT LIKE 'Ra%';

-- AGGREGATE FUNCTIONS
SELECT MIN(year) FROM movies;
SELECT MAX(year) FROM movies;
SELECT COUNT(*) FROM movies;
SELECT COUNT(*) FROM movies WHERE year > 2005;
SELECT COUNT(year) FROM movies;

SELECT DISTINCT genre FROM movies_genres;
SELECT COUNT(DISTINCT genre) FROM movies_genres;

-- GROUP BY
SELECT * FROM movies;
SELECT year, COUNT(year) FROM movies GROUP BY year;
SELECT year, COUNT(DISTINCT name) FROM movies GROUP BY year;
SELECT year, COUNT(year) FROM movies GROUP BY year ORDER BY year;
SELECT year, COUNT(year) year_count FROM movies GROUP BY year; -- aliasing

-- HAVING
SELECT year, COUNT(name) movie_count FROM movies GROUP BY year HAVING movie_count > 10000;
SELECT name, year FROM movies HAVING year > 2000;
SELECT year, COUNT(year) year_count FROM movies WHERE rankscore > 7 GROUP BY year HAVING year_count > 250;

-- INNER JOIN
SELECT m.id, m.name, g.genre 
	FROM movies m 
	JOIN movies_genres g 
	ON m.id = g.movie_id 
	LIMIT 20;

SELECT * FROM movies;

-- LEFT OUTER JOIN
SELECT m.name, g.genre
    FROM movies m
    LEFT OUTER JOIN movies_genres g
    ON m.id = g.movie_id
    LIMIT 20;
    
SELECT m.name, g.genre
    FROM movies m
    LEFT JOIN movies_genres g
    ON m.id = g.movie_id
    LIMIT 20;

SELECT a.first_name, a.last_name, m.name, r.role
    FROM actors a
    JOIN roles r
    ON a.id = r.actor_id
    JOIN movies m
    ON m.id = r.movie_id
    AND m.name = 'Titanic'; -- K-way join
    
SELECT * FROM actors;
SELECT * FROM roles;
SELECT * FROM movies;

-- RIGHT OUTER JOIN
SELECT m.name, g.genre
    FROM movies m
    RIGHT JOIN movies_genres g
    ON m.id = g.movie_id
    LIMIT 2000;
    
-- CROSS JOIN
SELECT m.name, g.genre
    FROM movies m
    CROSS JOIN movies_genres g
    ON m.id = g.movie_id
    LIMIT 2000;
    
-- Sub-Queries
SELECT first_name 
    FROM actors
    WHERE id
    IN (
        SELECT actor_id
        FROM roles
        WHERE movie_id
        IN (
            SELECT id
            FROM movies
            WHERE name = 'Titanic'
        )
    );
    
SELECT * 
	FROM movies 
	WHERE rankscore >= ALL(SELECT MAX(rankscore) FROM movies);
    
SELECT MAX(rankscore) FROM movies;
    
SELECT * 
	FROM country c 
    WHERE lifeexpectancy > (SELECT AVG(lifeexpectancy) FROM country);

SELECT AVG(lifeexpectancy) FROM country;

-- Correlated Subquery

SELECT name, continent, lifeexpectancy 
	FROM country c 
    WHERE lifeexpectancy > (SELECT AVG(lifeexpectancy) FROM country WHERE continent = c.continent);

SELECT AVG(lifeexpectancy) FROM country WHERE continent = 'North America';
SELECT name, continent, lifeexpectancy  FROM country WHERE continent = 'North America';
    
Select DISTINCT region from country;
    
SHOW DATABASES;
USE world;
SHOW TABLES;
DESCRIBE city;
DESCRIBE country;
DESCRIBE countrylanguage;
select * from city;
select * from country;
select * from countrylanguage;

-- INSERT
INSERT INTO movies (id, name, year, rankscore) VALUES ('412321', 'Jersey', 2019, 8);
INSERT INTO movies (id, name, year, rankscore) VALUES (412322, 'Rangasthalam', 2018, 8), (412323, 'Pushpa', 2021, 8);

select max(id) from movies;

select * from movies where id = 412323;

-- UPDATE
-- UPDATE movies SET rankscore = 7; -- updates all the rows in the column
UPDATE movies SET rankscore = 9 WHERE id = 412323;

-- DELETE
-- DELETE FROM movies -- deletes all the rows
DELETE FROM movies WHERE id = 412323;

-- CREATE
CREATE TABLE country (id INT PRIMARY KEY, name VARCHAR(50) NOT NULL, language VARCHAR(20) NOT NULL);
DESCRIBE country;
INSERT INTO country (id, name, language) VALUES (412321, 'INDIA', 'Telugu');
SELECT * FROM country;

-- ALTER
ALTER TABLE country ADD budget INT;
ALTER TABLE country MODIFY budget VARCHAR(10);
ALTER TABLE country DROP budget;

-- DROP
SHOW TABLES;
DROP TABLE country;
DROP TABLE IF EXISTS country;
DROP DATABASE db_name;

-- TRUNCATE
TRUNCATE TABLE country;
COMMIT;





















































































































































































































































































