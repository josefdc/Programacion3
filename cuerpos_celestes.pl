% Cuerpos Celestes. Dados los siguientes enunciados:

% 1. Solamente las lunas orbitan alrededor de un planeta.

% 2. La Luna orbita alrededor de la Tierra

% 3. Los planetas del sistema solar orbitan alrededor del Sol.

% 4 Venus y la Tierra son planetas del sistema solar.

% 5. El Sol es una estrella

% 6. Toda estrella, luna o planeta es un cuerpo celeste.

% 7. ¿Cuáles son los cuerpos celestes?

% a) Traduzca al lenguaje formal de la lógica de predicados.

% b)Exprese en forma clausal las fórmulas obtenidas en el paso anterior.

% c) Convierta las anteriores cláusulas en un programa de prolog (hechos y reglas).

% d) Utilice el programa para responder a las siguientes preguntas: ¿quién órbita alrededor del

% sol? ¿es el sol un planeta? ¿Cuáles son los cuerpos celestes?

% e) llustre el árbol SLD para la consulta ¿quién órbita alrededor del sol?, mostrando todas las

% respuestas posibles

% solucion

% a) Traduzca al lenguaje formal de la lógica de predicados.

% 1. ∀x (luna(x) → ∃y(planeta(y) ∧ orbita(x,y)))
% 2. orbita(luna, tierra)
% 3. ∀x (planeta(x) → orbita(x, sol))
% 4. planeta(venus) ∧ planeta(tierra)
% 5. estrella(sol)
% 6. ∀x (estrella(x) ∨ luna(x) ∨ planeta(x) → cuerpo_celeste(x))
% 7. cuerpo_celeste(x)

% c) Convierta las anteriores cláusulas en un programa de prolog (hechos y reglas).
% Hechos

luna(luna).
planeta(venus).
planeta(tierra).
estrella(sol).

% Reglas 

orbita(luna, Y) :- planeta(Y).
orbita(luna, tierra).
orbita(X, sol) :- planeta(X).
cuerpo_celeste(X) :- estrella(X).
cuerpo_celeste(X) :- luna(X).
cuerpo_celeste(X) :- planeta(X).

% d) Utilice el programa para responder a las siguientes preguntas: ¿quién órbita alrededor del
% sol? ¿es el sol un planeta? ¿Cuáles son los cuerpos celestes?

% ¿quién órbita alrededor del sol?
% ?- orbita(X, sol).
% X = venus ;
% X = tierra ;
% false.

% ¿es el sol un planeta?
% ?- planeta(sol).
% false.

% ¿Cuáles son los cuerpos celestes?
% ?- cuerpo_celeste(X).
% X = sol ;
% X = luna ;
% X = venus ;
% X = tierra ;
% false.