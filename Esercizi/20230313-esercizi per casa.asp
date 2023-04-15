%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% non ground, non positivo
% 1)

a(X,Y) :- b(X,Y), not c(X,Y).
c(X,Y) :- b(X,Z), b(Z,Y).

b(2,7). b(9,1). b(7,9).

SOL: {
	Tp(0): {b(2,7), b(9,1), b(7,9)}
    Tp(1): {c(2,9), c(7,1)}
    Tp(2): {a(2,7), a(9,1), a(7,9)}

    M: {a(2,7), a(9,1), a(7,9), b(2,7), b(9,1), b(7,9), c(2,9), c(7,1)}
}

% EDB facts:
b(2,7).
b(7,9).
b(9,1).
% Facts derived to be true in every answer set:
a(2,7).
a(7,9).
a(9,1).
c(2,9).
c(7,1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a(X,Y) :- b(X,Y), not c(X,Y).

c(X,Y) :- b(X,Z), b(Y,W).

t(X,Y) :- a(X,Y).
t(X,Y) :- t(X,Z), t(Z,Y).

p(X,Y) :- b(X,Y), not t(X,Y).

b(2,7). b(9,1). b(7,9).

SOL: {
    Tp(0): {b(2,7), b(9,1), b(7,9)}
    Tp(1): {[...], c(2,2), c(2,9), c(9,2), c(9,9), c(2,7), c(7,2), c(7,7), c(9,7), c(7,9)}
    Tp(2): {[...], a(9,1)}
    Tp(3): {[...], t(9,1)}
    Tp(4): {[...], p(2,7), p(7,9)}

    M: {a(9,1), b(2,7), b(9,1), b(7,9), c(2,2), c(2,9), c(9,2), c(9,9), c(2,7), c(7,2), c(7,7), c(9,7), c(7,9), p(2,7), p(7,9), t(9,1)}
}
-----
b(2,7).
b(7,9).
b(9,1).
a(9,1).
c(2,2).
c(2,7).
c(2,9).
c(7,2).
c(7,7).
c(7,9).
c(9,2).
c(9,7).
c(9,9).
t(9,1).
p(2,7).
p(7,9).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a(X,Y) :- b(X), b(Y), not c(X,Y), X != Y.
b(Y) :- c(X,Y), not q(X).

c(X,Z) :- b(X), Z=X+1, Z<4.

q(0).
b(1).

SOL: {
    Tp(0): {q(0), b(1)}
    Tp(1): {[...], c(1,2)}
    Tp(2): {[...], b(2)}
    Tp(3): {[...], a(2,1), c(2,3)}
    Tp(4): {[...], b(3)}
    Tp(5): {[...], a(1,3), a(3,1), a(3,2)}
}
-----
q(0).
a(1,3).
a(2,1).
a(3,1).
a(3,2).
b(1).
b(2).
b(3).
c(1,2).
c(2,3).

%%%%
Es. 01
======
Calcolare l'unico answer set del seguente programma Datalog.

q(X,Y) :- a(X), c(Y).
p(X,Y,Z) :- a(X), q(Y,Z), m(X,Z).
m(X,Y) :- a(Z), p(Z,X,Y).
m(X,Y) :- b(X,Y),  n(X,Y).
n(X,Y) :- q(X,Y).
n(X,Y) :- b(X,Y), m(X,Y).
d(X,Y,Z) :- p(X,Y,Z), not n(Z,Y).

a(1).
a(2).
b(1,2).
c(2).

STRATI: {q} -> 

SOL: {
    Tp(0): {a(1), a(2), b(1,2), c(2)}
    Tp(1): {[...], q(1,2), q(2,2)}
    Tp(2): {[...], n(1,2), n(2,2)}
    Tp(3): {[...], m(1,2)}
    Tp(4): {[...], p(1,1,2), p(1,2,2)}
    Tp(5): {[...], d(1,1,2), m(2,2)}
    Tp(6): {[...], p(2,1,2), p(2,2,2)}
    Tp(7): {[...], d(2,1,2)}

    M: {a(1), a(2), b(1,2), c(2), d(1,1,2), d(2,1,2,) m(1,2), m(2,2), n(1,2), n(2,2), p(1,1,2), p(1,2,2), p(2,1,2), p(2,2,2), q(1,2), q(2,2)}
}
-----
a(1).
a(2).
b(1,2).
c(2).
q(1,2).
q(2,2).
p(1,1,2).
p(1,2,2).
p(2,1,2).
p(2,2,2).
m(1,2).
m(2,2).
n(1,2).
n(2,2).
d(1,1,2).
d(2,1,2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b(X):- a(X,Y), not a(Y,X).
h(Z) :- c(T,Y), Z=T+Y, Z<10.
c(Y,Z):- h(Y), h(Z), not b(Y).

a(2,3). a(3,2). a(2,6). a(6,1).
c(1,2).

STRATI: {b} -> {hc}

SOL: {
    Tp(0): {a(2,3), a(3,2), a(2,6), a(6,1), c(1,2)}
    Tp(1): {[...], b(2), b(6)}
    Tp(2): {[...], h(3)}
    Tp(3): {[...], c(3,3)}
    Tp(4): {[...], h(6)}
    Tp(5): {[...], c(3,6)}
    Tp(6): {[...], h(9)}
    Tp(7): {[...], c(3,9), c(9,3), c(9,6), c(9,9)}

    M: {a(2,3), a(3,2), a(2,6), a(6,1), b(2), b(6), c(1,2), c(3,3), c(3,6), c(3,9), c(9,3), c(9,6), c(9,9) h(3), h(6), h(9)}
}
-----
{b(2), b(6), h(3), h(6), h(9), c(1,2), c(3,3), c(3,6), c(3,9), c(9,3), c(9,6), c(9,9)}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

==============================================================================
Esercizio 1 - Implementare in Datalog le query richeste sullo schema seguente.
==============================================================================

person(ciccio).
person(kali).
person(simo).

seller(joe).
seller(alan).
seller(norma).

likes(ciccio,heineken).
likes(ciccio,bud).
likes(ciccio,becks).
likes(kali,bud).
%likes(kali,ceres).
likes(kali,becks).
%likes(simo,heineken).
likes(simo,bud).
likes(simo,ceres).

sells(joe,heineken,30).
sells(joe,bud,15).
sells(alan,heineken,24).
sells(alan,ceres,30).
sells(alan,becks,12).
sells(norma,heineken,30).
sells(norma,bud,40).
sells(norma,ceres,20).

frequents(ciccio,joe).
frequents(ciccio,norma).
frequents(kali,alan).
frequents(kali,norma).
frequents(simo,joe).
frequents(simo,alan).
frequents(simo,norma).

beers(heineken,manufactor1).
beers(bud,manufactor2).
beers(ceres,manufactor1).
beers(becks,manufactor2).

% I produttori delle birre vendute da Joe.
q1(M) :- beers(B,M), sells(joe,B,_).

% stasera andiamo da Joe, chi possiamo incontrare?
q2(P) :- frequents(P,joe).

% le birre che piacciono sia a simo che a kali
q3(B) :- likes(simo,B), likes(kali,B).

% I possibili incontri che si possono verificare 
q4(P1,P2) :- frequents(P1,S), frequents(P2,S), P1 != P2.

% le birre che piacciono o a ciccio o a kali.
q5(B) :- likes(ciccio,B).
q5(B) :- likes(kali,B).

% Supponendo che ogni persona conosca tutti quelli che frequentano lo stesso bar, 
% e che si possano facilmente conoscere tutte le persone 
% conosciute da un conoscente, calcolare quali persone puo' arrivare a 
% conoscere ciccio. 

knows(ciccio, P) :- frequents(ciccio, B), frequents(P, B), ciccio!=Y
knows(ciccio, P2) :- knows(ciccio, P1), frequents(P1, B), frequents (P2, B), P1!=P2,ciccio!=P2.

% oppure (più generico), va lasciato != e non < perchè non riusciremmo a generare tutte le conoscenze

knows(X,Y) :- frequents(X,L), frequents(Y,L), X!=Y.
knows(X,Y) :- knows(X,Z), knows(Z,Y), X!=Y

conosceCiccio(X) :- knows(ciccio,X).

% le birre che NON sono vendute da Norma
q7(B) :- beers(B,_), not venduteDaNorma(B).
venduteDaNorma(B) :- sells(norma, B, _).

% stasera andiamo da joe, chi NON possiamo incontrare
q8(P) :- person(P), not frequents(P,joe).

% le birre vendute da alan che NON sono prodotte da manufactor1 e non costano più di 20

%%% se volessimo completamente escludere le birre prodotte da manufactor1
q9(B) :- sells(alan,B,P), not prodotteDaManufactor1(B), P<20
prodotteDaManufactor1(B) :- beers(B,manufactor1).

%%% oppure
q9(B) :- sells(alan,B,P), not beers(B,manufactor1), P<20

%%% se volessimo includere birre prodotte da es. manufactor1 ma anche manufactor2
q9(B) :- sells(alan,B,P), beers(B,M), M!=manufactor1

% il bar in cui la bud costa di più
q10(Bar) :- sells(Bar,bud,_), not nonCaro(Bar).
nonCaro(Bar1) :- sells(Bar1,bud,P1), sells(Bar2,bud,P2), P1<P2.


