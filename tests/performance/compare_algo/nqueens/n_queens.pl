
% N-Queens Solver optimized with backtracking to find all solutions
n_queens(N, Solutions) :-
    length(Board, N),
    nums_list(1, N, List),
    findall(Board, place_queens(List, Board), Solutions).

% Generate a list of numbers from Start to End
nums_list(Start, End, [Start|Rest]) :-
    Start =< End,
    NewStart is Start + 1,
    nums_list(NewStart, End, Rest).
nums_list(Start, End, []) :-
    Start > End.

% Place queens on the board ensuring safety
place_queens([], []).
place_queens(Available, [Queen|Rest]) :-
    select(Queen, Available, NextAvailable),
    place_queens(NextAvailable, Rest),
    safe_position(Queen, Rest, 1).

% Check safe placement: no queens attack each other
safe_position(_, [], _).
safe_position(Queen, [Other|Rest], Dist) :-
    Queen \= Other,
    abs(Queen - Other) =\= Dist,
    NextDist is Dist + 1,
    safe_position(Queen, Rest, NextDist).


:- current_prolog_flag(stack_limit,X),X_16 is X * 16, set_prolog_flag(stack_limit,X_16).

nqueens(N, L):- n_queens(N, L).

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

:- use_module(library(lists)).
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

