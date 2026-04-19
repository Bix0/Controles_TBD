WITH d AS ( -- Calcula duración y extrae el mes/año de cada cita
  SELECT 
    c.Id_Peluqueria, 
    c.Id_Cliente, 
    TO_CHAR(c.Fecha_Cita, 'YYYY-MM') AS mes, -- PostgreSQL: Convierte fecha a 'AAAA-MM'
    EXTRACT(EPOCH FROM (h.Hora_Fin - h.Hora_Inicio)) / 60 AS dur -- PostgreSQL: Diferencia exacta en minutos
  FROM citas c 
  JOIN horario h ON c.Id_Horario = h.Id_Horario
),
r AS ( -- Asigna ranking sin colapsar filas
  SELECT *, 
    ROW_NUMBER() OVER (
      PARTITION BY Id_Peluqueria, mes -- Reinicia la numeración por cada peluquería y mes
      ORDER BY dur DESC -- Ordena de mayor a menor duración
    ) AS rn 
  FROM d
)
-- Filtra solo el registro con ranking 1
SELECT Id_Peluqueria, Id_Cliente, mes, dur 
FROM r 
WHERE rn = 1 
ORDER BY Id_Peluqueria, mes;