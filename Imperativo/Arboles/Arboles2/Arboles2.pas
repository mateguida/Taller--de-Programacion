{3. Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).
d. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}
program Arboles2;
type
	examenFinal = record
		codigoMateria : integer;
		fecha : string;
		nota : real;
		end;
		
	listaFinales = ^nodo;
	
	nodo = record
		dato : examenFinal;
		sig : listaFinales;
		end;
		
	alumno = record
		numLegajo: integer;
		finales : listaFinales;
		end;
		
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato : alumno;
		hi : arbol;
		hd : arbol;
		end;
		
procedure leerInformacionFinal(var f : examenFinal);
begin
	write('Ingrese codigo de materia = '); readln(f.codigoMateria);
	write('Ingrese fecha del final = '); readln(f.fecha);
	write('Ingrese nota de la evaluacion = '); readln(f.nota);
end;
		
procedure agregarFinal(var l : listaFinales; f : examenFinal);
var
	aux : listaFinales;
begin
	new(aux);
	aux^.dato := f;
	aux^.sig := l;
	l := aux;
end;	
		
procedure agregarArbol(var a : arbol; f : examenFinal; numL : integer);
begin
	if(a = nil)then begin
		new(a);
		a^.dato.numLegajo := numL;
		a^.dato.finales := nil;
		agregarFinal(a^.dato.finales, f);
	end 
	else if(a^.dato.numLegajo = numL)then
		agregarFinal(a^.dato.finales, f)
	else if(numL > a^.dato.numLegajo)then
		agregarArbol(a^.hd, f, numL)
	else
		agregarArbol(a^.hi, f, numL);
end;

procedure leerInformacion(var a : arbol);
var
	finalActual : examenFinal;
	legajoActual : integer;
begin
	write('Ingrese numero de legajo del Alumno que rindio el final = ');
	readln(legajoActual);
	while(legajoActual <> 0) do begin
		leerInformacionFinal(finalActual);
		agregarArbol(a, finalActual, legajoActual);
		write('Ingrese numero de legajo del Alumno que rindio el final = '); readln(legajoActual);
	end;
end;

procedure contarLegajosImpares(a : arbol ; var cont : integer);
begin
	if(a <> nil)then begin
		if((a^.dato.numLegajo mod 2) <> 0)then
			cont := cont + 1;
		contarLegajosImpares(a^.hi, cont);
		contarLegajosImpares(a^.hd, cont);
	end;
end;

function incisoB(a : arbol) : integer;
var
	contador : integer;
begin
	contador := 0;
	if(a = nil)then begin
		incisoB := 0
	end
	else begin
		contarLegajosImpares(a, contador);
		incisoB := contador;
	end;
end;

function finalesAprobados(l : listaFinales) : integer;
var
	contadorAprobados : integer;
begin
	contadorAprobados := 0;
	while(l <> nil)do begin
		if(l^.dato.nota >= 4)then
			contadorAprobados := contadorAprobados + 1;
		l := l^.sig;
	end;
	finalesAprobados := contadorAprobados;
end;

procedure incisoC(a : arbol);
begin
	if(a <> nil)then begin
		writeln('Finales que aprobo el alumno con legajo ', a^.dato.numLegajo,' : ', finalesAprobados(a^.dato.finales));
		incisoC(a^.hi);
		incisoC(a^.hd);
	end;	
end;

function promedioFinales(l : listaFinales) : real;
var
	contador : integer;
	acumulador : real;
begin
	acumulador := 0;
	contador := 0;
	while(l <> nil)do begin
		contador := contador + 1;
		acumulador := acumulador + l^.dato.nota;
		l := l^.sig;
	end;
	if(contador = 0)then
		promedioFinales := 0
	else
		promedioFinales := (acumulador/contador);
end;

procedure incisoD(a : arbol; promedio: real);
begin
	if(a <> nil)then begin
		if(promedioFinales(a^.dato.finales) >= promedio)then
			writeln('El alumno con numero de legajo ',a^.dato.numLegajo,' tiene un promedio de ', promedioFinales(a^.dato.finales):2:2);
		incisoD(a^.hi, promedio);
		incisoD(a^.hd, promedio);
	end;	
end;

var
	promedioEvaluar : real;
	legajoImpar : integer;
	arbolAlumnos : arbol;
begin
	arbolAlumnos := nil;
	leerInformacion(arbolAlumnos);
	legajoImpar := incisoB(arbolAlumnos);
	writeln;
	writeln('La cantidad de alumnos con legajo impar es de ',legajoImpar,' alumnos');
	incisoC(arbolAlumnos);
	writeln('Ingrese promedio = '); readln(promedioEvaluar);
	incisoD(arbolAlumnos, promedioEvaluar);
end.
