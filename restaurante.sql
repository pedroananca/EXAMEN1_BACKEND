create schema if not exists restaurante;

create table if not exists restaurante.mozo(
ID_mozo CHAR(8) Primary key,
Nombre VARCHAR(45) NOT NULL,
Email VARCHAR(30) NOT NULL UNIQUE,
Celular CHAR(9) NOT NULL UNIQUE,
Fecha_de_inicio DATE ,
Área VARCHAR(20) NOT NULL
);
create table if not exists restaurante.platos(
Nombre VARCHAR(25) primary key,
Descripción VARCHAR(100) default '',
Precio FLOAT NOT NULL
);

create table if not exists restaurante.mesas(
ID_mesa INT primary key auto_increment,
Número INT not null UNIQUE 
);

create table if not exists restaurante.pedidos(
ID_pedido INT primary key auto_increment,
Precio FLOAT NOT NULL,
Fecha DATE NOT NULL,
Hora INT NOT NULL,
id_mozo CHAR(8),
id_mesa INT,
foreign key (id_mozo) references  restaurante.mozo(ID_mozo) on delete cascade,
foreign key (id_mesa) references  restaurante.mesas(ID_mesa) on delete cascade
);

create table if not exists restaurante.detalle_pedido(
id_pedido INT,
nombre_plato VARCHAR(25),
precio FLOAT,
primary key(id_pedido,nombre_plato),
foreign key (id_pedido) references restaurante.pedidos(ID_pedido) on delete cascade,
foreign key (nombre_plato) references restaurante.platos(Nombre) on delete cascade
);

