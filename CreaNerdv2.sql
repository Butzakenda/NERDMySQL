创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创创/*
An谩lisis y Desarrollo de Software
SENA - CEGAFE
Cesar Leonardo Rodriguez Landero
2023/02/26
2501469 - ADSO
2023/03/24 --> Cambio a Oracle 
Nombre del esquema: nerd
*/


create table MatricularProducto /*Fuerte, auto incremental*/
(
	IdMatricularProducto	number(11) 		primary key,
    CopiaRegistro			varchar2(100)	not null,
    PeticionRevision		varchar2(100)	not null,
    SolicitudAlianza		varchar2(100)	not null,
    Fecha					date			not null
);
create table RevisarProducto /*Debil, auto incremental*/
(
	IdRevisarProducto		number(11)		not null 	primary key,
    IdMatricularProducto	number(11)		not null,
    AvalRevision			varchar2(100)	not null,
    Fecha					date			not null
);
create table RatificarProducto	/*Debil, auto incremental*/
(
	IdRatificarProducto		number(11)		not null	primary key,
    IdRevisarProducto		number(11)		not null,
    ProductoPatentado		varchar2(100)	not null,
    Fecha					date			not null
);
create table InscribirProducto	/*Debil, auto incremental*/
(
	IdInscribirProducto		number(11)		not null	primary key,
    IdRatificarProducto		number(11)		not null,
    FechaHora				timestamp		not null
);
create table Departamento	/*Fuerte*/
(
	IdDepartamento			number(11)		not null	primary key,
    Nombre					varchar2(50)	not null
);
create table Ciudad	/*Debil*/
(
	IdCiudad				number(11)		not null	primary key,
    IdDepartamento			number(11)		not null,
    Nombre					varchar2(50)	not null
);
create table Categoria /*Fuerte*/
(
	IdCategoria				number(11)		not null	primary key,
    Nombre					varchar2(50)    not null,
    Descripcion				varchar2(200)	not null
);
create table Colaborador	/*Debil, auto incremental*/
(
	IdColaborador			number(11)		not null	primary key,
    IdDepartamento			number(11)		not null,
    IdCiudad				number(11)		not null,
    Documento				varchar2(20)	not null,
    Nombres					varchar2(50)	not null,
    Apellidos				varchar2(50)	not null,
    CorreoELectronico		varchar2(50)	not null,
    Telefono				varchar2(20)	not null,
    FechaNacimiento			date			not null
);
create table Producto	/*Debil, auto incremental*/
(
	IdProducto				number(11)		not null	primary key,
    IdInscribirProducto		number(11)		not null,
    IdDepartamento			number(11)		not null,
    IdCiudad				number(11)		not null,
    IdCategoria				number(11)		not null,
    IdColaborador			number(11)		not null,
    Nombre					varchar2(50)	not null,
    Precio					number(12,2)	not null,
    Descripcion				varchar2(200)	not null
);

create table Cliente	/*Debil, auto incremental*/
(
	IdCliente				number(11)		not null	primary key,
	IdDepartamento			number(11)		not null,
    IdCiudad				number(11)		not null,
    Documento				varchar2(20)	not null,
    Nombres					varchar2(50)	not null,
    Apellidos				varchar2(50)	not null,
    CorreoELectronico		varchar2(50)	not null,
    Telefono				varchar2(50)	null,
    SolicitudAlianza		varchar2(100)	null,
    FechaNacimiento			date			not null
);
create table Factura	/*Debil, auto incremental*/
(
	IdFactura 				number(11)		not null	primary key,	
    IdProducto				number(11)		not null,
    IdCliente				number(11)		not null,
    IdColaboradorVenta		number(11)		not null,
    IdColaboradorCompra		number(11)		null,
    FechaHora				timestamp		not null,
    MetodoPago				varchar2(20)	not null,
    Total					number(12,2)	not null
);
create table PQR	/*Debil, auto incremental*/
(
	IdPQR					number(11)		not null	primary key,
    IdColaborador			number(11)		null,
    IdCliente				number(11)		null,
    Tipo					varchar2(30)	not null,
    Calidad					varchar(12)		not null,
    Descripcion				varchar2(200)	not null
);

/*-------------------------------RELACIONES----------------------------------------*/
/*Metodologia*/
/*#Relacion / -Tabla Que Genera Dependencia- / -Tabla Con Dependencia- */

/*R1: MatricularProducto/RevisarProducto  O*/
alter table RevisarProducto
add CONSTRAINT fk_ReviProducto_MatriProducto foreign key (IdMatricularProducto)
references MatricularProducto(IdMatricularProducto);

/*R2: RevisarProducto/RatificarProducto  O*/
alter table	RatificarProducto
add CONSTRAINT	fk_RatiProducto_ReviProducto foreign key (IdRevisarProducto)
references RevisarProducto(IdRevisarProducto);

/*R3: RatificarProducto/InscribirProducto  O*/
alter table InscribirProducto
add CONSTRAINT fk_InscriProducto_RatiProducto foreign key (IdRatificarProducto)
references RatificarProducto(IdRatificarProducto);

/*R4: InscribirProducto/Producto  O*/
alter table	Producto
add CONSTRAINT	fk_Producto_InscriProducto foreign key (IdInscribirProducto)
references InscribirProducto(IdInscribirProducto);

/*R5: Departamento/Producto  O*/
alter table	Producto
add CONSTRAINT fk_Producto_Departamento foreign key (IdDepartamento)
references Departamento(IdDepartamento);

/*R6: Departamento/Ciudad  X*/
alter table Ciudad
add CONSTRAINT fk_Ciudad_Departamento foreign key (IdDepartamento)
references Departamento(IdDepartamento);

/*R7: Ciudad/Producto  O*/
alter table Producto
add CONSTRAINT fk_Producto_Ciudad foreign key (IdCiudad)
references Ciudad(IdCiudad);

/*R8: Categoria/Producto  O*/
alter table Producto
add CONSTRAINT fk_Prodcuto_Categoria foreign key (IdCategoria)
references Categoria(IdCategoria);

/*R9: Producto/Factura  O*/
alter table Factura
add CONSTRAINT fk_Factura_Producto foreign key (IdProducto)
references Producto(IdProducto);

/*R10: Cliente/Factura  O*/
alter table Factura
add CONSTRAINT fk_Factura_Cliente foreign key (IdCliente)
references Cliente(IdCliente);

/*R11: Colaborador/Producto  O*/
alter table Producto
add CONSTRAINT fk_Producto_Colaborador foreign key (IdColaborador)
references Colaborador (IdColaborador);

/*R12: ColaboradorCompra/Factura  O*/
alter table Factura
add CONSTRAINT fk_Factura_ColaboradorCompra foreign key (IdColaboradorCompra)
references Colaborador(IdColaborador);

/*R13: ColaboradorVenta/Factura  O*/
alter table Factura
add CONSTRAINT fk_Factura_ColaboradorVenta foreign key (IdColaboradorVenta)
references Colaborador(IdColaborador);

/*R14 Cliente/PQR  O*/
alter table PQR
add  CONSTRAINT fk_PQR_Cliente foreign key (IdCliente)
references Cliente(IdCliente);

/*R15: Colaborador/PQR  O*/
alter table PQR
add CONSTRAINT fk_PQR_Colaborador foreign key (IdColaborador)
references Colaborador(IdColaborador);

/*R16: Ciudad/Cliente  O*/
alter table Cliente
add CONSTRAINT fk_Cliente_Ciudad foreign key (IdCiudad)
references Ciudad(IdCiudad);

/*R17: Departamento/Cliente  O*/
alter table Cliente
add CONSTRAINT fk_Cliente_Departamento foreign key (IdDepartamento)
references Departamento(IdDepartamento);

/*R18: Departamento/Colaborador  O*/
alter table Colaborador
add CONSTRAINT fk_Colaborador_Departamento foreign key (IdDepartamento)
references Departamento (IdDepartamento);

/*R19: Ciudad/Colaborador  O*/
alter table Colaborador
add CONSTRAINT fk_Colaborador_Ciudad foreign key (IdCiudad)
references Ciudad (IdCiudad);


/*-------------------------------RESTRICCIONES----------------------------------------*/
/*Metodologia*/
/*Tabla/Campo a restringir/Restriccion*/


alter table Producto
add CONSTRAINT ck_Producto_Precio check(Precio >= 0);
/*Producto/Precio/Valor en 0*/



/*Factura/Total/Valor en 0*/
alter table Factura
add CONSTRAINT ck_Factura_Total check(Total >= 0);
/*-------------------------------SECUENCIAS----------------------------------------*/
CREATE SEQUENCE sqMatricularProducto
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqRevisarProducto
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqRatificarProducto
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqInscribirProducto
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqColaborador
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqProducto
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqCliente
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqFactura
START WITH 1
INCREMENT BY 1
MINVALUE 1;


CREATE SEQUENCE sqPQR
START WITH 1
INCREMENT BY 1
MINVALUE 1;
