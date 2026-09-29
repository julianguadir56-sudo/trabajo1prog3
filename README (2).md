# Actividad 02: Backtracking en grafo dirigido

Programación III - Universidad Tecnológica de Pereira (UTP)
Profesor: Ramiro Andrés Barrios Valencia

**Integrantes:** Julian Guadir, Alejandro Ipaz

## Descripción

Grafo dirigido y ponderado (Vancouver, Edmonton, Calgary, Saskatoon, Regina, Winnipeg)
modelado en Prolog. Incluye reglas de camino con backtracking (con control de ciclos),
nodos conectados con su costo, verificación de aristas y costo pasando por un nodo intermedio.

## Archivos

- `grafo.pl`: base de conocimiento y reglas.
- `ProgIIIG1-Act02-Julian-Alejandro.pdf`: informe con las consultas y resultados.

## Cómo ejecutar

Requiere [SWI-Prolog](https://www.swi-prolog.org/).

```bash
swipl grafo.pl
```

Consultas de ejemplo:

```prolog
?- camino(saskatoon, vancouver, C).          % false
?- conectado(regina, N, C).
?- tiene_aristas(regina).
?- costo_via(vancouver, calgary, winnipeg, C).
?- camino(edmonton, calgary, C).             % C = 21
```
