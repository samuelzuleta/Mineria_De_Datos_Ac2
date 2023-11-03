# Mineria_De_Datos_Ac2
Repositorio que contiene el Data Build Tool asociado a la actividad N°2 del grupo 7 de la materia minería de datos (Periodo 2023-03), Universidad del norte.

## :construction_worker: Mienbros del equipo.
- Samuel Zuleta
- Salomon Saens
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

Durante el desarrollo de este taller se daran respuesta a una serie de preguntas basadas en varios conjuntos de datos que se nos dan como punto de partida. Las respuestas seran contestadas precisamente
a travez de consultas SQL a estos conjuntos de datos que deberan ser exportados a Bigquery y posteriormente materializados e imputados. Todo, a excepción de la migración inicial la cual sera manual, deberá 
ser realizado a travez de un Data Build Tool configurado para conectarce a Bigquery y ejecutar las sentencias SQL una a una hasta realizarlas todas.

Finalmente crearemos un reporte en Looker Studio. 

## Migración de datos a Bigquery

Para la migración de las 4 tablas a bigquery Realizamos una subida manual ya que este era el unico paso que teniamos permitido realizar de esta manera. La migración fue rapida gracias a que Bigquery te permite 
la opcion de subir las tablas directamente desde Google drive sin intermediarios, siendo ambos servicios de Google es algo normal.

Las 4 tablas quedaron subidas como vistas dentro del proyecto "mineria-uninorte" en el conjunto de datos "Actividad2" conservando el formato de origen y con sus respectivos nombres (Compras_EXT, Clientes_EXT, Olimpica_EXT, Exito_EXT). Estas seran el unico material con el que se desarrollaran todos los puntos ademas de lo generado a partir de ellas.

## Materialización de las tablas

La materialización de las tablas tambien fue una tarea relativamente sencilla ya que esta se limitaba a crear 4 consultas SQL que reralizaran un SELECT del contenido total de cada una de ellas (a las tablas 
externas con finalización ".EXT") pra luego crear una nueva para cada una con los mismos datos.

Sabemos que este paso es realizado principalmente para no tener que ejecutar las vistas cada que se deseen consultar, lo que disminuye los tiempos de ejecución de los Querys.

## Imputación de datos faltantes

Para realizar el proceso de imputación de los datos en primer lugar debiamos saber cuales de las tablas requerian de este proceso. Nos dimos cuenta que la unica tabla con Valores faltantes era la tabla de productos olimpica en su columna de precio por lo que era la unica que necesitaba imputación. Las instrucciones indicaban que la imputación era usando la media, El proceso a seguir fue el siguiente:

Realizamos Un conteno de los productos que si tenian precio con una función over() y ademas ordenamos los precios de forma desecendente, luego añadimos numeración a cada precio. Despues de eso usaremos una 
consulta que a travez del uso del CASE WHEN decida como calcular la media en función de si hay un numero par o impar de precios y guardarla, por ultimo hacemos una consulta a la tabla De olimpica y remplazamos los valores que son nulos. 

Esta nueva tabla imputada se guardara con el nombre de "Olimpica_IMP" y sera usada en el desarrollo de las preguntas en sustitución de la normal.

## Pregunta N° 1

## Pregunta N° 2

## Pregunta N° 3

## Pregunta N° 4

## Pregunta N° 5

## Informe en Looker Studio
























