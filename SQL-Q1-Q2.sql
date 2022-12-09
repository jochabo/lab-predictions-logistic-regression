USE sakila;

SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM film_category;

-- QUERY 1:
SELECT f.film_id,f.title, f.rental_duration, f.rental_rate, f.length, f.rating, fc.category_id
FROM film f 
JOIN film_category fc USING (film_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
WHERE date_format((r.rental_date), "%Y")=2005 
GROUP BY f.film_id, f.title, f.rental_duration, f.rental_rate, f.length, f.rating, fc.category_id
ORDER BY f.film_id ASC;

 -- r.rental_date, r.return_date, 
-- 

-- QUERY 2:
-- All the films that were rented in May 2005
SELECT DISTINCT film_id FROM film f 
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id 
WHERE date_format((r.rental_date), "%M") = "May" AND
date_format((r.rental_date), "%Y") = 2005;


SELECT DISTINCT film_id, 
CASE WHEN date_format((r.rental_date), "%M-%Y") = "May-2005" THEN True ELSE False END AS rented_in_may_2005
FROM film f 
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
JOIN film_category fc USING (film_id)
WHERE date_format((r.rental_date), "%Y")=2005 ORDER BY film_id ASC;

SELECT DISTINCT film_id, 
CASE WHEN date_format((r.rental_date), "%M-%Y") = "May-2005" THEN True ELSE False END AS rented_in_may_2005
FROM film f 
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
GROUP BY film_id, rented_in_may_2005;

