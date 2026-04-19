WITH ConteoCitas AS -- Se genera la tabla ConteoCitas a partir de la siguiente declaracion:
(SELECT EXTRACT(MONTH FROM c.Fecha_Cita) AS Mes, -- Seleccionamos los meses extraidos de las fechas como MES
		e.Nombres,e.Apellidos, -- El nombre del empleado
		COUNT(c.Id_Cita) AS Total_Citas, -- Se cuenta el total de las citas del mes
        RANK() OVER (PARTITION BY EXTRACT(MONTH FROM c.Fecha_Cita) ORDER BY COUNT(c.Id_Cita) DESC) as Ranking -- Hacemos un ranking ventana, utilizando como base los meses de las fechas, ordenandolos de manera descendente por la cantidad de citas por mes, y el que este mas arriba es el 1ro
		FROM Citas c -- Desde las citas
		JOIN Empleado e ON c.Id_Empleado = e.Id_Empleado -- Unimos los empleados que tengan citas junto a la tabla empleados
		WHERE EXTRACT(YEAR FROM c.Fecha_Cita) = 2021 -- Extraemos solamente las citas que tengan el anio 2021
		GROUP BY Mes, e.Id_Empleado, e.Nombres, e.Apellidos) -- Y agrupamos por mes, id nombre y apellido empleado
SELECT Mes, Nombres,Apellidos,Total_Citas -- Se seleciona mes nombres y total citas
FROM ConteoCitas -- de la nueva tabla conteocitas
WHERE Ranking = 1 -- donde ranking sea 1, o sea quienes cumplieron con tener mas citas
ORDER BY Mes ASC; -- y se ordenan de orden ascendente