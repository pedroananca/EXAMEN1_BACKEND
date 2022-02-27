create schema if not exists pregunta1 ;

create table if not exists pregunta1.Clientes(
	ID_cliente CHAR(8) primary key,
	Apellidos VARCHAR(45) not null,
	Nombres VARCHAR(45) not null,
	Dirección VARCHAR(70),	
	Ciudad VARCHAR(20),
	País VARCHAR(20),
	Celular CHAR(9) not null unique,
	Fax VARCHAR(250) ,
	Fecha_ingreso DATE not null, 
    IND_vigente BINARY not null
);
create table if not exists pregunta1.Vendedor(
	ID_vendedor CHAR(8) primary key,
	Nombre VARCHAR(45) not null
);

create table if not exists pregunta1.Artículo(
ID_articulo INT primary key  auto_increment,
descripción VARCHAR(200),
precio_unitario FLOAT not null,
stock INT not null default '0'
);

create table if not exists pregunta1.Pedido(
ID_pedido INT primary key auto_increment,
Fecha_pedido DATE not null,
subtotal FLOAT not null ,
Impuesto FLOAT not null,
Total FLOAT not null,
Estado BOOLEAN not null,
id_cliente CHAR(8) not null ,
id_vendedor CHAR(8) not null,
foreign key(id_cliente) references pregunta1.Clientes(ID_cliente) on delete cascade,
foreign key(id_vendedor) references pregunta1.Vendedor(ID_vendedor) on delete cascade
);

create table if not exists pregunta1.Detalle_pedido(
id_pedido INT,
id_articulo INT,
cantidad INT not null,
precio FLOAT not null,
subtotal INT not null,
primary key(id_pedido, id_articulo),
foreign key(id_pedido) references pregunta1.Pedido(ID_Pedido) on delete cascade,
foreign key(id_articulo) references pregunta1.Artículo(ID_articulo) on delete cascade
);

show variables like 'secure_file_priv';	
