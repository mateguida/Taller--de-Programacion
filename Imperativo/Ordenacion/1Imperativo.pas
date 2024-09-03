Program ejercicio2Imperativo;
const
	dimF = 300;
type
	oficina = record
		codigoID : integer;
		dniPropietario : integer;
		valorExpensa : real;
		end;
	
	vectorOficinas = array[1..dimF] of oficina;
	
procedure cargarVector(var vec : vectorOficinas; var dimL : integer);
var
	i, codigoActual : integer;
begin
	i := 1;
	codigoActual := 0;
	while((i < dimF) and (codigoActual <> -1))do begin
		writeln('CARGANDO OFICINA');
		write('Ingrese codigo de identificacion = ');
		readln(codigoActual);
		if(codigoActual <> -1)then begin
			vec[i].codigoID := codigoActual;
			write('Ingrese dni del propietario = ');
			readln(vec[i].dniPropietario);
			write('Ingrese valor de la expensa = ');
			readln(vec[i].valorExpensa);
			dimL := dimL + 1;
			i := i + 1;
		end;
	end;
end;

procedure imprimirVector(vec : vectorOficinas; dimL : integer);
var
	i : integer;
begin
	writeln;
	writeln('Imprimiendo vector');
	write('[');
	for i := 1 to dimL do begin
		write(vec[i].codigoID, ', ');
	end;
	write(']');
end;

procedure ordenarVectorInsercion(var vec : vectorOficinas; dimL : integer);
var
	i , j : integer;
	actual : oficina;
begin
	for i := 2 to dimL do begin
		actual := vec[i];
		j := i-1;
		while((j > 0) and (vec[j].codigoID > actual.codigoID))do begin
			vec[j+1] := vec[j];
			j := j - 1;
		end;
		vec[j+1] := actual;
	end;
end;

procedure ordenarVectorSeleccion(var vec : vectorOficinas; dimL : integer);
var
	i, j, pos : integer;
	actual : oficina;
begin
	for i := 1 to (dimL-1) do begin
		pos := i;
		for j := (i+1) to dimL do
			if vec[j].codigoID < vec[pos].codigoID then pos := j;
		actual := vec[pos];
		vec[pos] := vec[i];
		vec[i] := actual;
	end;
end;

var
	oficinas, oficinasDesordenado : vectorOficinas;
	dimL : integer;
begin
	dimL := 0;
	cargarVector(oficinas, dimL);
	oficinasDesordenado := oficinas;
	imprimirVector(oficinas, dimL);
	ordenarVectorInsercion(oficinas, dimL);
	writeln;
	imprimirVector(oficinas, dimL);
	writeln('Ordenacion por Insercion');
	ordenarVectorSeleccion(oficinasDesordenado, dimL);
	writeln;
	imprimirVector(oficinasDesordenado, dimL);
	writeln('Ordenacion por Seleccion');
end.
