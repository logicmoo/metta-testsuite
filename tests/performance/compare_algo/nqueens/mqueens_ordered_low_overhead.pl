'mc__+'(A,B,R) :- number(A),number(B),!,plus(A,B,R).
'mc__+'(A,B,['+',A,B]).

'mc__-'(A,B,R) :- number(A),number(B),!,plus(B,R,A).
'mc__-'(A,B,['-',A,B]).

'mc__*'(A,B,R) :- number(A),number(B),!,R is A*B.
'mc__*'(A,B,['*',A,B]).

%%%%%%%%%%%%%%%%%%%%% logic

mc__and(A,B,B):- atomic(A), A\=='False', A\==0.
mc__and(_,_,'False').

mc__or(A,B,B):- (\+ atomic(A); A='False'; A=0), !.
mc__or(_,_,'True').

%%%%%%%%%%%%%%%%%%%%% comparison

'mc__=='(A,A,1) :- !.
'mc__=='(_,_,0).

'mc__<'(A,B,R) :- number(A),number(B),!,(A<B -> R=1 ; R=0).
'mc__<'(A,B,['<',A,B]).

%%%%%%%%%%%%%%%%%%%%% lists

'mc__car-atom'([H|_],H).

'mc__cdr-atom'([_|T],T).

'mc__cons-atom'(A,B,[A|B]).

%%%%%%%%%%%%%%%%%%%%% misc

'mc__empty'(_) :- fail.

is_True(T):- atomic(T), T\=='False', T\==0.

%%%%%%%%%%%%%%%%%%%%% nqueens

mc__select(A, B) :-
    (   C=[],
        'mc__=='(A, C, D),
        is_True(D)
    *-> mc__empty(E),
        B=E
    ;   'mc__car-atom'(A, F),
        'mc__cdr-atom'(A, G),
        B=[F, G]
    ).
mc__select(A, B) :-
    (   C=[],
        'mc__=='(A, C, D),
        is_True(D)
    *-> mc__empty(E),
        B=E
    ;   'mc__car-atom'(A, F),
        'mc__cdr-atom'(A, G),
        mc__select(G, H),
        H=[I, J],
        'mc__cons-atom'(F, J, K),
        B=[I, K]
    ).

mc__range(A, B, C) :-
    (   'mc__=='(A, B, D),
        is_True(D)
    *-> C=[A]
    ;   'mc__+'(A, 1, E),
        mc__range(E, B, F),
        'mc__cons-atom'(A, F, G),
        C=G
    ).

mc__nqueens_aux(A, B, C) :-
    (   D=[],
        'mc__=='(A, D, E),
        is_True(E)
    *-> C=B
    ;   mc__select(A, F),
        F=[G, H],
        (   mc__not_attack(G, 1, B, I),
            is_True(I)
        *-> 'mc__cons-atom'(G, B, J),
            mc__nqueens_aux(H, J, K),
            L=K
        ;   mc__empty(M),
            L=M
        ),
        C=L
    ).

mc__not_attack(A, B, C, D) :-
    (   E=[],
        'mc__=='(C, E, F),
        is_True(F)
    *-> G='True',
        D=G
    ;   'mc__car-atom'(C, H),
        'mc__cdr-atom'(C, I),
        (   'mc__=='(A, H, J),
            'mc__+'(B, H, K),
            'mc__=='(A, K, L),
            'mc__+'(A, B, M),
            'mc__=='(H, M, N),
            mc__or(L, N, O),
            mc__or(J, O, P),
            is_True(P)
        *-> Q='False',
            R=Q
        ;   'mc__+'(B, 1, S),
            mc__not_attack(A, S, I, T),
            R=T
        ),
        D=R
    ).

nqueens(A, B) :-
    mc__range(1, A, C),
    D=[],
    mc__nqueens_aux(C, D, B).


:- time(findall(X,nqueens(12,X),Y)).



