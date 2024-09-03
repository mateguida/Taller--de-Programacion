{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de 
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción, 
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje 
promedio otorgado por las críticas. 
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de 
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el 
código de la película -1. 
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje 
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos 
métodos vistos en la teoría. 
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje, 
del vector obtenido en el punto c).}
program CL1EJ3Imperativo;
type
	generos = 1..8;
	
	pelicula = record 
		codigoPelicula :integer;
		codigoGenero : generos;
		puntajeCriticas : real;
		end;
		
	listaPeliculas = ^nodo;
	
	nodo = record
		dato : pelicula;
		sig : listaPeliculas
		end;
		
	vecPuntajesGeneros = array[generos] of real;
	vecCodigosGeneros = array[generos] of integer;

procedure leerPelicula(var p : pelicula);
begin
	write('Ingrese codigo de pelicula = ');
	readln(p.codigoPelicula);
	if(p.codigoPelicula <> -1)then begin
		write('Ingrese genero 1..8 = ');
		readln(p.codigoGenero);
		write('Ingrese puntaje criticas = ');
		readln(p.puntajeCriticas);
	end;
end;

procedure inicializarVector(var vector : vecPuntajesGeneros);
var
	i : integer;
begin
	for i := 1 to 8 do vector[i] := 0;
end;

procedure inicializarVectorC(var vector : vecCodigosGeneros);
var
	i : integer;
begin
	for i := 1 to 8 do vector[i] := 0;
end;

procedure generarVectorGeneros(var vectorPuntajes : vecPuntajesGeneros; var vectorCodigos : vecCodigosGeneros; l : listaPeliculas);
begin
	inicializarVector(vectorPuntajes);
	inicializarVectorC(vectorCodigos);
	while(l <> nil) do begin
		if(l^.dato.puntajeCriticas > vectorPuntajes[l^.dato.codigoGenero])then
			vectorPuntajes[l^.dato.codigoGenero] := l^.dato.puntajeCriticas;
			vectorCodigos[l^.dato.codigoGenero] := l^.dato.codigoPelicula;
		l := l^.sig;
	end;
end;

procedure agregarPelicula(p : pelicula; var l : listaPeliculas);
var
	posAnterior, posActual, nuevaPelicula : listaPeliculas;
begin
	posAnterior := l;
	posActual := l;
	new(nuevaPelicula);
	nuevaPelicula^.dato := p;
	while((posActual <> nil) and (posActual^.dato.codigoGenero <> l^.dato.codigoGenero))do begin
		posAnterior := posActual;
		posActual := posActual^.sig;
	end;
	if(posActual = posAnterior)then
		l := nuevaPelicula
	else
		posAnterior^.sig := nuevaPelicula;
	nuevaPelicula^.sig := posActual;
end;

procedure cargarLista(var l : listaPeliculas);
var
	peli : pelicula;
begin
	leerPelicula(peli);
	while(peli.codigoPelicula <> -1)do begin
		agregarPelicula(peli, l);
		leerPelicula(peli);
	end;
end;

procedure imprimirVectorG(vec : vecPuntajesGeneros);
var
	i : integer;
begin
	writeln;
	write('[');
	for i := 1 to 8 do begin
		write(vec[i]:2:2 ,', ');
	end;
	write(']');
end;	

procedure imprimirVectorCG(vec : vecCodigosGeneros);
var
	i : integer;
begin
	writeln;
	write('[');
	for i := 1 to 8 do begin
		write(vec[i] ,', ');
	end;
	write(']');
end;	

procedure ordenarVector(var vec : vecCodigosGeneros);
var
	i, j, pos : integer;
	actual : integer;
begin
	for i := 1 to 7 do begin
		pos := i;
		for j := (i+1) to 8 do begin
			if(vec[j] < vec[pos])then pos := j;
		end;
		actual := vec[i];
		vec[pos] := vec[i];
		vec[i] := actual;
	end;
end;

var
	lista : listaPeliculas;
	vectorPuntajes : vecPuntajesGeneros;
	vectorCodigos : vecCodigosGeneros;
begin
	lista := nil;
	cargarLista(lista);
	generarVectorGeneros(vectorPuntajes,vectorCodigos, lista);
	imprimirVectorG(vectorPuntajes);
	imprimirVectorCG(vectorCodigos);
	ordenarVector(vectorCodigos);
	imprimirVectorCG(vectorCodigos);
end.
