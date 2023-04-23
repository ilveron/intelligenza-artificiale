%%% ESERCIZIO 1
% Dati fatti del tipo empl(ID,S), che rappresentano impiegati con Identificativo e Salario, 
% e fatti del tipo precede(ID1,ID2) che rappresentano un ordine tra gli impiegati, calcolare: 

empl(1, 2000).
empl(2, 3500).
empl(3, 1250).
empl(4, 6000).
empl(5, 666).
empl(6, 1337).

precede(4,2).
precede(2,1).
precede(1,6).
precede(6,3).
precede(3,5).

% impiegato che guadagna di meno
q1(ID) :- empl(ID,S1), not piuRemunerati(ID).
piuRemunerati(ID1) :- empl(ID1,S1), empl(ID2,S2), S1>S2.

% impiegato che guadagna di più
q2(ID) :- empl(ID,S1), not menoRemunerati(ID).
menoRemunerati(ID1) :- empl(ID1,S1), empl(ID2,S2), S1<S2.

% la chiusura transitiva della relazione precede (ossia calcolando tutte le precedenze indirette)
q3(ID1,ID2) :- precede(ID1,ID2).
q3(ID1,ID3) :- q3(ID1,ID2), precede(ID2,ID3).

% impiegato che precede tutti gli altri
q4(ID) :- empl(ID,_), not sonoSottoposti(ID).
sonoSottoposti(ID) :- precede(_,ID).

% impiegato che segue tutti gli altri
q5(ID) :- empl(ID,_), not sonoSuperiori(ID).
sonoSuperiori(ID) :- precede(ID,_).

% la somma dei salari di tutti gli impiegati
parz(ID1, Sum) :- empl(ID1,S1), empl(ID2,S2), precede(ID1,ID2), Sum = S1+S2.
parz(ID2, Sum) :- parz(ID1, S1), empl(ID2,S2), precede(ID2,ID1), Sum = S1+S2.
parzCapo(S1) :- parz(ID, S1), parz(ID, S2), q4(ID), S1 < S2.
q6(Sum) :- parz(ID, Sum), q4(ID), not parzCapo(Sum).

% -------------------------------------------------
%%% Esercizio 2
aeroporto(n001, milano).
aeroporto(n002, roma).
aeroporto(n003, napoli).
aeroporto(n004, lamezia).
aeroporto(n005, newyork).
aeroporto(n006, tokyo).
aeroporto(n007, dubai).
aeroporto(n008, istanbul).
aeroporto(n009, londra).

%volo(Codice,Compagnia,Aereoporto1,Aereoporto2,OraPartenza,OraArrivo,Costo)
volo(v01, alitalia, n001, n002, 10, 11, 115).           % Milano -> Roma
volo(v02, emirates, n007, n008, 9, 14, 300).            % Dubai -> Istanbul
volo(v03, british, n009, n006, 17, 6, 750).             % Londra -> Tokyo
volo(v04, ryanair, n004, n001, 15, 17, 30).             % Lamezia -> Milano
volo(v05, wizzair, n009, n002, 18, 20, 45).             % Londra -> Roma
volo(v06, united, n005, n007, 8, 22, 1000).             % New York -> Dubai

passeggero(kali, v01).
passeggero(simo, v02).
passeggero(ale, v06).
passeggero(erne, v02).
passeggero(andre, v03).
passeggero(cino, v05).
passeggero(matte, v05).
passeggero(fra, v04).
passeggero(fede, v06).

person(chiara, f, 30).
person(kali, m, 25).
person(simo, f, 23).
person(ale, m, 29).
person(erne, m, 42).
person(andre, m, 25).
person(cino, m, 32).
person(matte, m, 14).
person(fra, f, 33).
person(fede, f, 18).


% i voli su cui si pranza (pranzo: tra le 12 e le 14).
q1(V) :- volo(V, _, _, _, P, A, _), P<=14, A>=12.
q1(V) :- volo(V, _, _, _, P, A, _), A<P, P<14.

% i voli su cui non si cena (cena: tra le 19 e le 21).
q2(V) :- volo(V, _, _, _, _, _, _), not conCena(V).
conCena(V) :- volo(V, _, _, _, P, A, _), A>=19, P<=21.
conCena(V) :- volo(V, _, _, _, P, A, _), A<P, P<21.

% l'aeroporto che apre piu' presto (apertura: in concomitanza col primo volo della giornata).
q3(A) :- volo(_, _, A, _, _, _, _), not apronoTardi(A).
apronoTardi(A1) :- volo(_, _, A1, _, P1, _, _), volo(_, _, A2, _, P2, _, _), A1!=A2, P1>P2.

% l'aeroporto che chiude piu' tardi.
  % ... simile a quello che apre piu' presto
q4(A) :- volo(_, _, A, _, _, _, _), not apronoPresto(A).
apronoPresto(A1) :- volo(_, _, A1, _, P1, _, _), volo(_, _, A2, _, P2, _, _), A1!=A2, P1<P2.

% tutti i passeggeri che vanno da milano a roma entro la mattina (mattina: entro le 13).
q5(P) :- aeroporto(AP,milano), aeroporto(AA,roma), volo(V, _, AP, AA, _, A, _), passeggero(P, V), A<=13.

% i voli che contengono sia uomini che donne.
q6(V) :- voliConUomini(V), passeggero(P, V), person(P, f, _).                                   % Praticamente controlliamo che in ogni volo in cui è presente un uomo sia presente anche una donna
voliConUomini(V) :- volo(V, _, _, _, _, _, _), passeggero(P, V), person(P, m, _).

% i voli che non contengono nessuna donna.
q7(V) :- volo(V, _, _, _, _, _, _), not voliConDonne(V).
voliConDonne(V) :- volo(V, _, _, _, _, _, _), passeggero(P, V), person(P, f, _).

% tutte le coppie di codici di aeroporti connessi in qualche modo.
q8(A1,A2) :- connesso(A1, A2).
q8(A1,A3) :- q8(A1,A2), connesso(A2,A3).
connesso(A1, A2) :- volo(_, _, A1, A2, _, _, _).

% i possibili colpi di fulmine (persone che volano almeno una volta contemporaneamente sullo stesso aereo)
q9(P1, P2) :- passeggero(P1,V), passeggero(P2,V), P1<P2.
% q9(P1, P2) :- passeggero(P1,V), passeggero(P2,V), person(P1,m,_), person(P2,f,_).             % Per canonicità biblica

% incontri impossibili (persone che non volano mai assieme)
q10(P1, P2) :- passeggero(P1,_), passeggero(P2,_), P1<P2, not q9(P1,P2).                        % Tutte le coppie meno quelle che abbiamo trovato nella query precedente
% -------------------------------------------------