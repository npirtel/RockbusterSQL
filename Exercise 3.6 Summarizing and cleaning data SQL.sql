--Rockbuster’s database engineers have loaded some new data into the database, clean and profile film and customer tables


--Duplicate values
--Film table
SELECT title,
release_year, 
language_id,
COUNT(*)
FROM film
GROUP BY title,
release_year, 
language_id
HAVING COUNT(*) > 1

--Customer table
SELECT first_name,
last_name, 
email,
address_id,
COUNT(*)
FROM customer
GROUP BY first_name,
last_name, 
email,
address_id
HAVING COUNT(*) > 1



--Non-uniform values
--Film table
SELECT DISTINCT release_year,
language_id,
rating
FROM film

--Customer table
SELECT DISTINCT activebool,
last_update,
active
FROM customer



--Missing values
--Film table
SELECT title,
description,
release_year, 
language_id,
rating
FROM film
WHERE 
language_id IS NULL

--Customer table
SELECT first_name,
last_name,
email,
address_id
FROM customer
WHERE 
email IS NULL



--Descriptive statistics of columns in film and customer tables
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
AVG(length) AS avg_length,

MIN(replacement_cost) AS min_cost,
MAX(replacement_cost) AS max_cost,
AVG(replacement_cost) AS avg_cost,

MIN(replacement_cost) AS min_cost,
MAX(replacement_cost) AS max_cost,
AVG(replacement_cost) AS avg_cost,

MODE() WITHIN GROUP (ORDER BY release_year)
       AS modal_year,
MODE() WITHIN GROUP (ORDER BY language_id)
       AS modal_language,
MODE() WITHIN GROUP (ORDER BY rating)
       AS modal_rating
FROM film;

--Customer table
SELECT MIN(customer_id) AS min_customerid,
MAX(customer_id) AS max_customerid,

MIN(store_id) AS min_storeid,
MAX(store_id) AS max_storeid,

MIN(address_id) AS min_addressid,
MAX(address_id) AS max_addressid,

MIN(create_date) AS first_customer_add,
MAX(create_date) AS last_customer_add,

MODE() WITHIN GROUP (ORDER BY first_name)
       AS modal_firstname,
MODE() WITHIN GROUP (ORDER BY last_name)
       AS modal_lastname,
MODE() WITHIN GROUP (ORDER BY activebool)
       AS modal_active_status
FROM customer;