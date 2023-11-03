WITH Top AS(
  SELECT a.producto, COUNT(*) AS cuenta
  FROM {{ ref("Compras") }} a
  GROUP BY a.producto
  ORDER BY cuenta DESC
  LIMIT 10
),
Oli AS (
  SELECT * except(Cantidad,Precio)
  FROM {{ ref("Olimpica_IMP") }}
),
Exi AS(
  SELECT * except(Cantidad,Precio)
  FROM {{ ref("Exito") }}
),
prod AS(
  SELECT *
  FROM Oli

  UNION ALL

  SELECT *
  FROM Exi 
)

select p.Codigo, p.producto, t.cuenta AS Veces_comprado
FROM Top t INNER JOIN prod p on t.producto = p.Codigo
order by t.cuenta desc