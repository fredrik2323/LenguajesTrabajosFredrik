/*Implemente la función aplanar. Esta función recibe una lista con múltiples listas anidadas como elementos y devuelve una lista con los mismos elementos de manera lineal (sin listas).

Ejemplos de uso:
aplanar([1,2,[3,[4,5],[6,7]]],X).
True
X=[1,2,3,4,5,6,7].
*/

% si la lista esta vacia, la lista aplanada tambien esta vacia.
aplanar([], []).

% si el primer elemento de la lista es un numero, lo agregamos a la lista aplanada.
aplanar([X|Xs], [X|Ys]) :-
    number(X),
    aplanar(Xs, Ys).

aplanar([X|Xs], Ys) :-
    is_list(X),
    aplanar(X, Zs),
    aplanar(Xs, Ws),
    append(Zs, Ws, Ys).
