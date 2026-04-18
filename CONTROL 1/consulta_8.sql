SELECT DISTINCT Peluqueria.Nombre, Servicio.Nombre, Detalle_Cita.Precio_Unitario
FROM Peluqueria
JOIN Citas ON Peluqueria.Id_Peluqueria = Citas.Id_Peluqueria
JOIN Detalle_Cita ON Citas.Id_Cita = Detalle_Cita.Id_Cita
JOIN Servicio ON Detalle_Cita.Id_Servicio = Servicio.Id_Servicio
WHERE Detalle_Cita.Precio_Unitario = (
    SELECT MAX(Detalle_Cita_Dos.Precio_Unitario)
    FROM Citas AS Citas_Dos
    JOIN Detalle_Cita AS Detalle_Cita_Dos ON Citas_Dos.Id_Cita = Detalle_Cita_Dos.Id_Cita
    WHERE Citas_Dos.Id_Peluqueria = Peluqueria.Id_Peluqueria
);