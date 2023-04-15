%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data la seguente base di dati, esprimere in datalog le query richieste.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% libri
libro(l1).
libro(l2).
libro(l3).
libro(l4).
libro(l5).

% autori
autore(camilleri).
autore(eco).
autore(pirandello).
autore(brawn).
autore(king).

% editori
editore(mondadori).
editore(rizzoli).
editore(rusconi).
editore(salani).
editore(sellerio).

% lettori 
lettore(stefania).
lettore(francesco).
lettore(simona).
lettore(giovambattista).
lettore(giovanni).

% pubblicazione(L,A,E,D) - il libro L, scritto dallautore A è stato pubblicato dalleditore E nellanno D
pubblicazione(l1,camilleri,sellerio,2004).
pubblicazione(l1,eco,sellerio,1999).
pubblicazione(l2,pirandello,rizzoli,1936).
pubblicazione(l3,brawn,rusconi,2003).
pubblicazione(l3,eco,rusconi,2003).
pubblicazione(l3,king,rusconi,2003).
pubblicazione(l4,camilleri,mondadori,2004).
pubblicazione(l4,brawn,mondadori,2004).
pubblicazione(l5,camilleri,mondadori,2004).

% venduto(L,C) - il libro L ha venduto C copie
venduto(l1,234).
venduto(l2,34).
venduto(l3,23).
venduto(l4,935).
venduto(l5,257).

% letto(P,L) - il lettore P ha letto il libro L
letto(stefania,l1).
letto(stefania,l3).
letto(francesco,l2).
letto(francesco,l5).
letto(simona,l4).
letto(simona,l3).
letto(simona,l1).
letto(giovanni,l5).
letto(giovanni,l1).
letto(giovanni,l4).
letto(giovambattista,l3).
letto(giovambattista,l2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% gli editori dei libri scritti da camilleri nel 2004
q1(E) :- pubblicazione(_,camilleri,E,2004).

% i libri letti sia da giovanni che da francesco
q2(L) :- letto(giovanni,L),letto(francesco,L).

% i libri scritti da un solo autore
q3(L) :- libro(L), not almenoDueAutori(L).
almenoDueAutori(L) :- pubblicazione(L,A1,_,_), pubblicazione(L,A2,_,_), A1!=A2.

% i libri scritti da almeno 2 autori
% q4(L) :- libro(L), not q3(L).
q4(L) :- almenoDueAutori(L).

% i libri scritti da esattamente 2 autori
q5(L) :- libro(L), not q3(L), not almenoTreAutori(L).
almenoTreAutori(L) :- pubblicazione(L,A1,_,_), pubblicazione(L,A2,_,_), pubblicazione(L,A3,_,_), A1!=A2, A1!=A3, A2!=A3.

% il libro che ha venduto piu copie
q6(L) :- libro(L), not libriMenoCopie(L).
libriMenoCopie(L) :- venduto(L,C1), venduto(_,C2), C1<C2.

% le coppie di lettori che hanno letto almeno uno stesso libro
q7(X,Y) :- letto(X,L), letto(Y,L), X<Y.

% gli autori che non hanno scritto nessun libro edito da mondadori
q8(A) :- autore(A), not autoriPerMondadori(A).
autoriPerMondadori(A) :- pubblicazione(_,A,mondadori,_).

% le persone che non hanno letto nessun libro di camilleri
q9(P) :- lettore(P), not lettoriCamilleri(P).
lettoriCamilleri(P) :- letto(P,L), pubblicazione(L,camilleri,_,_).