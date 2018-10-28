USE sakila;

 
SELECT first_name, last_name 
from actor;
 

SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name'
from actor;


SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE "Joe";
  	

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE "%D%E%N%";


SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE "%L%I%"
ORDER BY last_name, first_name;


SELECT country_id, country
FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh','China')

ORDER BY country;



ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(30)
AFTER first_name;

SELECT first_name, middle_name, last_name 
FROM actor;
  	


ALTER TABLE actor
MODIFY COLUMN middle_name BLOB;

SELECT first_name, middle_name, last_name 
FROM actor;



ALTER TABLE actor
DROP COLUMN middle_name ;

SELECT * 
FROM actor;

SELECT last_name, count(last_name) AS last_name_count
FROM actor
GROUP BY last_name;



SELECT last_name, count(last_name) AS last_name_count
FROM actor
GROUP BY last_name
HAVING count(last_name) > 1;


SELECT first_name, last_name
FROM actor
WHERE 
	last_name = 'WILLIAMS'
	OR 
    first_name = 'GROUCHO';

UPDATE actor
SET first_name = 'HARPO' 
WHERE 
	last_name = 'WILLIAMS'
	AND 
    first_name = 'GROUCHO';
 
SELECT first_name, last_name
FROM actor
WHERE 
	last_name = 'WILLIAMS'
	AND 
    first_name = 'HARPO'; 
    


SELECT first_name, last_name
FROM actor
WHERE 
    first_name = 'HARPO'; 
 
UPDATE actor
SET first_name = 'GROUCHO' 
WHERE  
    first_name = 'HARPO';
    
SELECT first_name, last_name
FROM actor
WHERE 
    first_name = 'HARPO'; 


describe sakila.address;
DESC sakila.address;
show create table sakila.address;

SELECT *
FROM staff; 

SELECT *
FROM address; 

SELECT first_name, last_name, address
FROM staff
INNER JOIN address


USING(address_id);  
SELECT *
FROM staff; 
SELECT *
FROM payment; 
  	
    
SELECT lt.staff_id, SUM(amount)
FROM staff AS lt
INNER JOIN payment AS rt
ON lt.staff_id = rt.staff_id
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id;


SELECT *
FROM film_actor;

SELECT *
FROM film;

SELECT title, count(actor_id) AS number_of_actors
FROM  film
INNER JOIN film_actor
USING(film_id)
GROUP BY actor_id;  


SELECT *
FROM inventory;

SELECT lt.film_id, rt.title, count(lt.film_id)
FROM inventory AS lt
INNER JOIN film as rt
USING(film_id)
GROUP BY lt.film_id
HAVING rt.title = 'Hunchback Impossible';



SELECT *
FROM payment;

SELECT *
FROM customer;


SELECT customer_id, rt.last_name, SUM(amount) 
FROM payment AS lt
JOIN customer AS rt
USING(customer_id)
GROUP BY customer_id
ORDER BY last_name;


SELECT title
FROM film
WHERE title LIKE "Q%" OR title LIKE "K%"
AND 
language_id IN
(
SELECT language_id
FROM language 
WHERE name="English"
); 



SELECT actor_id, first_name, last_name
FROM actor 
WHERE actor_id IN
	(
	SELECT actor_id
	FROM film_actor
	WHERE film_id in
		(
		SELECT film_id 
		FROM film 
		WHERE title = "Alone Trip"
		)
	);
  
SELECT first_name, last_name, email
FROM customer

JOIN address
USING (address_id)

JOIN city
USING(city_id)

JOIN country
USING(country_id)
WHERE country = "Canada";



SELECT film_id, title, description 
FROM film
WHERE film_id IN  
	(
	SELECT film_id
	FROM film_category
	WHERE category_id in 

		(SELECT category_id
		FROM category
		WHERE name = 'Family'
		)
	);



SELECT rt.film_id, title, count(film_id) As times_rented
FROM rental AS lt
LEFT JOIN inventory AS rt
USING(inventory_id)
LEFT JOIN film AS endt
USING(film_id)
GROUP BY film_id
ORDER BY times_rented DESC;



 

SELECT store_id, sum(amount) AS $rev
FROM payment
JOIN staff
using(staff_id)
GROUP BY store_id;



SELECT store_id, city, country 
FROM store
INNER JOIN address
USING(address_id)
INNER JOIN city
USING(city_id)
INNER JOIN country
USING(country_id); 




SELECT category_id, category.name , sum(amount) as rev
From payment
Join rental
using(rental_id)
JOIN inventory
using(inventory_id)
JOIN film_category
USING(film_id)
JOIN category
USING (category_id)
GROUP BY category_id
ORDER BY rev DESC
LIMIT 5;


  	

CREATE VIEW top_five_genres AS

SELECT category_id, category.name , sum(amount) as rev
From payment
Join rental
using(rental_id)
JOIN inventory
using(inventory_id)
JOIN film_category
USING(film_id)
JOIN category
USING (category_id)
GROUP BY category_id
ORDER BY rev DESC
LIMIT 5;


SELECT * 
FROM top_five_genres;


DROP VIEW top_five_genres;






