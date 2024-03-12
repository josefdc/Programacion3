% 1. (0.8 | 5.0) La sucesión de Fibonacci es 0,1,1,2,3,5,8,13,21,... en la que cada término, salvo los dos primeros, es la suma de los anteriores. Definir la relación fibonacci(+N,-X) que se verifique si X es el N-ésimo término de la sucesión de Fibonacci. Por ejemplo,
% ?- fibonacci(6,X).
% X = 8

% Casos base
fibonacci(0, 0). % El 0-ésimo término es 0
fibonacci(1, 1). % El 1-ésimo término es 1

% Caso recursivo
fibonacci(N, X) :-
    N > 1, % Aseguramos que N es al menos 2 para aplicar la relación
    N1 is N - 1, % Calculamos N-1
    N2 is N - 2, % Calculamos N-2
    fibonacci(N1, X1), % Obtenemos el término N-1 de la sucesión
    fibonacci(N2, X2), % Obtenemos el término N-2 de la sucesión
    X is X1 + X2. % X es la suma de los dos términos anteriores
