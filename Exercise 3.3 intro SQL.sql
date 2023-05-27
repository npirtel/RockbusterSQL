/*Line manager wants to improve the movie search filters on the Rockbuster app*/

/*SELECT command to find what movie categories exist in database*/
SELECT * 
FROM category


 /*add new genres in the name column into category table*/
INSERT INTO category(name) 
VALUES ('Thriller'), ('Crime'), ('Mystery'), 
	   ('Romance'), ('War')


/*Select African Egg movie, find out characteristics*/
SELECT *
FROM film
WHERE title = 'African Egg'


/*Update comedy movies (5) to thriller (17)*/
SELECT *
FROM film_category
WHERE film_id = '5'

UPDATE film_category
SET category_id = '17'
WHERE film_id = '5'


/*remove mystery category (19) from database*/
DELETE FROM category
WHERE category_id = '19'





