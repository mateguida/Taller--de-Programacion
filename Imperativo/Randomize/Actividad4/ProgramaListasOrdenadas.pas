program ProgramaListas;
type
	listaEnteros = ^nodo;
	
	nodo = record
		num : integer;
		sig: listaEnteros;
		end;

function buscarElemento(l : listaEnteros; num : integer) : boolean;
var
	encontreNumero : boolean;
begin
	encontreNumero := false;
	while(l <> nil)do begin
		if(l^.num = num)then
			encontreNumero := true;
		l := l^.sig;
	end;
	buscarElemento := encontreNumero;
end;

procedure agregarNumero(var l : listaEnteros; num : integer);
var
	nuevoNumero, posActual, posAnterior : listaEnteros;
begin
	new(nuevoNumero);
	nuevoNumero^.num := num;
	posActual := l;
	posAnterior := l;
	while((posActual <> nil) and (num > posActual^.num))do begin
		posAnterior := posActual;
		posActual := posActual^.sig;
	end;
	if(posAnterior = posActual)then begin
		nuevoNumero^.sig := l;
		l := nuevoNumero;
	end
	else begin
		posAnterior^.sig := nuevoNumero;
		nuevoNumero^.sig := posActual;
	end;
end;

procedure cargarLista(var l : listaEnteros);
var
	numGenerado : integer;
begin
	numGenerado := 100 + random(51);
	while(numGenerado <> 120) do begin
		writeln(numGenerado);
		agregarNumero(l, numGenerado);
		numGenerado := 100 + random(51);
	end;

end;

procedure imprimirLista(l : listaEnteros);
begin
	writeln;
	write('[');
	while(l <> nil)do begin
		write(l^.num,',');
		l := l^.sig;
	end;
	write(']');
	writeln;
end;

var
	lista : listaEnteros;
	numBuscar : integer;
begin
	lista := nil;
	randomize;
	cargarLista(lista);
	imprimirLista(lista);
	write('Ingrese el numero que quiere buscar en la lista (entre 100 y 150) = ');
	readln(numBuscar);
	writeln('El numero ', numBuscar, ' esta en la lista? = ', buscarElemento(lista, numBuscar));
end.
