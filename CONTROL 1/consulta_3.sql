WITH GananciasPorEmpleado AS (
  -- Filtrar, unir y AGREGAR ganancias por peluquero y mes
  -- sumar los montos de cada peluquero durante el mes para obtener su total mensual
  SELECT 
    c.Id_Peluqueria,
    c.Id_Empleado,
    DATE_FORMAT(c.Fecha_Cita, '%Y-%m') AS Mes, -- agrupar por año-mes de la cita
    SUM(p.Monto_Total) AS Total_Ganado -- suma de todos los pagos asociados a sus citas
  FROM citas c
  JOIN pago p ON c.Id_Cita = p.Id_Cita
  WHERE c.Fecha_Cita >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR) -- Solo últimos 3 años desde hoy
    AND p.Estado_Pago = 'Pagado' -- Excluye pagos pendientes, cancelados o fallidos
  GROUP BY c.Id_Peluqueria, c.Id_Empleado, Mes -- Agrupa obligatoriamente antes de rankear
),
RankingGanancias AS (
  -- Ordenar las ganancias totales dentro de cada peluquería y mes
  -- ROW_NUMBER() asigna 1 al peluquero con mayor suma en cada combinación (Peluquería + Mes)
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY Id_Peluqueria, Mes -- Reinicia el conteo por cada peluquería y mes
      ORDER BY Total_Ganado DESC -- Mayor acumulado primero
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