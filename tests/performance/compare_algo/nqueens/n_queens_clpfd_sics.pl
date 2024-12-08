:- use_module(library(clpfd)).

queens(N, L, LabelingType) :-
     length(L, N),
     domain(L, 1, N),
     constrain_all(L),
     labeling(LabelingType, L).

constrain_all([]).
constrain_all([X|Xs]) :-
     constrain_between(X, Xs, 1),
     constrain_all(Xs).

constrain_between(_X, [], _N).
constrain_between(X, [Y|Ys], N) :-
     no_threat(X, Y, N),
     N1 is N+1,
     constrain_between(X, Ys, N1).

no_threat(X, Y, I) :-
        X   #\= Y,
        X+I #\= Y,
        X-I #\= Y.

% version 1: weak but efficient
no_threat(X, Y, I) +:
     X in \({Y} \/ {Y+I} \/ {Y-I}),
     Y in \({X} \/ {X+I} \/ {X-I}).

/*
% version 2: strong but very inefficient version
no_threat(X, Y, I) +:
    X in unionof(B,dom(Y),\({B} \/ {B+I} \/ {B-I})),
    Y in unionof(B,dom(X),\({B} \/ {B+I} \/ {B-I})).

% version 3: strong but somewhat inefficient version
no_threat(X, Y, I) +:
    X in (4..card(Y)) ? (inf..sup) \/
          unionof(B,dom(Y),\({B} \/ {B+I} \/ {B-I})),
    Y in (4..card(X)) ? (inf..sup) \/
          unionof(B,dom(X),\({B} \/ {B+I} \/ {B-I})).
*/

nqueens(N, L):- queens(N, L, [ff]).

% N-Queens Solver optimized with backtracking to find all solutions
aqueens(N, Solutions) :-
    findall(Board, nqueens(N, Board), Solutions).

% Function to solve N-Queens for a given N and time it
time_sols(Solutions, Call) :-
    statistics(runtime, [StartCPU, _]),
    statistics(walltime, [StartWall, _]),

    copy_term(Call, Copy), numbervars(Copy, 0, _),
    once(Call),

    statistics(runtime, [EndCPU, _]),
    statistics(walltime, [EndWall, _]),

    CPUTime is EndCPU - StartCPU,
    WallTime is EndWall - StartWall,

    length(Solutions, NumSolutions),
    format("N = ~q: Found ~d solution(s) in ~d ms (CPU) and ~d ms (Wall)\n",
           [Copy, NumSolutions, CPUTime, WallTime]).

:- use_module(library(between)).

% Main function to solve the N-Queens problem for sizes S to E
solve_for_sizes(S, E) :-
    between(S, E, N),
    format("Solving for N = ~d\n", [N]),
    % time_sols([OneSol], nqueens(N, OneSol)),
    time_sols(Solutions, aqueens(N, Solutions)),
    fail; % Forces Prolog to backtrack and try the next N
    true.

% Run the main function
:- solve_for_sizes(10, 15).

