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
WHERE length > 120; -- el lenth es = a la duración de la pelicula, por lo que utilizo esta columna de la tabla film y utilizo where para agregarle la condición de mayor de 120 minutos

/* EJERCICIO_5
Recupera los nombres de todos los actores*/

SELECT concat(first_name, " ", last_name) AS Nombre_completo
FROM actor
ORDER BY Nombre_completo; -- de la tabla de actor seleccioné el first y last name y juntando las columnas con concat le puse otro nombre a la columna, posteriormente la ordené. 

/* EJERCICIO_6
Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido*/

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%Gibson%"; -- Aquí utilizo la misma Query que en el ejercico 3 cambiando el parametro de busqueda

/*EJERCICIO_7
Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20*/

SELECT actor_id, first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20; -- con el WHERE filtro los datos y con el BETWEEN selecciono el rango de valores --

/*EJERCICIO_8
Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación*/

SELECT title, rating
FROM film
WHERE rating NOT IN ("R", "PG-13"); -- on el WHERE filtro los datos y con NOT IN le digo que no quiero que me busque --

/*EJERCICIO_9
Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento*/

SELECT rating, COUNT(*) AS total_peliculas  
FROM film  
GROUP BY rating
ORDER BY total_peliculas DESC; -- selecciono la clasificación de la peli que los datos se encuentran en la columna de rating y 
-- luego con COUNT cuento el número de registro de esa columna y le asigno un nombre los resultados los ordenos por el total de pelis de manera descendente --

/*EJERCICIO_10
Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas*/

 SELECT*
 FROM customer; -- Reviso que tengo las informaciones distribuidas en 2 tablas por lo que decido hacer un JOIN 
 -- primero reviso la tabla de customer de aquí me tengo que traer el customer_id, first y last name --

SELECT*
FROM rental; -- Reviso la tabla de rental de aquí me tengo que traer el customer_id, y el rental_id. El customer_id me une ambas tabla, el rental_id--

-- SOLUCION --
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres  -- selecciono las columnas que tenog que tener en cuenta y quiero que aparezcan 
-- y le pido que quiero que de la tabla de rental me cuente los registros existentes.
  FROM customer c  
      JOIN rental r 
          ON c.customer_id = r.customer_id  -- con JOIN uno la tabla rental con customer con las colunmas que tienen en común para obtener los alquileres de cada cliente --
          GROUP BY c.customer_id, c.first_name, c.last_name  
              ORDER BY total_alquileres DESC;

/*EJERCICIO_11
Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres*/ 

SELECT*
FROM rental; -- reviso la tabla rental y veo que necesito la información de otra tabla por lo que tengo que hacer un JOIN. De esta tabla 

SELECT*
FROM category;





	






