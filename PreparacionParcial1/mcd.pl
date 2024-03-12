% 2. (1.0 | 5.0) Definir la relación mcd(X,Y,Z) que se verifique si Z es el máximo común divisor de X e Y. Por ejemplo,
% ?- mcd(12,20,X).
% X = 4

% Caso base: el mcd de cualquier número y 0 es el propio número.
mcd(X, 0, X) :- X > 0.

% Caso recursivo: si Y no es cero, se calcula el mcd de Y y el resto de la división de X entre Y.
mcd(X, Y, Z) :-
    Y > 0,
    Resto is X mod Y,
    mcd(Y, Resto, Z).
