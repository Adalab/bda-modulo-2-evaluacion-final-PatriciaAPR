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
WHERE last_name LIKE "%Gibson%";


