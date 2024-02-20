% Hechos de la familia Simpson
es_padre(homero, bart).
es_padre(homero, lisa).
es_padre(homero, maggie).
es_padre(abraham, herbert).
es_padre(abraham, homero).
es_padre(clancy, patty).
es_padre(clancy, selma).
es_padre(clancy, marge).

es_madre(marge, bart).
es_madre(marge, lisa).
es_madre(marge, maggie).
es_madre(mona, homero).
es_madre(jacqueline, marge).
es_madre(jacqueline, patty).
es_madre(jacqueline, selma).
es_madre(selma, ling).

es_mujer(marge).
es_mujer(patty).
es_mujer(selma).
es_mujer(ling).
es_mujer(maggie).
es_mujer(lisa).

es_hombre(bart).
es_hombre(homero).
es_hombre(herbert).

% Reglas para determinar las relaciones de más de una generación

% Regla para determinar si alguien es abuelo
abuelo(Abuelo, Nieto) :-
    es_padre(Padre, Nieto),
    es_padre(Abuelo, Padre).
abuelo(Abuelo, Nieto) :-
    es_madre(Madre, Nieto),
    es_padre(Abuelo, Madre).

% Regla para determinar si alguien es abuela
abuela(Abuela, Nieto) :-
    es_madre(Madre, Nieto),
    es_madre(Abuela, Madre).
abuela(Abuela, Nieto) :-
    es_padre(Padre, Nieto),
    es_madre(Abuela, Padre).

% Reglas para determinar si dos personas son hermanos
es_hermano(Hermano_a, Hermano_b) :-
    es_padre(Padre, Hermano_a),
    es_padre(Padre, Hermano_b),
    Hermano_a \= Hermano_b.
es_hermano(Hermano_a, Hermano_b) :-
    es_madre(Madre, Hermano_a),
    es_madre(Madre, Hermano_b),
    Hermano_a \= Hermano_b.

% Regla para determinar si alguien es tío o tía
tio_o_tia(TioOTia, Sobrino) :-
    es_hermano(TioOTia, PadreOMadre),
    (es_padre(PadreOMadre, Sobrino); es_madre(PadreOMadre, Sobrino)).

% Regla para determinar si alguien es primo o prima
primo_o_prima(PrimoOPrima, Persona) :-
    tio_o_tia(TioOTia, Persona),
    (es_padre(TioOTia, PrimoOPrima); es_madre(TioOTia, PrimoOPrima)).

% Regla para determinar si alguien es hijo o hija
es_hijo_o_hija(HijoOHija, PadreOMadre) :-
    es_padre(PadreOMadre, HijoOHija); es_madre(PadreOMadre, HijoOHija).
