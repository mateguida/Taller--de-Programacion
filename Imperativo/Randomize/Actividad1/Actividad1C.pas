program Act1;
var 
	ale, i, n, a, b: integer;
begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
     write('Ingrese la cantidad de numeros que quiere imprimir = ');
     readln(n);
     write('Ingrese el limite superior de los numeros randomizados = ');
     readln(b);
     write('Ingrese el limite inferior de los numeros randomizados = ');
     readln(a);
     for i := 1 to n do begin
		ale := a + random(b-a);
		writeln ('El numero aleatorio numero ',i,' generado es: ', ale);
	end
end.
