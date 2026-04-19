WITH ConteoCitas AS (
    SELECT 
        p.Nombre AS Peluqueria,
        h.Dia_Semana,
        h.Hora_Inicio,
        h.Hora_Fin,
        co.Nombre_Comuna,
        COUNT(c.Id_Cita) AS Total_Citas,
        RANK() OVER (
            PARTITION BY p.Id_Peluqueria 
            ORDER BY COUNT(c.Id_Cita) ASC
        ) as Ranking
    FROM horario h
    JOIN citas c ON h.Id_Horario = c.Id_Horario
    JOIN peluqueria p ON p.Id_Peluqueria = c.Id_Peluqueria
    JOIN comuna co ON co.Id_Comuna = p.Id_Comuna
    GROUP BY 
        p.Id_Peluqueria, 
        p.Nombre, 
        h.Dia_Semana, 
        h.Hora_Inicio, 
        h.Hora_Fin,
        co.Nombre_Comuna
)
SELECT 
    Peluqueria,
    Dia_Semana,
    Hora_Inicio,
    Hora_Fin,
    Nombre_Comuna,
    Total_Citas
FROM ConteoCitas
WHERE Ranking = 1;