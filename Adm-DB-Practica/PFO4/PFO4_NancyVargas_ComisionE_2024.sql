-- PFO4_NancyVargas_ComisionE_2024

-- drop database if exists sakila;
-- create database sakila;
use sakila;

SELECT f.title AS film_title, 
    a.first_name AS actor_first_name, 
    a.last_name AS actor_last_name, 
    c.name AS category_name, 
    r.rental_date, 
    cu.first_name AS customer_first_name, 
    cu.last_name AS customer_last_name
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN customer cu ON r.customer_id = cu.customer_id
WHERE 
   YEAR(r.rental_date) = 2005
   AND MONTH(r.rental_date) = 6
   AND EXISTS 
(
    SELECT 1
    FROM payment p
    WHERE p.customer_id = cu.customer_id AND p.amount > 6
)
LIMIT 9;

