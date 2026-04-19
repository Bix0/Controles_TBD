SELECT c.Nombre_Comuna, -- Se selecciona los datos que queremos ver, en ese caso el nombre de la comuna
COUNT(DISTINCT p.Id_Peluqueria) AS Cantidad_Peluquerias, -- Aqui hay unos count, en el cual contamos solamente las peluquerias UNICAS
COUNT(DISTINCT cl.Id_Cliente) AS Cantidad_Clientes_Residentes -- Aqui hay unos count, en el cual contamos solamente los clientes UNICOS
from Comuna c -- Sacamos los datos principales de la comuna
left join Cliente cl on  c.Id_Comuna = cl.Id_Comuna -- Se hace left join, ya que sacamos solamente los que tengan ids compatibles
left join Peluqueria p on  c.Id_Comuna = p.Id_Comuna 
group by c.Id_Comuna,c.Nombre_Comuna -- Agrupamos por nombre e id comuna
order by Cantidad_Peluquerias DESC; -- y los ordenamos por el tag Cantidad_Peluquerias