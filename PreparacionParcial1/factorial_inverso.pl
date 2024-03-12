% 4. (1.4 | 5.0) Definir la relación factorial_inverso(X,N) que se verifique si X es el factorial de N. Por ejemplo,
% ?- factorial_inverso(120,N).
% N = 5;
% No
% ?- factorial_inverso(80,N).
% No

% Relación auxiliar para calcular el factorial.
factorial(0, 1). % El factorial de 0 es 1.
factorial(N, F) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

% Relación factorial_inverso que verifica si X es el factorial de N.
% Utiliza una relación auxiliar con un acumulador para probar diferentes valores de N.
factorial_inverso(X, N) :-
    factorial_inverso_aux(X, 1, N).

% Relación auxiliar que incrementa N hasta que el factorial de N sea igual a X.
factorial_inverso_aux(X, Acc, Acc) :-
    factorial(Acc, F),
    F =:= X.
factorial_inverso_aux(X, Acc, N) :-
    factorial(Acc, F),
    F < X,
    Acc1 is Acc + 1,
    factorial_inverso_aux(X, Acc1, N).
