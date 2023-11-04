# Mineria_De_Datos_Ac2
Repositorio que contiene el Data Build Tool asociado a la actividad N°2 del grupo 7 de la materia minería de datos (Periodo 2023-03), Universidad del norte.

## :construction_worker: Mienbros del equipo.
- Samuel Zuleta
- Salomon Saenz
- Edilberto Rodrigez
- Juan Saieh
- Eduardo Rey

## :world_map: Tabla de contenidos
1. [NOTA IMPORTANTE](#anotaciones-importantes)
2. [Contexto Inicial del desarrollo](#contextualización)
3. [Migración de los datos](#migración-de-datos-a-bigquery)
4. [Materialización de las tablas](#materialización-de-las-tablas)
5. [Imputación](#imputación-de-datos-faltantes)
6. [Pregunta 1](#pregunta-n-1)
7. [Pregunta 2](#pregunta-n-1)
8. [Pregunta 3](#pregunta-n-1)
9. [Pregunta 4](#pregunta-n-1)
10. [Pregunta 5](#pregunta-n-1)
11. [Informe looker studio](#informe-en-looker-studio)


## ANOTACIONES IMPORTANTES

## Contextualización 

Durante el desarrollo de este taller, se darán respuesta a una serie de preguntas basadas en varios conjuntos de datos que se nos dan como punto de partida. Las respuestas serán contestadas precisamente
a través de consultas SQL a estos conjuntos de datos que deberán ser exportados a BigQuery y posteriormente materializados e imputados. Todo, a excepción de la migración inicial, la cual sera manual, deberá 
ser realizado a través de un Data Build Tool configurado para conectarce a Bigquery y ejecutar las sentencias SQL una a una hasta realizarlas todas.

Finalmente crearemos un reporte en Looker Studio. 

## Migración de datos a BigQuery

Para la migración de las 4 tablas a Bigquery, realizamos una subida manual, ya que este era el único paso que teníamos permitido realizar de esta manera. La migración fue rápida gracias a que Bigquery te permite la opción de subir las tablas directamente desde Google drive sin intermediarios, siendo ambos servicios de Google es algo normal.

Las 4 tablas quedaron subidas como vistas dentro del proyecto "mineria-uninorte" en el conjunto de datos "Actividad2" conservando el formato de origen y con sus respectivos nombres (Compras_EXT, Clientes_EXT, Olimpica_EXT, Exito_EXT). Estas serán el único material con el que se desarrollarán todos los puntos además de lo generado a partir de ellas.

## Materialización de las tablas

La materialización de las tablas también fue una tarea relativamente sencilla, ya que se limitaba a crear 4 consultas SQL que realizaran un SELECT del contenido total de cada una de ellas (a las tablas externas con extensión ".EXT") para luego crear una nueva tabla para cada una con los mismos datos.

Sabemos que este paso se realiza principalmente para evitar tener que ejecutar las vistas cada vez que se deseen consultar, lo que disminuye los tiempos de ejecución de los Querys.

## Imputación de datos faltantes

Para realizar el proceso de imputación de los datos en primer lugar debíamos saber cuáles de las tablas requerían de este proceso. Nos dimos cuenta que la única tabla con Valores faltantes era la tabla de productos olímpica en su columna de precio por lo que era la única que necesitaba imputación. Las instrucciones indicaban que la imputación era usando la media, El proceso a seguir fue el siguiente:
Realizamos un conteo de los productos que si tenían precio con una función over() y además ordenamos los precios de forma descendente, luego añadimos numeración a cada precio. Después de eso usaremos una consulta que a través del uso del CASE WHEN decida como calcular la media en función de si hay un numero par o impar de precios y guardarla, por último hacemos una consulta a la tabla De olímpica y remplazamos los valores que son nulos.
Esta nueva tabla imputada se guardará con el nombre de "Olimpica_IMP" y será usada en el desarrollo de las preguntas en sustitución de la normal.

## Pregunta N° 1

### ¿Cuál es el gasto promedio de "Vino Tinto" tanto en las tiendas Olimpica como en las EXITO?

Para responder estas preguntas era nescesario utilizar 3 tablas: La de productos exito, la de producto olimpica con su imputación y por ultimo la tabla de compras, definimos que el resultado final debian ser 
2 valores que serian los gatos promedios de vino tinto en exito y en olimpica. El procedimiento fue el siguiente: 

- Extraer de las tablas de productos tanto exito como olimpica todos los codigos y los precios de los diferentes productos que cumplieran con que en su descripción estuviera el fragmento "vino tinto".
- Unir ambas tablas usando un UNION ALL. Luego usando la tabla compras realizamos un conteo de las veces que fueron comprados cada producto para asi a travez de un INNER JOIN filtrar solo los conteos de vino tinto
- Por ultimo y usando una columna auxiliar en la tabla anterior calculamos el promedio de cada tienda y lo mostramos en 2 diferentes filas.

## Pregunta N° 2

### ¿Quiénes son los compradores destacados en los establecimientos Olimpica y EXITO?

Esta pregunta la interpretamos como que debiamos extraer el top de clientes con más Compras en Dinero de ambas tiendas de manera conjunta, decidimos centrarno en los 10 mayores compradores, en este punto utilizamos
las 4 tablas. El proceso fue el siguiente: 

- En primero lugar tomamos el codigo y precio de los productos tanto de olimpica como de exito y lo unimos todo en una tabla (UNION ALL).
- Luego enfrentamos esta tabla con la tabla de compras para realizar un perfil de cada codigo de cliente y la sumatoria de los precios de todos lo productos que compro.
- Al final realizamos un join con la anterior tabla y la de clientes para obtener sus datos a travez del codigo para mostrar entonces los datos de los 10 más prominentes y su gasto total.

## Pregunta N° 3

### ¿Quiénes son los clientes que han realizado compras específicamente en Olimpica pero no en EXITO?

Para Responder esta pregunta decidimos que solo era necesario utilizar la tabla de Compras y como la pregunta nos lo indica: mostrar los clientes Que hicieran compras en olimpica pero no en EXITO. La consulta 
ocurre de la siguiente manera: 

- Realizamos 2 conteos: 1 que cuente la cantidad de comprar por cliente en Olimpica y otro para exito agrupandos por cliente.
- Luego realizamos un INNER JOIN entre ambos en donde la condicion sea que el contador de olimpica sea mayor a 0 ( > 0 ) y el de Exito igual a 0 ( = 0 )

### IMPORTANTE: 

El resultado de esta consulta SQL no nos arroja nada aparentemente , esto es debido a que no existen clientes que realizen compras solo en Olimpica y no en Exito.

## Pregunta N° 4

### ¿Cuáles son los productos que las personas compran con mayor frecuencia?

Lo que esta pregunta claramente nos incita a buscar son los productos, ya sea de Olimpica o de EXITO, que tiene más número de ventas, para este utilizamos ambas tablas de productos y la de Compras. El proceso
logico es el siguiente:

- Primero Realizamos un conteo por codigo de producto que muestre la cantidad de veces que ha sido comprado cada uno y lo ordenamos de mayores a menores tomando solo los 10 primeros.
- Extraemos información relevante de los productos tanto de Olimpica como de Exito y los unimos en una sola tabla.
- Finalmente asociamos cada condigo de la tabla de conteo con su respectiva información y ordenamos nuevamente en base a el conteo de ventas.

## Pregunta N° 5

### ¿Qué artículos nunca han sido comprados por los clientes?

Esta pregunta nos pide encontrar aquellos articulos de cualquiera de las tiendas que no tiene ventas aun, para responder a esta pregunta una vez mas utilizamos las tablas de Olimpica, Exito y Compras. La 
estructura es la siguiente:

- Tomar de las tablas de productos de ambas tiendas la información relevante de cada producto y juntarlo en una sola tabla (UNION ALL).
- Crear otra tabla donde guardemos todos los productos distintos que estan en compras y a cada un le añadimo la columna auxiliar "Esta" que siempre contiene esa misma palabra.
- Usando un RIGHT JOIN con la tabla de productos en compras lado derecho y la tabla de productos al izquierdo, elegimos unicamente a aquellos cuya casilla "Esta" tiene un valor nulo, que serian los
que no aparecen en la tabla de productos en compras y por lo tanto los que aun no han sido comprados.

## Informe en Looker Studio

[Link del informe](https://lookerstudio.google.com/reporting/d9a88c7b-6a5b-4544-8214-9a86b2ca00ac/page/1mJhD)






















