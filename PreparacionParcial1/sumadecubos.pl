% 3. (1.0 | 5.0) Desarrolle un programa que calcule la suma de los primeros N cubos.
% ?- sumancubos(5,S).
% S = 225

% Caso base: la suma de los primeros 0 cubos es 0.
sumancubos(0, 0).

% Caso recursivo: para sumar los primeros N cubos, sumamos N^3 al resultado de sumancubos(N-1).
sumancubos(N, S) :-
    N > 0, % Nos aseguramos que N sea positivo
    N1 is N - 1, % Decrementamos N
    sumancubos(N1, S1), % Calculamos la suma de los cubos hasta N-1
    S is S1 + N^3. % Sumamos N^3 a la suma acumulada
