# MODULE-5-SQL-LOGIC-PROJECT
Proyecto final del Módulo 5 del curso Data & Analytics V3 de ThePower, desarrollado por Miguel Encinas. Este proyecto se centra en la aplicación de diferentes comandos y técnicas de SQL básico y avanzado, incluyendo:
- **WHERE**
- **Funciones de agregación**
- **Diferentes JOINs**
- **(NOT) EXISTS**
- **Subconsultas**
- **Vistas**
- **Tablas temporales**
- **CTEs**

## ⬇️ Carga de la base de datos 
En primer lugar, importamos nuestra base de datos a DBeaver por medio de postgresSQL (Crear nueva base de datos). Una vez se ha creado nuestra BBDD en DBeaver, la establecemos por defecto, y tras esto abrimos nuestro archivo BBDD_Proyecto_shakila_sinuser.sql a través de la opción 'Buscar archivo denominado'. Una vez abierto este archivo, seleccionamos todo el código y lo ejecutamos. Por último, en caso de no ver cambios, hacemos seleccionamos la opción 'Renovar' en nuestra base de datos, y con esto tendremos cargada nuestra BBDD. 

Una vez hecho todo esto, para poder visualizar el esquema de nuestra BBDD, hacemos click derecho en nuestra base de datos y seleccionamos la opción 'View diagram', con lo que nos mostrará nuestra BBDD y cómo se relacionan las tablas entre ellas. De manera similar, para poder comenzar con nuestro archivo SQL, hacemos click derecho en el archivo 'public' de nuestra base de datos, seleccionamos Editor SQL -> Nuevo script SQL.

## 🧰 Esquema de la BBDD
El archivo .sql correspondiente al esquema de la BBDD está disponible en el repositorio con el nombre _BBDD_Proyecto_shakila_Esquema_Miguel_Encinas.sql_.

## 📝 SQL con las diferentes consultas
El archivo .sql con los enunciados de los problemas planteados, así como las consultas que los resuelven, está disponible en el repositorio con el nombre _BBDD_Proyecto_shakila_Miguel_Encinas.sql_.

De maner similar, el archivo plano _SQL_Code.txt_ musetra todo el código utilizado para este proyecto.

## 🔎 Análisis de los datos
En esta BBDD, nos encontramos con un conjunto de datos que concuerda con una plataforma o tienda de alquiler de películas. En dicha BBDD, tenemos por un lado la información completa de los títulos de los que disponen, tanto en la propia tabla _film_ como en las tablas relacionadas de manera directa e indirecta con ella (_actor,film_actor, category_, etc). Gracias a ello, podemos obtener información no sólo de la película en sí, sino de los actores que participan y la categoría a la que pertenecen.

Por otro lado, nos encontramos con la otra parte de la BBDD, en la que podemos conocer a los clientes de esta tienda o plataforma, así como los alquileres y los pagos que han realizado. Esta información está relacionada con nuestras películas a través de la tabla _inventory_, y nos permite obtener información más centrada en el propio negocio.

A través de las diferentes consultas, hemos podido obtener una gran variedad de información acerca de los actores que participan en ciertas películas, número de películas alquiladas por cliente, películas que se alquilan por encima de X precio, etc. En este proyecto, cabe destacar el uso que he podido aplicar de los **diferentes tipos de JOIN** para poder relacionar varias tablas entre sí y obtener los datos solicitados. Asimismo, la realización de **diferentes tipos de subconsultas** también me ha permitido relizar consultas avanzadas, combinando varios requisitos en una misma _query_, permitiéndome así obtener información más concreta y precisa. Po último, la combinación y aplicación de otros comandos habitualmente empleados como **(NOT) EXISTS, Vistas, Tablas temporales y CTEs** me ha permitido entender y utilizar dichas herramientas para la optimización y reutilización de las consultas.

En general, este proyecto me ha permitido:
- Utilizar **PostgreSQL** y **DBeaver** para la visualización y manejo de BBDD
- **Entender una base de datos**, tantos las tablas individuales que la conforman como las relaciones que hay entre ellas
- Utilizar diferentes **herramientas de SQL**, tanto básicas como avanzadas, permitiéndome obtener un mayor dominio del lenguaje
- Utilizar **varios comandos diferentes** para poder obtener el mismo resultado
- Guardar mis datos y consultas en un **archivo .sql** para compartirlo o editarlo cuando sea necesario
