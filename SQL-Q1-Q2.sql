USE sakila;

SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- QUERY 1:
SELECT f.film_id, f.title, r.rental_date, f.rental_rate, r.return_date, i.inventory_id, f.length, r.rental_id
FROM film f 
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE date_format((r.rental_date), "%Y")=2005;

-- QUERY 2:
-- All the films that were rented in May 2005
SELECT DISTINCT film_id FROM film f 
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id 
WHERE date_format((r.rental_date), "%M") = "May" AND
date_format((r.rental_date), "%Y") = 2005;


SELECT film_id, 
CASE WHEN film_id IN 
(SELECT DISTINCT f.film_id 
FROM film f 
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id 
WHERE date_format((r.rental_date), "%M") = "May" AND
date_format((r.rental_date), "%Y") = 2005) THEN 1 ELSE 0 END AS rented_in_may_2005
FROM film;

SELECT f.title, 
CASE 
WHEN DATE(rental_date)
BETWEEN '2005-05-01' AND '2005-05-31'
THEN True
ELSE False
END AS rented_in_may_2005
FROM rental r 
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
JOIN film_category fc USING (film_id)
JOIN category c USING (category_id)
GROUP BY f.title, day_type;

FROM film f 
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE date_format((r.rental_date), "%Y")=2005;

