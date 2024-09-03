program Act1E;
var 
	ale, f, a, b: integer;
begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
     write('Ingrese el numero que esta buscando = ');
     readln(f);
     write('Ingrese el limite inferior de los numeros randomizados = ');
     readln(a);
     write('Ingrese el limite superior de los numeros randomizados = ');
     readln(b);
     if(f < a)then
		writeln('El numero que busca no esta dentro del rango')
	 else begin
		ale := a + random(b-a+1);
		while(ale <> f)do begin
			writeln ('El numero aleatorio generado es: ', ale);
			ale := a + random(b-a+1);
		end
	 end;
end.
