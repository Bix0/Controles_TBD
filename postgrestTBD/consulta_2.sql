SELECT * FROM ( 
    SELECT 
        c.Nombres, 
        c.Apellido_Paterno, 
        com_c.Nombre_Comuna as Comuna_Cliente, 
        p.Nombre as Peluqueria,
        com_p.Nombre_Comuna as Comuna_Peluqueria, 
        EXTRACT(MONTH FROM pa.Fecha_pago) as Mes, 
        SUM(pa.Monto_Total) as Gasto_Total,
        RANK() OVER (
            PARTITION BY p.Id_Peluqueria, EXTRACT(MONTH FROM pa.Fecha_pago) 
            ORDER BY SUM(pa.Monto_Total) DESC
        ) as Ranking
    FROM cliente c
    JOIN comuna com_c ON c.Id_Comuna = com_c.Id_Comuna
    JOIN citas ci ON c.Id_Cliente = ci.Id_Cliente
    JOIN peluqueria p ON ci.Id_Peluqueria = p.Id_Peluqueria
    JOIN Comuna com_p ON p.Id_Comuna = com_p.Id_Comuna
    JOIN Pago pa ON ci.Id_Cita = pa.Id_Cita
    GROUP BY 
        c.Id_Cliente, 
        c.Nombres, 
        c.Apellido_Paterno, 
        com_c.Nombre_Comuna, 
        p.Id_Peluqueria, 
        p.Nombre, 
        com_p.Nombre_Comuna, 
        EXTRACT(MONTH FROM pa.Fecha_pago)
) AS Resultado
WHERE Ranking = 1;