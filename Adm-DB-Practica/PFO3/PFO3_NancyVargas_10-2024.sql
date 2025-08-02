-- PFO3_NancyVargas_10-2024

use taller;

-- 1)El dueño del taller quiere saber cual es el monto total que cada 
-- cliente debe abonar al asistir al taller. El informe debe mostrar nombre, apellido, teléfono y monto.  
select c.Nombre, c.Apellido, c.tel, sum(p.Monto) as MontoTotal from cliente c
inner join vehiculo v on c.codC = v.codC
inner join ficha f on v.codVEH = f.codVEH
inner join presup p on f.codf = p.codF
group by c.Nombre, c.Apellido, c.tel;

-- 2)Tomando la consulta del punto 1, se pide mostrar al cliente o clientes que abona el monto menor.
select c.Nombre, c.Apellido, c.tel, sum(p.Monto) as MontoTotal from cliente c
join vehiculo v on c.codC = v.codC
join ficha f on v.codVEH = f.codVEH
join presup p on f.codF = p.codF
group by c.Nombre, c.Apellido, c.tel
having sum(p.Monto) = (
    select min(monto_total)
    from (
		select sum(p2.Monto) as monto_total from cliente c2
        join vehiculo v2 on c2.codC = v2.codC
        join ficha f2 on v2.codVEH = f2.codVEH
        join presup p2 on f2.codF = p2.codF
        group by c2.codC
        ) as subconsulta
);

-- 3)Identificar cual o cuales fueron los mecánicos que diagnostican que realizaron la mayor cantidad de revisiones.
select m.Nombre, m.Apellido,  count(fmd.codMD) as CantidadRevisiones from mecanico m
inner join mecdiag md on m.codMec = md.codMec
inner join fichamd fmd on md.codMD = fmd.codMD
where m.repara = 0 
group by m.codMec, m.Nombre, m.Apellido;
/* where m.repara = 1 ==> robe pero no tira ningun dato*/

-- 5)El dueño del taller debe comprar los repuestos y necesita un listado que muestre el nombre,
--  la cantidad, el precio unitario y el total. El listado debe estar ordenado por nombre.
select r.Nombre, sum(pr.cant) as Cantidad, r.precio, sum(pr.cant * r.precio) as Total from repuesto r
join Presurep pr on r.codRep = pr.codRep
group by r.Nombre, r.precio
order by r.Nombre;


-- 6)Obtener un listado que muestre nombre, apellido del cliente y una columna con el llamada "mensaje". 
-- Esa columna debe decir "Sin vehículo registrado" y "Con vehículo registrado",
-- según el cliente tenga o no algún vehículo registrado.}
select c.Nombre, c.Apellido, 
       case when v.codC is null then 'Sin vehículo registrado' 
       else 'Con vehículo registrado' end as Mensaje from cliente c
left join vehiculo v on c.codC = v.codC
group by c.Nombre, c.Apellido, v.codVEH;

-- 7) Mostrar en un listado los arreglos que usan por lo menos un repuesto cuyo precio unitario 
-- es menor que el promedio de precios de todos los repuestos. El  listado 
-- debe mostrar matricula del vehículo, teléfono del cliente, y el monto a abonar en concepto de repuestos.
select v.Matricula, c.tel as 'telefono_Cliente', r.Nombre as 'Repuesto',
(pr.cant*r.precio) as 'precio_Respuesto'
from cliente c
inner join vehiculo v on c.codC = v.codC
inner join ficha f on v.codVEH = f.codVEH
inner join presup p on f.codF = p.codF
inner join Presurep pr on p.NPresup = pr.NPresup
inner join repuesto r on pr.codRep = r.codRep
where r.precio < (select avg(precio) from repuesto);

-- 8)Mostrar los clientes registrados que aún no tienen ingreso en el taller para un diagnóstico.
select c.Nombre, c.Apellido, c.tel from cliente c
where c.codC in (select v.codC
     from vehiculo v
     left join ficha f on v.codVEH = f.codVEH
     group by v.codC
     having count(f.codF) = 0);

-- 9)Obtener un listado ordenado por apellido de los mecánicos y el tipo. 
-- El tipo esta definido con el atributo "repara".
select m.Apellido, 'Repara' as Tipo from mecanico m
where m.repara = 1
order by Apellido;

-- 10)Mostrar los repuestos que no se mencionan en los presupuestos.
select r.Nombre, r.stock, r.precio from repuesto r
left join Presurep pr on r.codRep = pr.codRep
where pr.codRep is null;

-- 11)Identificar por fecha cuántas fichas se confeccionaron y cuántos mecánicos diagnosticaron. 
-- Recordá que una ficha puede tener más de un diagnostico; por esa razón existe la tabla “fichamd”.
select f.fecha, count(distinct f.codF) as fichas, 
      count(distinct m.codMec) as mecanicos
from ficha f 
left join fichamd fmd on f.codF = fmd.codF
inner join mecdiag md on fmd.codMD = md.codMD
inner join mecanico m on md.codMec = m.codMec
group by  f.fecha;
