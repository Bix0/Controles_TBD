select * from ( select c.Nombres, c.Apellido_Paterno, com_c.Nombre_Comuna as Comuna_Cliente, p.Nombre as Peluqueria,
	com_p.Nombre_Comuna as Comuna_Peluqueria, month (pa.Fecha_pago) as Mes, sum(pa.Monto_Total) as Gasto_Total,
    rank() over (partition by p.Id_Peluqueria, Month(pa.Fecha_pago) order by sum(pa.Monto_Total) desc) as Ranking

from cliente c
join comuna com_c on c.Id_Comuna = com_c.Id_Comuna
join citas ci on c.Id_Cliente = ci.Id_Cliente
join peluqueria p on ci.Id_Peluqueria = p.Id_Peluqueria
join Comuna com_p on p.Id_Comuna = com_p.Id_Comuna
join Pago pa on ci.Id_Cita = pa.Id_Cita
group by c.Id_Cliente, p.Id_Peluqueria, month(pa.Fecha_Pago)
) as Resultado
where Ranking = 1;