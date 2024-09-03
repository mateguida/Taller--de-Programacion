{Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
insertarlos a la derecha.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).}
program Arboles4;
type
	rangoDias = 1..31;
	rangoMeses = 1..12;
	fechaPrestamo = record
		dia : rangoDias;
		mes : rangoMeses
		end;
	
	prestamo = record //Defino el tipo de datos prestamo
		isbnLibro : integer;
		numSocio : integer;
		fecha : fechaPrestamo;
		cantDiasPrestamo : integer;
		end;
		
	arbolPrestamos = ^nodoPrestamos; //Defino el arbol i
	nodoPrestamos = record
		dato : prestamo;
		hi : arbolPrestamos;
		hd : arbolPrestamos;
		end;
		
	listaPrestamos = ^nodoLista; //defino lista para almacenar los prestamos del arbol ii
	nodoLista = record
		dato : prestamo;
		sig : listaPrestamos;
		end;
		
	prestamoISBN = record //defino el tipo de datos que tendra el nodo del arbol ii
		numero : integer;
		prestamos : listaPrestamos;
		end;
		
	arbolISBN = ^nodoISBN; //defino arbol ii
	nodoISBN = Record
		dato : prestamoISBN;
		hi : arbolISBN;
		hd : arbolISBN;
		end;

//Procedimiento que leera la informacion del teclado y la guardara en el prestamo actual
procedure leerPrestamo(var p : prestamo);
begin
	write('Ingrese el ISBN del libro = '); readln(p.isbnLibro);
	if(p.isbnLibro <> 0)then begin
		write('Numero de socio = '); readln(p.numSocio);
		write('Fecha(dia) = '); readln(p.fecha.dia);
		write('Fecha(mes) = '); readln(p.fecha.mes);
		write('Dias de prestamo = '); readln(p.cantDiasPrestamo);
	end;
end;

//Procedimiento que insertara los prestamos actuales en el arbol 1, ordenados por ISBN
procedure agregarAlArbol1(var a : arbolPrestamos; p : prestamo);
begin
	if(a = nil)then begin
		new(a);
		a^.dato := p;
		a^.hi := nil;
		a^.hd := nil;
	end
	else if(p.isbnLibro < a^.dato.isbnLibro)then
		//si es menor, se agrega a la izq
		agregarAlArbol1(a^.hi, p)
	else 
		//si es mayor o igual, se agrega a la derecha
		agregarAlArbol1(a^.hd, p);
end;

//procedimiento que agregara un prestamo adelante de toda la lista
procedure agregarAdelanteLista(var l : listaPrestamos; p : prestamo);
var
	aux : listaPrestamos;
begin
	new(aux);
	aux^.dato := p;
	aux^.sig := l;
	l := aux;
end;

//Procedimiento que recibira el arbol2 y un prestamo y lo insertara ordenado por numero de isbn.
procedure agregarAlArbol2(var a : arbolISBN; p : prestamo);
begin
	if(a = nil)then begin
		//si esta el arbol vacio
		new(a); //creo el nodo
		a^.dato.numero := p.isbnLibro; //cargo el numero
		agregarAdelanteLista(a^.dato.prestamos, p); //Cargo el prestamo a la lista
		a^.hi := nil; //inicializo hijos
		a^.hd := nil;
	end
	else if(p.isbnLibro = a^.dato.numero)then 
		//si el isbn es el mismo, cargo prestamo a la lista
		agregarAdelantelista(a^.dato.prestamos, p)
	else if(p.isbnLibro < a^.dato.numero)then
		//si es menor, evaluo el hijo izquierdo
		agregarAlArbol2(a^.hi,p)
	else	
		//si es mayor o igual, evaluo el hijo derecho
		agregarAlArbol2(a^.hd,p);
end

//Procedimiento que leera la informacion ingresada por teclado y la enviara a los modulos para que 
//sean ingresados en los respectivos arboles
procedure leerInformacion(var arbol1 : arbolPrestamos; var arbol2 : arbolISBN);
var
	prestamoActual : prestamo
begin
	leerPrestamo(prestamoActual);
	while(prestamoActual.isbnLibro <> 0)do begin
		agregarAlArbol1(arbol1, prestamoActual);
		agregarAlArbol2(arbol2, prestamoActual);
		leerPrestamo(prestamoActual);
	end;	
end;

//b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más grande.
procedure ISBNmasGrande(a : arbolPrestamos)

var
	arboli : arbolPrestamos;
	arbolii : arbolISBN;
begin
	arboli := nil;
	arbolii := nil;
	leerInformacion(arboli, arbolii)
end.
	
	
		
