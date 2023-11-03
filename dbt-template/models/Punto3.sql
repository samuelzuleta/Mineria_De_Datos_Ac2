-- depends_on: {{ ref('Olimpica_IMP') }}
WITH Ventas_O AS (
  SELECT a.cliente,COUNT(*) as cuenta
  FROM {{ ref("Compras") }} a
  WHERE a.producto LIKE "OLI%"
  GROUP BY a.cliente
),
Ventas_E AS (
  SELECT a.cliente, COUNT(*) as cuenta
  FROM {{ ref("Compras") }} a
  WHERE a.producto LIKE "EXI%"
  GROUP BY a.cliente
)

SELECT o.cliente, o.cuenta AS Compras_Oli, e.cuenta AS Compras_Exi
FROM Ventas_O o INNER JOIN Ventas_E e ON o.cuenta > 0 and e.cuenta = 0