--Write subqueries from previous task as CTEs


--Average amount paid by top 5 paying customers
EXPLAIN(SELECT round(AVG(total_amount_paid),2) AS avg_amount_paid
FROM
(SELECT SUM(A.amount) AS total_amount_paid,
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
LIMIT 5) AS total_amount_paid)

--Subquery as CTE
EXPLAIN(WITH avg_amount_cte (total_amount_paid) AS
(SELECT SUM(A.amount) AS total_amount_paid,
B.customer_id,
B.first_name,
B.last_name,
D.city,
E.country
FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_id = E.country_id
WHERE city IN
('Aurora','Cianjur','Acua', 'So Leopoldo', 'Iwaki','Ambattur','Shanwei',
 'Citrus Heights','Teboksary','Tianjin')
GROUP BY B.customer_id,
B.first_name,
B.last_name,
E.country,
D.city
ORDER BY SUM(A.amount) DESC
LIMIT 5)
SELECT round(AVG(total_amount_paid),2) AS avg_amount_paid
FROM avg_amount_cte)



-- top 5 paying customers in which countries
EXPLAIN(SELECT 
 A.country,
 COUNT(DISTINCT D.customer_id) AS all_customer_count,
 COUNT(DISTINCT top_5_customers.customer_id) AS top_customer_count
FROM country A
	INNER JOIN city B ON A.country_id = B.country_id
	INNER JOIN address C ON B.city_id = C.city_id
	INNER JOIN customer D ON C.address_id = D.address_id
LEFT JOIN
	(SELECT 
	  SUM(A.amount) AS total_amount_paid,
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
	GROUP BY 
	 B.customer_id,
	 B.first_name,
	 B.last_name,
	 E.country,
	 D.city
	ORDER BY total_amount_paid DESC
	LIMIT 5) AS top_5_customers ON A.country = top_5_customers.country
GROUP BY 
 A.country, 
 top_5_customers.country, 
 top_5_customers.customer_id
ORDER BY 
 all_customer_count DESC,
 top_5_customers.customer_id
LIMIT 5)

--As CTE
EXPLAIN(WITH top_customer_count_cte AS
	(SELECT 
	  SUM(A.amount) AS total_amount_paid,
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
	GROUP BY 
	 B.customer_id,
	 B.first_name,
	 B.last_name,
	 E.country,
	 D.city
	ORDER BY total_amount_paid DESC
	LIMIT 5), 

all_customer_count_cte AS
(SELECT 
 A.country,
 COUNT(DISTINCT D.customer_id) AS all_customer_count
FROM country A
	INNER JOIN city B ON A.country_id = B.country_id
	INNER JOIN address C ON B.city_id = C.city_id
	INNER JOIN customer D ON C.address_id = D.address_id
GROUP BY 
 A.country) 
 
SELECT 
 A.country,
 COUNT(DISTINCT D.customer_id) AS all_customer_count,
 COUNT(DISTINCT top_customer_count_cte.customer_id) AS top_customer_count
FROM country A
	INNER JOIN city B ON A.country_id = B.country_id
	INNER JOIN address C ON B.city_id = C.city_id
	INNER JOIN customer D ON C.address_id = D.address_id
LEFT JOIN
top_customer_count_cte ON A.country = top_customer_count_cte.country
GROUP BY
A.country
ORDER BY 
 all_customer_count DESC,
 top_customer_count
LIMIT 5)
