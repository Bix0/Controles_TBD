-- Consulta 6 --
WITH Concurrencia AS (
    SELECT 
        EXTRACT(YEAR FROM Citas.Fecha_Cita) AS Anio,
        EXTRACT(MONTH FROM Citas.Fecha_Cita) AS Mes,
        Peluqueria.Nombre,
        Horario.Hora_Inicio,
        Horario.Hora_Fin,
        COUNT(Citas.Id_Cita) AS Cantidad_Citas
    FROM Citas
    JOIN Peluqueria ON Citas.Id_Peluqueria = Peluqueria.Id_Peluqueria
    JOIN Horario ON Citas.Id_Horario = Horario.Id_Horario
    -- Sacar datos entre los años 2018 y 2029
    WHERE EXTRACT(YEAR FROM Citas.Fecha_Cita) BETWEEN 2018 AND 2029
    GROUP BY Anio, Mes, Peluqueria.Nombre, Horario.Hora_Inicio, Horario.Hora_Fin
),
Ranking AS (
    SELECT *, RANK() OVER(PARTITION BY Nombre, Anio, Mes ORDER BY Cantidad_Citas DESC) AS Rnk
    FROM Concurrencia
)
SELECT Anio, Mes, Nombre, Hora_Inicio, Hora_Fin, Cantidad_Citas
FROM Ranking
WHERE Rnk = 1
ORDER BY Anio ASC, Mes ASC, Nombre ASC;