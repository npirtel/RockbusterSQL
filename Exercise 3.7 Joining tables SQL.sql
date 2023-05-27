--Management team would like to know what are top performing countries, cities, and customers.


--Top 10 countries with most customers
SELECT COUNT(A.customer_id) AS customer_amount,
       D.country
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_ID = D.country_ID
GROUP BY D.country
ORDER BY COUNT(A.customer_id) DESC LIMIT 10


--Top 10 cities with most customers within top 10 countries in first query
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


--5 highest paying customers in the top 10 cities within top 10 countries
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
ORDER BY SUM(A.amount) DESC
LIMIT 5