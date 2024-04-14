/*1)	Construya una función que se llame sub_conjunto. Esta función recibe dos listas y debe retornar True cuando el primer argumento es subconjunto completo del segundo y #f en caso contrario.


Ejemplos de uso
sub_conjunto([],[1,2,3,4,5]).
True
sub_conjunto([1,2,3],[1,2,3,4,5]).
True
sub_conjunto([1,2,6],[1,2,3,4,5]).
False
*/

% La lista vacía es subconjunto.
sub_conjunto([], _).
sub_conjunto([X|Cola1], Lista2) :-
    member(X, Lista2),
    sub_conjunto(Cola1, Lista2).
