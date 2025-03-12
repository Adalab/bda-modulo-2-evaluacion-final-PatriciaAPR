USE sakila; -- usamos la base de datos sakila

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
  FROM customer AS c  
      JOIN rental AS r 
          ON c.customer_id = r.customer_id  -- con JOIN uno la tabla rental con customer con las colunmas que tienen en común para obtener los alquileres de cada cliente --
          GROUP BY c.customer_id, c.first_name, c.last_name  
              ORDER BY total_alquileres DESC;

/*EJERCICIO_11
Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres*/ 

SELECT*
FROM rental; -- reviso la tabla rental y veo que necesito la información de otra tabla por lo que tengo que hacer un JOIN. De esta tabla necesitaré rental_id

SELECT*
FROM category; -- de esta tabla necesito la categoria_id y el nombre 

SELECT*
FROM film_category;

SELECT*
FROM inventory; -- cantidad de peliculas alquiladas 

-- SOLUCION --
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres -- aquí selecciono la columna de nombre de la tabla de categoria, la renombro y 
-- luego cuento el número de registro  de la rentalid y la renombro como total de alquileres
        FROM rental AS r  -- tomo estos datos porque aquí estan los alquileres realizados --
            JOIN inventory i 
                ON r.inventory_id = i.inventory_id  -- uno la tabla rental e inventario para saber qué películas fueron alquiladas --
                   JOIN film AS f 
                        ON i.film_id = f.film_id  -- uno la tabla film e inventario para saber los detalles de cada pelicula --
                           JOIN film_category fc 
							  ON f.film_id = fc.film_id  -- Uno film con film_category para saber a qué categoría pertenece cada película --
								JOIN category AS c 
                                    ON fc.category_id = c.category_id  -- Uno film_category con category para obtener los nombres de las categorías--
                                       GROUP BY c.name  -- agrupo por categoria para contar los alquileres de cada peli --
                                               ORDER BY total_alquileres DESC; -- ordeno los resultados de mayor a menor por el número de veces que se han alquilado --
                                               
                                               
/*EJERCICIO_12
Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración*/

SELECT*
FROM film; 

SELECT rating, AVG(length) AS promedio_duracion  -- Selecciono la clasificación=rating y calculo el promedio de duración con AVG y con el resultado renombro la columna
FROM film  
GROUP BY rating -- agrupo por clasificación =rating --
ORDER BY promedio_duracion DESC; -- ordeno en orden descendente --


/*EJERCICIO_13
 Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/
 
 SELECT*
 FROM actor; -- de aquí tomo el nombr ey apellido del actor (a.first_name, a.last_name)
 
 SELECT*
 FROM film_actor; -- de aquí tomo el id del actor --
 
 SELECT*
 FROM film; -- de aquí el actor_id

-- SOLUCION --
SELECT a.first_name, a.last_name  -- presento el nombre y apellido de los actores --
      FROM actor AS a  
          JOIN film_actor fa 
              ON a.actor_id = fa.actor_id  -- Relaciono a los actores con películas.
                JOIN film AS f 
                    ON fa.film_id = f.film_id  -- uno film_actor con film para obtener el título de la película--
					  WHERE f.title = 'Indian Love'; -- filtro para ver los actores que han participado en esta pelicula
                      
/*EJERCICIO_ 14
Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción*/
SELECT title  
       FROM film  
           WHERE description LIKE '%dog%'  
                 OR description LIKE '%cat%';

/*EJERCICIO_15
Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor*/

SELECT*
FROM actor;

SELECT*
FROM film_actor; 

-- SOLUCION --
SELECT a.actor_id, a.first_name, a.last_name  -- selecciono los datos que quiero que me muestre de la tabla actor --
      FROM actor AS a  
          LEFT JOIN film_actor AS fa 
               ON a.actor_id = fa.actor_id  -- hago un LEFT JOIN con film_actor para incluir todos los actores, incluso aquellos que no tengan una coincidencia en film_actor --
                  WHERE fa.actor_id IS NULL; -- Filtro los actores que no tienen películas asociadas=aquellos que no aparecen en la tabla film_actor.
                  
/*EJERCICIO_16
Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010*/

SELECT title  
FROM film  
WHERE release_year BETWEEN 2005 AND 2010;

/*EJERCICIO_17
 Encuentra el título de todas las películas que son de la misma categoría que "Family"*/

SELECT*
FROM film; -- de aquí necesito el titulo --

SELECT*
FROM film_category; -- de aquí necesito el film_id y category_id --

SELECT*
FROM category; -- de aquí necesito el catgegory_id y el name--

-- SOLUCION -- 
SELECT f.title  
     FROM film AS f  
         JOIN film_category AS fc 
            ON f.film_id = fc.film_id  -- uno film con film_category para conectar las películas con sus categorías.
              JOIN category AS c 
                  ON fc.category_id = c.category_id  -- Uno film_category con category para obtener el nombre de la categoría.
                    WHERE c.name = 'Family';   -- Filtro solo las películas que pertenecen a la categoría "Family" --
                    
/*EJERCICIO_18
Muestra el nombre y apellido de los actores que aparecen en más de 10 películas*/

SELECT*
FROM actor; -- de aquí necesito first en last name y actor id

SELECT*
FROM film_actor; -- de aquí necesito el actor _id y film_id

-- SOLUCION -- 
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas  -- saco las columnas de interés= first y last name, y cuento los registros de film_id de la tabla 
-- de film_actor --
     FROM actor AS a  
         JOIN film_actor AS fa 
            ON a.actor_id = fa.actor_id  -- Uno actor con film_actor para relacionar actores con películas--
              GROUP BY a.actor_id, a.first_name, a.last_name  -- agrupo los resultados por actores para contar las pelis --
				 HAVING COUNT(fa.film_id) > 10 -- filtro y sumo los registros para los grupos creados con GROUP BY, y filtro solo los actores que han participado en 
                 -- más de 10 películas --
					 ORDER BY total_peliculas DESC; -- el total de la pelicula lo ordeno en orde descendiente -- 
                     
/*EJERCICIO_19
Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film*/

SELECT title  -- obtengo el titulo de la pelicula --
FROM film  -- de la tabla film --
WHERE rating = 'R'  -- clasificadas =rating con R
AND length > 120; -- duración mayor a 120 --

/*EJERCICIO_20
Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración*/ 

SELECT*
FROM film; -- de auqí necesito length=promedio de duración --

SELECT*
FROM film_category; -- de auqí necesito film_id y category_id--

SELECT*
FROM category; -- de auqí necesito category_id y name --

-- SOLUCION--				
SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion  -- seleciono el nombre de la tabla category y la renombro, calculo el promedio de duración y renombro
   FROM film AS f  
	 JOIN film_category AS fc 
        ON f.film_id = fc.film_id  -- uno las tablas film y film category para ver la relación entre pelicula y categoria --
          JOIN category AS c 
             ON fc.category_id = c.category_id  -- uno las tablas film category y categoria para ver el nombre categoria --
               GROUP BY c.name  -- Agrupo por categoría para calcular el promedio por grupo
				  HAVING AVG(f.length) > 120  -- Filtro solo las categorías cuyo promedio de duración sea mayor a 120 minutos (utilizo con GROUP BY).
                     ORDER BY promedio_duracion DESC; -- ordeno de forma descendente el promedio de duración --				
	
/*EJERCICIO_21 
Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado*/

SELECT*
FROM actor; -- aqui necesito first y last name-- 

SELECT*
FROM film_actor; -- aqui necesito actor_id y film_id-- 


-- SOLUCION --
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas  -- selecciono las columnas que necesito mostrar y agrupo por el numero de registro y renombro --
    FROM actor AS a  
       JOIN film_actor AS fa 
		 ON a.actor_id = fa.actor_id  -- junto las tablas de actor y film actor para juntar a los actores con sus peliculas --
           GROUP BY a.actor_id, a.first_name, a.last_name  -- agrupo por actor para contar sus peliculas --
                  HAVING COUNT(fa.film_id) >= 5  -- Filtro solo los actores (en GROUP BY) que han actuado en al menos 5 películas.
					ORDER BY total_peliculas DESC; -- ordeno el total de pelis en orden descendiente


/*EJERCICIO_22
Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior
a 5 días y luego selecciona las películas correspondientes*/

SELECT f.title  -- selecciono el titulo de la peli de la tabla de film --
       FROM film AS f  
	     WHERE f.film_id IN -- esta es la consulta principal (desde SELECT hasta WHERE) que selecciona el título de las películas cuyos film_id están en la lista 
         -- de los film_id obtenidos en la subconsulta--
			      (SELECT film_id FROM rental WHERE rental_duration > 5); -- Esta subconsulta selecciona los film_id de las películas que fueron alquiladas por más de 5 días, 
																			-- consultando la tabla rental--
/*EJERCICIO_23
Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores 
que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores*/

SELECT a.first_name, a.last_name  -- selecciono first y last name de la tabla actor --
     FROM actor AS a  
       WHERE a.actor_id NOT IN -- coloco la condición de que el actor no esté y hago la subconsulta --La consulta principal selecciona el nombre y apellido de los actores 
                               -- cuyo actor_id no aparece en la lista obtenida en la subconsulta (es decir, actores que no han actuado en ninguna película de la categoría "Horror").
	     (SELECT fa.actor_id  
             FROM film_actor AS fa  
                JOIN film_category AS fc ON fa.film_id = fc.film_id  
                  JOIN category AS c ON fc.category_id = c.category_id  
                      WHERE c.name = 'Horror'); -- hago una subconsulta para seleccionar los actor_id de los actores que han actuado en películas de la categoría "Horror".
                                                -- Se hace un JOIN entre film_actor, film_category, y category para obtener los actores que han actuado en películas de esa categoría--

/*EJERCICIO_24
Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film*/

SELECT f.title  -- selecciono el titulo -- 
    FROM film AS f  
      JOIN film_category AS fc 
        ON f.film_id = fc.film_id  -- relaciono las películas con sus categorías en film_category--
          JOIN category AS c 
            ON fc.category_id = c.category_id  -- uno con la tabla category para obtener el nombre de la categoría --
              WHERE c.name = 'Comedy'  -- filtro por la categoria comedy --
                AND f.length > 180; -- filtro las pelis con una duración mayor a 180 minutos