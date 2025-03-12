USE sakila -- usamos la base de datos sakila

/* EJERCICIO_1.
Selecciona todos los nombres de las películas sin que aparezca duplicados*/

-- SOLUCION --
SELECT DISTINCT title -- el DISTINCT me ayuda a identificar los valores únicos de una columna y evitar las repeticiones en los mismos-- 
FROM film; 

/*EJERCICIO _2
Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"*/

SELECT*
FROM film; -- Observo la tabla completa para saber la columnas que necesito --

SELECT title, rating
FROM film; -- selecciono la información que necesito --

-- SOLUCION --
SELECT DISTINCT title, rating
FROM film 
WHERE rating = "PG-13"; -- con WHERE selecciono la condición que necesito para que me devuelva los resultados de la columna rating y le pongo un DISTINCT para que no se repitan los nombres de las peliculas --


/*EJERCICIO_3 
Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción*/

SELECT title, description
FROM film
WHERE description LIKE "%amazing%"; -- WHERE y LIKE filtra la columna en donde la palabra amazing aparezca y el % me ayuda a en contrar la palabra amazing en cualquier parte de la descripción

/* EJERCICIO_4
 Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos*/

SELECT title, length
FROM film
WHERE length > length;

/* EJERCICIO_5
Recupera los nombres de todos los actores*/

SELECT a.actor_id,
FROM film_actor

 AS `actor_id`,`a`.`first_name` AS `first_name`,`a`.`last_name` AS `last_name`,group_concat(distinct concat(`c`.`name`,': ',(select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ') from ((`sakila`.`film` `f` join `sakila`.`film_category` `fc` on((`f`.`film_id` = `fc`.`film_id`))) join `sakila`.`film_actor` `fa` on((`f`.`film_id` = `fa`.`film_id`))) where ((`fc`.`category_id` = `c`.`category_id`) and (`fa`.`actor_id` = `a`.`actor_id`)))) order by `c`.`name` ASC separator '; ') AS `film_info` from (((`sakila`.`actor` `a` left join `sakila`.`film_actor` `fa` on((`a`.`actor_id` = `fa`.`actor_id`))) left join `sakila`.`film_category` `fc` on((`fa`.`film_id` = `fc`.`film_id`))) left join `sakila`.`category` `c` on((`fc`.`category_id` = `c`.`category_id`))) group by `a`.`actor_id`,`a`.`first_name`,`a`.`last_name`






