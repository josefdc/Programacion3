% my_member(Element,[list]).

%caso base
my_member(Element,[Element|_]).
% cuando la lista este vacia
my_member(Element,[]):- 
    false.
%caso recursivo
my_member(Element,[_|Tail]):-
    my_member(Element,Tail).

%implementacion de proper_lenght
% caso base
proper_length([],0).
%caso recursivo
proper_length([_|Tail],N):-
    proper_length(Tail,N1),
    N is N1+1.

// llamado a la funcion
proper_length([1,2,3,4,5],N).