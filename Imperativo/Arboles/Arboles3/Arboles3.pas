{3. Implementar un programa modularizado para una librería. Implementar módulos para:
a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados su código, la
cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
ingreso de las ventas finaliza cuando se lee el código de venta -1.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el código de producto con mayor cantidad de unidades vendidas.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos
valores recibidos (sin incluir) como parámetros.
}
program Arboles3;
type
	producto = record
		codigo : integer;
		unidadesVendidas : integer;
		montoTotal : real;
		end;
	
	venta = record
		codigoVenta : integer;
		codigoProducto : integer;
		unidadesVendidas : integer;
		precioUnitario : real;
		end;
	
	arbol = ^nodo;
	nodo = record
		dato : producto;
		hi : arbol;
		hd : arbol;
	end;
	
procedure leerVenta(var v : venta);
begin
	write('Codigo de venta = '); readln(v.codigoVenta);
	write('Codigo de Producto = '); readln(v.codigoProducto);
	write('Unidades vendidas = '); readln(v.unidadesVendidas);
	write('Precio unitario del producto = '); readln(v.precioUnitario);
end;

procedure agregarVenta(var a : arbol; v : venta);
begin
	if(a = nil)then begin
		new(a);
		a^.dato.codigo := v.codigoProducto;
		a^.dato.unidadesVendidas := v.unidadesVendidas;
		a^.dato.montoTotal := (v.precioUnitario * v.unidadesVendidas);
	end
	else if(a^.dato.codigo = v.codigoProducto)then begin
		a^.dato.unidadesVendidas := a^.dato.unidadesVendidas + v.unidadesVendidas;
		a^.dato.montoTotal := a^.dato.unidadesVendidas + (v.unidadesVendidas * v.precioUnitario);
	end
	else if(v.codigoProducto > a^.dato.codigo)then
		agregarVenta(a^.hd, v)
	else
		agregarVenta(a^.hi, v);
end;
	
procedure leerVentas(var a : arbol);
var
	ventaActual : venta;
begin
	leerVenta(ventaActual);
	while(ventaActual.codigoVenta <> -1)do begin
		agregarVenta(a, ventaActual);
		leerVenta(ventaActual);
	end;
end;

procedure enOrden(a : arbol);
begin
	if(a <> nil)then begin
		enOrden(a^.hi);
		writeln('Codigo de producto = ', a^.dato.codigo);
		writeln('Total de unidades vendidas = ', a^.dato.unidadesVendidas);
		writeln('Monto Total = ', a^.dato.montoTotal:2:2);
		enOrden(a^.hd);
	end;
end;
	
procedure buscarMaximoVentas(a : arbol; var codMax, unidadesMax : integer);
begin
	if(a <> nil)then begin
		if(a^.dato.unidadesVendidas > unidadesMax)then begin
			codMax := a^.dato.codigo;
			unidadesMax := a^.dato.unidadesVendidas
		end;
		buscarMaximoVentas(a^.hi, codMax, unidadesMax);
		buscarMaximoVentas(a^.hd, codMax, unidadesMax);
	end;
end;
	
procedure contarInferiores(a : arbol; codigo : integer; var contador : integer);
begin
	if(a <> nil)then begin
		if(a^.dato.codigo < codigo)then
			contador := contador + 1;
		contarInferiores(a^.hi, codigo, contador);
		contarInferiores(a^.hd, codigo, contador);
	end;
end;

procedure calcularMontoRango(a : arbol; minimo, maximo :integer; var monto : real);
begin
	if(a <> nil)then begin
		if((a^.dato.codigo > minimo) and (a^.dato.codigo < maximo))then begin
			monto := monto + a^.dato.montoTotal; //ESTOY DENTRO DEL RANGO
			calcularMontoRango(a^.hi, minimo, maximo, monto);
			calcularMontoRango(a^.hd, minimo, maximo, monto);
		end
		else if(a^.dato.codigo < minimo)then
			calcularMontoRango(a^.hd, minimo, maximo, monto) //ESTOY POR DEBAJO DEL RANGO
		else
			calcularMontoRango(a^.hi, minimo, maximo, monto);//ESTOY POR ENCIMA DEL RANGO
	end;
end;

var
	arbolProductos : arbol;
	codigoMaximo, unidadesMaximo, codigoAux, contadorMenores, codigoMinimoRango, codigoMaximoRango : integer;
	montoTotal : real;
begin
	arbolProductos := nil;
	codigoMaximo := 0;
	montoTotal := 0;
	contadorMenores := 0;
	unidadesMaximo := -1;
	leerVentas(arbolProductos);
	writeln;
	enOrden(arbolProductos); //Inciso B
	buscarMaximoVentas(arbolProductos, codigoMaximo, unidadesMaximo); //Inciso C
	writeln;
	writeln('El codigo de producto con mas unidades vendidas fue el codigo ',codigoMaximo,' con ',unidadesMaximo,' unidades vendidas'); writeln;
	write('Ingrese el codigo de producto para contar los codigos que sean inferiores = '); readln(codigoAux);
	contarInferiores(arbolProductos, codigoAux, contadorMenores); //Inciso D
	writeln('La cantidad de codigos menores a ', codigoAux,' es de ', contadorMenores); writeln;
	write('Ingrese limite inferior para comparar codigos = '); readln(codigoMinimoRango);
	write('Ingrese limite superior para comparar codigos = '); readln(codigoMaximoRango);
	calcularMontoRango(arbolProductos, codigoMinimoRango, codigoMaximoRango, montoTotal);
	writeln('El monto total recaudado con productos con codigo entre ', codigoMinimoRango, ' y ', codigoMaximoRango, ' es de ', montoTotal:2:2,'$');
end.		
	
