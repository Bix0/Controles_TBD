WITH GananciasPorEmpleado AS (
  -- Filtrar, unir y AGREGAR ganancias por peluquero y mes
  SELECT 
    c.Id_Peluqueria,
    c.Id_Empleado,
    TO_CHAR(c.Fecha_Cita, 'YYYY-MM') AS Mes, -- PostgreSQL: TO_CHAR para formatear
    SUM(p.Monto_Total) AS Total_Ganado 
  FROM citas c
  JOIN pago p ON c.Id_Cita = p.Id_Cita
  WHERE c.Fecha_Cita >= CURRENT_DATE - INTERVAL '3 years' -- PostgreSQL: Resta de fechas directa
    AND p.Estado_pago = 'Pagado' 
  GROUP BY c.Id_Peluqueria, c.Id_Empleado, TO_CHAR(c.Fecha_Cita, 'YYYY-MM') -- Agrupamos por la función completa
),
RankingGanancias AS (
  -- Ordenar las ganancias totales dentro de cada peluquería y mes
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY Id_Peluqueria, Mes 
      ORDER BY Total_Ganado DESC 
    ) AS Posicion
  FROM GananciasPorEmpleado
)
-- Extraer unicamente al #1 de cada grupo
SELECT 
  Id_Peluqueria,
  Id_Empleado,
  Mes,
  Total_Ganado
FROM RankingGanancias
WHERE Posicion = 1
ORDER BY Id_Peluqueria, Mes;