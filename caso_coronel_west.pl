% Hechos
nacion_hostil(corea_del_sur).
vende_armas_a(coronel_west, corea_del_sur).
es_estadounidense(coronel_west).

% Reglas
es_criminal(Persona) :-
    es_estadounidense(Persona),
    nacion_hostil(Nacion),
    vende_armas_a(Persona, Nacion).
