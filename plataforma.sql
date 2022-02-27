#CREACION DE DIAGRAMA LOGICO
create schema if not exists plataforma;
#drop schema plataforma;
create table if not exists plataforma.Profesor(
ID_Profesor CHAR(8) primary key,
Nombre VARCHAR(50)  not null,
Email VARCHAR(30) not null unique,
Descripción VARCHAR(200) default '',
Celular CHAR(9) unique,
Foto BLOB 

);
create table if not exists plataforma.Alumno(
ID_Alumno CHAR(8) primary key,
Nombre VARCHAR(50) not null,
Email	VARCHAR(30) not null unique, 
Celular CHAR(9) not null unique
);
create table if not exists plataforma.Curso(
Nombre VARCHAR(25) primary key ,
Descripción VARCHAR(200) default'',
Precio FLOAT not null,
Fecha DATE not null,
Hora INT not null
);
	
create table if not exists plataforma.horario_alumno(
id_alumno  CHAR(8),
nombre_curso VARCHAR(25),
numero_matrícula INT not null,
primary key(id_alumno, nombre_curso),
foreign key(id_alumno) references plataforma.Alumno(ID_Alumno) on delete cascade,
foreign key(nombre_curso) references plataforma.Curso(Nombre) on delete cascade

);
create table if not exists plataforma.horario_profesor(
id_profesor CHAR(8),
nombre_curso VARCHAR(25),
numero_clase INT not null,
primary key (id_profesor,nombre_curso), 
foreign key(id_profesor)references plataforma.Profesor(ID_Profesor) on delete cascade,
foreign key(nombre_curso) references plataforma.Curso(Nombre) on delete cascade
);
#IMPORTACION DE DATOS
select * from plataforma.Profesor;
show variables like 'secure_file_priv';
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/profesor.csv'
into table plataforma.Profesor fields terminated by ',' lines terminated by '\n'
ignore 1 rows;

select * from plataforma.Alumno;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/alumno.csv'
into table plataforma.Alumno fields terminated by ',' lines terminated by '\n'
ignore 1 rows;

select * from plataforma.Curso;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/curso.csv'
into table plataforma.Curso fields terminated by ',' lines terminated by '\n'
ignore 1 rows;

select * from plataforma.horario_profesor;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/horario_profesor.csv'
into table plataforma.horario_profesor fields terminated by ',' lines terminated by '\n'
ignore 1 rows;

select * from plataforma.horario_alumno;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/horario_alumno.csv'
into table plataforma.horario_alumno fields terminated by ',' lines terminated by '\n'
ignore 1 rows;
#CONSULTAS
# consulta 1
Select * from (select plataforma.alumno.ID_Alumno,plataforma.alumno.Nombre,
plataforma.curso.Nombre as Asignatura 
from plataforma.alumno join plataforma.curso join plataforma.horario_alumno 
on plataforma.curso.Nombre = plataforma.horario_alumno.nombre_curso
on plataforma.alumno.ID_Alumno = plataforma.horario_alumno.id_alumno
)as tabla_join1 where tabla_join1.Asignatura = "Algebra";
#consulta 2	
select curso,count(*) from (select plataforma.curso.Nombre as curso from plataforma.curso join
plataforma.horario_profesor on plataforma.horario_profesor.nombre_curso=plataforma.curso.Nombre 
join plataforma.profesor on plataforma.horario_profesor.id_profesor = plataforma.profesor.ID_Profesor) 
as tabla_join2 group by curso having count(*)>1;
#consulta 3
select ID,Nombre, count(*) from (select plataforma.alumno.ID_Alumno as ID,plataforma.alumno.Nombre,plataforma.horario_alumno.numero_matrícula as matricula  from 
plataforma.alumno  join plataforma.horario_alumno
 on plataforma.alumno.ID_Alumno=plataforma.horario_alumno.id_alumno join plataforma.curso
 on plataforma.curso.Nombre=plataforma.horario_alumno.nombre_curso) as tabla_join3  group by nombre having count(*)>1  ;
#consulta 4
Select * from (select plataforma.alumno.ID_Alumno,plataforma.alumno.Nombre
from  plataforma.alumno join plataforma.curso join plataforma.horario_alumno
on plataforma.curso.Nombre = plataforma.horario_alumno.nombre_curso
on plataforma.alumno.ID_Alumno = plataforma.horario_alumno.id_alumno
where plataforma.curso.Nombre = "Algebra" or "Literatura"
)as tabla_join4 group by Nombre;



