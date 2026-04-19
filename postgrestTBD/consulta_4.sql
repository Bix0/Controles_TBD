SELECT 
    c.Nombres, 
    c.Apellido_Paterno, 
    c.Apellido_Materno 
FROM Cliente c
JOIN Citas ci ON c.Id_Cliente = ci.Id_Cliente
JOIN Detalle_Cita dc ON ci.Id_Cita = dc.Id_Cita
WHERE c.Genero = 'Hombre' AND dc.Id_Servicio IN (1, 2)
GROUP BY 
    c.Id_Cliente, 
    c.Nombres, 
    c.Apellido_Paterno, 
    c.Apellido_Materno
HAVING COUNT(DISTINCT dc.Id_Servicio) = 2;