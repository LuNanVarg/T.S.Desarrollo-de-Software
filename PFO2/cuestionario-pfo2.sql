
use taller;

-- Ejercicios de PFO 2 A.B.D =>
-- 1) Obtener los datos de los presupuestos cuyo monto es menor a $ 10000
select * from presup
      where Monto < 10000;

-- 2) Obtener el cliente más joven, según su documento
select * from cliente 
   order by codc desc limit 1;

-- 3) Obtener los repuestos que tengan la misma cantidad de stock que en el punto de
--    pedido (stock de reposición)
select Nombre, Stock, PP from repuesto
     where Stock = PP;

-- 4) Obtener los mecánicos cuyo apellido comience con la letra C
select * from mecanico
     where apellido like 'C%';
     
-- 5) Obtener nombre del repuesto junto al precio ordenado alfabéticamente.
select Nombre, precio from repuesto 
order by Nombre asc;

-- 6) Obtener la cantidad de presupuestos realizados en el taller
select count(*) as CantidadPresupuestos
from presup;

-- 7) Obtener por color cuántos vehículos registrados hay.
select Color,count(*) as cantidad_vehiculos 
from vehiculo 
group by Color;

-- 8) Obtener, por cada código de ficha, la cantidad de informes asociados que tiene.
select codF, count(*) as cantidad_informes from fichamd 
group by codF;

-- 9) Listar ordenado por temática a los mecánicos que diagnostican (indicar nombre, apellido y temática).
select m.nombre, m.apellido, md.tematica from mecanico m
join mecdiag md on m.codMec = md.codMec 
order by md.tematica;

-- 10) Obtener los números de presupuesto que tengan al menos un repuesto cuyo precio
-- oscile entre $ 1200 y $ 10000 inclusive.
select distinct p.NPresup from presup p
join presurep pr on p.NPresup = pr.NPresup
join repuesto r on pr.codRep = r.codRep
where r.precio between 1200 and 10000;

-- 11) Calcular el valor promedio del costo de los repuestos del taller. El título de la
-- columna debe decir “Precio Promedio”
select avg(precio) as PrecioPromedio
from repuesto;

-- 12) Obtener los datos de los clientes que tienen más de un vehículo.
select c.* from cliente c
join vehiculo v on c.codC = v.codC
group by c.codC
having count(v.codVEH) > 1;

-- 13) Identificar con nombre y apellido a los mecánicos que no hicieron ningún diagnóstico.
select nombre, apellido from mecanico 
where codMec not in(select codMec from mecdiag);

-- 14) Obtener por vehículo el monto final que deben abonar en concepto de presupuesto.
select ficha.codVeH, vehiculo.Modelo, vehiculo.Marca, presup.NPresup, presup.Monto from vehiculo 
join ficha on vehiculo.codVEH = ficha.codVEH
join presup on ficha.codF = presup.codF;

select ficha.codVeH, vehiculo.Modelo, vehiculo.Marca, presup.NPresup,
/*SUM*/
(presup.Monto) as MontoFinal 
from vehiculo 
inner join ficha on vehiculo.codVEH = ficha.codVEH
inner join presup on ficha.codF = presup.codF
/*group by ficha.codVeH, vehiculo.Modelo, vehiculo.Marca, presup.NPresup*/

	








