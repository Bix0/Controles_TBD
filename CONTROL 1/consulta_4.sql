select distinct c.Nombres, c.Apellido_Paterno, c.Apellido_Materno from Cliente c
join Citas ci on c.Id_cliente = ci.Id_Cliente
join Detalle_Cita dc on ci.Id_cita = dc.id_Cita
where c.Genero = "hombre" and dc.Id_servicio in(1,2)
group by c.Id_cliente, c.Nombres, c.Apellido_Paterno
having count(Distinct dc.Id_servicio) = 2
