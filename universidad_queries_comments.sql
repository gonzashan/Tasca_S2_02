/* Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom*/

select p.apellido1, p.apellido2, p.nombre 
	from persona as p where p.tipo = "alumno" 
	order by p.apellido1, p.apellido2, p.nombre desc;

/* Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades */

select p.apellido1, p.apellido2, p.nombre 
	from persona as p where p.telefono is null;

/* Retorna el llistat dels alumnes que van néixer en 1999.*/

select p.apellido1, p.apellido2, p.nombre 
	from persona as p where Year(p.fecha_nacimiento) = 1999;

/* Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon 
en la base de dades i a més el seu NIF acaba en K.*/

select p.apellido1, p.apellido2, p.nombre, p.tipo, p.telefono, p.nif 
	from persona p, profesor as t 
	where p.id = t.id_profesor 
	and p.tipo = "profesor" 
	and p.telefono is null 
	and p.nif like "%k";

/* Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, 
en el tercer curs del grau que té l'identificador 7.*/

select * from asignatura a 
	where a.cuatrimestre = 1 
	and a.curso = 3 
	and a.id_grado = 7;

/* Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/

select p.apellido1, p.apellido2, p.nombre, d.nombre 
	from persona p, profesor t, departamento d 
	where (p.id = t.id_profesor) 
	and (p.tipo = "profesor") 
	and (t.id_departamento = d.id) 
	order by p.apellido1,p.apellido2,p.nombre desc;

/* Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M */

select  p.nombre, p.nif, am.id_asignatura as "asignaturas", a.nombre, c.anyo_inicio, c.anyo_fin 
	from persona p, alumno_se_matricula_asignatura am, asignatura a, curso_escolar c 
	where (p.tipo = "alumno") 
	and (p.nif = "26902806M") 
	and (p.id = am.id_alumno) 
	and (am.id_asignatura = a.id) 
	and(am.id_curso_escolar = c.id);

/* Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura 
en el Grau en Enginyeria Informàtica (Pla 2015).*/

select distinct dp.nombre 
	as "departamento", gd.nombre 
	as "grado" from persona p, profesor t, departamento dp, asignatura ag, grado gd 
	where (p.tipo = "profesor") 
	and (p.id = t.id_profesor) 
	and (t.id_departamento = dp.id) 
	and (ag.id_profesor = t.id_profesor) 
	and (gd.nombre = "Grado en Ingeniería Informática (Plan 2015)");

/* Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.*/

select distinct p.nombre from persona p, alumno_se_matricula_asignatura asma, curso_escolar c
	 where (p.tipo = "alumno") 
	 and (asma.id_alumno = p.id) 
	 and (c.id = asma.id_curso_escolar) 
	 and (c.anyo_inicio = 2018) ;

/* Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/

select distinct p.nombre from persona p 
	where (p.tipo = "profesor");

/* Retorna un llistat amb els professors/es que no estan associats a un departament. El llistat haurà 
d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom */

select p.nombre, p.nif, f.id_departamento from persona p 
	left join profesor f on p.id = f.id_profesor 
	left join departamento d on f.id_departamento = d.id 
	where p.tipo = "profesor" 
	order by p.nombre 
	asc;

/* Retorna un llistat amb els professors/es que no estan associats a un departament.*/ 

select p.nombre from persona p 
	left join profesor t on p.id = t.id_profesor 
	where p.tipo = "profesor" 
	and id_profesor is null;

/* Retorna un llistat amb els departaments que no tenen professors/es associats.*/
/* todos los profesores tienen asociados un departamento*/

select * from profesor where id_departamento is null; 

/* Retorna un llistat amb els professors/es que no imparteixen cap assignatura.*/

select p.nombre from persona p 
	left join profesor t on t.id_profesor = p.id 
	left join asignatura ag on ag.id_profesor = t.id_profesor 
	where p.tipo = "profesor" 
	and ag.id_profesor is null;

/* Retorna un llistat amb les assignatures que no tenen un professor/a assignat.*/

select * from asignatura ag 
	where ag.id_profesor is null; 

/* Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.*/

select d.nombre, ag.nombre from departamento d 
	left join profesor t on t.id_departamento = d.id 
	left join asignatura ag on ag.id_profesor = t.id_profesor 
	left join alumno_se_matricula_asignatura asma on asma.id_asignatura = ag.id 
	where ag.nombre is not null 
	and asma.id_asignatura is null;

/* Retorna el nombre total d'alumnes que hi ha.*/ 

select count(*) from persona 
	where persona.tipo = "alumno";

/* Calcula quants alumnes van néixer en 1999.*/

select count(*) from persona 
	where persona.tipo = "alumno" 
	and year(persona.fecha_nacimiento) = 1999;

/* Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, 
una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat 
de major a menor pel nombre de professors/es.*/

select d.nombre, count(t.id_profesor) as "total profesores" from profesor t, departamento d 
	where d.id in (t.id_departamento) 
	group by t.id_departamento 
	order by count(t.id_profesor) 
	desc;

/* Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
Tingui en compte que poden existir departaments que no tenen professors/es associats. 
Aquests departaments també han d'aparèixer en el llistat.*/

select d.nombre, count(t.id_profesor) as "total profesores" from departamento d 
	left join profesor t on d.id = t.id_departamento 
	group by d.nombre 
	order by count(t.id_profesor) 
	desc;

/* Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/

select g.nombre, count(ag.id) as "total asignaturas" from grado g 
	left join asignatura ag on g.id = ag.id_grado 
	group by g.nombre 
	order by count(ag .id) 
	desc; 

/* Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre 
d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.*/ 

select g.nombre, count(ag.id) as "total asignaturas" from grado g 
	left join asignatura ag on g.id = ag.id_grado 
	group by g.nombre having total_asignaturas > 40 
	order by count(ag.id) 
	desc; 

/* Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, 
tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/

select g.nombre, ag.tipo, sum(ag.creditos) as "total créditos" from grado g 
	inner join asignatura ag on g.id = ag.id_grado 
	group by ag.tipo 
	order by sum(ag.creditos) 
	desc;

/* Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.*/

select c.anyo_inicio as "Año inicio", count(asma.id_alumno) as "Alumnos x año" 
	from curso_escolar c 
	inner join alumno_se_matricula_asignatura asma 
	on c.id = id_curso_escolar 
	group by c.anyo_inicio;

/* Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. 
El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/

select p.id, p.nombre, p.apellido1, p.apellido2, count(ag.id) as "num asignaturas" from profesor t 
	left join asignatura ag on t.id_profesor = ag.id_profesor 
	right join persona p on t.id_profesor = p.id 
		group by t.id_profesor 
		order by count(ag.id) 
		desc; 

/* Retorna totes les dades de l'alumne/a més jove.*/

select * from persona 
	where fecha_nacimiento = (select max(fecha_nacimiento) from persona) 
		and tipo ='alumno'; 

/* Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.*/

select p.* from persona p 
	where id in (select t.id_profesor from profesor t) 
	and not exists (select ag.id_profesor from asignatura ag 
		where ag.id_profesor = p.id) 
		and p.tipo = 'profesor'; 

