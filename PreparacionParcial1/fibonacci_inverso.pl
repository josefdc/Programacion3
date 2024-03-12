% Relación auxiliar para calcular la secuencia de Fibonacci.
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, Value) :-
    N > 1,
    N1 is N - 1, fibonacci(N1, F1),
    N2 is N - 2, fibonacci(N2, F2),
    Value is F1 + F2.

% Relación fibonacci_inverso que verifica si X es un término en la secuencia de Fibonacci.
% Se usa una relación auxiliar con un acumulador para probar diferentes valores de N.
fibonacci_inverso(X, N) :-
    fibonacci_inverso_aux(X, 0, N).

% Relación auxiliar que incrementa N hasta que el término N-ésimo de la secuencia de Fibonacci sea igual a X.
fibonacci_inverso_aux(X, Acc, Acc) :-
    fibonacci(Acc, F),
    F =:= X.
fibonacci_inverso_aux(X, Acc, N) :-
    fibonacci(Acc, F),
    F < X,
    Acc1 is Acc + 1,
    fibonacci_inverso_aux(X, Acc1, N).
