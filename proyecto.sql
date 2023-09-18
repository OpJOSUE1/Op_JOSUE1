CREATE DATABASE BD_BIBLIOTECA_josue
USE BD_BIBLIOTECA_josue
DROP DATABASE BD_BIBLIOTECA_josue

CREATE TABLE AUTOR
(
	Cve_Autor VARCHAR (3),
	Nombre_Autot VARCHAR (20),
	CONSTRAINT pk_autor PRIMARY KEY (Cve_Autor)
)
CREATE TABLE Editorial
(
	Cve_Edit VARCHAR (3),
	Nombre_Edit VARCHAR (50),
	CONSTRAINT pk_edit PRIMARY KEY (Cve_Edit)
	
)

CREATE TABLE CATEGORIA
(
	Cve_cat VARCHAR(3),
	Tipo_cate VARCHAR(10),
	CONSTRAINT pk_cate PRIMARY KEY (Cve_cat)
)
CREATE TABLE ALUMNO
(	
	Cve_Alu VARCHAR(3),
	Nombre_Alu VARCHAR (20),
	Telefono VARCHAR (4),
	CONSTRAINT pk_alu PRIMARY KEY (Cve_Alu)
)

CREATE TABLE LIBRO
(	
	Cve_Lb VARCHAR (3),
	Titulo_Lb VARCHAR(50),
	Año_Lb VARCHAR (4),
	No_Copias VARCHAR(2),
	Precio_Lb VARCHAR(4),
	Cve_Autor1 VARCHAR(3),
	Cve_Edit2 VARCHAR(3),
	Cve_Cat3 VARCHAR(3),
	CONSTRAINT pk_libro PRIMARY KEY (Cve_Lb),
	CONSTRAINT fk1_autor FOREIGN  KEY (Cve_Autor1) REFERENCES AUTOR (Cve_Autor),
	CONSTRAINT fk2_editorial FOREIGN  KEY (Cve_Edit2) REFERENCES Editorial (Cve_Edit),
	CONSTRAINT fk3_categoria FOREIGN  KEY (Cve_cat3) REFERENCES CATEGORIA(Cve_cat)
)
DROP TABLE PRESTAMO

CREATE TABLE PRESTAMO
(
	Cve_Lb1 VARCHAR(3),
	Cve_Alu2 VARCHAR(3),
	prestado varchar(2),
	Fecha_prestamo DATE,
	Tiempo_prestamo VARCHAR(10),
	Devuelto VARCHAR(2),
	Fecha_Devolucion DATE,
	Deuda VARCHAR (2),
	Dias_Deuda VARCHAR (10),
	Multa VARCHAR (10),
	Multa_pagada VARCHAR(2),
	CONSTRAINT fk1_libro FOREIGN KEY (Cve_Lb1) REFERENCES LIBRO (Cve_Lb),
	CONSTRAINT fk2_alumno FOREIGN KEY (Cve_Alu2) REFERENCES ALUMNO (Cve_Alu)
)

INSERT INTO autor VALUES
('A00','Diego'),
('A01','Carlos'),
('A02','Alvaro'),
('A03','Maria'),
('A04','Jose'),
('A05','Jaime'),
('A06','Gabriel'),
('A07','Angel'),
('A08','Jesus'),
('A09','Jocelyn')

INSERT INTO editorial VALUES
('E01','Planeta mexicana'),
('E02','Penguin Random House Grupo'),
('E03','Ediciones Castillo'),
('E04','Siglo xxl Ediciones'),
('E05','Ediciones cal y arena')

INSERT INTO categoria VALUES
('C01','Novela'),
('C02','Aventura'),
('C03','No Ficcion'),
('C04','Romance'),
('C05','Terror')

INSERT INTO alumno VALUES
('Al0','Sofia','1234'),
('Al1','Mario','5432'),
('Al2','Valentina','6789'),
('Al3','Isabella','1236'),
('Al4','Andres','9870'),
('Al5','Camila','7890'),
('Al6','Gustavo','7654'),
('Al7','Victoria','4567'),
('Al8','Juan','4532'),
('Al9','Alejandro','2354')

INSERT INTO libro VALUES
('L00','El raton y el leon','2000','5','$250','A00','E01','C01'),
('L01','El Cuervo','2001','6','$250','A01','E01','C01'),
('L02','Latidos que no dije','2002','7','$250','A02','E02','C02'),
('L03','Un lugar en el cielo','2003','3','$250','A03','E02','C02'),
('L04','Romancero gitano','2004','4','$250','A04','E03','C03'),
('L05','Este horrible deseo de amarte','2005','9','$250','A05','E03','C03'),
('L06','Solitario','2006','2','$250','A06','E04','C04'),
('L07','Algun tiempo atrás','2007','8','$250','A07','E04','C04'),
('L08','A un minuto de ti ','2008','7','$250','A08','E05','C05'),
('L09','El grito de el tiempo','2009','4','$250','A09','E05','C05')

INSERT INTO prestamo VALUES
('L00','Al0','si','2000/01/01','3dias','si','2000/01/04','no','','',''),
('L01','Al1','si','2001/02/02','3dias','no','0000/00/00','si','1','50+250','si'),
('L02','Al2','si','2002/03/03','6dias','si','2002/03/10','si','1','50','si'),
('L03','Al3','si','2003/04/04','6dias','no','0000/00/00','si','10','500+250','si'),
('L04','Al4','si','2004/05/05','2dias','si','2004/05/08','si','1','50','no'),
('L05','Al5','si','2005/06/06','2dias','si','2005/06/08','no','','',''),
('L06','Al6','si','2006/07/07','5dias','no','0000/00/00','si','5','250+250','no'),
('L07','Al7','si','2007/08/08','5dias','no','0000/00/00','si','2','100+250','si'),
('L08','Al8','si','2008/09/09','7dias','si','2008/09/16','no','','',''),
('L09','Al9','si','2009/10/10','7dias','no','0000/00/00','si','20','1000+250','no')

/*queremos saber a que categoria pertenece el libro " Este horrible deso de amarte" L05 */
SELECT  Titulo_Lb,Tipo_cate
FROM libro INNER JOIN categoria
ON libro.Cve_Cat3 = categoria.Cve_Cat
where Cve_Lb ='L05'

/*queremos saber todos los libros que pertenecen a la editorial "E05"*/
SELECT Titulo_Lb,Cve_edit
FROM libro INNER JOIN editorial
ON libro.Cve_Edit2 = editorial.Cve_edit
WHERE Cve_edit ='E05'

/*queremos saber que libros a escrito el autor "A03"*/
SELECT Titulo_Lb, Cve_Autor
FROM libro INNER JOIN autor 
ON libro.Cve_Autor1 = autor.Cve_Autor
WHERE Cve_Autor = 'A03'

/*queremos saber que libros estan prestados*/
SELECT prestado,Titulo_Lb 
FROM prestamo INNER JOIN libro
ON prestamo.Cve_Lb1 = libro.Cve_Lb
WHERE prestado='si'

/*queremos saber que personas tienen los libros que se han prestado*/
SELECT Nombre_Alu,Cve_Lb1
FROM libro INNER JOIN prestamo
ON prestamo.Cve_Lb1 =libro.Cve_Lb
INNER JOIN alumno 
ON prestamo.Cve_Alu2 = alumno.Cve_Alu
WHERE prestado = 'si'

/*queremos saber que personas deben libros por q ya no los entregaron*/
SELECT Nombre_Alu
FROM alumno INNER JOIN prestamo 
ON prestamo.Cve_Alu2 = alumno.Cve_Alu
WHERE devuelto = 'no'

/*queremos saber que personas tienen multa por no entregar libro  y si ya esta pagada o no*/
SELECT Nombre_Alu, Multa, Multa_pagada
FROM alumno INNER JOIN prestamo 
ON prestamo.Cve_Alu2 = alumno.Cve_Alu
WHERE devuelto = 'no'

/*queremos saber que personas, de q autores y de q editorial tienen libros prestados*/
SELECT Nombre_Alu,Titulo_Lb,Nombre_Autot,Nombre_Edit
FROM libro INNER JOIN prestamo
ON prestamo.Cve_Lb1 =libro.Cve_Lb
INNER JOIN alumno 
ON prestamo.Cve_Alu2 = alumno.Cve_Alu
INNER JOIN autor 
ON libro.Cve_Autor1 = autor.Cve_Autor
INNER JOIN editorial
ON libro.Cve_Edit2 = editorial.Cve_Edit
WHERE prestado = 'si'


/*queremos saber que libros han sido perdidos y no se han repuestos*/
SELECT Titulo_Lb, Multa, Multa_Pagada
FROM libro INNER JOIN prestamo 
ON libro.Cve_Lb = prestamo.Cve_Lb1
WHERE Devuelto = 'no' and Multa_pagada = 'no' 


/*que libros y qe alumnos devolvieron libros*/
SELECT Titulo_Lb, Nombre_Alu, Devuelto
FROM prestamo INNER JOIN alumno
ON prestamo.Cve_Alu2 = alumno.Cve_Alu
INNER JOIN  libro
on prestamo.Cve_Lb1 = libro.Cve_Lb
WHERE devuelto = 'si'
/*en que fechas devolvieron los alumnos y que libros */
SELECT Titulo_Lb, Nombre_Alu,Fecha_Devolucion
FROM libro INNER JOIN prestamo
ON libro.Cve_Lb = prestamo.Cve_Lb1
INNER JOIN alumno
ON prestamo.Cve_Alu2 = alumno.Cve_Alu
WHERE prestamo.devuelto ='si'
/*que libros no fueron devueltos, quienes no los devolvieron y que multas tienen*/
SELECT devuelto, nombre_alu, titulo_lb,multa
FROM prestamo INNER JOIN alumno
ON prestamo.Cve_alu2 = alumno.Cve_alu
INNER JOIN libro 
ON prestamo.Cve_Lb1 = libro.Cve_Lb
WHERE prestamo.devuelto = 'no'

/*libro,categoria, autor, editorial, alumno que pido el libro y condicion de devolucion de cada libro*/
SELECT titulo_Lb, Nombre_Autot, tipo_cate, nombre_edit, nombre_alu, devuelto
FROM prestamo INNER JOIN alumno 
ON prestamo.cve_alu2 = alumno.cve_alu
INNER JOIN libro
ON prestamo.cve_lb1 = libro.cve_lb
INNER JOIN autor
ON libro.Cve_autor1 = autor.Cve_Autor
INNER JOIN editorial 
ON libro.cve_edit2 = editorial.cve_edit
INNER JOIN categoria
ON libro.cve_cat3 = categoria.cve_cat
WHERE prestamo.prestado = 'si'


