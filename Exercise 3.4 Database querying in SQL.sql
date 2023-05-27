/*Exercise focused on optimizing queries and sorting and grouping data*/

/*Selecting only needed columns (film_id, title) from film table*/
SELECT film_id,
title
FROM film


/*Comparing computational cost of general (all columns) vs specific query*/
EXPLAIN
SELECT *
FROM film

EXPLAIN
SELECT film_id,
title
FROM film


/*Sorting movie titles from A-Z, newest-oldest, and highest-lowest rental rate*/
SELECT title, release_year, rental_rate
FROM film
ORDER BY title ASC, release_year DESC, rental_rate DESC


/*Calculating average rental rate for each MPAA rating category*/
SELECT rating,
AVG(rental_rate)
FROM film
GROUP BY rating


/*Calculated minimum and maximum rental durations for each MPAA category*/
SELECT rating, 
MIN(rental_duration),
MAX(rental_duration)
FROM film
GROUP BY rating