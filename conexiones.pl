% Hechos de conexiones con costos

conectado_con(s, v1, 16).
conectado_con(s, v2, 13).
conectado_con(v1, v3, 12).
conectado_con(v1, v2, 4).
conectado_con(v2, v1, 4).
conectado_con(v2, v4, 14).
conectado_con(v3, v4, 7).
conectado_con(v3, t, 20).
conectado_con(v4, v3, 9).
conectado_con(v4, t, 4).

% Regla para encontrar conexión con una ciudad intermedia.
% Esto asume que el predicado conectado_con/3 ya está definido como se mostró antes.

conexion_una_intermedia(Inicio, Intermedio, Fin, CostoTotal) :-
    conectado_con(Inicio, Intermedio, Costo1),   % Hay conexión de 'Inicio' a 'Intermedio'.
    conectado_con(Intermedio, Fin, Costo2),       % Hay conexión de 'Intermedio' a 'Fin'.
    \+ (conectado_con(Inicio, Fin, _)),           % No hay conexión directa entre 'Inicio' y 'Fin'.
    CostoTotal is Costo1 + Costo2.                % 'CostoTotal' es la suma de 'Costo1' y 'Costo2'.

% Regla base para una conexión directa sin ciudades intermedias.
conexion(Inicio, Fin, Costo) :-
    conectado_con(Inicio, Fin, Costo).

% Regla recursiva para encontrar una conexión con ciudades intermedias.
conexion(Inicio, Fin, CostoTotal) :-
    conectado_con(Inicio, Intermedio, Costo1),
    Intermedio \= Fin,
    conexion(Intermedio, Fin, Costo2),
    CostoTotal is Costo1 + Costo2.

tiene_aristas(Nodo) :-
    (conectado_con(Nodo, _, _) ; conectado_con(_, Nodo, _)).

costo_via_intermedio(X, Y, Z, CostoTotal) :-
    conectado_con(X, Y, Costo1),
    conectado_con(Y, Z, Costo2),
    CostoTotal is Costo1 + Costo2.

%------------------------------------------------------------------------

%Ahora usando listas, en vez de declarar los hechos

conectado_con2([s, v1, 16]).
conectado_con2([s, v2, 13]).
conectado_con2([v1, v3, 12]).
conectado_con2([v1, v2, 4]).
conectado_con2([v2, v1, 4]).
conectado_con2([v2, v4, 14]).
conectado_con2([v3, v4, 7]).
conectado_con2([v3, t, 20]).
conectado_con2([v4, v3, 9]).
conectado_con2([v4, t, 4]).


%usando listas de listas
conexion_una_intermedia2(Inicio, Intermedio, Fin, CostoTotal) :-
    conectado_con2([Inicio, Intermedio, Costo1]),   % Hay conexión de 'Inicio' a 'Intermedio'.
    conectado_con2([Intermedio, Fin, Costo2]),       % Hay conexión de 'Intermedio' a 'Fin'.
    \+ (conectado_con2([Inicio, Fin, _])),           % No hay conexión directa entre 'Inicio' y 'Fin'.
    CostoTotal is Costo1 + Costo2.                % 'CostoTotal' es la suma de 'Costo1' y 'Costo2'.