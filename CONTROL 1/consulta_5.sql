SELECT Cliente.Nombres, Cliente.Apellido_Paterno, Comuna.Nombre_Comuna, Peluqueria.Nombre, Detalle_Cita.Subtotal 
FROM Cliente
JOIN Comuna ON Cliente.Id_Comuna = Comuna.Id_Comuna
JOIN Citas ON Cliente.Id_Cliente = Citas.Id_Cliente
JOIN Peluqueria ON Citas.Id_Peluqueria = Peluqueria.Id_Peluqueria
JOIN Detalle_Cita ON Citas.Id_Cita = Detalle_Cita.Id_Cita
JOIN Servicio ON Detalle_Cita.Id_Servicio = Servicio.Id_Servicio
WHERE Servicio.Nombre = 'Tinte';