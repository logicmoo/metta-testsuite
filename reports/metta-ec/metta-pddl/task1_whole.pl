%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attempted Prolog Representation of the Original Code
% As close as possible to the original structure and logic.
% Note: The original code uses a custom language (MeTTa) and logic.
%       This Prolog code is a best-effort adaptation. Some semantics
%       differ due to language differences.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Objects
object(a).
object(b).
object(c).

% Initial state
initial_state([
    on_table(a),
    on_table(b),
    on_table(c),
    clear(a),
    clear(b),
    clear(c),
    arm_empty
]).

% Goal state
goal([on(a,b), on(b,c)]).
% ===================================================================
% (5) Action: pickup(X)
% Pre: clear(X), on_table(X), arm_empty
% Add: holding(X)
% Del: clear(X), on_table(X), arm_empty
action(pickup(X),
    [clear(X), on_table(X), arm_empty],
    [holding(X)],
    [clear(X), on_table(X), arm_empty]).

% ===================================================================
% (6) Action: putdown(X)
% Pre: holding(X)
% Add: clear(X), arm_empty, on_table(X)
% Del: holding(X)
action(putdown(X),
    [holding(X)],
    [clear(X), arm_empty, on_table(X)],
    [holding(X)]).

% ===================================================================
% (7) Action: stack(X,Y)
% Pre: clear(Y), holding(X)
% Add: arm_empty, clear(X), on(X,Y)
% Del: clear(Y), holding(X)
action(stack(X,Y),
    [clear(Y), holding(X)],
    [arm_empty, clear(X), on(X,Y)],
    [clear(Y), holding(X)]).

% ===================================================================
% (8) Action: unstack(X,Y)
% Pre: on(X,Y), clear(X), arm_empty
% Add: holding(X), clear(Y)
% Del: on(X,Y), clear(X), arm_empty
action(unstack(X,Y),
    [on(X,Y), clear(X), arm_empty],
    [holding(X), clear(Y)],
    [on(X,Y), clear(X), arm_empty]).

% ===================================================================
% (9) States will be represented as state_fluent(StateId, Fluent).
% Comments and TODO lines are omitted or turned into Prolog comments.

% ===================================================================
% (10) Imports and special hyperon constructs are not applicable in Prolog.

% ===================================================================
% (11) Formula satisfaction for not(Expr)
formula_satisfaction(StateId, not(Expr)) :-
    \+ formula_satisfaction(StateId, Expr).

% ===================================================================
% (12) Formula satisfaction for or([...])
formula_satisfaction(_StateId, or([])) :- fail.
formula_satisfaction(StateId, or([H|T])) :-
    formula_satisfaction(StateId, H);
    formula_satisfaction(StateId, or(T)).

% ===================================================================
% (13) Formula satisfaction for and([...])
formula_satisfaction(_StateId, and([])) :- true.
formula_satisfaction(StateId, and([H|T])) :-
    formula_satisfaction(StateId, H),
    formula_satisfaction(StateId, and(T)).

% ===================================================================
% (14) Base case of formula satisfaction: if it's a fluent
formula_satisfaction(StateId, Expr) :-
    \+ is_compound_expr(Expr),
    state_fluent(StateId, Expr).


% is_compound_expr/1 checks if an expression is and/or/not
is_compound_expr(and(_)).
is_compound_expr(or(_)).
is_compound_expr(not(_)).

% ===================================================================
% (15) Check if action is applicable in a given state
all_satisfied(_StateId, []).
all_satisfied(StateId, [C|Cs]) :-
    formula_satisfaction(StateId, C),
    all_satisfied(StateId, Cs).

action_applicable(StateId, ActionTerm) :-
    action(ActionTerm, Pre, _, _),
    all_satisfied(StateId, Pre).

% ===================================================================
% (16) args_combination/2 - Generate parameter combinations from domain objects
% This is a helper if we need grounding actions.
args_combination([], [[]]).
args_combination([_Param|Rest], Combos) :-
    findall(O, object(O), Objects),
    args_combination(Rest, RestCombos),
    combine_values(Objects, RestCombos, Combos).

combine_values([], _, []).
combine_values([V|Vs], RestCombos, All) :-
    findall([V|R], member(R, RestCombos), This),
    combine_values(Vs, RestCombos, More),
    append(This, More, All).

% ===================================================================
% (17) actions_applicable: find all applicable actions
% We can just rely on backtracking since action/4 and action_applicable exist
actions_applicable(StateId, ActionTerm) :-
    action_applicable(StateId, ActionTerm).

% ===================================================================
% (18) Applying action effects
apply_action_effect(StateFluents, ActionTerm, NewStateFluents) :-
    action(ActionTerm, _, Add, Del),
    subtract(StateFluents, Del, Temp),
    union(Temp, Add, NewStateFluents).

% ===================================================================
% (19) signed_fluents: separate positive and negative fluents
signed_fluents([], [], []).
signed_fluents([not(F)|R], P, [F|N]) :-
    signed_fluents(R, P, N).
signed_fluents([F|R], [F|P], N) :-
    \+ F = not(_),
    signed_fluents(R, P, N).

% ===================================================================
% (20) state-diff: apply positive and negative differences
state_diff(AllStates, and(Diffs), NewState) :-
    signed_fluents(Diffs, Pos, Neg),
    subtract(AllStates, Neg, Temp),
    union(Temp, Pos, NewState).

% ===================================================================
% (21) state-transition: given a state, find new states
% We store states as state_fluent(StateId, F).
% We just combine actions_applicable and apply_action_effect here.
get_state_fluents(S, Fs) :- findall(F, state_fluent(S,F), Fs).

state_transition(StateId, (ActionTerm, NewFluents)) :-
    actions_applicable(StateId, ActionTerm),
    get_state_fluents(StateId, OldFluents),
    apply_action_effect(OldFluents, ActionTerm, NewFluents).

% ===================================================================
% (22) state-visited?: check if given fluents match an existing state
same_set(A,B) :- sort(A,SA), sort(B,SB), SA = SB.

state_visited_fluents(Fluents, StateId) :-
    get_state_fluents(StateId, FS),
    same_set(FS, Fluents).

state_visited(Fluents) :-
    state_fluent(S,_),
    state_visited_fluents(Fluents, S),
    !.

% ===================================================================
% (23) state-visited
state_visited(StateId) :-
    get_state_fluents(StateId, FS),
    state_visited(FS).

% ===================================================================
% (24) state-enqueued?
state_enqueued(StateId) :-
    state_fluent(StateId, _).

% ===================================================================
% (25) goal-satisfied
goal_satisfied(StateId) :-
    goal(GoalFluents),
    all_satisfied(StateId, GoalFluents).

% ===================================================================
% (26) retrace-steps: from a given state back to initial (0)
:- dynamic succ/3.
retrace_steps(0, []).

retrace_steps(To, Steps) :-
    succ(From, ActionTerm, To),
    retrace_steps(From, Prev),
    append(Prev, [ActionTerm], Steps).

% ===================================================================
% (27) add-state-fluents!
:- dynamic state_fluent/2.

add_state_fluents(_StateId, []).
add_state_fluents(StateId, [F|Fs]) :-
    assertz(state_fluent(StateId,F)),
    add_state_fluents(StateId, Fs).

% ===================================================================
% (28) enqueue-next-states!
already_visited(Fluents) :-
    state_fluent(S,_),
    get_state_fluents(S,FS),
    same_set(FS,Fluents),
    !.

enqueue_next_states(_FromID, [], NextUID, NextUID).
enqueue_next_states(FromID, [(ActionTerm,Fluents)|Rest], NextUID, FinalID) :-
    \+ already_visited(Fluents),
    add_state_fluents(NextUID, Fluents),
    assertz(succ(FromID, ActionTerm, NextUID)),
    New is NextUID+1,
    enqueue_next_states(FromID, Rest, New, FinalID).

enqueue_next_states(FromID, [_|Rest], NextUID, FinalID) :-
    enqueue_next_states(FromID, Rest, NextUID, FinalID).

% ===================================================================
% (29) fw-state-search
fw_state_search(CurState, _NextUID, _Limit, Plan) :-
    goal_satisfied(CurState),
    retrace_steps(CurState, Plan).

fw_state_search(CurState, NextUID, Limit, Plan) :-
    CurState =< Limit,
    findall((A,F), state_transition(CurState,(A,F)), NextStates),
    enqueue_next_states(CurState, NextStates, NextUID, NewUID),
    NextFront is CurState+1,
    fw_state_search(NextFront, NewUID, Limit, Plan).

% ===================================================================
% (30) planner-main
planner_main(Limit, Plan) :-
    initial_state(Fluents),
    add_state_fluents(0, Fluents),
    fw_state_search(0, 1, Limit, Plan).

% ===================================================================
% (31) unf predicate - in Prolog we unify directly, skipping this.

% ===================================================================
% (32) Imports and tests - just comments.
% !(planner-main 100) would run the search.

% ===================================================================
% (33) make-queue
make_queue([]).

% ===================================================================
% (34) empty-queue?
empty_queue([]).

% ===================================================================
% (35) front-queue
front_queue([Front|_], Front).

% ===================================================================
% (36) pop-queue
pop_queue([_|Rest], Rest).

% ===================================================================
% (37) insert-queue
insert_queue(Q, Item, NewQ) :-
    append(Q,[Item],NewQ).

% ===================================================================
% (38) L-empty?
l_empty([]).

% ===================================================================
% (39) L-size
l_size(List, N) :-
    length(List,N).

% ===================================================================
% (40) L-push-front
l_push_front(List, Item, [Item|List]).

% ===================================================================
% (41) L-push-back
l_push_back([], Item, [Item]).
l_push_back([H|T], Item, [H|R]) :-
    l_push_back(T, Item, R).

% ===================================================================
% (42) L-pop-front
l_pop_front([_|T], T).

% ===================================================================
% (43) L-pop-back
l_pop_back([_], []) :- !.
l_pop_back([H|T],[H|R]) :-
    l_pop_back(T,R).

% ===================================================================
% (44) L-append is append/3 built-in, no need to redefine.

% ===================================================================
% (45) L-front
l_front([X|_], X).

% ===================================================================
% (46) L-back
l_back([X], X).
l_back([_|T], X) :-
    l_back(T, X).

% ===================================================================
% (47) L-index
l_index(List,Index,Elem) :-
    nth0(Index,List,Elem).

% ===================================================================
% (48) L-contains?
l_contains(List,Item) :-
    member(Item,List).

% ===================================================================
% (49) L-subset?
l_subset([], _).
l_subset([H|T],List) :-
    member(H,List),
    l_subset(T,List).

% ===================================================================
% (50) L-seteq?
l_seteq(L1,L2) :-
    sort(L1,S1),
    sort(L2,S2),
    S1=S2.

% ===================================================================
% (51) L-intersection
l_intersection(A,B,I) :-
    findall(X,(member(X,A),member(X,B)),I).

% ===================================================================
% (52) Run planner:
% ?- planner_main(100, Plan).
% Plan will be a list of actions that achieve the goal

:- time(planner_main(100, Plan)), writeln(Plan).
