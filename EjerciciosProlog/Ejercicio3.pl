/* La distancia de Hamming entre dos cadenas es el número de posiciones en que los correspondientes elementos son distintos. Por ejemplo, la distancia de Hamming entre “roma” y “loba” es 2 (porque hay 2 posiciones en las que los elementos correspondientes son distintos: la posición 1 y la 3). Nótese en los ejemplos, que el tamaño de las cadenas puede no ser igual y por ende debe tomarse como referencia para la comparación el tamaño de palabra menor)
Ejemplos de uso:
distanciaH("romano","comino",X).
X = 2
distanciaH("romano","camino",X).
X = 3
*/

% Predicado para calcular la distancia de Hamming entre dos cadenas
distanciaH(Cadena1, Cadena2, Distancia) :-
    atom_chars(Cadena1, Chars1), % Convertir la primera cadena en una lista de caracteres
    atom_chars(Cadena2, Chars2), % Convertir la segunda cadena en una lista de caracteres
    distanciaH_aux(Chars1, Chars2, Distancia).

% ambas listas están vacías
distanciaH_aux([], [], 0).
distanciaH_aux([], [_|_], Longitud) :-
    length(_, Longitud).
distanciaH_aux([_|_], [], Longitud) :-
    length(_, Longitud).
distanciaH_aux([X|Xs], [X|Ys], Distancia) :-
    distanciaH_aux(Xs, Ys, Distancia).
distanciaH_aux([_|Xs], [_|Ys], Distancia) :-
    distanciaH_aux(Xs, Ys, D),
    Distancia is D + 1.
