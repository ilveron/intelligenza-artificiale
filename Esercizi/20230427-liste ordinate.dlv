% Scrivere un programma ASP senza disgiunzione e stratificato che utilizzando le liste riempia delle liste di interi ordinate in modo crescente e 
% 1) fornisca in output quella di lunghezza massima, 
% 2) data una lista di elementi illegali, restituisca la lista di lunghezza massima tra quelle che non contengono nessun elemento illegale.

% Modello dei dati in INPUT:
%   number(N)               ? gli interi da ordinare
%   forbidden(L)            ? lista di elementi illegali

% Modello dei dati in OUTPUT:
%   biggestList(L)          ? La lista ordinata più lunga.
%   biggestLegalList(L)     ? La lista ordinata legale più lunga

number(1..4).
forbidden([2,3]).

% Sicuramente le liste contenenti un solo numero sono ordinate 
orderedList([X]) :- number(X).

% Genero le altre liste
%% Se la lista con Y in testa è una lista ordinata, e X è un numero più piccolo della testa Y, allora lo si inserisce in testa, mantenendo l'ordine
orderedList([X|[Y|L]]) :- orderedList([Y|L]), number(X), X<Y.

% Segno la lunghezza di tutte le liste
listLength(Len,List) :- orderedList(List), &length(List;Len).

% Segno la lunghezza massima di una lista
maxListLength(Len) :- #max{X : listLength(X,_)}=Len.

% Trovo la lista più lunga
biggestList(List) :- listLength(Len,List), maxListLength(Len).

% Segno le liste ILLEGALI
%% Se un number N è membro di una ordererList, ed è contemporaneamente membro di forbidden, allora l'orderedList è da considerarsi ILLEGALE
illegalList(L) :- orderedList(L), forbidden(F), number(N), &member(N,L;), &member(N,F;).

% Segno le liste LEGALI (tutte meno quelle illegali)
legalList(L) :- orderedList(L), not illegalList(L).

biggestLegalList(List) :- listLength(Len,List), Len=#max{LLen : listLength(LLen,LL), legalList(LL)}.
