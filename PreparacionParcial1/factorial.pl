% Ejercicio 2.2 Definir la relación factorial(+X,?Y) que se verifique si Y es el factorial de X. Por ejemplo,

% | ?- factorial (3,X).
% | X = 6

% Caso base: el factorial de 0 es 1.
factorial(0, 1).

% Caso recursivo: factorial de N es N multiplicado por el factorial de N-1.
factorial(N, F) :-
    N > 0,              % Asegurarse de que N es positivo.
    N1 is N - 1,        % Restar 1 a N para la llamada recursiva.
    factorial(N1, F1),  % Llamada recursiva para calcular factorial de N-1.
    F is N * F1.        % Calcular factorial de N multiplicando N por el resultado de la llamada recursiva.
