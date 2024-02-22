%preguntas a responder

%1.Existe una conexion entre Saskatoo y Vancouver?
%2. Con que nodos esta conectado Regina y cual es el costo de cada conexion?

%hechos de conexiones, con precios

conectado_con(vancouver,edmonton,16).
conectado_con(vancouver,calgary,13).
conectado_con(edmonton,saskaton,12).
conectado_con(saskatoon,winnipeg,20).
conectado_con(saskatoon,calgary,9).
conectado_con(calgary,regina,14).
conectado_con(regina,winnipeg,4).
conectado_con(regina,saskatoon).


%reglas
$% crear regla para saber si hay conexion, directa y no directa

%1.Existe una conexion entre Saskatoo y Vancouver?
conectado(X,Y):-conectado_con(X,Y,_).



%2. Con que nodos esta conectado Regina y cual es el costo de cada conexion?
conectado_con_regina(X,Y,C):-conectado_con(X,Y,C).
conectado_con_regina(Y,X,C):-conectado_con(X,Y,C).
conectado_con_regina(X,regina,C):-conectado_con(X,regina,C).
conectado_con_regina(regina,X,C):-conectado_con(X,regina,C).


