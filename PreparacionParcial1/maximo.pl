% Ejercicio 2.1 Definir la relación máximo(+X,+Y,?Z) que se verifique si Z es el máximo de X e Y. Por ejemplo,

% | ?- máximo (2, 3, X).
% | X = 3
% | ?- máximo (3, 2, X).
% | X = 3

% Definición de la relación máximo que verifica si Z es el máximo entre X e Y.
maximo(X, Y, X) :- X >= Y. % Si X es mayor o igual a Y, entonces X es el máximo.
maximo(X, Y, Y) :- X < Y.  % Si X es menor que Y, entonces Y es el máximo.
