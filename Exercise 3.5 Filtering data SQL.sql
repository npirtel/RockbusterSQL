/*The management board has sent a list of questions they want answered*/


/*Film title has 'Uptown' anywhere in name*/
SELECT film_id, title, description
FROM film
WHERE title LIKE '%Uptown%'


/*Film length is more than 120 minutes and rental rate is more than 2.99*/
SELECT film_id, title, length, rental_rate, description
FROM film
WHERE length > 120 AND rental_rate > 2.99


/*Rental duration is between 3 and 7 days (where 3 and 7 aren’t inclusive)*/
SELECT film_id, title, rental_duration, description
FROM film
WHERE rental_duration > 3 AND rental_duration < 7


/*Film replacement cost is less than 14.99*/
SELECT film_id, title, replacement_cost, description
FROM film
WHERE replacement_cost < 14.99


/*Film rating is either PG or G*/
SELECT film_id, title, rating, description
FROM film
WHERE rating IN ('PG', 'G')



/*For films rated either PG or G:*/
/*Count of movies*/
SELECT COUNT(film_id) AS count_of_movies
FROM film
WHERE rating IN ('PG','G')

/*Average rental rate*/
SELECT COUNT(film_id) AS count_of_movies,
AVG(rental_rate) AS avg_rental_rate
FROM film
WHERE rating IN ('PG','G')

/*Maximum rental duration and minimum rental duration*/
SELECT COUNT(film_id) AS count_of_movies,
MIN(rental_duration) AS min_rent_duration, 
MAX(rental_duration) AS max_rent_duration
FROM film
WHERE rating IN ('PG','G')



/*Same queries as above, but broken down by MPAA rating*/
SELECT rating,
COUNT(film_id) AS count_of_movies
FROM film
GROUP BY rating
HAVING rating IN ('PG','G')

SELECT rating, 
COUNT(film_id) AS count_of_movies,
AVG(rental_rate) AS avg_rental_rate
FROM film
GROUP BY rating
HAVING rating IN ('PG','G')

SELECT rating, 
COUNT(film_id) AS count_of_movies,
MIN(rental_duration) AS min_rent_duration, 
MAX(rental_duration) AS max_rent_duration
FROM film
GROUP BY rating
HAVING rating IN ('PG','G')