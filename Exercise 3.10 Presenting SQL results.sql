--Most pertinent findings from previous tasks for final Rockbuster presentation


--Descriptive stats 
--Film table
SELECT MIN(film_id) AS min_filmid,
MAX(film_id) AS max_filmid,

MIN(rental_duration) AS min_rent,
MAX(rental_duration) AS max_rent,
AVG(rental_duration) AS avg_rent,

MIN(rental_rate) AS min_rate,
MAX(rental_rate) AS max_rate,
AVG(rental_rate) AS avg_rate,

MIN(length) AS min_length,
MAX(length) AS max_length,
AVG(length) AS avg_length

FROM film;

--Customer table
SELECT MIN(customer_id) AS min_customerid,
MAX(customer_id) AS max_customerid,
COUNT (customer_id) AS total_customers,

MIN(store_id) AS min_storeid,
MAX(store_id) AS max_storeid

FROM customer;


--Number of movies per MPAA rating
SELECT rating,
COUNT(rating)
FROM film
GROUP BY rating


--Number of films for every release year and language
SELECT rating, COUNT(A.rating), 
A.release_year, COUNT(A.release_year),
B.name AS language, COUNT(B.name)
FROM film A
INNER JOIN language B ON A.language_id = B.language_id
GROUP BY A.rating, A.release_year, B.name


--Total number of staff
SELECT COUNT(staff_id) AS total_staff FROM staff



--Top 10 countries with most customers
SELECT COUNT(A.customer_id) AS customer_amount,
       D.country
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_ID = D.country_ID
GROUP BY D.country
ORDER BY COUNT(A.customer_id) DESC 
LIMIT 10


--Top 10 cities within top 10 countries
SELECT COUNT(A.customer_id) AS customer_amount,
	   C.city,
       D.country
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_ID = D.country_ID
WHERE country IN
('India','China','United States', 'Japan', 'Mexico','Brazil','Russian Federation',
 'Phillippines','Turkey','Indonesia')
GROUP BY country,
city
ORDER BY COUNT(A.customer_id) DESC
LIMIT 10


--Top 5 paying customers in the top 10 cities within top 10 countries
SELECT SUM(A.amount) AS total_amount_paid,
B.customer_id,
B.first_name,
B.last_name,
D.city,
E.country
FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_ID = E.country_ID
WHERE city IN
('Aurora','Cianjur','Acua', 'So Leopoldo', 'Iwaki','Ambattur','Shanwei',
 'Citrus Heights','Teboksary','Tianjin')
GROUP BY B.customer_id,
B.first_name,
B.last_name,
E.country,
D.city
ORDER BY total_amount_paid DESC
LIMIT 5


--Total revenue for top 10 countries
SELECT SUM(A.amount) AS total_revenue,
COUNT(DISTINCT B.customer_id) AS total_customers,
--B.first_name,
--B.last_name,
--D.city,
E.country
FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_ID = E.country_ID
--WHERE city IN
--('Aurora','Cianjur','Acua', 'So Leopoldo', 'Iwaki','Ambattur','Shanwei',
-- 'Citrus Heights','Teboksary','Tianjin')
GROUP BY --B.customer_id,
--B.first_name,
--B.last_name,
E.country
--D.city
ORDER BY total_revenue DESC
LIMIT 10

SELECT SUM(amount) AS total_revenue
FROM payment


--Movies that contribute most to revenue by title, movie type
SELECT SUM(A.amount) AS revenue,
D.title AS movie_title
--F.name AS movie_type
FROM payment A
INNER JOIN rental B ON A.rental_id = B.rental_id
INNER JOIN inventory C ON B.inventory_id = C.inventory_id
INNER JOIN film D ON C.film_id = D.film_id
INNER JOIN film_category E ON D.film_id = E.film_id
INNER JOIN category F ON E.category_id = F.category_id
GROUP BY 
D.title
--F.name
ORDER BY revenue DESC