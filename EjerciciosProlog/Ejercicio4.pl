% Hechos: Platos y sus calorías
calorias(guacamole, 200).
calorias(ensalada, 150).
calorias(consome, 300).
calorias(tostadas_caprese, 250).
calorias(filete_de_cerdo, 400).
calorias(pollo_al_horno, 280).
calorias(carne_en_salsa, 320).
calorias(tilapia, 160).
calorias(salmon, 300).
calorias(trucha, 225).
calorias(flan, 200).
calorias(nueces_con_miel, 500).
calorias(naranja_confitada, 450).
calorias(flan_de_coco, 375).

% plato principal y comida completa
plato_principal(Plato) :-
    (plato_de_carne(Plato); plato_de_pescado(Plato)).

plato_de_carne(Plato) :-
    member(Plato, [filete_de_cerdo, pollo_al_horno, carne_en_salsa]).

plato_de_pescado(Plato) :-
    member(Plato, [tilapia, salmon, trucha]).

comida_completa(Entrada, PlatoPrincipal, Postre) :-
    plato_principal(PlatoPrincipal),
    entrada(Entrada),
    postre(Postre).

entrada(Entrada) :-
    member(Entrada, [guacamole, ensalada, consome, tostadas_caprese]).

postre(Postre) :-
    member(Postre, [flan, nueces_con_miel, naranja_confitada, flan_de_coco]).

% calcular el total de calorías de una comida completa
total_calorias(Entrada, PlatoPrincipal, Postre, TotalCalorias) :-
    calorias(Entrada, CalEntrada),
    calorias(PlatoPrincipal, CalPlatoPrincipal),
    calorias(Postre, CalPostre),
    TotalCalorias is CalEntrada + CalPlatoPrincipal + CalPostre.

% encontra las primeras N combinaciones de comidas
% que no se repita ningun elemento
combinaciones_de_comidas(N, MaxCalorias, Combinaciones) :-
    findall((Entrada, PlatoPrincipal, Postre, TotalCalorias),
            (comida_completa(Entrada, PlatoPrincipal, Postre),
             total_calorias(Entrada, PlatoPrincipal, Postre, TotalCalorias),
             TotalCalorias =< MaxCalorias),
            ListaComidas),
    length(ListaComidas, Len),
    (Len >= N ->
        sublist(ListaComidas, N, Combinaciones);
        Combinaciones = ListaComidas).

% obtener una sublista de N elementos de una lista
sublist(Lista, N, Sublista) :-
    length(Sublista, N),
    append(Sublista, _, Lista).

% Ejemplo del cual se puede probar.
%  combinaciones_de_comidas(5, 1000, Combinaciones).
% combinaciones_de_comidas(5, 1500, Combinaciones).
