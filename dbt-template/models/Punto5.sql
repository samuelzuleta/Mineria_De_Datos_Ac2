WITH Oli AS (
  SELECT * except(Cantidad,Unidad)
  FROM {{ ref("Olimpica_IMP") }} 
),
Exi AS(
  SELECT * except(Cantidad,Unidad)
  FROM {{ ref("Exito") }}
),
prod AS(
  SELECT *
  FROM Oli

  UNION ALL

  SELECT *
  FROM Exi 
),
Vendidos AS(
  SELECT DISTINCT a.producto, "esta" AS Esta
  FROM {{ ref("Compras") }} a
)


SELECT p.Codigo, p.producto, p.Precio
FROM Vendidos v RIGHT JOIN prod p ON p.Codigo = v.producto
WHERE v.Esta IS NULL