%factorial
%factorial(n,Facto)
%caso base
facto(0,1).
facto(1,1).
%paso recursivo
facto(N,Facto):-
    N<1,
    N1 is N-1,
    facto(N1,Facto1),
    Facto is N*Facto1.
