pairwise_weight(C,D,G) :- G=#sum{X,C,D,K : votes(X,C,P1,K),votes(X,D,P2,K), P1<P2}, candidate(C), candidate(D),C!=D.														
pairwise_weight(C,D,A-X) :- pairwise_weight(D,C,X),voters(A),C!=D.		

arc(A,B) :- pairwise_weight(A,B,C),pairwise_weight(B,A,D),C>D.
arc(B,A) :- pairwise_weight(A,B,C),pairwise_weight(B,A,D),C<D.

arc_num(C) :- C =#count{A,B: arc(A,B)}.
ver(C) :- candidate(C).

{re_arc(A,B):arc(B,A),ver(A;B)}H:- arc_num(C), H=C/2.
slater(A,B) :- arc(A,B),not re_arc(B,A),ver(A;B).
slater(A,B) :- re_arc(A,B),ver(A;B).
:- slater(A,B),slater(B,A).
reach(A,B) :- slater(A,B),ver(A;B).
reach(A,B) :- slater(A,C),reach(C,B),ver(A;B;C).
:- reach(A,A),ver(A).
%:- not reach(A,B), ver(A;B).


diff(Z) :- Z=#count{A,B:re_arc(A,B)}.
#minimize{Z:diff(Z)}.
winner(A) :- not reach(_,A),ver(A).
#show re_arc/2.
#show winner/1.
%#show arc/2.
%#show arc_num/1.
%#show slater/2.
%#show reach/2.
%#show pairwise_weight/3.
%#show diff/1.
