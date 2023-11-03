WITH Ventas_totales AS (
  SELECT Codigo,Precio
  FROM {{ ref("Olimpica_IMP") }}

  UNION ALL

  SELECT Codigo,Precio
  FROM {{ ref("Exito") }}
),
cliente_gastos_compras AS(
  SELECT a.cliente AS Numero,  SUM(b.Precio) AS total_compras
  FROM {{ ref("Compras") }} a
  INNER JOIN Ventas_totales b ON a.producto = b.Codigo
  GROUP BY a.cliente
  ORDER BY total_compras DESC
  LIMIT 10
),

cliente_gastos_compras_datos_cliente AS(
  SELECT a.C__digo,a.Nombre, a.Apellido, a.Latitud AS lat, a.Longitud AS long, b.total_compras
  FROM {{ ref("Clientes") }} a INNER JOIN cliente_gastos_compras b ON a.C__digo = b.Numero
),

campo_nombre AS (
  SELECT CONCAT(Nombre,' ',Apellido) AS Nombre, C__digo, total_compras
  FROM cliente_gastos_compras_datos_cliente
)
SELECT *
FROM campo_nombre
ORDER BY campo_nombre.total_compras DESC