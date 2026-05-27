-- DataProject: LógicaConsultasSQL
-- Alumno: Miguel Encinas Gimenez

/*
 Aquí se recogen las queries de SQL para resolver los distintos ejercicios de la taera, así como
 una breve explicación cuando resulta necesario aclarar algún aspecto de dichas consultas.
 */

--1. Crea el esquema de la BBDD.
/*
 Para crear el esquema de nuestra BBDD, importamos nuestra base de datos a DBeaver por medio de postgresSQL (Crear nueva base de datos). 
 Una vez se ha creado nuestra BBDD en DBeaver, la establecemos por defecto, y tras esto abrimos nuestro archivo BBDD_Proyecto_shakila_sinuser.sql
 a través de la opción 'Buscar archivo denominado'. Una vez abierto este archivo, seleccionamos todo el código y lo ejecutamos. Por último,
 en caso de no ver cambios, hacemos seleccionamos la opción 'Renovar' en nuestra base de datos, y con esto tendremos cargada nuestra BBDD.
 Una vez hecho todoe esto, para poder visualizar el esquema de nuestra BBDD, hacemos click derecho en nuestra base de datos y seleccionamos
 la opción 'View diagram', con lo que nos mostrará nuestra BBDD y cómo se relacionan las tablas entre ellas.
 */

--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select f.film_id, f.title, f.rating
from film f
where f.rating = 'R'
order by f.title;

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select a.actor_id, concat(a.first_name, ' ', a.last_name) as "Complete name"
from actor a
where a.actor_id between 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original.
select *
from film f
where f.language_id = f.original_language_id;
--La query no nos devuelve ningún resultado ya que, al parecer, la columna original_language_id solamente presenta valores NULL

select distinct f.original_language_id 
from film f;
--Con este comando, efectivamente comprobamos que en dicha columna solo existen valores NULL

--5. Ordena las películas por duración de forma ascendente.
select f.film_id, f.title, f.length 
from film f 
order by f.length;
--No hace falta indicar que lo ordene de forma ascendente, ya que si no especificas, SQL aplica dicho orden de manera predeterminada

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select a.actor_id, a.first_name, a.last_name 
from actor a
where a.last_name like 'ALLEN';

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select f.rating, count(f.rating) as "Number of films"
from film f
group by f.rating
order by "Number of films";

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select f.film_id, f.title
from film f
where f.rating = 'PG-13'
or f.length > 180;
-- Considerando que la duración en la tabla figura en minutos, convertimos las 3 h a minutos (180') para nuestra query

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance(f.replacement_cost), 2)
from film f;
-- Entendiendo que es una unidad monetaria, redondeamos a dos decimales para que el resultado sea más intuitivo.

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MAX(f.length), MIN(f.length)
from film f;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select count(p.payment_id)
from payment p;
/*
 Con esto, sabemos que tenemos 16.049 valores totales. Por tanto, para poder acceder al antepenúltimo valor, en primer lugar debemos poner un LIMIT de 1 para seleccionar un solo valor
 Tras esto, seleccionamos un offset de 16.043 (16.049-3) para que nos muestre el antepenúltimo valor, habiendo ordenado previamente de manera ascendente ordenado por el día de alquiler
*/
select p.payment_id, p.payment_date, p.amount
from payment p 
order by p.payment_date asc
limit 1
offset 16046;

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select f.film_id, f.title, f.rating 
from film f
where f.rating not in ('NC-17', 'G');

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select f.rating, round(AVG(f.length),2) as "Average length"
from film f
group by f.rating
order by "Average length";

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select f.film_id, f.title, f.length 
from film f
where f.length > 180
order by f.length;

--15. ¿Cuánto dinero ha generado en total la empresa?
--Para ello, tenemos que ir a la tabla payment, y calcular la suma total de amount
select SUM(amount) as "Total amount"
from payment p;

--16. Muestra los 10 clientes con mayor valor de id.
select c.customer_id, concat(c.first_name, ' ', c.last_name) as "Complete name"
from customer c
order by c.customer_id desc
limit 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select concat(a.first_name, ' ', a.last_name) as "Complete name", f.title 
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
inner join film f
on fa.film_id = f.film_id 
where f.title  = 'EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.
select distinct f.title 
from film f;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f.title, f.length, c."name" as "Category"
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id 
where c."name" = 'Comedy'
and f.length > 180;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c."name",  round(avg(f.length), 2) as "Average length"
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on c.category_id = fc.category_id 
group by c.category_id 
having round(avg(f.length), 2) > 110
order by "name";

--21. ¿Cuál es la media de duración del alquiler de las películas?
select round(extract(epoch from AVG(r.return_date - r.rental_date))/(60*60*24), 2) as "Average rental days"
from rental r;
/*Para esta query, he tenido que apoyarme en una pequeña búsqueda de internet para perfilar el resultado. Con mi primera consulta, usando únicamente la función AVG, obtenía un resultado
 en un formato poco intuitivo incluyendo días, horas minutos, etc. Debido a esto, gracias a mi búsqueda en internet, descubrí la funcion EXTRACT(EPOCH()), que permite transformar tu resultado en
 segundos. Apliqué dicha función, y dividí el resultado entre (60*60/24), que son los segundos que hay en un día. Finalmente, apliqué la función ROUND() como en otras consultas previas, para
 redondear el resultado a dos decimales
 */

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select a.actor_id, concat(a.first_name, ' ', a.last_name), a.last_update 
from actor a;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
-- En función de cómo entendamos el enunciado, podemos averiguar en primer lugar el número de alquiler por día en función del número de día (es decir, del 1 al 31).
-- Para este caso, no distinguimos por mes y usamos el comando extract (day()) para extraer el número de día de la columna con el timestamp, y agrupamos por dicho número
select extract(day from r.rental_date) as "Day of month", count(r.rental_date) as "Number of rentals per day"
from rental r 
group by extract(day from r.rental_date)
order by "Number of rentals per day" desc;

--En cambio, si queremos distinguir por día concreto, usamos directamente el comando date() para extraer la fecha completa de la timestamp, y agrupar los datos por dicha fecha.
select date(r.rental_date) as "Day", count(r.rental_date) as "Number of rentals per day"
from rental r 
group by date(r.rental_date)
order by "Number of rentals per day";

--24. Encuentra las películas con una duración superior al promedio.
select f.film_id, f.title, f.length 
from film f
where f.length > (
	select AVG(f2.length)
	from film f2)
order by f.length;

--25. Averigua el número de alquileres registrados por mes.
--Usamos un código similar al del enunciado 23, pero esta vez agrupamos por numero de mes en vez de por día.
select extract(month from r.rental_date) as "Month", count(r.rental_date) as "Number of rentals per month"
from rental r 
group by extract(month from r.rental_date)
order by "Number of rentals per month";

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select round(AVG(p.amount), 2), round(variance(p.amount), 2), round(stddev(p.amount), 2)
from payment p;

--27. ¿Qué películas se alquilan por encima del precio medio?
--La manera que me parecía más sencilla es hacer INNER JOINS desde la tabla payment hasta la tabla film, usando las primary keys de cada par de tablas
select f.film_id, f.title, p.amount
from payment p
inner join rental r
on p.rental_id = r.rental_id
inner join inventory i
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id 
where p.amount > (
	select avg(p2.amount)
	from payment p2)
order by p.amount;

--28. Muestra el id de los actores que hayan participado en más de 40 películas.
select fa.actor_id, count(fa.film_id) as "Number of films"
from film_actor fa 
group by actor_id
having count(fa.film_id) > 40
order by actor_id;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select f.film_id, f.title, count(i.inventory_id) as "Available copies"
from film f
left join inventory i 
on f.film_id = i.film_id
group by f.film_id, f.title 
order by f.film_id;
--En este caso, está bastante claro que lo más conveniente es usar LEFT JOIN empezando desde la tabla film

--30. Obtener los actores y el número de películas en las que ha actuado.
select fa.actor_id, concat(a.first_name, ' ', a.last_name) as "Complete name", count(fa.film_id) as "Number of films"
from film_actor fa
left join actor a
on fa.actor_id = a.actor_id 
group by fa.actor_id, a.first_name, a.last_name 
order by actor_id;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.title, concat(a.first_name, ' ', a.last_name) as "Actor name"
from film f
left join film_actor fa 
on f.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id
order by f.title;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select concat(a.first_name, ' ', a.last_name) as "Actor name", f.title
from actor a
left join film_actor fa 
on a.actor_id = fa.actor_id
left join film f
on fa.film_id = f.film_id
order by "Actor name";
--Tanto en este enunciado como en el anterior, al pedirnos todos los actores o películas, lo más conveniente es usar LEFT JOIN empezando desde la tabla actor o film, respectivamente.

--33. Obtener todas las películas que tenemos y todos los registros dealquiler.
select f.film_id, f.title, r.rental_id 
from film f
full join inventory i
on f.film_id = i.film_id
full join rental r
on i.inventory_id = r.inventory_id
order by f.film_id;
--Con este FULL JOIN mostramos todos los datos de películas y de registros aunque, como se puede ver, también muestra alguna película sin alquileres asociados.
--En caso de querer mostrar solamente las películas que tengan alquileres asociados, lo más conveniente serían dos LEFT JOIN, en vez de FULL JOIN.

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c.customer_id, concat(c.first_name, ' ', c.last_name), sum(p.amount) as "Total spent"
from customer c
inner join payment p 
on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by "Total spent" desc
limit 5;
-- Usar LEFT JOIN también sería correcto, pero en este caso, no nos interesan los pagos sin cliente asociado, y los clientes que no tengan pagos nunca van a estar en el top 5, así que creo que INNER JOIN también es correcto.

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select a.actor_id, concat(a.first_name, ' ', a.last_name)
from actor a
where a.first_name = 'JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
--Escribo la query pero no la aplico, para evitar confusiones en futuros enunciado y mantener la homogeneidad del código
alter table actor
rename column first_name to Nombre;
alter table actor
rename column last_name to Apellido;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min(a.actor_id), max(a.actor_id)
from actor a;

--38. Cuenta cuántos actores hay en la tabla “actor”.
select count(a.actor_id)
from actor a;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select *
from actor a
order by a.last_name;

--40. Selecciona las primeras 5 películas de la tabla “film”.
select *
from film f
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
-- Para averiguar el nombre de actor más repetido, ordenamos por el conteo de los nombres en orden descendente
select a.first_name, count(a.actor_id) as "Actores con este nombre"
from actor a
group by a.first_name
order by "Actores con este nombre" desc
--Se puede observar que hay 3 nombres con el mismo conteo en la cabeza de la tabla, así que limitamos el número de resultados devueltos
--para que devuelva solamente esos nombres
limit 3;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id, c.first_name, c.last_name 
from rental r
left join customer c
on r.customer_id = c.customer_id;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select c.customer_id, c.first_name, c.last_name, r.rental_id 
from customer c
left join rental r
on c.customer_id = r.customer_id
order by c.customer_id;
--Tanto en este enunciado como en el anterior, sin duda LEFT JOIN es lo más conveniente, al pedirnos 'todos' los alquileres o los clientes.

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f
cross join category c;
--No ha tenido mucha utilidad, ya que simplemente ha realizado todas las combinaciones posibles entre las filas de la tabla film y la tabla category.
--Considero que esta operación difícilmente puede tener alguna utilidad real.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select distinct a.actor_id, a.first_name,  a.last_name
from actor a 
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film_category fc
on fa.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where c."name" = 'Action'
order by a.actor_id;
--En este caso, creo que LEFT JOIN sería igualmente válido, porque al final aplico un filtro con WHERE para quedarme con los resultados de interés, 
--pero conceptualmente diría que lo más correcto es que todos sean INNER JOIN

---46. Encuentra todos los actores que no han participado en películas.
select *
from actor a 
LEFT JOIN film_actor fa
on a.actor_id = fa.actor_id
where fa.actor_id is null;
/*
Siguiendo esta lógica, left join trae a todos los actores y, si un actor no tiene coincidencia en la tabla film_actor(fa), las columnas
de fa quedarán como null. De esta manera, podemos solicitar dichas columnas con el WHERE. Al aparecer la tabla vacía, esto nos indica que
no hay películas que no tengan actores asociados.
*/

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select a.first_name, a.last_name, count(fa.film_id) as "Total number of films"
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
group by a.first_name, a.last_name
order by "Total number of films" desc;
--Siguiendo la lógica del enunciado, si hay alguna película sin actor asociado, no nos interesa, así que un LEFT JOIN empezando desde la tabla actor sería lo más lógico.

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
	select a.first_name, a.last_name, count(fa.film_id) as "Total number of films"
	from actor a
	left join film_actor fa
	on a.actor_id = fa.actor_id
	group by a.first_name, a.last_name
	order by "Total number of films" desc;
select *
from actor_num_peliculas

--49. Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as "Total rental number"
from rental r
left join customer c
on r.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name
order by "Total rental number" desc;
--Un cliente sin alquiler no nos interesa para este caso concreto, así que un LEFT JOIN empezando desde la tabla rental sería suficiente.

--50. Calcula la duración total de las películas en la categoría 'Action'.
select sum(f.length) as "Total length (min)"
from film f
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c."name" = 'Action';
--Al igual que en el enunciado 45, creo que LEFT JOIN sería igualmente válido, porque al final aplico un filtro con WHERE para obtener los resultados de interés, 
--pero conceptualmente diría que lo más correcto es que todos sean INNER JOIN, porque una película sin categoría no nos interesa en este caso.

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as (
	select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as "Total rental number"
	from rental r
	inner join customer c
	on r.customer_id = c.customer_id
	group by c.customer_id, c.first_name, c.last_name
	order by "Total rental number" desc);
--En este caso, no queremos un alquiler que no tenga un cliente asociado (lo normal sería que no lo hubiera, pero nunca se sabe), por eso un INNER JOIN puede ser lo más lógico.

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as (	
	select f.film_id, f.title, count(r.rental_id) as "Number of rentals"
	from film f
	inner join inventory i
	on f.film_id = i.film_id 
	inner join rental r
	on i.inventory_id = r.inventory_id
	group by f.film_id, f.title
	having count(r.rental_id) >= 10);
--De manera similar al enunciado anterior, creo que lo más conveniente aquí es el uso de INNER JOIN.

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select f.film_id , f.title 
from customer c
inner join rental r
on c.customer_id = r.customer_id
inner join inventory i
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
where r.return_date is null
and concat(c.first_name, ' ', c.last_name) = 'TAMMY SANDERS'
order by f.title;
--No queremos clientes sin alquileres, ni alquileres sin inventario, ni inventario sin películas, por lo que lo más lógico aquí sería un INNER JOIN en todos los casos

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as "Number of Sci-Fi films"
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film_category fc
on fa.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where c."name" = 'Sci-Fi'
group by a.actor_id, a.first_name, a.last_name 
order by a.last_name;

--Otra opción que se me ha ocurrido, quizás más conveniente para este enunciado, sería utilizar la cláusula WHERE EXISTS, ya que el requisito es que al menos haya hecho una película en la categoría Sci-Fi
select a.actor_id, a.first_name, a.last_name
from actor a
where exists (
	select 1
	from film_actor fa
	inner join film_category fc
	on fa.film_id = fc.film_id
	inner join category c
	on fc.category_id = c.category_id 
	where a.actor_id = fa.actor_id
	and c."name" = 'Sci-Fi')
order by a.last_name;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
with spartacus_cheaper_first as (
	select *
	from rental r
	inner join inventory i
	on r.inventory_id = i.inventory_id
	inner join film f
	on i.film_id = f.film_id
	where f.title = 'SPARTACUS CHEAPER'
	order by r.rental_date
	limit 1)
select distinct a.first_name, a.last_name 
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join inventory i 
on fa.film_id  = i.film_id 
inner join rental r
on i.inventory_id = r.inventory_id
where r.rental_date > (
	select spartacus_cheaper_first.rental_date
	from spartacus_cheaper_first)
order by a.last_name 

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select distinct a.actor_id, a.first_name, a.last_name
from actor a
where not exists (
	select 1
	from film_actor fa
	inner join film_category fc 
	on fa.film_id = fc.film_id
	inner join category c
	on fc.category_id = c.category_id
	where a.actor_id = fa.actor_id 
	and c."name" = 'Music')
order by a.actor_id;

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
--En este primer caso, planteo una query que nos devuelve el título de las películas, con sus correspondiente rental_id y los días de duración de ese alquiler, ya que una misma película se ha podido alquilar más veces
select r.rental_id, f.title,(date(r.return_date) - date(r.rental_date)) as "Number of rent days"
from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id
where (date(r.return_date) - date(r.rental_date)) > 8
order by f.title;

--Si en vez de querer ver estudiar los alquileres que han superado los 8 días, queremos saber el título único de las películas que, en algún momento, fueron alquiladas más de 8 días, podemos usar la siguiente query
select f.title
from film f
where exists (
	select 1
	from inventory i 
	inner join rental r
	on i.inventory_id = r.inventory_id
	where f.film_id = i.film_id
	and (date(r.return_date) - date(r.rental_date)) > 8)
order by f.title;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
--Al igual que en los enunciados 45 y 50, creo que LEFT JOIN sería igualmente válido, pero diría que lo más correcto es que todos sean INNER JOIN, porque una película sin categoría no nos interesa en este caso tampoco.
select f.title, c."name" as "Category"
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where c."name" = 'Animation'
order by f.title;

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select f.title, f.length
from film f
where f.length = 
	(select f2.length 
	from film f2
	where f2.title = 'DANCING FEVER');

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select c.first_name, c.last_name
from customer c
inner join rental r
on c.customer_id = r.customer_id
inner join inventory i
on r.inventory_id = i.inventory_id
group by c.first_name, c.last_name
having count(distinct i.film_id) >= 7
order by c.last_name;
--Usamos INNER JOIN porque un cliente sin alquiler no interesa, y un alquiler sin inventario no debería existir, y en dicho caso no interesaría tampoco

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c."name" as "Category", count(r.rental_id) as "Total of films rented"
from rental r
inner join inventory i
on r.inventory_id = i.inventory_id
inner join film_category fc 
on i.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
group by c."name"
order by "Total of films rented";
--De manera similar al enunciado anterior, INNER JOIN sería la opción más correcta.


--62. Encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as "Category", count(f.film_id) as "Number of films"
from film f
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where f.release_year = 2006
group by c."name"
order by "Number of films";

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select *
from staff s
cross join store s2 

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente,
select c.customer_id, count(r.rental_id) as "Number of rented films"
from customer c
inner join rental r
on c.customer_id = r.customer_id
inner join inventory i
on r.inventory_id = i.inventory_id
group by c.customer_id
order by "Number of rented films";
--En este caso, solamente se muestran los clientes que han alquilado alguna película (es lo que más se ajusta al enunciado a mi parecer), 
--pero si queremos mostrar todos los clientes sin excepción, tendríamos que empezar con un LEFT JOIN en vez de INNER JOIN.
