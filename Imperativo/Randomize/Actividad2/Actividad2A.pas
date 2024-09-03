program ProgramaVectores;
const
	dimF = 1000;
type
	vecEnteros = array[1..dimF] of integer;
	
procedure cargarVector(var vec : vecEnteros; var dimL : integer; limInferior, limSuperior : integer);
var
	numeroRandom : integer;
begin
	numeroRandom := limInferior + random(limSuperior - limInferior + 1);
	writeln(numeroRandom);
	while((dimL < dimF) and (numeroRandom <> 0))do begin
		dimL := dimL + 1;
		vec[dimL] := numeroRandom;
		numeroRandom := limInferior + random(limSuperior - limInferior + 1);
	end;
end;

procedure imprimirVector(vec : vecEnteros; dimL : integer);
var
	i : integer;
begin
	write('[');
	for i := 0 to dimL do begin
		write(vec[i],',');
	end;
	write(']');
end;
	
var
	A, B : integer; //Limites del Random
	dimensionLogica : integer;
	vectorNumerosRandom : vecEnteros;
begin
	dimensionLogica := 0;
	write('Ingrese limite inferior = ');
	readln(A);
	write('Ingrese limite superior = ');
	readln(B);
	cargarVector(vectorNumerosRandom, dimensionLogica, A, B);
	imprimirVector(vectorNumerosRandom, dimensionLogica);
end.
