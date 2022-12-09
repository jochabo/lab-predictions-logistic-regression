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

SELECT film_id,
    CASE WHEN SUM(
			CASE WHEN DATE_FORMAT((r.rental_date), '%M-%Y') = 'May-2005' THEN TRUE
                ELSE FALSE
            END) > 0
        THEN
            TRUE
        ELSE FALSE
    END AS rented_in_may_2005
FROM
    film f
	JOIN inventory i USING (film_id)
	JOIN rental r USING (inventory_id)
	JOIN film_category fc USING (film_id)
GROUP BY f.film_id;
-- ORDER BY film_id ASC;

