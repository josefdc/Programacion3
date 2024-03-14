% Caso base: el mcm de X e Y es 0 si alguno de los dos es 0.
mcm(_, 0, 0).
mcm(0, _, 0).

% Caso base: el mcm de cualquier número y 1 es el propio número.
mcm(X, 1, X) :- X > 0.
mcm(1, Y, Y) :- Y > 0.

% Caso recursivo: si X y Y no son 0 ni 1, se calcula el mcm de X e Y dividiendo el producto de X e Y entre el máximo común divisor de X e Y.
mcm(X, Y, Z) :-
    X > 0,
    Y > 0,
    mcd(X, Y, MCD),
    Z is (X * Y) / MCD.