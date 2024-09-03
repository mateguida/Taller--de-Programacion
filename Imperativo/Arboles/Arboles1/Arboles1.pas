{a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles}
program Arboles1;
type

//DECLARO ARBOL Y TIPOS DEL REGISTRO VENTAS
	arbol = ^nodo;
	
	producto = record
		codigoProducto : integer;
		unidadesVendidas: integer;
		end;
	
	venta = record
		prod : producto;
		diaFechaProducto : integer;
		end;
	
	nodo = record
		dato : venta;
		hi : arbol;
		hd : arbol;
		end;
	
//DECLARO SEGUNDO TIPO DE ARBOL PARA INCISO 2 Y 3
	
	arbol2 = ^nodo2;
	
	nodo2 = record
		dato : producto;
		hi : arbol2;
		hd : arbol2;
		end;
	
//GENERO INFORMACION DE LA VENTA ALEATORIAMENTE
procedure randomProducto(var p : producto);
begin
	p.codigoProducto := random(100);
	p.unidadesVendidas := random(2000	);
end;	

//PROCEDIMIENTO PARA AGREGAR HOJAS AL ARBOL
procedure agregarAlArbol(var arbolActual : arbol; v : venta);
begin
	if(arbolActual = nil)then begin //SI EL ARBOL ESTA VACIO
		new(arbolActual);
		arbolActual^.dato := v; //LE ASIGNO LA VENTA 
		arbolActual^.hi := nil; //INICIALIZO LOS HIJOS
		arbolActual^.hd := nil;
	end
	else begin //SI NO ESTA VACIO
		if(v.prod.codigoProducto < arbolActual^.dato.prod.codigoProducto)then //SI EL DATO ES MAS CHICO, GENERO HOJA PARA LA IZQ
			agregarAlArbol(arbolActual^.hi, v)
		else
			agregarAlArbol(arbolActual^.hd, v);// SI ES MAYOR O IGUAL, GENERO HOJA PARA LA DERECHA
	end;
end;

//PROCEDIMIENTO PARA AGREGAR HOJAS AL ARBOL 2
procedure agregarAlArbol2(var arbolActual : arbol2; p : producto);
begin
	if(arbolActual = nil)then begin //SI EL ARBOL ESTA VACIO
		new(arbolActual);
		arbolActual^.dato := p; //LE ASIGNO LA VENTA 
		arbolActual^.hi := nil; //INICIALIZO LOS HIJOS
		arbolActual^.hd := nil;
	end
	else begin //SI NO ESTA VACIO
		if(p.codigoProducto < arbolActual^.dato.codigoProducto)then //SI EL DATO ES MAS CHICO, GENERO HOJA PARA LA IZQ
			agregarAlArbol2(arbolActual^.hi, p)
		else
			agregarAlArbol2(arbolActual^.hd, p);// SI ES MAYOR O IGUAL, GENERO HOJA PARA LA DERECHA
	end;
end;
	
//PROCEDIMIENTO QUE GENERARA VENTAS Y LAS AGREGARA HASTA QUE SE GENERE EL CODIGO DE VENTA 0
procedure generarVentas(var arbol1: arbol ; var arbolSeg : arbol2);
var
	prodActual : producto;
	ventaActual : venta;
begin
	randomProducto(prodActual);
	ventaActual.prod := prodActual;
	ventaActual.diaFechaProducto := random(32);
	while(ventaActual.prod.codigoProducto <> 0)do begin
		agregarAlArbol(arbol1, ventaActual);
		agregarAlArbol2(arbolSeg, prodActual);
		randomProducto(prodActual);
		ventaActual.prod := prodActual;
		ventaActual.diaFechaProducto := random(32);
	end;
end;

//PROCEDIMIENTO QUE IMPRIME EL ARBOL EN ORDEN
procedure enOrden(a : arbol);
begin
	if ( a <> nil)then
	begin
		enOrden(a^.HI);
		writeln('Codigo = ',a^.dato.prod.codigoProducto);
		writeln('Dia Mes = ',a^.dato.diaFechaProducto);
		writeln('Unidades = ',a^.dato.prod.unidadesVendidas);
		enOrden(a^.HD);
	end;
end;

//PROCEDIMIENTO QUE IMPRIME EL ARBOL EN ORDEN
procedure enOrden2(a : arbol2);
begin
	if ( a <> nil)then
	begin
		writeln('Nodo raiz = ', a^.dato.codigoProducto, '/ ', a^.dato.unidadesVendidas);
		enOrden2(a^.HI);
		writeln(a^.dato.codigoProducto);
		writeln(a^.dato.unidadesVendidas);
		writeln;
		enOrden2(a^.HD);
	end;
end;

procedure preOrden(a : arbol);
begin
	if ( a <> nil)then
	begin
		writeln(a^.dato.prod.codigoProducto);
		preOrden(a^.HI);
		preOrden(a^.HD);
	end;
end;

procedure buscarFecha(a : arbol; f : integer ; var cont : integer);
begin
	if(a <> nil)then begin
		buscarFecha(a^.hi, f, cont);
		if(a^.dato.diaFechaProducto = f)then
			cont := cont + a^.dato.prod.unidadesVendidas;
		buscarFecha(a^.hd, f, cont);
	end;
end;

procedure buscarCodigoMaximo(a: arbol2 ; var codigo, ventasMax : integer);
begin
	if(a<> nil)then begin
		buscarCodigoMaximo(a^.hi, codigo, ventasMax);
		if(a^.dato.unidadesVendidas > ventasMax)then begin
			codigo := a^.dato.codigoProducto;
			ventasMax := a^.dato.unidadesVendidas;
		end;
		buscarCodigoMaximo(a^.hd, codigo, ventasMax);
	end;
end;

var
	arbolVentas : arbol;
	arbolVentasUnidades : arbol2;
	fechaBuscar, contadorVentas, contadorVentasMax, codigoMaximo : integer;
begin
	arbolVentas := nil;
	arbolVentasUnidades := nil;
	randomize;
	generarVentas(arbolVentas, arbolVentasUnidades);
	writeln('Nodo raiz = ', arbolVentas^.dato.prod.codigoProducto, '/ ', arbolVentas^.dato.prod.unidadesVendidas);
	enOrden(arbolVentas);
	write('Ingrese el dia del mes que quiere comprobar la cantidad de ventas = ');
	readln(fechaBuscar);
	contadorVentas := 0;
	contadorVentasMax := 0;
	codigoMaximo := 0;
	buscarFecha(arbolVentas, fechaBuscar, contadorVentas);
	writeln('La cantidad de unidades vendidas el dia ', fechaBuscar, ' fue de ', contadorVentas, ' productos.');
	buscarCodigoMaximo(arbolVentasUnidades, codigoMaximo, contadorVentasMax);
	writeln('El producto que mas ventas tuvo fue el de codigo ', codigoMaximo, ' con ', contadorVentasMax, ' ventas');
	//enOrden2(arbolVentasUnidades);
	//preOrden(arbolVentas);
	
end.
