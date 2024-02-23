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
es_mujer(mona).
es_mujer(jacqueline).

es_hombre(bart).
es_hombre(homero).
es_hombre(herbert).
es_hombre(abraham).
es_hombre(clancy).

% Reglas para determinar las relaciones de más de una generación

% Regla para determinar si alguien es abuelo
abuelo(Abuelo, Nieto) :-
    es_hombre(Abuelo),
    (es_padre(Padre, Nieto), es_padre(Abuelo, Padre) ;
     es_madre(Madre, Nieto), es_padre(Abuelo, Madre)).

% Regla para determinar si alguien es abuela
abuela(Abuela, Nieto) :-
    es_mujer(Abuela),
    (es_madre(Madre, Nieto), es_madre(Abuela, Madre) ;
     es_padre(Padre, Nieto), es_madre(Abuela, Padre)).

% Reglas para determinar si dos personas son hermanos
hermano_de(Hermano_a, Hermano_b) :-
    es_hombre(Hermano_a),
    Hermano_a \= Hermano_b,
    (es_padre(Padre, Hermano_a), es_padre(Padre, Hermano_b) ;
     es_madre(Madre, Hermano_a), es_madre(Madre, Hermano_b)).

hermana_de(Hermana_a, Hermana_b) :-
    es_mujer(Hermana_a),
    Hermana_a \= Hermana_b,
    (es_padre(Padre, Hermana_a), es_padre(Padre, Hermana_b) ;
     es_madre(Madre, Hermana_a), es_madre(Madre, Hermana_b)).

% Regla para determinar si alguien es tío o tía
tio_de(Tio, Sobrino) :-
    es_hombre(Tio),
    hermano_de(Tio, PadreOMadre),
    (es_padre(PadreOMadre, Sobrino); es_madre(PadreOMadre, Sobrino)).

tia_de(Tia, Sobrino) :-
    es_mujer(Tia),
    hermana_de(Tia, PadreOMadre),
    (es_padre(PadreOMadre, Sobrino); es_madre(PadreOMadre, Sobrino)).

% Regla para determinar si alguien es primo o prima
primo_de(Primo, Persona) :-
    es_hombre(Primo),
    (tio_de(Tio, Persona); tia_de(Tia, Persona)),
    es_padre(Tio, Primo) ; es_madre(Tia, Primo).

prima_de(Prima, Persona) :-
    es_mujer(Prima),
    (tio_de(Tio, Persona); tia_de(Tia, Persona)),
    es_padre(Tio, Prima) ; es_madre(Tia, Prima).

% Regla para determinar si alguien es nieto o nieta
nieto_de(Nieto, Abuelo) :-
    es_hombre(Nieto),
    (abuelo(Abuelo, Nieto) ; abuela(Abuela, Nieto)).

nieta_de(Nieta, Abuela) :-
    es_mujer(Nieta),
    (abuelo(Abuelo, Nieta) ; abuela(Abuela, Nieta)).
