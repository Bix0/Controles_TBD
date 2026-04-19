WITH d AS ( -- Calcula duración y extrae el mes/año de cada cita
  SELECT 
    c.Id_Peluqueria, 
    c.Id_Cliente, 
    DATE_FORMAT(c.Fecha_Cita, '%Y-%m') AS mes, -- Convierte fecha a 'AAAA-MM' para agrupar por mes
    TIMESTAMPDIFF(MINUTE, h.Hora_Inicio, h.Hora_Fin) AS dur -- Diferencia exacta en minutos
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