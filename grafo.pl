% ============================================================
% Actividad 02 - Backtracking en grafo dirigido
% Programacion III - UTP
% Autores: Julian Guadir, Alejandro Ipaz
% ============================================================

% ---------- Base de conocimiento ----------
% arista(Origen, Destino, Costo)
arista(vancouver, edmonton, 16).
arista(vancouver, calgary, 13).
arista(calgary, edmonton, 4).
arista(edmonton, saskatoon, 12).
arista(saskatoon, calgary, 9).
arista(calgary, regina, 14).
arista(regina, saskatoon, 7).
arista(saskatoon, winnipeg, 20).
arista(regina, winnipeg, 4).

% nodo(N): los vertices del grafo
nodo(vancouver).
nodo(edmonton).
nodo(calgary).
nodo(saskatoon).
nodo(regina).
nodo(winnipeg).

% ---------- Reglas ----------
% camino(X, Y, C): existe un camino de X a Y con costo total C.
% Se lleva una lista de visitados para evitar ciclos
% (por ejemplo edmonton -> saskatoon -> calgary -> edmonton).
camino(X, Y, C) :- camino(X, Y, [X], C).

camino(X, Y, _, C) :-
    arista(X, Y, C).
camino(X, Y, V, C) :-
    arista(X, Z, C1),
    Z \== Y,
    \+ member(Z, V),
    camino(Z, Y, [Z|V], C2),
    C is C1 + C2.

% conectado(X, Y, C): nodos alcanzables desde X y el costo de cada ruta.
conectado(X, Y, C) :-
    nodo(Y),
    X \== Y,
    camino(X, Y, C).

% tiene_aristas(X): el nodo X tiene al menos una arista
% (saliente o entrante).
tiene_aristas(X) :- arista(X, _, _), !.
tiene_aristas(X) :- arista(_, X, _), !.

% costo_via(X, Y, Z, C): costo de ir de X a Z pasando por Y.
costo_via(X, Y, Z, C) :-
    camino(X, Y, C1),
    camino(Y, Z, C2),
    C is C1 + C2.
