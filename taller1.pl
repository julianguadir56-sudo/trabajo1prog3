% =====================================================================
% Universidad Tecnologica de Pereira - Programacion III
% Actividad01: Logica de Predicados y Prolog
% =====================================================================

:- discontiguous padre/2, madre/2.

% =====================================================================
% EJERCICIO 1: ARBOL GENEALOGICO
% Solo las relaciones directas (padre/madre) son hechos.
% Las relaciones de mas de una generacion se obtienen por reglas.
% =====================================================================

% ---------- Hechos: genero ----------
hombre(abraham).
hombre(herbert).
hombre(homero).
hombre(clancy).
hombre(bart).

mujer(mona).
mujer(jacqueline).
mujer(marge).
mujer(patty).
mujer(selma).
mujer(lisa).
mujer(maggie).
mujer(ling).

% ---------- Hechos: relaciones directas ----------
% padre(Padre, Hijo)
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, marge).
padre(clancy, patty).
padre(clancy, selma).
padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).

% madre(Madre, Hijo)
madre(mona, homero).
madre(jacqueline, marge).
madre(jacqueline, patty).
madre(jacqueline, selma).
madre(marge, bart).
madre(marge, lisa).
madre(marge, maggie).
madre(selma, ling).

% ---------- Reglas ----------
% progenitor(P, H): P es padre o madre de H
progenitor(P, H) :- padre(P, H).
progenitor(P, H) :- madre(P, H).

% hijo/hija
hijo(H, P) :- hombre(H), progenitor(P, H).
hija(H, P) :- mujer(H), progenitor(P, H).

% abuelos (2 generaciones)
abuelo(A, N) :- hombre(A), progenitor(A, P), progenitor(P, N).
abuela(A, N) :- mujer(A), progenitor(A, P), progenitor(P, N).

% hermanos (comparten al menos un progenitor)
hermanos(X, Y) :- progenitor(P, X), progenitor(P, Y), X \== Y.
hermano(X, Y) :- hombre(X), hermanos(X, Y).
hermana(X, Y) :- mujer(X), hermanos(X, Y).

% tios: hermanos de un progenitor
tio(T, S) :- hombre(T), progenitor(P, S), hermanos(T, P).
tia(T, S) :- mujer(T), progenitor(P, S), hermanos(T, P).

% sobrinos
sobrino(S, T) :- hombre(S), progenitor(P, S), hermanos(T, P).
sobrina(S, T) :- mujer(S), progenitor(P, S), hermanos(T, P).

% primos: hijos de hermanos
primos(X, Y) :- progenitor(P, X), progenitor(Q, Y), hermanos(P, Q).
primo(X, Y) :- hombre(X), primos(X, Y).
prima(X, Y) :- mujer(X), primos(X, Y).

% ancestros y descendientes (recursivas, cualquier numero de generaciones)
ancestro(A, D) :- progenitor(A, D).
ancestro(A, D) :- progenitor(A, X), ancestro(X, D).
descendiente(D, A) :- ancestro(A, D).

% ---------- Consultas de prueba (resultado esperado) ----------
% ?- padre(homero, bart).            % true
% ?- abuelo(X, bart).                % X = abraham ; X = clancy
% ?- abuela(X, lisa).                % X = mona ; X = jacqueline
% ?- hermano(bart, lisa).            % true
% ?- hermana(X, bart).               % X = lisa ; X = maggie
% ?- tio(herbert, bart).             % true
% ?- tia(X, bart).                   % X = patty ; X = selma
% ?- tia(marge, ling).               % true
% ?- primo(bart, ling).              % true
% ?- prima(X, ling).                 % X = lisa ; X = maggie
% ?- sobrino(X, patty).              % X = bart
% ?- ancestro(abraham, X).           % herbert, homero, bart, lisa, maggie
% ?- descendiente(ling, X).          % X = selma ; X = clancy ; X = jacqueline
% ?- abuelo(clancy, ling).           % true

% =====================================================================
% EJERCICIO 2: EL CORONEL WEST ES UN CRIMINAL
% Ley: es un crimen que un estadounidense venda armas a naciones hostiles.
% =====================================================================

% ---------- Hechos ----------
americano(west).
enemigo(corea_del_sur, estados_unidos).
misil(m1).                       % "algunos misiles": existe al menos uno
posee(corea_del_sur, m1).

% ---------- Reglas ----------
% Todos los misiles de Corea del Sur le fueron vendidos por el Coronel West
vende(west, M, corea_del_sur) :- misil(M), posee(corea_del_sur, M).

% Un misil es un arma
arma(M) :- misil(M).

% Un enemigo de Estados Unidos es una nacion hostil
hostil(N) :- enemigo(N, estados_unidos).

% La ley: crimen de un estadounidense que vende armas a naciones hostiles
criminal(X) :- americano(X), arma(Y), vende(X, Y, N), hostil(N).

% ---------- Consultas de prueba (resultado esperado) ----------
% ?- criminal(west).                 % true
% ?- criminal(X).                    % X = west
% ?- vende(west, M, N).              % M = m1, N = corea_del_sur
% ?- hostil(corea_del_sur).          % true
% ?- arma(m1).                       % true
