/*
 * Project: MeTTaLog - A MeTTa to Prolog Transpiler/Interpreter
 * Description: This file is part of the source code for a transpiler designed to convert
 *              MeTTa language programs into Prolog, utilizing the SWI-Prolog compiler for
 *              optimizing and transforming function/logic programs. It handles different
 *              logical constructs and performs conversions between functions and predicates.
 *
 * Author: Douglas R. Miles
 * Contact: logicmoo@gmail.com / dmiles@logicmoo.org
 * License: LGPL
 * Repository: https://github.com/trueagi-io/metta-wam
 *             https://github.com/logicmoo/hyperon-wam
 * Created Date: 8/23/2023
 * Last Modified: $LastChangedDate$  # You will replace this with Git automation
 *
 * Usage: This file is a part of the transpiler that transforms MeTTa programs into Prolog. For details
 *        on how to contribute or use this project, please refer to the repository README or the project documentation.
 *
 * Contribution: Contributions are welcome! For contributing guidelines, please check the CONTRIBUTING.md
 *               file in the repository.
 *
 * Notes:
 * - Ensure you have SWI-Prolog installed and properly configured to use this transpiler.
 * - This project is under active development, and we welcome feedback and contributions.
 *
 * Acknowledgments: Special thanks to all contributors and the open source community for their support and contributions.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the
 *    distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
/*

 @TODO make this test

            !(unify (a $b 1 (d)) (a $a 1 (d)) ok nok)
            !(unify (a $b c) (a b $c) (ok $b $c) nok)
            !(unify $a (a b c) (ok $a) nok)
            !(unify (a b c) $a (ok $a) nok)
            !(unify (a b c) (a b d) ok nok)
            !(unify ($x a) (b $x) ok nok)
        ");

        assert_eq_metta_results!(metta.run(parser),
            Ok(vec![
                vec![expr!("ok")],
                vec![expr!("ok" "b" "c")],
                vec![expr!("ok" ("a" "b" "c"))],
                vec![expr!("ok" ("a" "b" "c"))],
                vec![expr!("nok")],
                vec![expr!("nok")]
*/
%
% post match modew
%:- style_check(-singleton).
:- multifile(nop/1).
:- meta_predicate(nop(0)).
:- multifile(fake_notrace/1).
:- meta_predicate(fake_notrace(0)).
:- meta_predicate(color_g_mesg(+,0)).
:- multifile(color_g_mesg/2).

self_eval0(X):- \+ callable(X),!.
self_eval0(X):- is_valid_nb_state(X),!.
%self_eval0(X):- string(X),!.
%self_eval0(X):- number(X),!.
%self_eval0([]).
self_eval0(X):- is_metta_declaration(X),!.
self_eval0([F|X]):- !, is_list(X),length(X,Len),!,nonvar(F), is_self_eval_l_fa(F,Len),!.
self_eval0(X):- typed_list(X,_,_),!.
%self_eval0(X):- compound(X),!.
%self_eval0(X):- is_ref(X),!,fail.
self_eval0('True'). self_eval0('False'). % self_eval0('F').
self_eval0('Empty').
self_eval0(X):- atom(X),!, \+ nb_current(X,_),!.

coerce(Type,Value,Result):- nonvar(Value),Value=[Echo|EValue], Echo == echo, EValue = [RValue],!,coerce(Type,RValue,Result).
coerce(Type,Value,Result):- var(Type), !, Value=Result, freeze(Type,coerce(Type,Value,Result)).
coerce('Atom',Value,Result):- !, Value=Result.
coerce('Bool',Value,Result):- var(Value), !, Value=Result, freeze(Value,coerce('Bool',Value,Result)).
coerce('Bool',Value,Result):- is_list(Value),!,as_tf(call_true(Value),Result),
set_list_value(Value,Result).
   
set_list_value(Value,Result):- nb_setarg(1,Value,echo),nb_setarg(1,Value,[Result]).

%is_self_eval_l_fa('S',1). % cheat to comment

% these should get uncomented with a flag
%is_self_eval_l_fa(':',2)
% is_self_eval_l_fa('=',2).
% eval_20(Eq,RetType,Depth,Self,['quote',Eval],RetVal):- !, Eval = RetVal, check_returnval(Eq,RetType,RetVal).
is_self_eval_l_fa('quote',_).
is_self_eval_l_fa('{...}',_).
is_self_eval_l_fa('[...]',_).

self_eval(X):- notrace(self_eval0(X)).

:-  set_prolog_flag(access_level,system).
hyde(F/A):- functor(P,F,A), redefine_system_predicate(P),'$hide'(F/A), '$iso'(F/A).
:- 'hyde'(option_else/2).
:- 'hyde'(atom/1).
:- 'hyde'(quietly/1).
%:- 'hyde'(fake_notrace/1).
:- 'hyde'(var/1).
:- 'hyde'(is_list/1).
:- 'hyde'(copy_term/2).
:- 'hyde'(nonvar/1).
:- 'hyde'(quietly/1).
%:- 'hyde'(option_value/2).


is_metta_declaration([F|_]):- F == '->',!.
is_metta_declaration([F,H,_|T]):- T ==[], is_metta_declaration_f(F,H).

is_metta_declaration_f(F,H):- F == ':<', !, nonvar(H).
is_metta_declaration_f(F,H):- F == ':>', !, nonvar(H).
is_metta_declaration_f(F,H):- F == '=', !, is_list(H),  \+ (current_self(Space), is_user_defined_head_f(Space,F)).

% is_metta_declaration([F|T]):- is_list(T), is_user_defined_head([F]),!.

:- nb_setval(self_space, '&self').
evals_to(XX,Y):- Y=@=XX,!.
evals_to(XX,Y):- Y=='True',!, is_True(XX),!.

%current_self(Space):- nb_current(self_space,Space).

do_expander('=',_,X,X):-!.
do_expander(':',_,X,Y):- !, get_type(X,Y)*->X=Y.

'get_type'(Arg,Type):- 'get-type'(Arg,Type).


eval_true(X):- \+ iz_conz(X), callable(X),as_tf(X,TF),!,TF=='True'.
eval_true(X):- eval_args(X,Y), once(var(Y) ; \+ is_False(Y)).

eval_args(X,Y):- current_self(Self), eval_args(100,Self,X,Y).
eval_args(Depth,Self,X,Y):- eval_args('=',_,Depth,Self,X,Y).
eval_args(Eq,RetType,Depth,Self,X,Y):- eval(Eq,RetType,Depth,Self,X,Y).

/*
eval_args(Eq,RetTyp e,Depth,Self,X,Y):-
   locally(set_prolog_flag(gc,true),
      rtrace_on_existence_error(
     eval(Eq,RetType,Depth,Self,X,Y))).
*/


%eval(Eq,RetType,Depth,_Self,X,_Y):- forall(between(6,Depth,_),write(' ')),writeqln(eval(Eq,RetType,X)),fail.
eval(Depth,Self,X,Y):- eval('=',_RetType,Depth,Self,X,Y).


eval(_Eq,_RetType,_Dpth,_Slf,X,Y):- var(X),nonvar(Y),!,X=Y.
eval(_Eq,_RetType,_Dpth,_Slf,X,Y):- notrace(self_eval(X)),!,Y=X.
%eval(_Eq,RetType,_Depth,_Self,_X,_Y):- RetType=='%Undefined%',trace,fail.
eval(Eq,RetType,Depth,Self,X,Y):- notrace(nonvar(Y)), var(RetType), 
   once(get_type(Depth,Self,Y,RetType1)),  RetType1\=='%Undefined%', !,
   eval(Eq,RetType1,Depth,Self,X,Y).
eval(Eq,RetType,Depth,Self,X,Y):- notrace(nonvar(Y)),!,
   eval(Eq,RetType,Depth,Self,X,XX),evals_to(XX,Y).


eval(Eq,RetType,_Dpth,_Slf,[X|T],Y):- T==[], number(X),!, do_expander(Eq,RetType,X,YY),Y=[YY].

/*
eval(Eq,RetType,Depth,Self,[F|X],Y):-
  (F=='superpose' ; ( option_value(no_repeats,false))),
  fake_notrace((D1 is Depth-1)),!,
  eval(Eq,RetType,D1,Self,[F|X],Y).
*/

eval(Eq,RetType,Depth,Self,X,Y):- atom(Eq),  ( Eq \== ('='),  Eq \== ('match')) ,!,
   call(call,Eq,'=',RetType,Depth,Self,X,Y).

eval(_Eq,_RetType,_Dpth,_Slf,X,Y):- self_eval(X),!,Y=X.
eval(Eq,RetType,Depth,Self,X,Y):- eval_00(Eq,RetType,Depth,Self,X,Y).

allow_repeats_eval_(_):- !.
allow_repeats_eval_(_):- option_value(no_repeats,false),!.
allow_repeats_eval_(X):- \+ is_list(X),!,fail.
allow_repeats_eval_([F|_]):- atom(F),allow_repeats_eval_f(F).
allow_repeats_eval_f('superpose').
allow_repeats_eval_f('collapse').


:- nodebug(metta(overflow)).
eval_00(_Eq,_RetType,_Depth,_Slf,X,Y):- self_eval(X),!,X=Y.
eval_00(Eq,RetType,Depth,Self,X,YO):- eval_01(Eq,RetType,Depth,Self,X,YO).
eval_01(Eq,RetType,Depth,Self,X,YO):-
    if_t((Depth<1, trace_on_overflow), 
      (debug(metta(eval)))),
   notrace((Depth2 is Depth-1,
   copy_term(X, XX))),
   trace_eval(eval_20(Eq,RetType),e,Depth2,Self,X,M),
   (self_eval(M)-> YO=M ;
   (((M=@=XX)-> YO=M 
	  ;eval_02(Eq,RetType,Depth2,Self,M,YO)))).

eval_02(_Eq,RetType,_Depth2,_Self,Y,Y):- RetType=='Atom',!.
eval_02(Eq,RetType,Depth2,Self,Y,YO):-
  eval_01(Eq,RetType,Depth2,Self,Y,YO).




/*
eval_02(Eq,RetType,Depth2,Self,Y,YO):- 
  once(user:if_or_else((subst_args_h(Eq,RetType,Depth2,Self,Y,YO)), 
    if_or_else(finish_eval(Depth2,Self,Y,YO),
	    Y=YO))).
*/
% eval_15(Eq,RetType,Depth,Self,X,Y):- !, eval_20(Eq,RetType,Depth,Self,X,Y).

eval_15(Eq,RetType,Depth,Self,X,Y):- ((eval_20(Eq,RetType,Depth,Self,X,Y),
   if_t(var(Y),fbug((eval_20(Eq,RetType,Depth,Self,X,Y),var(Y)))),
   nonvar(Y))*->true;(eval_failed(Depth,Self,X,Y),fail)).


subst_args_h(_Eq,_RetType,Depth,Self,PredDecl,Res):- !, finish_eval(Depth,Self,PredDecl,Res).
%subst_args_h(Eq,RetType,Depth,Self,PredDecl,Res):- fail,
%  subst_args_h(Eq,RetType,Depth,Self,PredDecl,Res).





:- discontiguous eval_20/6.
:- discontiguous eval_40/6.
%:- discontiguous eval_30fz/5.
%:- discontiguous eval_31/5.
%:- discontiguous eval_defn/5.

eval_20(Eq,RetType,_Dpth,_Slf,Name,Y):-
    atom(Name), !,
      (nb_current(Name,X)->do_expander(Eq,RetType,X,Y);
       Y = Name).


eval_20(Eq,RetType,_Dpth,_Slf,X,Y):- self_eval(X),!,do_expander(Eq,RetType,X,Y).

get_operator_typedef_args(_Self,OP,_X,_ParamTypes,_RetType):- !, fail,var(OP),!,fail.
get_operator_typedef_args(Self,OP,_,ParamTypes,RetType):- symbol(OP),!,
   get_operator_typedef1(Self,OP,ParamTypes,FixRetType), fixRetType(FixRetType,RetType).
get_operator_typedef_args(Self,[OP,C],X,ParamTypes,RetType):- symbol(OP),!,
  get_operator_typedef_args(Self,OP,[C|X],ParamTypes,RetType).
   
%fixRetType(FixRetType,'Atom'):- FixRetType=='%Undefined%',!.
fixRetType(FixRetType,_RetType):- FixRetType=='%Undefined%',!.
fixRetType(FixRetType,_RetType):- FixRetType=='Any',!.
fixRetType(RetType,RetType).

% =================================================================
% =================================================================
% =================================================================
%  VAR HEADS/ NON-LISTS
% =================================================================
% =================================================================
% =================================================================

eval_20(Eq,RetType,_Dpth,_Slf,[X|T],Y):- T==[], \+ callable(X),!, do_expander(Eq,RetType,X,YY),Y=[YY].
%eval_20(Eq,RetType,_Dpth,Self,[X|T],Y):- T==[],  atom(X),
%   \+ is_user_defined_head_f(Self,X),
%   do_expander(Eq,RetType,X,YY),!,Y=[YY].

eval_20(Eq,RetType,Depth,Self,[OP|X],Y):- var(RetType),
  get_operator_typedef_args(Self,OP,X,_ParamTypes,RetType1),
  %notrace(writeqnl(get_operator_typedef_args(Self,OP,X,ParamTypes,RetType1))),
  %(RetType1 == '%Undefined%' -> trace ; true),  
  nonvar(RetType1),!,
  eval_20(Eq,RetType1,Depth,Self,[OP|X],Y).


eval_20(Eq,RetType,Depth,Self,X,Y):- atom(Eq),  ( Eq \== ('=')) ,!,
   call(Eq,'=',RetType,Depth,Self,X,Y).


eval_20(Eq,RetType,Depth,Self,[V|VI],VVO):-  \+ is_list(VI),!,
 eval(Eq,RetType,Depth,Self,VI,VM),
  ( VM\==VI -> eval(Eq,RetType,Depth,Self,[V|VM],VVO) ;
    (eval(Eq,RetType,Depth,Self,V,VV), (V\==VV -> eval(Eq,RetType,Depth,Self,[VV|VI],VVO) ; VVO = [V|VI]))).

eval_20(Eq,RetType,_Dpth,_Slf,X,Y):- \+ is_list(X),!,do_expander(Eq,RetType,X,Y).

eval_20(Eq,_RetType,Depth,Self,[V|VI],[V|VO]):- var(V),is_list(VI),!,maplist(eval(Eq,_ArgRetType,Depth,Self),VI,VO).

eval_20(_,_,_,_,['echo',Value],Value):- !.
eval_20(=,Type,_,_,['coerce',Type,Value],Result):- !, coerce(Type,Value,Result).

% =================================================================
% =================================================================
% =================================================================
%  LET/LET*
% =================================================================
% =================================================================
% =================================================================


possible_type(_Self,_Var,_RetTypeV).

let_equals(V,ER):- V=ER,!.
let_equals(V,ER):- V=~ER.

eval_20(Eq,RetType,Depth,Self,['let',V,E,Body],OO):- !, % var(V), nonvar(E), !,
		%(var(V)->true;trace),
		possible_type(Self,V,RetTypeV),
		((eval(Eq,RetTypeV,Depth,Self,E,ER), let_equals(V,ER))*->
		   eval(Eq,RetType,Depth,Self,Body,OO);
			make_empty(RetType,[], OO)).



eval_20(Eq,RetType,Depth,Self,['let*',Lets,Body],RetVal):-
	expand_let_star(Lets,Body,NewLet),!, 
		eval_20(Eq,RetType,Depth,Self,NewLet,RetVal).

eval_20(Eq,RetType,Depth,Self,['let*',[[V,E]|Lets],Body],RetVal):- !,
		eval_20(Eq,RetType,Depth,Self,['let',V,E,['let*',Lets,Body]],RetVal).


expand_let_star(Lets,Body,Body):- Lets==[],!.
expand_let_star([H|LetRest],Body,['let',V,E,NewBody]):- 
    is_list(H), H = [V,E], !,
	expand_let_star(LetRest,Body,NewBody).

eval_20(Eq,RetType,Depth,Self,X,RetVal):- 
    fail,
	once(expand_eval(X,XX)),X\==XX,!, 
		%fbug(expand_eval(X,XX)),
	    eval_20(Eq,RetType,Depth,Self,XX,RetVal).

expand_eval(X,Y):- \+ is_list(X),!, X=Y.
expand_eval([H|A],[H|AA]):- \+ ground(H),!,maplist(expand_eval,A,AA).
expand_eval(['let*',Lets,Body],NewBody):- expand_let_star(Lets,Body,NewBody),!.
expand_eval([H|A],[H|AA]):- maplist(expand_eval,A,AA).

% =================================================================
% =================================================================
% =================================================================
%  EVAL LAZY
% =================================================================
% =================================================================
% =================================================================


is_progn(C):- var(C),!,fail.
is_progn('chain-body').
is_progn('progn').

eval_20(Eq,RetType,Depth,Self,[Comma,X  ],Res):- is_progn(Comma),!, eval_args(Eq,RetType,Depth,Self,X,Res).
eval_20(Eq,RetType,Depth,Self,[Comma,X,Y],Res):- is_progn(Comma),!, eval_args(Eq,_,Depth,Self,X,_),
  eval_args(Eq,RetType,Depth,Self,Y,Res).
eval_20(Eq,RetType,Depth,Self,[Comma,X|Y],Res):- is_progn(Comma),!, eval_args(Eq,_,Depth,Self,X,_),
  eval_args(Eq,RetType,Depth,Self,[Comma|Y],Res).


eval_20(Eq,RetType,Depth,Self,[chain,X],TF):- 
   eval_args(Eq,RetType,Depth,Self,X,TF).
eval_20(Eq,RetType,Depth,Self,[chain,X|Y],TF):-  eval_args(Eq,RetType,Depth,Self,X,_), eval_args(Eq,RetType,Depth,Self,[chain|Y],TF).

eval_20(Eq,RetType,Depth,Self,['eval',X],TF):- !,
   eval_args(Eq,RetType,Depth,Self,X, TF).


eval_20(Eq,RetType,Depth,Self,['eval-for',Type,X],TF):- !,
	ignore(Type=RetType),
	eval_args(Eq,Type,Depth,Self,X, TF).


% =================================================================
% =================================================================
% =================================================================
%  LET
% =================================================================
% =================================================================
% =================================================================



eval_until_unify(_Eq,_RetType,_Dpth,_Slf,X,X):- !.
eval_until_unify(Eq,RetType,Depth,Self,X,Y):- eval_until_eq(Eq,RetType,Depth,Self,X,Y),!.

eval_until_eq(Eq,RetType,_Dpth,_Slf,X,Y):-  X=Y,check_returnval(Eq,RetType,Y).
%eval_until_eq(Eq,RetType,Depth,Self,X,Y):- var(Y),!,eval_in_steps_or_same(Eq,RetType,Depth,Self,X,XX),Y=XX.
%eval_until_eq(Eq,RetType,Depth,Self,Y,X):- var(Y),!,eval_in_steps_or_same(Eq,RetType,Depth,Self,X,XX),Y=XX.
eval_until_eq(Eq,RetType,Depth,Self,X,Y):- \+is_list(Y),!,eval_in_steps_some_change(Eq,RetType,Depth,Self,X,XX),Y=XX.
eval_until_eq(Eq,RetType,Depth,Self,Y,X):- \+is_list(Y),!,eval_in_steps_some_change(Eq,RetType,Depth,Self,X,XX),Y=XX.
eval_until_eq(Eq,RetType,Depth,Self,X,Y):- eval_in_steps_some_change(Eq,RetType,Depth,Self,X,XX),eval_until_eq(Eq,RetType,Depth,Self,Y,XX).
eval_until_eq(_Eq,_RetType,_Dpth,_Slf,X,Y):- length(X,Len), \+ length(Y,Len),!,fail.
eval_until_eq(Eq,RetType,Depth,Self,X,Y):-  nth1(N,X,EX,RX), nth1(N,Y,EY,RY),
  EX=EY,!, maplist(eval_until_eq(Eq,RetType,Depth,Self),RX,RY).
eval_until_eq(Eq,RetType,Depth,Self,X,Y):-  nth1(N,X,EX,RX), nth1(N,Y,EY,RY),
  ((var(EX);var(EY)),eval_until_eq(Eq,RetType,Depth,Self,EX,EY)),
  maplist(eval_until_eq(Eq,RetType,Depth,Self),RX,RY).
eval_until_eq(Eq,RetType,Depth,Self,X,Y):-  nth1(N,X,EX,RX), nth1(N,Y,EY,RY),
  h((is_list(EX);is_list(EY)),eval_until_eq(Eq,RetType,Depth,Self,EX,EY)),
  maplist(eval_until_eq(Eq,RetType,Depth,Self),RX,RY).

eval_1change(Eq,RetType,Depth,Self,EX,EXX):-
    eval_20(Eq,RetType,Depth,Self,EX,EXX),  EX \=@= EXX.

eval_complete_change(Eq,RetType,Depth,Self,EX,EXX):-
   eval(Eq,RetType,Depth,Self,EX,EXX),  EX \=@= EXX.

eval_in_steps_some_change(_Eq,_RetType,_Dpth,_Slf,EX,_):- \+ is_list(EX),!,fail.
eval_in_steps_some_change(Eq,RetType,Depth,Self,EX,EXX):- eval_1change(Eq,RetType,Depth,Self,EX,EXX).
eval_in_steps_some_change(Eq,RetType,Depth,Self,X,Y):- append(L,[EX|R],X),is_list(EX),
    eval_in_steps_some_change(Eq,RetType,Depth,Self,EX,EXX), EX\=@=EXX,
    append(L,[EXX|R],XX),eval_in_steps_or_same(Eq,RetType,Depth,Self,XX,Y).

eval_in_steps_or_same(Eq,RetType,Depth,Self,X,Y):-eval_in_steps_some_change(Eq,RetType,Depth,Self,X,Y).
eval_in_steps_or_same(Eq,RetType,_Dpth,_Slf,X,Y):- X=Y,check_returnval(Eq,RetType,Y).

  % (fail,make_empty(RetType,[],Template))).


possible_type(_Self,_Var,_RetTypeV).

eval_20(Eq,RetType,Depth,Self,['let',E,V,Body],OO):- var(V), nonvar(E), !,
	  %(var(V)->true;trace),
	  possible_type(Self,V,RetTypeV),
	  eval(Eq,RetTypeV,Depth,Self,E,ER), V=ER,
	  eval(Eq,RetType,Depth,Self,Body,OO).

eval_20(Eq,RetType,Depth,Self,['let',V,E,Body],OO):- !, % var(V), nonvar(E), !,
        %(var(V)->true;trace),
        possible_type(Self,V,RetTypeV),
        eval(Eq,RetTypeV,Depth,Self,E,ER), V=ER,
        eval(Eq,RetType,Depth,Self,Body,OO).
/*

eval_20(Eq,RetType,Depth,Self,['let',V,E,Body],OO):- nonvar(V),nonvar(E),!,
	possible_type(Self,V,RetTypeV),
	possible_type(Self,E,RetTypeV),
	((V=E,fail) -> true;
	(eval(Eq,RetTypeV,Depth,Self,E,ER), 
	(V=ER -> true;
	(eval(Eq,RetTypeV,Depth,Self,V,VR),
	(E=VR -> true; ER=VR))))),
	eval(Eq,RetType,Depth,Self,Body,OO).


eval_20(Eq,RetType,Depth,Self,['let',V,E,Body],OO):- var(V), nonvar(E), !,
        %(var(V)->true;trace),
        possible_type(Self,V,RetTypeV),
        eval(Eq,RetTypeV,Depth,Self,E,ER), V=ER,
        eval(Eq,RetType,Depth,Self,Body,OO).

eval_20(Eq,RetType,Depth,Self,['let',V,E,Body],OO):- var(V), var(E), !,
	  V=E, eval(Eq,RetType,Depth,Self,Body,OO).


%eval_20(Eq,RetType,Depth,Self,['let',V,E,Body],BodyO):- !,eval(Eq,RetType,Depth,Self,E,V),eval(Eq,RetType,Depth,Self,Body,BodyO).
eval_20(Eq,RetType,Depth,Self,['let*',[],Body],RetVal):- !, eval(Eq,RetType,Depth,Self,Body,RetVal).
%eval_20(Eq,RetType,Depth,Self,['let*',[[Var,Val]|LetRest],Body],RetVal):- !,
%   eval_until_unify(Eq,_RetTypeV,Depth,Self,Val,Var),
%   eval_20(Eq,RetType,Depth,Self,['let*',LetRest,Body],RetVal).
eval_20(Eq,RetType,Depth,Self,['let*',[[Var,Val]|LetRest],Body],RetVal):- !,
    eval_20(Eq,RetType,Depth,Self,['let',Var,Val,['let*',LetRest,Body]],RetVal).
*/
% =================================================================
% =================================================================
% =================================================================
%  TRACE/PRINT
% =================================================================
% =================================================================
% =================================================================

eval_20(Eq,RetType,_Dpth,_Slf,['repl!'],Y):- !,  repl,check_returnval(Eq,RetType,Y).
%eval_20(Eq,RetType,Depth,Self,['enforce',Cond],Res):- !, enforce_true(Eq,RetType,Depth,Self,Cond,Res).
eval_20(Eq,RetType,Depth,Self,['!',Cond],Res):- !, call(eval(Eq,RetType,Depth,Self,Cond,Res)).
eval_20(Eq,RetType,Depth,Self,['rtrace!',Cond],Res):- !, rtrace(eval(Eq,RetType,Depth,Self,Cond,Res)).
eval_20(Eq,RetType,Depth,Self,['notrace!',Cond],Res):- !, quietly(eval(Eq,RetType,Depth,Self,Cond,Res)).
eval_20(Eq,RetType,Depth,Self,['trace!',A,B],C):- !,
	 stream_property(S,file_no(2)),!,
	 eval(Eq,RetType,Depth,Self,A,AA),	
	 with_output_to(S,(format('~N'), write_src(AA),format('~N'))),
	 eval(Eq,RetType,Depth,Self,B,C).
eval_20(Eq,RetType,Depth,Self,['trace',Cond],Res):- !, with_debug(eval,eval(Eq,RetType,Depth,Self,Cond,Res)).
eval_20(Eq,RetType,Depth,Self,['time!',Cond],Res):- !, time_eval(eval(Cond),eval(Eq,RetType,Depth,Self,Cond,Res)).
eval_20(Eq,RetType,Depth,Self,['print',Cond],Res):- !, eval(Eq,RetType,Depth,Self,Cond,Res),format('~N'),print(Res),format('~N').
% !(println! $1)
eval_20(Eq,RetType,Depth,Self,['println!'|Cond],Res):- !, 
  maplist(eval(Eq,RetType,Depth,Self),Cond,[Res|Out]),
    format('~N'),maplist(println_impl,[Res|Out]),format('~N'),
    make_empty(RetType,Res).
eval_20(Eq,RetType,Depth,Self,['trace!',A|Cond],Res):- !, maplist(eval(Eq,RetType,Depth,Self),[A|Cond],[AA|Result]),
   last(Result,Res),
	 stream_property(S,file_no(2)),
	 with_output_to(S,(format('~N'),maplist(println_impl,[AA]),format('~N'))).


println_impl(X):- nl,with_indents(false,write_src(X)),nl.

%eval_20(Eq,RetType,_Dpth,_Slf,['trace!',A],A):- !, format('~N'),fbug(A),format('~N').

eval_20(Eq,RetType,_Dpth,_Slf,List,YY):- is_list(List),maplist(self_eval,List),List=[H|_], \+ atom(H), !,Y=List,do_expander(Eq,RetType,Y,YY).

eval_20(Eq,_ListOfRetType,Depth,Self,['TupleConcat',A,B],OO):- fail, !,
    eval(Eq,RetType,Depth,Self,A,AA),
    eval(Eq,RetType,Depth,Self,B,BB),
    append(AA,BB,OO).
eval_20(Eq,OuterRetType,Depth,Self,['range',A,B],OO):- (is_list(A);is_list(B)),
  ((eval(Eq,RetType,Depth,Self,A,AA),
    eval(Eq,RetType,Depth,Self,B,BB))),
    ((AA+BB)\=@=(A+B)),
    eval_20(Eq,OuterRetType,Depth,Self,['range',AA,BB],OO),!.


%eval_20(Eq,RetType,Depth,Self,['colapse'|List], Flat):- !, maplist(eval(Eq,RetType,Depth,Self),List,Res),flatten(Res,Flat).

eval_20(_Eq,_OuterRetType,_Depth,_Self,[P,_,B],_):-P=='/',B==0,!,fail.


% =================================================================
% =================================================================
% =================================================================
%  UNIT TESTING/assert<STAR>
% =================================================================
% =================================================================
% =================================================================


eval_20(Eq,RetType,Depth,Self,['assertTrue', X],TF):- !, eval(Eq,RetType,Depth,Self,['assertEqual',X,'True'],TF).
eval_20(Eq,RetType,Depth,Self,['assertFalse',X],TF):- !, eval(Eq,RetType,Depth,Self,['assertEqual',X,'False'],TF).

eval_20(Eq,RetType,Depth,Self,['assertEqual',X,Y],RetVal):- !,
   loonit_assert_source_tf(
        ['assertEqual',X,Y],
        (bagof_eval(Eq,RetType,Depth,Self,X,XX), bagof_eval(Eq,RetType,Depth,Self,Y,YY)),
         equal_enough_for_test(XX,YY), TF),
  (TF=='True'->make_empty(RetType,RetVal);RetVal=['Error'(XX,expected(YY))]).

eval_20(Eq,RetType,Depth,Self,['assertNotEqual',X,Y],RetVal):- !,
   loonit_assert_source_tf(
        ['assertEqual',X,Y],
        (bagof_eval(Eq,RetType,Depth,Self,X,XX), bagof_eval(Eq,RetType,Depth,Self,Y,YY)),
         ( \+ equal_enough(XX,YY)), TF),
  (TF=='True'->make_empty(RetType,RetVal);RetVal=['Error'(XX,expected(YY))]).

eval_20(Eq,RetType,Depth,Self,['assertEqualToResult',X,Y],RetVal):- !,
   loonit_assert_source_tf(
        ['assertEqualToResult',X,Y],
        (bagof_eval(Eq,RetType,Depth,Self,X,XX), =(Y,YY)),
         equal_enough_for_test(XX,YY), TF),
  (TF=='True'->make_empty(RetType,RetVal);RetVal=['Error'(XX,expected(YY))]).


loonit_assert_source_tf(_Src,Goal,Check,TF):- \+ is_testing,!,
    reset_eval_num,
    call(Goal),
    as_tf(Check,TF),!.

loonit_assert_source_tf(Src,Goal,Check,TF):-
    copy_term(Goal,OrigGoal),
    reset_eval_num,
   loonit_asserts(Src, time_eval('\n; EVAL TEST\n;',Goal), Check),
   as_tf(Check,TF),!,
  ignore((
          once((TF='True', trace_on_pass);(TF='False', trace_on_fail)),
     with_debug(metta(eval),time_eval('Trace',OrigGoal)))).

sort_result(Res,Res):- \+ compound(Res),!.
sort_result([And|Res1],Res):- is_and(And),!,sort_result(Res1,Res).
sort_result([T,And|Res1],Res):- is_and(And),!,sort_result([T|Res1],Res).
sort_result([H|T],[HH|TT]):- !, sort_result(H,HH),sort_result(T,TT).
sort_result(Res,Res).

unify_enough(L,L).
unify_enough(L,C):- into_list_args(L,LL),into_list_args(C,CC),unify_lists(CC,LL).

%unify_lists(C,L):- \+ compound(C),!,L=C.
%unify_lists(L,C):- \+ compound(C),!,L=C.
unify_lists(L,L):-!.
unify_lists([C|CC],[L|LL]):- unify_enough(L,C),!,unify_lists(CC,LL).

%s_empty(X):- var(X),!.
s_empty(X):- var(X),!,fail.
is_empty('Empty').
is_empty([]).
is_empty([X]):-!,is_empty(X).
has_let_star(Y):- sub_var('let*',Y).


% !(pragma! unit-tests tollerant) ; tollerant or exact
is_tollerant:- \+ option_value('unit-tests','exact').

equal_enough_for_test(X,Y):- equal_enough_for_test1(X,Y),!.

equal_enough_for_test1(X,Y):- is_empty(X),!,is_empty(Y).
equal_enough_for_test1(X,Y):- has_let_star(Y),!,\+ is_empty(X).
equal_enough_for_test1(X,Y):- must_det_ll((subst_vars(X,XX),subst_vars(Y,YY))),!,equal_enough_for_test2(XX,YY),!.
equal_enough_for_test2(X,Y):- equal_enough(X,Y).

equal_enough(R,V):- copy_term(R,RR),copy_term(V,VV),equal_enough1(R,V),!,R=@=RR,V=@=VV.
equal_enough(R,V):- is_list(R),is_list(V),sort(R,RR),sort(V,VV),!,equal_enouf(RR,VV),!.
equal_enough(R,V):- copy_term(R,RR),copy_term(V,VV),equal_enouf(R,V),!,R=@=RR,V=@=VV.

equal_enough1(R,V):- 
  is_list(R),is_list(V),sort(R,RR),sort(V,VV),!,
  always_remove_nils(RR,RRR), always_remove_nils(VV,VVV),
  equal_enouf(RRR,VVV),!.
equal_enough1(R,V):- equal_enouf(R,V),!.

equal_enouf(R,V):- is_ftVar(R), is_ftVar(V), R=V,!.
equal_enouf(X,Y):- is_empty(X),!,is_empty(Y).
equal_enouf(X,Y):- symbol(X),symbol(Y),atom_concat('&',_,X),atom_concat('Grounding',_,Y).
equal_enouf(R,V):- R=@=V, R=V, !.
equal_enouf(_,V):- V=@='...',!.
equal_enouf(L,C):- is_tollerant, is_list(L),is_list(C), 
	 maybe_remove_nils(C,CC),equal_enouf(L,CC).

equal_enouf(L,C):- is_list(L),into_list_args(C,CC),!,equal_enouf_l(CC,L).
equal_enouf(C,L):- is_list(L),into_list_args(C,CC),!,equal_enouf_l(CC,L).
%equal_enouf(R,V):- (var(R),var(V)),!, R=V.
equal_enouf(R,V):- (var(R);var(V)),!, R==V.
equal_enouf(R,V):- number(R),number(V),!, RV is abs(R-V), RV < 0.03 .
equal_enouf(R,V):- atom(R),!,atom(V), has_unicode(R),has_unicode(V).
equal_enouf(R,V):- (\+ compound(R) ; \+ compound(V)),!, R==V.
equal_enouf(L,C):- into_list_args(L,LL),into_list_args(C,CC),!,equal_enouf_l(CC,LL).

equal_enouf_l([S1,V1|_],[S2,V2|_]):- S1 == 'State',S2 == 'State',!, equal_enouf(V1,V2).
equal_enouf_l(C,L):- \+ compound(C),!,L=@=C.
equal_enouf_l(L,C):- \+ compound(C),!,L=@=C.
equal_enouf_l([C|CC],[L|LL]):- !, equal_enouf(L,C),!,equal_enouf_l(CC,LL).

maybe_remove_nils(I,O):- always_remove_nils(I,O),!,I\=@=O.
always_remove_nils(I,O):- \+ compound(I),!,I=O.
always_remove_nils([H|T], TT):- H==[],!, always_remove_nils(T,TT). 
always_remove_nils([H|T], TT):- H=='Empty',!, always_remove_nils(T,TT). 
always_remove_nils([H|T],[H|TT]):- always_remove_nils(T,TT). 

has_unicode(A):- atom_codes(A,Cs),member(N,Cs),N>127,!.

set_last_error(_).

% =================================================================
% =================================================================
% =================================================================
%  SPACE EDITING
% =================================================================
% =================================================================
% =================================================================

eval_20(Eq,RetType,_Dpth,_Slf,['new-space'],Space):- !, 'new-space'(Space),check_returnval(Eq,RetType,Space).

eval_20(Eq,RetType,Depth,Self,[Op,Space|Args],Res):- is_space_op(Op),!,
  eval_space_start(Eq,RetType,Depth,Self,[Op,Space|Args],Res).

eval_space_start(Eq,RetType,_Depth,_Self,[_Op,_Other,Atom],Res):-
  (Atom == [] ;  Atom =='Empty';  Atom =='Nil'),!,
  make_empty(RetType,'False',Res),check_returnval(Eq,RetType,Res).

eval_space_start(Eq,RetType,Depth,Self,[Op,Other|Args],Res):-
  into_space(Depth,Self,Other,Space),
  eval_space(Eq,RetType,Depth,Self,[Op,Space|Args],Res).


eval_space(Eq,RetType,_Dpth,_Slf,['add-atom',Space,PredDecl],Res):- !,
   do_metta(python,load,Space,PredDecl,TF),make_empty(RetType,TF,Res),check_returnval(Eq,RetType,Res).

eval_space(Eq,RetType,_Dpth,_Slf,['remove-atom',Space,PredDecl],Res):- !,
   do_metta(python,unload,Space,PredDecl,TF),make_empty(RetType,TF,Res),check_returnval(Eq,RetType,Res).

eval_space(Eq,RetType,_Dpth,_Slf,['atom-count',Space],Count):- !,
    ignore(RetType='Number'),ignore(Eq='='),
	'atom-count'(Space, Count).
    %findall(Atom, metta_atom(Space, Atom),Atoms),
    %length(Atoms,Count).

eval_space(Eq,RetType,_Dpth,_Slf,['atom-replace',Space,Rem,Add],TF):- !,
   copy_term(Rem,RCopy), as_tf((metta_atom_iter_ref(Space,RCopy,Ref), RCopy=@=Rem,erase(Ref), do_metta(Space,load,Add)),TF),
 check_returnval(Eq,RetType,TF).

eval_space(Eq,RetType,_Dpth,_Slf,['get-atoms',Space],Atom):- !,
  ignore(RetType='Atom'),!, 
  metta_atom(Space, Atom), 
  check_returnval(Eq,RetType,Atom).

% Match-ELSE
eval_space(Eq,RetType,Depth,Self,['match',Other,Goal,Template,Else],Template):- !,
  ((eval_space(Eq,RetType,Depth,Self,['match',Other,Goal,Template],Template),
       \+ make_empty(RetType,[],Template))*->true;Template=Else).
% Match-TEMPLATE

eval_space(Eq,RetType,Depth,Self,['match',Other,Goal,Template],Res):- !,
   metta_atom_iter(Eq,Depth,Self,Other,Goal),   
   Depth2 is Depth-1,
   (eval(Eq,RetType,Depth2,Self,Template,Res)*->true;Template=Res).
   

%metta_atom_iter(Eq,_Depth,_Slf,Other,[Equal,[F|H],B]):- Eq == Equal,!,  % trace,
%   metta_defn(Eq,Other,[F|H],B).

/*
metta_atom_iter(Eq,Depth,Self,Other,[Equal,[F|H],B]):- Eq == Equal,!,  % trace,
   metta_defn(Eq,Other,[F|H],BB),
   eval_sometimes(Eq,_RetType,Depth,Self,B,BB).
*/

metta_atom_iter(_Eq,Depth,_,_,_):- Depth<3,!,fail.
metta_atom_iter(Eq,Depth,Self,Other,[And|Y]):- atom(And), is_comma(And),!,
  (Y==[] -> true ;
    ( D2 is Depth -1, Y = [H|T],
       metta_atom_iter(Eq,D2,Self,Other,H),metta_atom_iter(Eq,D2,Self,Other,[And|T]))).
metta_atom_iter(_Eq,_Depth,_Slf,Other,X):- dcall0000000000(metta_atom(Other,X)).

%metta_atom_iter(Eq,Depth,_Slf,Other,X):- dcall0000000000(eval_args_true(Eq,_RetType,Depth,Other,X)).
 % dcall0000000000(metta_atom_true(Eq,_RetType,Depth,Other,XX)), X=XX.

/*
eval_args_true_r(Eq,RetType,Depth,Self,X,TF1):-
  ((eval_ne(Eq,RetType,Depth,Self,X,TF1),  \+  is_False(TF1));
     ( \+  is_False(TF1),metta_atom_true(Eq,Depth,Self,Self,X))).

*/
eval_args_true(Eq,RetType,Depth,Self,X):-
   (nonvar(X),eval_ne(Eq,RetType,Depth,Self,X,TF1),  \+  is_False(TF1)).

metta_atom_true(Eq,_Dpth,_Slf,Other,H):-
	  can_be_ok(metta_atom_true,H), 
	  metta_atom(Other,H).
% is this OK?
%metta_atom_true(Eq,Depth,Self,Other,H):- nonvar(H), metta_defn(Eq,Other,H,B), D2 is Depth -1, eval_args_true(Eq,_,D2,Self,B).
% is this OK?
%metta_atom_true(Eq,Depth,Self,Other,H):- Other\==Self, nonvar(H), metta_defn(Eq,Other,H,B), D2 is Depth -1, eval_args_true(Eq,_,D2,Other,B).



metta_atom_iter_ref(Other,H,Ref):-clause(metta_atom_asserted(Other,H),true,Ref).
can_be_ok(A,B):- cant_be_ok(A,B),!,fbug(cant_be_ok(A,B)),trace.
can_be_ok(_,_).

cant_be_ok(_,[Let|_]):- Let==let.
% =================================================================
% =================================================================
% =================================================================
%  CASE/SWITCH
% =================================================================
% =================================================================
% =================================================================
% Macro: case
:- nodebug(metta(case)).

eval_20(Eq,RetType,Depth,Self,[P,X|More],YY):- is_list(X),X=[_,_,_],simple_math(X),
   eval_selfless_2(X,XX),X\=@=XX,!, eval_20(Eq,RetType,Depth,Self,[P,XX|More],YY).
% if there is only a void then always return nothing for each Case
eval_20(Eq,_RetType,Depth,Self,['case',A,[[Void,_]]],Res):-
   '%void%' == Void,
   eval(Eq,_UnkRetType,Depth,Self,A,_),!,Res =[].

% if there is nothing for case just treat like a collapse
eval_20(Eq,RetType,Depth,Self,['case',A,[]],Empty):- !,
  %forall(eval(Eq,_RetType2,Depth,Self,Expr,_),true),
  once(eval(Eq,_RetType2,Depth,Self,A,_)),
  make_empty(RetType,[],Empty).

% Macro: case
eval_20(Eq,RetType,Depth,Self,['case',A,CL|T],Res):- !,
   must_det_ll(T==[]),
   into_case_list(CL,CASES),
   findall(Key-Value,
     (nth0(Nth,CASES,Case0),
       (is_case(Key,Case0,Value),
        if_trace(metta(case),(format('~N'),writeqln(c(Nth,Key)=Value))))),KVs),!,
   eval_case(Eq,RetType,Depth,Self,A,KVs,Res).

eval_case(Eq,CaseRetType,Depth,Self,A,KVs,Res):-
   ((eval(Eq,_UnkRetType,Depth,Self,A,AA),
         if_trace((case),(writeqln('case'=A))),
         if_trace(metta(case),writeqln('switch'=AA)),
    (select_case(Depth,Self,AA,KVs,Value)->true;(member(Void -Value,KVs),Void=='%void%')))
     *->true;(member(Void -Value,KVs),Void=='%void%')),
    eval(Eq,CaseRetType,Depth,Self,Value,Res).

  select_case(Depth,Self,AA,Cases,Value):-
     (best_key(AA,Cases,Value) -> true ;
      (maybe_special_keys(Depth,Self,Cases,CasES),
       (best_key(AA,CasES,Value) -> true ;
        (member(Void -Value,CasES),Void=='%void%')))).

  best_key(AA,Cases,Value):-
     ((member(Match-Value,Cases),AA ==Match)->true;
      ((member(Match-Value,Cases),AA=@=Match)->true;
        (member(Match-Value,Cases),AA = Match))).

	into_case_list(CASES,CASES):- is_list(CASES),!.
		is_case(AA,[AA,Value],Value):-!.
		is_case(AA,[AA|Value],Value).

   maybe_special_keys(Depth,Self,[K-V|KVI],[AK-V|KVO]):-
     eval(Depth,Self,K,AK), K\=@=AK,!,
     maybe_special_keys(Depth,Self,KVI,KVO).
   maybe_special_keys(Depth,Self,[_|KVI],KVO):-
     maybe_special_keys(Depth,Self,KVI,KVO).
   maybe_special_keys(_Depth,_Self,[],[]).


% =================================================================
% =================================================================
% =================================================================
%  COLLAPSE/SUPERPOSE
% =================================================================
% =================================================================
% =================================================================



%[collapse,[1,2,3]]
eval_20(Eq,RetType,Depth,Self,['collapse',List],Res):-!,
 bagof_eval(Eq,RetType,Depth,Self,List,Res).

eval_20(Eq,RetType,Depth,Self,PredDecl,Res):-
  Do_more_defs = do_more_defs(true),
  clause(eval_21(Eq,RetType,Depth,Self,PredDecl,Res),Body),
  Do_more_defs == do_more_defs(true),
  call_ndet(Body,DET),
  nb_setarg(1,Do_more_defs,false),
 (DET==true -> ! ; true).

eval_21(_Eq,_RetType,_Depth,_Self,['fb-member',Res,List],TF):-!, as_tf(fb_member(Res,List),TF).
eval_21(_Eq,_RetType,_Depth,_Self,['fb-member',List],Res):-!, fb_member(Res,List).


eval_21(Eq,RetType,Depth,Self,['CollapseCardinality',List],Len):-!,
 bagof_eval(Eq,RetType,Depth,Self,List,Res),
 length(Res,Len).
/*
eval_21(_Eq,_RetType,_Depth,_Self,['TupleCount', [N]],N):- number(N),!.


*/
eval_21(Eq,_RetType,Depth,Self,['Tuple-Count',List],Len):-!,
 (\+ is_list(List)->bagof_eval(Eq,_,Depth,Self,List,Res);Res=List),!,
 length(Res,Len).
eval_21(_Eq,_RetType,_Depth,_Self,['tuple-count',List],Len):-!,
 length(List,Len).


%[superpose,[1,2,3]]
eval_20(_Eq,RetType,_Depth,_Self,['superpose',List],Res):- List==[], !,
  make_empty(RetType,[],Res).
  

eval_20(Eq,RetType,Depth,Self,['superpose',List],Res):- !,
  (((is_user_defined_head(Eq,Self,List) ,eval(Eq,RetType,Depth,Self,List,UList), List\=@=UList)
    *->  eval_20(Eq,RetType,Depth,Self,['superpose',UList],Res)
       ; ((member(E,List),eval(Eq,RetType,Depth,Self,E,Res))*->true;make_empty(RetType,[],Res)))),
  \+ Res = 'Empty'.

%[sequential,[1,2,3]]
eval_20(Eq,RetType,Depth,Self,['sequential',List],Res):- !,
  (((fail,is_user_defined_head(Eq,Self,List) ,eval(Eq,RetType,Depth,Self,List,UList), List\=@=UList)
    *->  eval_20(Eq,RetType,Depth,Self,['sequential',UList],Res)
       ; ((member(E,List),eval_ne(Eq,RetType,Depth,Self,E,Res))*->true;make_empty(RetType,[],Res)))).


get_sa_p1(P3,E,Cmpd,SA):-  compound(Cmpd), get_sa_p2(P3,E,Cmpd,SA).
get_sa_p2(P3,E,Cmpd,call(P3,N1,Cmpd)):- arg(N1,Cmpd,E).
get_sa_p2(P3,E,Cmpd,SA):- arg(_,Cmpd,Arg),get_sa_p1(P3,E,Arg,SA).
eval20_failed(Eq,RetType,Depth,Self, Term, Res):-
  fake_notrace(( get_sa_p1(setarg,ST,Term,P1), % ST\==Term,
   compound(ST), ST = [F,List],F=='superpose',nonvar(List), %maplist(atomic,List),
   call(P1,Var))), !,
   %max_counting(F,20),
   member(Var,List),
   eval(Eq,RetType,Depth,Self, Term, Res).


sub_sterm(Sub,Sub).
sub_sterm(Sub,Term):- sub_sterm1(Sub,Term).
sub_sterm1(_  ,List):- \+ compound(List),!,fail.
sub_sterm1(Sub,List):- is_list(List),!,member(SL,List),sub_sterm(Sub,SL).
sub_sterm1(_  ,[_|_]):-!,fail.
sub_sterm1(Sub,Term):- arg(_,Term,SL),sub_sterm(Sub,SL).
eval20_failed_2(Eq,RetType,Depth,Self, Term, Res):-
   fake_notrace(( get_sa_p1(setarg,ST,Term,P1),
   compound(ST), ST = [F,List],F=='collapse',nonvar(List), %maplist(atomic,List),
   call(P1,Var))), !, bagof_eval(Eq,RetType,Depth,Self,List,Var),
   eval(Eq,RetType,Depth,Self, Term, Res).


% =================================================================
% =================================================================
% =================================================================
%  NOP/EQUALITU/DO
% =================================================================
% =================================================================
% ================================================================
eval_20(_Eq,_RetType,_Depth,_Self,['nop'],                 _ ):- !, fail.
eval_20(_Eq,_RetType,_Depth,_Self,['empty'],                 _ ):- !, fail.
eval_20(_Eq,RetType,Depth,Self,['nop',Expr], Empty):- !,
  ignore(eval('=',_RetType2,Depth,Self,Expr,_)),
  make_empty(RetType,[], Empty).

eval_20(Eq,RetType,Depth,Self,['do-all',Expr], Empty):- !,
	 forall(eval(Eq,_RetType2,Depth,Self,Expr,_),true),
	 %eval_ne(Eq,_RetType2,Depth,Self,Expr,_),!,
	 make_empty(RetType,[],Empty).
% should this be calling backtracking on the first success?
eval_20(Eq,RetType,Depth,Self,['do',Expr], Empty):- !,
	forall(eval(Eq,_RetType2,Depth,Self,Expr,_),true),
	make_empty(RetType,[],Empty).

eval_20(_Eq,_RetType1,_Depth,_Self,['call!',S], TF):- !, eval_call(S,TF).
eval_20(_Eq,_RetType1,_Depth,_Self,['call-fn!',S], R):- !, eval_call_fn(S,R).

max_counting(F,Max):- flag(F,X,X+1),  X<Max ->  true; (flag(F,_,10),!,fail).
% =================================================================
% =================================================================
% =================================================================
%  if/If
% =================================================================
% =================================================================
% =================================================================



eval_20(Eq,RetType,Depth,Self,['if',Cond,Then,Else],Res):- !,
   eval(Eq,'Bool',Depth,Self,Cond,TF),
   (is_True(TF)
     -> eval(Eq,RetType,Depth,Self,Then,Res)
     ;  eval(Eq,RetType,Depth,Self,Else,Res)).

eval_20(Eq,RetType,Depth,Self,['If',Cond,Then,Else],Res):- !,
   eval(Eq,'Bool',Depth,Self,Cond,TF),
   (is_True(TF)
     -> eval(Eq,RetType,Depth,Self,Then,Res)
     ;  eval(Eq,RetType,Depth,Self,Else,Res)).

eval_20(Eq,RetType,Depth,Self,['If',Cond,Then],Res):- !,
   eval(Eq,'Bool',Depth,Self,Cond,TF),
   (is_True(TF) -> eval(Eq,RetType,Depth,Self,Then,Res) ;
      (!, fail,Res = [],!)).

eval_20(Eq,RetType,Depth,Self,['if',Cond,Then],Res):- !,
   eval(Eq,'Bool',Depth,Self,Cond,TF),
   (is_True(TF) -> eval(Eq,RetType,Depth,Self,Then,Res) ;
      (!, fail,Res = [],!)).


eval_20(Eq,RetType,_Dpth,_Slf,[_,Nothing],NothingO):-
   'Nothing'==Nothing,!,do_expander(Eq,RetType,Nothing,NothingO).


% =================================================================
% =================================================================
% =================================================================
%  CONS/CAR/CDR
% =================================================================
% =================================================================
% =================================================================



into_pl_list(Var,Var):- var(Var),!.
into_pl_list(Nil,[]):- Nil == 'Nil',!.
into_pl_list([Cons,H,T],[HH|TT]):- Cons == 'Cons', !, into_pl_list(H,HH),into_pl_list(T,TT),!.
into_pl_list(X,X).

into_metta_cons(Var,Var):- var(Var),!.
into_metta_cons([],'Nil'):-!.
into_metta_cons([Cons, A, B ],['Cons', AA, BB]):- 'Cons'==Cons, no_cons_reduce, !,
  into_metta_cons(A,AA), into_metta_cons(B,BB).
into_metta_cons([H|T],['Cons',HH,TT]):- into_metta_cons(H,HH),into_metta_cons(T,TT),!.
into_metta_cons(X,X).

into_listoid(AtomC,Atom):- AtomC = [Cons,H,T],Cons=='Cons',!, Atom=[H,[T]].
into_listoid(AtomC,Atom):- is_list(AtomC),!,Atom=AtomC.
into_listoid(AtomC,Atom):- typed_list(AtomC,_,Atom),!.

:- if( \+  current_predicate( typed_list / 3 )).
typed_list(Cmpd,Type,List):-  compound(Cmpd), Cmpd\=[_|_], compound_name_arguments(Cmpd,Type,[List|_]),is_list(List).
:- endif.

%eval_20(Eq,RetType,Depth,Self,['colapse'|List], Flat):- !, maplist(eval(Eq,RetType,Depth,Self),List,Res),flatten(Res,Flat).

%eval_20(Eq,RetType,Depth,Self,['flatten'|List], Flat):- !, maplist(eval(Eq,RetType,Depth,Self),List,Res),flatten(Res,Flat).


eval_20(Eq,RetType,_Dpth,_Slf,['car-atom',Atom],CAR_Y):- !, Atom=[CAR|_],!,do_expander(Eq,RetType,CAR,CAR_Y).
eval_20(Eq,RetType,_Dpth,_Slf,['cdr-atom',Atom],CDR_Y):- !, Atom=[_|CDR],!,do_expander(Eq,RetType,CDR,CDR_Y).

eval_20(Eq,RetType,Depth,Self,['Cons', A, B ],['Cons', AA, BB]):- no_cons_reduce, !,
 eval(Eq,RetType,Depth,Self,A,AA), eval(Eq,RetType,Depth,Self,B,BB).

%eval_20(_Eq,_RetType,Depth,Self,['::'|PL],Prolog):-  maplist(as_prolog(Depth,Self),PL,Prolog),!.
%eval_20(_Eq,_RetType,Depth,Self,['@'|PL],Prolog):- as_prolog(Depth,Self,['@'|PL],Prolog),!.

eval_20(Eq,RetType,Depth,Self,['Cons', A, B ],[AA|BB]):- \+ no_cons_reduce, !,
   eval(Eq,RetType,Depth,Self,A,AA), eval(Eq,RetType,Depth,Self,B,BB).



% =================================================================
% =================================================================
% =================================================================
%  STATE EDITING
% =================================================================
% =================================================================
% =================================================================

eval_20(Eq,RetType,Depth,Self,['change-state!',StateExpr, UpdatedValue], Ret):- !,
 call_in_shared_space(((eval(Eq,RetType,Depth,Self,StateExpr,StateMonad),
  eval(Eq,RetType,Depth,Self,UpdatedValue,Value),  'change-state!'(Depth,Self,StateMonad, Value, Ret)))).
eval_20(Eq,RetType,Depth,Self,['new-state',UpdatedValue],StateMonad):- !,
  call_in_shared_space(((eval(Eq,RetType,Depth,Self,UpdatedValue,Value),  'new-state'(Depth,Self,Value,StateMonad)))).
eval_20(Eq,RetType,Depth,Self,['get-state',StateExpr],Value):- !,
  call_in_shared_space((eval(Eq,RetType,Depth,Self,StateExpr,StateMonad), 'get-state'(StateMonad,Value))).

call_in_shared_space(G):- call_in_thread(main,G).

% eval_20(Eq,RetType,Depth,Self,['get-state',Expr],Value):- !, eval(Eq,RetType,Depth,Self,Expr,State), arg(1,State,Value).



check_type:- option_else(typecheck,TF,'False'), TF=='True'.

:- dynamic is_registered_state/1.
:- flush_output.
:- setenv('RUST_BACKTRACE',full).

% Function to check if an value is registered as a state name
:- dynamic(is_registered_state/1).
is_nb_state(G):- is_valid_nb_state(G) -> true ;
                 is_registered_state(G),nb_current(G,S),is_valid_nb_state(S).


:- multifile(state_type_method/3).
:- dynamic(state_type_method/3).
state_type_method(is_nb_state,new_state,init_state).
state_type_method(is_nb_state,clear_state,clear_nb_values).
state_type_method(is_nb_state,add_value,add_nb_value).
state_type_method(is_nb_state,remove_value,'change-state!').
state_type_method(is_nb_state,replace_value,replace_nb_value).
state_type_method(is_nb_state,value_count,value_nb_count).
state_type_method(is_nb_state,'get-state','get-state').
state_type_method(is_nb_state,value_iter,value_nb_iter).
%state_type_method(is_nb_state,query,state_nb_query).

% Clear all values from a state
clear_nb_values(StateNameOrInstance) :-
    fetch_or_create_state(StateNameOrInstance, State),
    nb_setarg(1, State, []).



% Function to confirm if a term represents a state
is_valid_nb_state(State):- compound(State),compound_name_arity(State,'State',N),N>0.

% Find the original name of a given state
state_original_name(State, Name) :-
    is_registered_state(Name),
    call_in_shared_space(nb_current(Name, State)).

% Register and initialize a new state
init_state(Name) :-
    State = 'State'(_,_),
    asserta(is_registered_state(Name)),
    call_in_shared_space(nb_setval(Name, State)).

% Change a value in a state
'change-state!'(Depth,Self,StateNameOrInstance, UpdatedValue, Out) :-
    fetch_or_create_state(StateNameOrInstance, State),
    arg(2, State, Type),
    ( (check_type,\+ get_type(Depth,Self,UpdatedValue,Type))
     -> (Out = ['Error', UpdatedValue, 'BadType'])
     ; (nb_setarg(1, State, UpdatedValue), Out = State) ).

% Fetch all values from a state
'get-state'(StateNameOrInstance, Values) :-
    fetch_or_create_state(StateNameOrInstance, State),
    arg(1, State, Values).

'new-state'(Depth,Self,Init,'State'(Init, Type)):- check_type->get_type(Depth,Self,Init,Type);true.

'new-state'(Init,'State'(Init, Type)):- check_type->get_type(10,'&self',Init,Type);true.

fetch_or_create_state(Name):- fetch_or_create_state(Name,_).
% Fetch an existing state or create a new one

fetch_or_create_state(State, State) :- is_valid_nb_state(State),!.
fetch_or_create_state(NameOrInstance, State) :-
    (   atom(NameOrInstance)
    ->  (is_registered_state(NameOrInstance)
        ->  nb_current(NameOrInstance, State)
        ;   init_state(NameOrInstance),
            nb_current(NameOrInstance, State))
    ;   is_valid_nb_state(NameOrInstance)
    ->  State = NameOrInstance
    ;   writeln('Error: Invalid input.')
    ),
    is_valid_nb_state(State).

% =================================================================
% =================================================================
% =================================================================
%  GET-TYPE
% =================================================================
% =================================================================
% =================================================================

eval_20(Eq,RetType,Depth,Self,['get-type',Val],TypeO):- !,
  eval_get_type(Eq,RetType,Depth,Self,Val,TypeO).

not_well_typed(Eq,RetType,Depth,Self,[H|Args]):-
  metta_type(Eq,H,[Ar|ArgTypes]),Ar=='->',
  \+ maplist(not_arg_violation(Depth,Self),Args,ArgTypes).


eval_get_type(Eq,RetType,Depth,Self,Val,TypeO):- 
  not_well_typed(Eq,RetType,Depth,Self,Val), !,  TypeO=[].

eval_get_type(Eq,RetType,Depth,Self,Val,TypeO):- 
  get_type(Depth,Self,Val,Type),
  term_singletons(Type,[]),
  Type\==[], Type\==Val,!,
  do_expander(Eq,RetType,Type,TypeO).



eval_20(Eq,RetType,Depth,Self,['length',L],Res):- !, eval(Eq,RetType,Depth,Self,L,LL), !, (is_list(LL)->length(LL,Res);Res=1).
eval_20(Eq,RetType,Depth,Self,['CountElement',L],Res):- !, eval(Eq,RetType,Depth,Self,L,LL), !, (is_list(LL)->length(LL,Res);Res=1).

eval_20(_Eq,_RetType,_Depth,_Self,['get-metatype',Val],TypeO):- !,
  get_metatype(Val,TypeO).

get_metatype(Val,Want):- get_metatype0(Val,Was),!,Want=Was.
	get_metatype0(Val,'Variable'):- var(Val),!.
	get_metatype0(Val,'Symbol'):- symbol(Val),!.
	get_metatype0(Val,'Expression'):- is_list(Val),!.
	get_metatype0(_Val,'Grounded').

% =================================================================
% =================================================================
% =================================================================
%  IMPORT/BIND
% =================================================================
% =================================================================
% =================================================================
nb_bind(Name,Value):- nb_current(Name,Was),same_term(Value,Was),!.
nb_bind(Name,Value):- call_in_shared_space(nb_setval(Name,Value)),!.
eval_20(_Eq,_RetType,_Dpth,_Slf,['extend-py!',Module],Res):-  !, 'extend-py!'(Module,Res).
eval_20(Eq,RetType,Depth,Self,['import!',Other,File],RetVal):- !,
	 (( into_space(Depth,Self,Other,Space), import_metta(Space,File),!,make_empty(RetType,Space,RetVal))),
	 check_returnval(Eq,RetType,RetVal). %RetVal=[].
eval_20(Eq,RetType,Depth,Self,['include!',Other,File],RetVal):- !,
	 (( into_space(Depth,Self,Other,Space), include_metta(Space,File),!,make_empty(RetType,Space,RetVal))),
	 check_returnval(Eq,RetType,RetVal). %RetVal=[].
eval_20(Eq,RetType,Depth,Self,['load-ascii',Other,File],RetVal):- !,
	 (( into_space(Depth,Self,Other,Space), include_metta(Space,File),!,make_empty(RetType,Space,RetVal))),
	 check_returnval(Eq,RetType,RetVal). %RetVal=[].
eval_20(Eq,RetType,_Depth,_Slf,['bind!',Other,['new-space']],RetVal):- atom(Other),!,assert(was_asserted_space(Other)),
  make_empty(RetType,[],RetVal), check_returnval(Eq,RetType,RetVal).
eval_20(Eq,RetType,Depth,Self,['bind!',Other,Expr],RetVal):- !,
   must_det_ll((into_name(Self,Other,Name),!,eval(Eq,RetType,Depth,Self,Expr,Value),
    nb_bind(Name,Value),  make_empty(RetType,Value,RetVal))),
   check_returnval(Eq,RetType,RetVal).
eval_20(Eq,RetType,Depth,Self,['pragma!',Other,Expr],RetVal):- !,
   must_det_ll((into_name(Self,Other,Name),nd_ignore((eval(Eq,RetType,Depth,Self,Expr,Value),
   set_option_value_interp(Name,Value))),  make_empty(RetType,Value,RetVal),
    check_returnval(Eq,RetType,RetVal))).
eval_20(Eq,RetType,_Dpth,Self,['transfer!',File],RetVal):- !, must_det_ll((include_metta(Self,File),
   make_empty(RetType,Self,RetVal),check_returnval(Eq,RetType,RetVal))).


fromNumber(Var1,Var2):- var(Var1),var(Var2),!,
   freeze(Var1,fromNumber(Var1,Var2)),
   freeze(Var2,fromNumber(Var1,Var2)).
fromNumber(0,'Z'):-!.
fromNumber(N,['S',Nat]):- integer(N), M is N -1,!,fromNumber(M,Nat).

eval_20(Eq,RetType,Depth,Self,['fromNumber',NE],RetVal):- !,
   eval('=','Number',Depth,Self,NE,N),
	fromNumber(N,RetVal), check_returnval(Eq,RetType,RetVal).

eval_20(Eq,RetType,Depth,Self,['dedup!',Eval],RetVal):- !,
   term_variables(Eval+RetVal,Vars),
   no_repeats_var(YY),!,
   eval_20(Eq,RetType,Depth,Self,Eval,RetVal),YY=Vars.


nd_ignore(Goal):- call(Goal)*->true;true.









% =================================================================
% =================================================================
% =================================================================
%  AND/OR
% =================================================================
% =================================================================
% =================================================================

is_True(T):- atomic(T), T\=='False', T\==0.

is_and(S):- \+ atom(S),!,fail.
%is_and(',').
is_and(S):- is_and(S,_).

is_and(S,_):- \+ atom(S),!,fail.
%is_and('and','True').
is_and('and2','True').
%is_and('#COMMA','True'). %is_and(',','True').  % is_and('And').

is_comma(C):- var(C),!,fail.
is_comma(',').
is_comma('{}').

eval_20(Eq,RetType,Depth,Self,['and',X,Y],TF):- !,
	as_tf(( (eval_args_true(Eq,RetType,Depth,Self,X), 
			 eval_args_true(Eq,RetType,Depth,Self,Y))), TF).


eval_20(Eq,RetType,Depth,Self,['or',X,Y],TF):- !,
  as_tf(( (eval_args_true(Eq,RetType,Depth,Self,X); 
		   eval_args_true(Eq,RetType,Depth,Self,Y))), TF).
	
eval_20(Eq,RetType,Depth,Self,['not',X],TF):- !,
	as_tf(( \+ eval_args_true(Eq,RetType,Depth,Self,X)), TF).


% ================================================
% === function / return of minimal metta
eval_20(Eq,RetType,Depth,Self,['function',X],Res):- !, gensym(return_,RetF),
  RetUnit=..[RetF,Res],
  catch(locally(nb_setval('$rettag',RetF),
           eval_args(Eq,RetType,Depth,Self,X, Res)),RetUnitR,RetUnitR=RetUnit).
eval_20(Eq,RetType,Depth,Self,['return',X],_):- !,
  nb_current('$rettag',RetF),RetUnit=..[RetF,Val],
  eval_args(Eq,RetType,Depth,Self,X, Val), throw(RetUnit).
% ================================================

% ================================================
% === catch / throw of mettalog
eval_20(Eq,RetType,Depth,Self,['catch',X,EX,Handler],Res):- !,	 
  catch(eval_args(Eq,RetType,Depth,Self,X, Res),
		 EX,eval_args(Eq,RetType,Depth,Self,Handler, Res)).
eval_20(Eq,_TRetType,Depth,Self,['throw',X],_):- !,
  eval_args(Eq,_RetType,Depth,Self,X, Val), throw(Val).
% ================================================

eval_20(Eq,RetType,Depth,Self,['number-of',X],N):- !,
   bagof_eval(Eq,RetType,Depth,Self,X,ResL),
   length(ResL,N), ignore(RetType='Number').

eval_20(Eq,RetType,Depth,Self,['number-of',X,N],TF):- !,
   bagof_eval(Eq,RetType,Depth,Self,X,ResL),
   length(ResL,N), true_type(Eq,RetType,TF).

eval_20(Eq,RetType,Depth,Self,['findall!',Template,X],ResL):- !,
   findall(Template,eval_args(Eq,RetType,Depth,Self,X,_),ResL).



eval_20(Eq,RetType,Depth,Self,['limit!',N,E],R):- !, eval_20(Eq,RetType,Depth,Self,['limit',N,E],R).
eval_20(Eq,RetType,Depth,Self,['limit',NE,E],R):-  !,
   eval('=','Number',Depth,Self,NE,N),
   limit(N,eval_ne(Eq,RetType,Depth,Self,E,R)).

eval_20(Eq,RetType,Depth,Self,['offset!',N,E],R):- !, eval_20(Eq,RetType,Depth,Self,['offset',N,E],R).
eval_20(Eq,RetType,Depth,Self,['offset',NE,E],R):-  !,
   eval('=','Number',Depth,Self,NE,N),
   offset(N,eval_ne(Eq,RetType,Depth,Self,E,R)).

eval_20(Eq,RetType,Depth,Self,['max-time!',N,E],R):- !, eval_20(Eq,RetType,Depth,Self,['max-time',N,E],R).
eval_20(Eq,RetType,Depth,Self,['max-time',NE,E],R):-  !,
   eval('=','Number',Depth,Self,NE,N),
   cwtl(N,eval_ne(Eq,RetType,Depth,Self,E,R)).


eval_20(Eq,RetType,Depth,Self,['call-cleanup!',NE,E],R):-  !,
   call_cleanup(eval(Eq,RetType,Depth,Self,NE,R),
                eval(Eq,_U_,Depth,Self,E,_)).

eval_20(Eq,RetType,Depth,Self,['setup-call-cleanup!',S,NE,E],R):-  !,
   setup_call_cleanup(
	     eval(Eq,_,Depth,Self,S,_),
         eval(Eq,RetType,Depth,Self,NE,R),
         eval(Eq,_,Depth,Self,E,_)).

eval_20(Eq,RetType,Depth,Self,['with-output-to!',S,NE],R):-  !,
   eval(Eq,'Sink',Depth,Self,S,OUT),
   with_output_to_stream(OUT,
      eval(Eq,RetType,Depth,Self,NE,R)).
                  
      
                                                                       
% =================================================================
% =================================================================
% =================================================================
%  DATA FUNCTOR
% =================================================================
% =================================================================
% =================================================================
eval20_failked(Eq,RetType,Depth,Self,[V|VI],[V|VO]):-
    nonvar(V),is_metta_data_functor(V),is_list(VI),!,
    maplist(eval(Eq,RetType,Depth,Self),VI,VO).


% =================================================================
% =================================================================
% =================================================================
%  EVAL FAILED
% =================================================================
% =================================================================
% =================================================================

eval_failed(Depth,Self,T,TT):-
  finish_eval(Depth,Self,T,TT).

%finish_eval(_,_,X,X):-!.

finish_eval(_Dpth,_Slf,T,TT):- var(T),!,TT=T.
finish_eval(_Dpth,_Slf,[F|LESS],Res):- once(eval_selfless([F|LESS],Res)), fake_notrace([F|LESS]\==Res),!.
finish_eval(Depth,Self,[H|T],[HH|TT]):- is_list(T),!, maplist(eval(Depth,Self),[H|T],[HH|TT]).
%eval_20(Eq,RetType,Depth,Self,['[|]', A, B ],['Cons', AA, BB]):- no_cons_reduce, !,
%  eval(Eq,RetType,Depth,Self,A,AA), eval(Eq,RetType,Depth,Self,B,BB).
finish_eval(_Depth,_Self,T,T).
%finish_eval(_Dpth,_Slf,[],[]):-!.

%finish_eval(Depth,Self,[V|Nil],[O]):- Nil==[], once(eval(Eq,RetType,Depth,Self,V,O)),V\=@=O,!.
%finish_eval(Depth,Self,[H|T],[HH|TT]):- !, eval(Depth,Self,H,HH), finish_eval(Depth,Self,T,TT).
%finish_eval(Depth,Self,T,TT):- eval(Depth,Self,T,TT).

   %eval(Eq,RetType,Depth,Self,X,Y):- eval_20(Eq,RetType,Depth,Self,X,Y)*->true;Y=[].

%eval_20(Eq,RetType,Depth,_,_,_):- Depth<1,!,fail.
%eval_20(Eq,RetType,Depth,_,X,Y):- Depth<3, !, ground(X), (Y=X).
%eval_20(Eq,RetType,_Dpth,_Slf,X,Y):- self_eval(X),!,Y=X.

% Kills zero arity functions eval_20(Eq,RetType,Depth,Self,[X|Nil],[Y]):- Nil ==[],!,eval(Eq,RetType,Depth,Self,X,Y).



% =================================================================
% =================================================================
% =================================================================
%  METTLOG PREDEFS
% =================================================================
% =================================================================
% =================================================================


eval_20(Eq,RetType,_Dpth,_Slf,['arity',F,A],TF):- !,as_tf(current_predicate(F/A),TF),check_returnval(Eq,RetType,TF).
eval_20(Eq,RetType,Depth,Self,['CountElement',L],Res):- !, eval(Eq,RetType,Depth,Self,L,LL), !, (is_list(LL)->length(LL,Res);Res=1),check_returnval(Eq,RetType,Res).
eval_20(Eq,RetType,_Dpth,_Slf,['make_list',List],MettaList):- !, into_metta_cons(List,MettaList),check_returnval(Eq,RetType,MettaList).


eval_20(Eq,RetType,Depth,Self,['maplist!',Pred,ArgL1],ResL):- !,
      maplist(eval_pred(Eq,RetType,Depth,Self,Pred),ArgL1,ResL).
eval_20(Eq,RetType,Depth,Self,['maplist!',Pred,ArgL1,ArgL2],ResL):- !,
      maplist(eval_pred(Eq,RetType,Depth,Self,Pred),ArgL1,ArgL2,ResL).
eval_20(Eq,RetType,Depth,Self,['maplist!',Pred,ArgL1,ArgL2,ArgL3],ResL):- !,
      maplist(eval_pred(Eq,RetType,Depth,Self,Pred),ArgL1,ArgL2,ArgL3,ResL).

  eval_pred(Eq,RetType,Depth,Self,Pred,Arg1,Res):-
      eval(Eq,RetType,Depth,Self,[Pred,Arg1],Res).
  eval_pred(Eq,RetType,Depth,Self,Pred,Arg1,Arg2,Res):-
      eval(Eq,RetType,Depth,Self,[Pred,Arg1,Arg2],Res).
  eval_pred(Eq,RetType,Depth,Self,Pred,Arg1,Arg2,Arg3,Res):-
      eval(Eq,RetType,Depth,Self,[Pred,Arg1,Arg2,Arg3],Res).

eval_20(Eq,RetType,Depth,Self,['concurrent-maplist!',Pred,ArgL1],ResL):- !,
      metta_concurrent_maplist(eval_pred(Eq,RetType,Depth,Self,Pred),ArgL1,ResL).
eval_20(Eq,RetType,Depth,Self,['concurrent-maplist!',Pred,ArgL1,ArgL2],ResL):- !,
      concurrent_maplist(eval_pred(Eq,RetType,Depth,Self,Pred),ArgL1,ArgL2,ResL).
eval_20(Eq,RetType,Depth,Self,['concurrent-maplist!',Pred,ArgL1,ArgL2,ArgL3],ResL):- !,
      concurrent_maplist(eval_pred(Eq,RetType,Depth,Self,Pred),ArgL1,ArgL2,ArgL3,ResL).
eval_20(Eq,RetType,Depth,Self,['concurrent-forall!',Gen,Test|Options],Empty):- !,
      maplist(s2p,Options,POptions),
      call(thread:concurrent_forall(
            user:eval_ne(Eq,RetType,Depth,Self,Gen,_),
            user:forall(eval(Eq,RetType,Depth,Self,Test,_),true),
            POptions)),
     make_empty(RetType,[],Empty).

eval_20(Eq,RetType,Depth,Self,['hyperpose',ArgL],Res):- !, metta_hyperpose(Eq,RetType,Depth,Self,ArgL,Res).


simple_math(Var):- attvar(Var),!,fail.
simple_math([F|XY]):- !, atom(F),atom_length(F,1), is_list(XY),maplist(simple_math,XY).
simple_math(X):- number(X),!.


eval_20(_Eq,_RetType,_Depth,_Self,['call-string!',Str],Empty):- !,'call-string!'(Str,Empty).

'call-string!'(Str,Empty):- 
			   read_term_from_atom(Str,Term,[variables(Vars)]),!,
			   call(Term),Empty=Vars.

/*
eval_20(Eq,RetType,Depth,Self,X,Y):-
  (eval_20(Eq,RetType,Depth,Self,X,M)*-> M=Y ;
     % finish_eval(Depth,Self,M,Y);
    (eval_failed(Depth,Self,X,Y)*->true;X=Y)).
*/
eval_20(_Eq,_RetType,_Dpth,_Slf,['extend-py!',Module],Res):-  !, 'extend-py!'(Module,Res).


/*
into_values(List,Many):- List==[],!,Many=[].
into_values([X|List],Many):- List==[],is_list(X),!,Many=X.
into_values(Many,Many).
eval_20(Eq,RetType,_Dpth,_Slf,Name,Value):- atom(Name), nb_current(Name,Value),!.
*/
% Macro Functions
%eval_20(Eq,RetType,Depth,_,_,_):- Depth<1,!,fail.
/*
eval_20(_Eq,_RetType,Depth,_,X,Y):- Depth<3, !, fail, ground(X), (Y=X).
eval_20(Eq,RetType,Depth,Self,[F|PredDecl],Res):- 
   fail,
   Depth>1,
   fake_notrace((sub_sterm1(SSub,PredDecl), ground(SSub),SSub=[_|Sub], is_list(Sub), maplist(atomic,SSub))),
   eval(Eq,RetType,Depth,Self,SSub,Repl),
   fake_notrace((SSub\=Repl, subst(PredDecl,SSub,Repl,Temp))),
   eval(Eq,RetType,Depth,Self,[F|Temp],Res).
*/
% =================================================================
% =================================================================
% =================================================================
%  PLUS/MINUS
% =================================================================
% =================================================================
% =================================================================

%eval_20(_Eq,_RetType,_Dpth,_Slf,LESS,Res):-  ((((eval_selfless(LESS,Res),fake_notrace(LESS\==Res))))),!.

eval_20(Eq,RetType,Depth,Self,['+',N1,N2],N):- number(N1),%!,
   eval(Eq,RetType,Depth,Self,N2,N2Res), fake_notrace(catch_err(N is N1+N2Res,_E,(set_last_error(['Error',N2Res,'Number']),fail))).
eval_20(Eq,RetType,Depth,Self,['-',N1,N2],N):- number(N1),%!,
   eval(Eq,RetType,Depth,Self,N2,N2Res), fake_notrace(catch_err(N is N1-N2Res,_E,(set_last_error(['Error',N2Res,'Number']),fail))).
eval_20(Eq,RetType,Depth,Self,['*',N1,N2],N):- number(N1),%!,
   eval(Eq,RetType,Depth,Self,N2,N2Res), fake_notrace(catch_err(N is N1*N2Res,_E,(set_last_error(['Error',N2Res,'Number']),fail))).

eval_20(Eq,RetType,Depth,Self,['length',L],Res):- !, eval(Depth,Self,L,LL),
   (is_list(LL)->length(LL,Res);Res=1),
   check_returnval(Eq,RetType,Res).

/*
eval_20(Eq,RetType,Depth,Self,[P,A,X|More],YY):- is_list(X),X=[_,_,_],simple_math(X),
   eval_selfless_2(X,XX),X\=@=XX,!,
   eval_20(Eq,RetType,Depth,Self,[P,A,XX|More],YY).
*/

eval_20(Eq,RetType,Dpth,Slf,['==',X,Y],Res):-  !,
    suggest_type(RetType,'Bool'),
    eq_unify(Eq,_SharedType,Dpth,Slf, X, Y, Res).

eq_unify(_Eq,_SharedType, _Dpth, _Slf, X, Y, TF):- often_fail, as_tf(X=:=Y,TF),!.
eq_unify(_Eq,_SharedType, _Dpth, _Slf, X, Y, TF):- often_fail, as_tf( '#='(X,Y),TF),!.
eq_unify( Eq, SharedType,  Dpth,  Slf, X, Y, TF):- as_tf(eval_until_unify(Eq,SharedType,Dpth,Slf, X, Y), TF).

often_fail.

suggest_type(_RetType,_Bool).


/*
*/
/*
eval_70(Eq,RetType,Depth,Self,PredDecl,Res):-
  Do_more_defs = do_more_defs(true),
  clause(eval_20(Eq,RetType,Depth,Self,PredDecl,Res),Body),
  Do_more_defs == do_more_defs(true),
  call_ndet(Body,DET),
  nb_setarg(1,Do_more_defs,false),
 (DET==true -> ! ; true).
*/
% =================================================================
% =================================================================
% =================================================================
% inherited by system
% =================================================================
% =================================================================
% =================================================================
is_system_pred(S):- atom(S),atom_concat(_,'!',S).
is_system_pred(S):- atom(S),atom_concat(_,'-fn',S).
is_system_pred(S):- atom(S),atom_concat(_,'-p',S).

% eval_20/6: Evaluates a Python function call within MeTTa.
% Parameters:
% - Eq: denotes get-type, match, or interpret call.
% - RetType: Expected return type of the MeTTa function.
% - Depth: Recursion depth or complexity control.
% - Self: Context or environment for the evaluation.
% - [MyFun|More]: List with MeTTa function and additional arguments.
% - RetVal: Variable to store the result of the Python function call.
eval_maybe_python(Eq, RetType, Depth, Self, [MyFun|More], RetVal) :-
    % MyFun as a registered Python function with its module and function name.
    metta_atom(Self, ['registered-python-function', PyModule, PyFun, MyFun]),!,
    % Tries to fetch the type definition for MyFun, ignoring failures.
	adjust_args_9(Eq,RetType,MVal,RetVal,Depth,Self,MyFun,More,Adjusted),
    % Constructs a compound term for the Python function call with adjusted arguments.
    compound_name_arguments(Call, PyFun, Adjusted),
    % Optionally prints a debug tree of the Python call if tracing is enabled.
    if_trace(host;python, print_tree(py_call(PyModule:Call, RetVal))),
    % Executes the Python function call and captures the result in MVal which propagates to RetVal.
    py_call(PyModule:Call, MVal),
    % Checks the return value against the expected type and criteria.
    check_returnval(Eq, RetType, RetVal).



%eval_20(_Eq,_RetType,_Dpth,_Slf,LESS,Res):- fake_notrace((once((eval_selfless(LESS,Res),fake_notrace(LESS\==Res))))),!.

% predicate inherited by system
eval_maybe_host_predicate(Eq,RetType,_Depth,_Self,[AE|More],TF):- allow_host_functions,
  once((is_system_pred(AE),
  length(More,Len),
  is_syspred(AE,Len,Pred))),
  \+ (symbol(AE),   symbol_concat(_,'-fn',AE)), %  % thus maybe -p or or !
  %current_predicate(Pred/Len),!,
  adjust_args_mp(Eq,RetType,Res,NewRes,Depth,Self,Pred,Len,AE,More,Adjusted),
  %fake_notrace( \+ is_user_defined_goal(Self,[AE|More])),!,
  %adjust_args(Depth,Self,AE,More,Adjusted),
  %maplist(as_prolog, More , Adjusted),
  if_trace(host;prolog,print_tree(apply(Pred,Adjusted))),
  catch_warn(efbug(show_call,eval_call(apply(Pred,Adjusted),Res))),
  check_returnval(Eq,RetType,NewRes).

show_ndet(G):- call(G).
%show_ndet(G):- call_ndet(G,DET),(DET==true -> ! ; fbug(show_ndet(G))).

:- if( \+  current_predicate( is_user_defined_goal / 2 )).
is_user_defined_goal(Self,Head):- is_user_defined_head(Self,Head).
:- endif.



adjust_args_mp(_Eq,_RetType,Res,NewRes,_Depth,_Self,_Pred,_Len,_AE,Args,Adjusted):- 
  Args==[],!,Adjusted=Args, NewRes = Res.

adjust_args_mp(Eq,RetType,Res,NewRes,Depth,Self,Pred,Len,AE,Args,Adjusted):- integer(Len),
   atom(Pred),
   Len> 0 , functor(P,Pred,Len), predicate_property(P,meta_predicate(Needs)),
   account_needs(1,Needs,Args,More),!,
   adjust_args_9(Eq,RetType,Res,NewRes,Depth,Self,AE,More,Adjusted).
adjust_args_mp(Eq,RetType,Res,NewRes,Depth,Self,_Pred,_Len,AE,Args,Adjusted):-
   adjust_args_9(Eq,RetType,Res,NewRes,Depth,Self,AE,Args,Adjusted).

acct(0,A,call(eval(A,_))).
acct(':',A,call(eval(A,_))).
acct(_,A,A).
account_needs(_,_,[],[]).
account_needs(N,Needs,[A|Args],[M|More]):- arg(N,Needs,What),!,
   acct(What,A,M),plus(1,N,NP1),
   account_needs(NP1,Needs,Args,More).

:- nodebug(metta(call)).
allow_host_functions.

s2ps(S,P):- S=='Nil',!,P=[].
s2ps(S,P):- \+ is_list(S),!,P=S.
s2ps([F|S],P):- atom(F),maplist(s2ps,S,SS),join_s2ps(F,SS,P),!.
s2ps(S,S):-!.
join_s2ps('Cons',[H,T],[H|T]):-!.
join_s2ps(F,Args,P):-atom(F),P=..[F|Args].

eval_call(S,TF):-
  s2ps(S,P), !,
  fbug(eval_call(P,'$VAR'('TF'))),as_tf(P,TF).

eval_call_fn(S,R):-
  s2ps(S,P), !,
  fbug(eval_call_fn(P,'$VAR'('R'))),as_tf(call(P,R),TF),TF\=='False'.

% function inherited from system
eval_maybe_host_function(Eq,RetType,_Depth,_Self,[AE|More],Res):- allow_host_functions,
  is_system_pred(AE),
  length([AE|More],Len),
  is_syspred(AE,Len,Pred),
  \+ (symbol(AE), symbol_concat(_,'-p',AE)), % thus maybe -fn or !
  %fake_notrace( \+ is_user_defined_goal(Self,[AE|More])),!,
  %adjust_args(Depth,Self,AE,More,Adjusted),!,
  %Len1 is Len+1,
  %current_predicate(Pred/Len1),
  %maplist(as_prolog,More,Adjusted),
  adjust_args_mp(Eq,RetType,Res,NewRes,Depth,Self,Pred,Len,AE,More,Adjusted),
  append(Adjusted,[NewRes],Args),
  if_trace(host;prolog,print_tree(apply(Pred,Args))),!,
  efbug(show_call,catch_warn(apply(Pred,Args))),
  check_returnval(Eq,RetType,Res).

% user defined function
%eval_20(Eq,RetType,Depth,Self,[H|PredDecl],Res):-
 %  fake_notrace(is_user_defined_head(Self,H)),!,
 %  eval_defn(Eq,RetType,Depth,Self,[H|PredDecl],Res).

/*eval_maybe_defn(Eq,RetType,Depth,Self,PredDecl,Res):-    
    eval_defn(Eq,RetType,Depth,Self,PredDecl,Res).

eval_maybe_subst(Eq,RetType,Depth,Self,PredDecl,Res):-
    subst_args_h(Eq,RetType,Depth,Self,PredDecl,Res).
*/



:- if( \+  current_predicate( check_returnval / 3 )).
check_returnval(_,_RetType,_TF).
:- endif.

:- if( \+  current_predicate( adjust_args / 5 )).
adjust_args(_Depth,_Self,_V,VI,VI).
:- endif.


last_element(T,E):- \+ compound(T),!,E=T.
last_element(T,E):- is_list(T),last(T,L),last_element(L,E),!.
last_element(T,E):- compound_name_arguments(T,_,List),last_element(List,E),!.




catch_warn(G):- quietly(catch_err(G,E,(fbug(catch_warn(G)-->E),fail))).
catch_nowarn(G):- quietly(catch_err(G,error(_,_),fail)).


% less Macro-ey Functions


as_tf(G,TF):-  G\=[_|_], catch_nowarn((call(G)*->TF='True';TF='False')).
as_tf_tracabe(G,TF):-  G\=[_|_], ((call(G)*->TF='True';TF='False')).
%eval_selfless_1(['==',X,Y],TF):- as_tf(X=:=Y,TF),!.
%eval_selfless_1(['==',X,Y],TF):- as_tf(X=@=Y,TF),!.

is_assignment(V):- \+ atom(V),!, fail.
is_assignment('is'). is_assignment('is!').
% is_assignment('='). %is_assignment('==').
is_assignment('=:=').  is_assignment(':=').

eval_selfless(E,R):-  often_fail, eval_selfless_0(E,R).

eval_selfless_0([F,X,XY],TF):- is_assignment(F),  fake_notrace(args_to_mathlib([X,XY],Lib)),!,eval_selfless3(Lib,['=',X,XY],TF).
eval_selfless_0([F|XY],TF):- eval_selfless_1([F|XY],TF),!.
eval_selfless_0(E,R):- eval_selfless_2(E,R).

eval_selfless_1([F|XY],TF):- \+ ground(XY),!,fake_notrace(args_to_mathlib(XY,Lib)),!,eval_selfless3(Lib,[F|XY],TF).
%eval_selfless_1(['>',X,Y],TF):-!,as_tf(X>Y,TF).
%eval_selfless_1(['<',X,Y],TF):-!,as_tf(X<Y,TF).
eval_selfless_1(['=>',X,Y],TF):-!,as_tf(X>=Y,TF).
eval_selfless_1(['<=',X,Y],TF):-!,as_tf(X=<Y,TF).
eval_selfless_1(['\\=',X,Y],TF):-!,as_tf(dif(X,Y),TF).

eval_selfless_2(['%',X,Y],TF):-!,eval_selfless_2(['mod',X,Y],TF).
eval_selfless_2(LIS,Y):-  fake_notrace(( ground(LIS),
   LIS=[F,_,_], atom(F), catch_warn(current_op(_,yfx,F)),
   LIS\=[_], s2ps(LIS,IS))), fake_notrace(catch((Y is IS),_,fail)),!.


eval_selfless3(Lib,FArgs,TF):- maplist(s2ps,FArgs,Next),!,
 notrace(compare_selfless0(Lib,Next,TF)).

:- use_module(library(clpfd)).
:- clpq:use_module(library(clpq)).
:- clpr:use_module(library(clpr)).

compare_selfless0(_,[F|_],_TF):- \+ atom(F),!,fail.
%compare_selfless0(clpfd,['=',X,Y],TF):-!,as_tf(X#=Y,TF).
compare_selfless0(clpfd,['\\=',X,Y],TF):-!,as_tf(X #\=Y,TF).
%compare_selfless0(clpfd,['>',X,Y],TF):-!,as_tf(X#>Y,TF).
%compare_selfless0(clpfd,['<',X,Y],TF):-!,as_tf(X#<Y,TF).
compare_selfless0(clpfd,['=>',X,Y],TF):-!,as_tf(X#>=Y,TF).
compare_selfless0(clpfd,['<=',X,Y],TF):-!,as_tf(X#=<Y,TF).
%compare_selfless0(clpfd,[F|Stuff],TF):- atom_concat('#',F,SharpF),P=..[SharpF|Stuff],!,as_tf(P,TF).
compare_selfless0(Lib,['\\=',X,Y],TF):-!,as_tf(Lib:{X \=Y}, TF).
%compare_selfless0(Lib,['=',X,Y],TF):-!,as_tf(Lib:{X =Y}, TF). %not_defined_by_user(=).
%compare_selfless0(Lib,['>',X,Y],TF):-!,as_tf(Lib:{X>Y},TF).
%compare_selfless0(Lib,['<',X,Y],TF):-!,as_tf(Lib:{X<Y},TF).
compare_selfless0(Lib,['=>',X,Y],TF):-!,as_tf(Lib:{X>=Y},TF).
compare_selfless0(Lib,['<=',X,Y],TF):-!,as_tf(Lib:{X=<Y},TF).
%compare_selfless0(Lib,[F|Stuff],TF):- P=..[F|Stuff],!,as_tf(Lib:{P},TF).

/*
args_to_mathlib(T,Lib):- var(T),!,get_attrs(T,XX),get_attrlib(XX,Lib).
args_to_mathlib(XY,Lib):- compound(XY),sub_term(T,XY),!,get_attrs(T,XX),get_attrlib(XX,Lib).
args_to_mathlib(XY,clpr):- once((sub_term(T,XY), float(T))). % Reals
args_to_mathlib(XY,clpq):- once((sub_term(Rat,XY),compound(Rat),Rat='/'(_,_))).
*/
args_to_mathlib(_,clpfd).

not_defined_by_user(Op):- current_self(Self), metta_defn('=',Self,[Op,_,_],_).

get_attrlib(XX,clpfd):- sub_var(clpfd,XX),!.
get_attrlib(XX,clpq):- sub_var(clpq,XX),!.
get_attrlib(XX,clpr):- sub_var(clpr,XX),!.

% =================================================================
% =================================================================
% =================================================================
%  USER DEFINED FUNCTIONS
% =================================================================
% =================================================================
% =================================================================

call_ndet(Goal,DET):- call(Goal),deterministic(DET),(DET==true->!;true).



:- dynamic(is_metta_type_constructor/3).

curried_arity(X,_,_):- var(X),!,fail.
curried_arity([F|T],F,A):-var(F),!,fail,len_or_unbound(T,A).
curried_arity([[F|T1]|T2],F,A):- nonvar(F),!,len_or_unbound(T1,A1),
  (var(A1)->A=A1;(len_or_unbound(T2,A2),(var(A2)->A=A2;A is A1+A2))).
curried_arity([F|T],F,A):-len_or_unbound(T,A).

%curried_arity(_,_,_).


len_or_unbound(T,A):- is_list(T),!,length(T,A).
len_or_unbound(T,A):- integer(A),!,length(T,A).
len_or_unbound(_,_).


:-if(true).

eval_maybe_defn(Eq,RetType,Depth,Self,X,Res):-
   \+  \+ (curried_arity(X,F,A),
           is_metta_type_constructor(Self,F,AA),
           ( \+ AA\=A ),!,
           if_trace(e,color_g_mesg('#772000',
                 indentq2(Depth,defs_none_cached((F/A/AA)=X))))),!,
   \+ fail_on_constructor,
   eval_constructor(Eq,RetType,Depth,Self,X,Res).
eval_maybe_defn(Eq,RetType,Depth,Self,X,Y):- can_be_ok(eval_maybe_defn,X),!,
      trace_eval(eval_defn_choose_candidates(Eq,RetType),' find_defn ',Depth,Self,X,Y).

eval_constructor(Eq,RetType,Depth,Self,X,Res):-
   eval_maybe_subst(Eq,RetType,Depth,Self,X,Res).


eval_defn_choose_candidates(Eq,RetType,Depth,Self,X,Y):-
    findall((XX->B0),get_defn_expansions(Eq,RetType,Depth,Self,X,XX,B0),XXB0L),!,
    eval_defn_bodies(Eq,RetType,Depth,Self,X,Y,XXB0L).
eval_defn_choose_candidates(Eq,RetType,Depth,Self,X,Y):-
    eval_defn_bodies(Eq,RetType,Depth,Self,X,Y,[]),!.



eval_defn_bodies(Eq,RetType,Depth,Self,X,Res,[]):- !,
   \+ \+ ignore((curried_arity(X,F,A),assert(is_metta_type_constructor(Self,F,A)))),!,
   if_trace(e,color_g_mesg('#773700',indentq2(Depth,defs_none(X)))),!,
   \+ fail_on_constructor,
   eval_constructor(Eq,RetType,Depth,Self,X,Res).

eval_defn_bodies(Eq,RetType,Depth,Self,X,Y,XXB0L):-
  if_trace(e,maplist(print_templates(Depth,'   '),XXB0L)),!,
  if_or_else((member(XX->B0,XXB0L), copy_term(XX->B0,USED),
    eval_defn_success(Eq,RetType,Depth,Self,X,Y,XX,B0,USED)),
    eval_defn_failure(Eq,RetType,Depth,Self,X,Y)).


eval_defn_success(Eq,RetType,Depth,Self,X,Y,XX,B0,USED):-
  X=XX, Y=B0, X\=@=B0,
  if_trace(e,color_g_mesg('#773700',indentq2(Depth,defs_used(USED)))),
  light_eval(Eq,RetType,Depth,Self,B0,Y),!.
eval_defn_failure(_Eq,_RetType,Depth,_Self,X,Res):-
  if_trace(e,color_g_mesg('#773701',indentq2(Depth,defs_failed(X)))),
  !, \+ fail_missed_defn, X=Res.


:-else.
eval_maybe_defn(Eq,RetType,Depth,Self,X,Y):- can_be_ok(eval_maybe_defn,X),!,
      trace_eval(eval_defn_choose_candidates(Eq,RetType),' find_defn ',Depth,Self,X,Y).

eval_defn_choose_candidates(Eq,RetType,Depth,Self,X,Y):-
	findall((XX->B0),get_defn_expansions(Eq,RetType,Depth,Self,X,XX,B0),XXB0L),
	XXB0L\=[],!, 
        Depth2 is Depth-1,
	if_trace((metta_defn),
        maplist(print_templates(Depth,'   '),XXB0L)),!,
	member(XX->B0,XXB0L), X=XX, Y=B0, X\=@=B0,
	%(X==B0 -> trace; eval(Eq,RetType,Depth,Self,B0,Y)).
	 light_eval(Depth2,Self,B0,Y).
eval_defn_choose_candidates(_Eq,_RetType,_Depth,_Self,_X,_Y):- \+ is_debugging(metta_defn),!,fail.
eval_defn_choose_candidates(_Eq,_RetType,_Depth,_Self,X,_Y):-
   color_g_mesg('#773700',write(no_def(X))),!,fail.
:- endif.


same_len_copy(Args,NewArgs):- length(Args,N),length(NewArgs,N).

get_defn_expansions(Eq,_RetType,_Depth,Self,[H|Args],[H|NewArgs],B0):- same_len_copy(Args,NewArgs),
   metta_defn(Eq,Self,[H|NewArgs],B0).

get_defn_expansions(Eq,RetType,Depth,Self,[[H|Start]|T1],[[H|NewStart]|NewT1],[Y|T1]):- is_list(Start),
	same_len_copy(Start,NewStart),
	X = [H|NewStart],
	findall((XX->B0),get_defn_expansions(Eq,RetType,Depth,Self,X,XX,B0),XXB0L),
	XXB0L\=[], if_trace((metta_defn;eval),maplist(print_templates(Depth,'curry 1'),XXB0L)),!,
	member(XX->B0,XXB0L), X=XX, Y=B0, X\=@=B0,
    light_eval(Eq,RetType,Depth,Self,B0,Y),
	same_len_copy(T1,NewT1).

get_defn_expansions(Eq,RetType,Depth,Self,[[H|Start]|T1],RW,Y):- is_list(Start), append(Start,T1,Args),
  get_defn_expansions(Eq,RetType,Depth,Self,[H|Args],RW,Y),
  if_trace((metta_defn;eval),indentq_d(Depth,'curry 2 ', [[[H|Start]|T1] ,'----->', RW])).

print_templates(Depth,_T,XX->B0):-!,
    indentq_d(Depth,'(=',XX),
    indentq_d(Depth,'',ste('',B0,')')).
print_templates(Depth,T,XXB0):- ignore(indentq_d(Depth,'<<>>'(T),template(XXB0))),!.

light_eval(Depth,Self,X,B):-
  light_eval(_Eq,_RetType,Depth,Self,X,B).
light_eval(_Eq,_RetType,_Depth,_Self,B,B).

not_template_arg(TArg):- var(TArg), !, \+ attvar(TArg).
not_template_arg(TArg):- atomic(TArg),!.
%not_template_arg(TArg):- is_list(TArg),!,fail.


% =================================================================
% =================================================================
% =================================================================
%  AGREGATES
% =================================================================
% =================================================================
% =================================================================

cwdl(DL,Goal):- call_with_depth_limit(Goal,DL,R), (R==depth_limit_exceeded->(!,fail);true).

cwtl(DL,Goal):- catch(call_with_time_limit(DL,Goal),time_limit_exceeded(_),fail).

%bagof_eval(Eq,RetType,Depth,Self,X,L):- bagof_eval(Eq,RetType,_RT,Depth,Self,X,L).


%bagof_eval(Eq,RetType,Depth,Self,X,S):- bagof(E,eval_ne(Eq,RetType,Depth,Self,X,E),S)*->true;S=[].
bagof_eval(_Eq,_RetType,_Dpth,_Slf,X,L):- typed_list(X,_Type,L),!.
bagof_eval(Eq,RetType,Depth,Self,Funcall,L):-
   findall_ne(E,eval(Eq,RetType,Depth,Self,Funcall,E),L).

setof_eval(Depth,Self,Funcall,L):- setof_eval('=',_RT,Depth,Self,Funcall,L).
setof_eval(Eq,RetType,Depth,Self,Funcall,S):- bagof_eval(Eq,RetType,Depth,Self,Funcall,L),
   sort(L,S).

findall_ne(E,Call,L):-
   findall(E,(rtrace_on_error(Call), is_returned(E)),L).

eval_ne(Eq,RetType,Depth,Self,Funcall,E):-
  eval(Eq,RetType,Depth,Self,Funcall,E).

is_returned(E):- \+ var(E), \+ is_empty(E).


:- ensure_loaded(metta_subst).

solve_quadratic(A, B, I, J, K) :-
    %X in -1000..1000,  % Define a domain for X
     (X + A) * (X + B) #= I*X*X + J*X + K.  % Define the quadratic equation
    %label([X]).  % Find solutions for X



as_type(B,_Type,B):- var(B),!.
as_type(B,_Type,B):- \+ compound(B),!.

as_type([OP|B],Type,Res):- var(Type),
   len_or_unbound(B,Len),
   get_operator_typedef(_Self,OP,Len,_ParamTypes,RetType),
   Type=RetType,
   eval_for(RetType,[OP|B],Res).

as_type(B,RetType,Res):- is_pro_eval_kind(RetType),
   eval_for(RetType,B,Res).

as_type(B,_Type,B).

same_types(A,C,_Type,A1,C1):-
  A1=A,C1=C,!.
same_types(A,C,Type,A1,C1):-
  freeze(A,guess_type(A,Type)),
  freeze(C,guess_type(C,Type)),
  A1=A,C1=C.
   
guess_type(A,Type):-
   current_self(Self),
   get_type(20,Self,A,Was),
   can_assign(Was,Type).
   
eval_for(RetType,X,Y):- 
  current_self(Self),
  eval('=',RetType,20,Self,X,Y).

%if_debugging(G):- ignore(call(G)).
if_debugging(_).
bcc:- trace,
  bc_fn([:,Prf,[in_tad_with,[sequence_variant,rs15],[gene,d]]],
     ['S',['S',['S',['S','Z']]]],
     OUT),
	write_src(prf=Prf), write_src(OUT).


bci:- trace,
  bc_impl([:,Prf,[in_tad_with,[sequence_variant,rs15],[gene,d]]],
	 ['S',['S',['S',['S','Z']]]],
	 OUT),    
	write_src(prf=Prf), write_src(OUT).



bcm:- % trace,
  bc_impl([:,Prf,[member,_A,_B,_C]],
	 ['S',['S',['S','Z']]],
	 OUT),    
	write_src(prf=Prf), write_src(OUT).


    bc_fn(A,B,C):- %trace,
      same_types(A,C,_,A1,C1),
      as_type(B,'Nat',B1),
      bc_impl(A1,B1,C1).


bc_impl([:, _prf, _ccln], _, [:, _prf, _ccln]) :-
    if_debugging(println_impl(['bc-base', [:, _prf, _ccln]])),
    metta_atom('&kb', [:, _prf, _ccln]),
    if_debugging(println_impl(['bc-base-ground', [:, _prf, _ccln]])),
    true.

bc_impl([:, [_prfabs, _prfarg], _ccln], ['S', _k], [:, [_prfabs, _prfarg], _ccln]) :-
    if_debugging(println_impl(['bc-rec', [:, [_prfabs, _prfarg], _ccln], ['S', _k]])),
    bc_impl([:, _prfabs, ['->', _prms, _ccln]], _k, [:, _prfabs, [->, _prms, _ccln]]),
    bc_impl([:, _prfarg, _prms], _k, [:, _prfarg, _prms]).
















end_of_file.



        eval_20(Eq,RetType,Depth,Self,X,Y):- fail,
          once(type_fit_childs(Eq,Depth,Self,RetType,X,XX)),
            X\=@=XX, fbug(type_fit_childs(X,XX)),fail,
          eval_evals(Eq,RetType,Depth,Self,XX,Y).


        into_arg_code([],true):-!.
        into_arg_code(H,TT):- \+ iz_conz(H), TT = H.
        into_arg_code([H,T],TT):- H==true,!,into_arg_code(T,TT).
        into_arg_code([T,H],TT):- H==true,!,into_arg_code(T,TT).
        into_arg_code([H,T],','(HH,TT)):- !, into_arg_code(H,HH),into_arg_code(T,TT).
        into_arg_code([H|T],TT):- H==true,!,into_arg_code(T,TT).
        into_arg_code([H|T],','(HH,TT)):- !, into_arg_code(H,HH),into_arg_code(T,TT).
        into_arg_code(TT,TT).
        into_arg_code([H|T],next(H,TT)):- into_arg_code(T,TT).


        % reduce args to match types even inside atoms
        type_fit_childs(_Eq,_Depth,_Self,_RetType,true,X,Y):- is_ftVar(X),!,Y=X.
        type_fit_childs(_Eq,_Depth,_Self,_RetType,true,X,Y):- symbolic(X),!,Y=X.
        type_fit_childs(Eq,Depth,Self,RetType,CodeForArg,X,Y):- compound_non_cons(X),!,
           into_list_args(X,XX),!,type_fit_childs(Eq,Depth,Self,RetType,CodeForArg,XX,Y).
        type_fit_childs(_Eq,_Depth,_Self,_RetType,true,X,Y):- \+ is_list(X),iz_conz(X), trace, !,Y=X.
        type_fit_childs(_Eq,_Depth,_Self,_RetType,true,X,Y):- self_eval(X),!,Y=X.

        type_fit_childs(_Eq,_Depth,_Self,_RetType,true,[H|Args],[H|Args]):- (H=='eval';H=='eval-for'),!.

        type_fit_childs(Eq,Depth,Self,RetType,CodeForArg,['let*',Lets,Body],RetVal):- !,
            expand_let_star(Lets,Body,NewLet),!,
                type_fit_childs(Eq,Depth,Self,RetType,CodeForArg,NewLet,RetVal).

        /*                                e,CodeForCond,['If',Cond,Then,Else],
            pe_fit_childs(Eq,Depth,Self,RetType,CodeForCond,['If',Cond,Then,Else],
                    ['If',ConVal,(CodeForThen),CodeForElse]):-
            type_fit_childs(Eq,Depth,Self,'Bool',CodeForCond,Cond,ConVal).
            type_fit_childs(Eq,Depth,Self,RetType,CodeForThen,Then,ThenVal).
            type_fit_childs(Eq,Depth,Self,RetType,CodeForElse,Else,ElseVal).
        */

        type_fit_childs(Eq,Depth,Self,RetType,FullCodeForArgs,[H|Args],Y):- H\==':',
           ignore(get_operator_typedef1(Self,H,ParamTypes,RType)),
           ignore(eager_for_type(RType,RetType)),!,
           must_det_ll((maplist(type_fit_childs(Eq,Depth,Self),ParamTypes,CodeForArgs,Args,NewArgs),
           into_arg_code(CodeForArgs,MCodeForArgs),
           into_arg_code([MCodeForArgs,'eval'(XX,Y)],FullCodeForArgs),

           XX = [H|NewArgs],
           Y = _)).
           %eval(Eq,RetType,CodeForArg,Depth,Self,XX,Y).

        type_fit_childs(Eq,Depth,Self,RetType,FullCodeForArgs,[H|Args],Y):-
           must_det_ll((ignore(get_operator_typedef1(Self,H,ParamTypes,RetType)),
           maplist(type_fit_childs(Eq,Depth,Self),ParamTypes,CodeForArgs,Args,NewArgs),
           into_arg_code(CodeForArgs,FullCodeForArgs),
           Y = [H|NewArgs])).
        type_fit_childs(_Eq,_Depth,_Self,_RetType,true,X,Y):-!,must_det_ll((X=Y)).

        eager_for_type(_RType,'Atom'):- !, fail.
        eager_for_type(_RType,'Type'):- !, fail.
        eager_for_type(RType,RetType):- RType==RetType,!.
        eager_for_type(RType,'Expression'):- !, RType=='Expression'.
        eager_for_type('Atom','Expression'):- !, fail.
        eager_for_type('Symbol','Expression'):- !, fail.
        eager_for_type(RType,Var):- var(Var),!,RType=Var.
        eager_for_type(_RType,_):-!.
        %eager_for_type(_RType,'Any'):- !.
        %eager_for_type(_RType,'Number').
        %eager_for_type(_RType,'Nat').


        eval_evals(_Eq,_Depth,_Self,_RetType,X,Y):-self_eval(X),!,Y=X.
        eval_evals(_Eq,_Depth,_Self,_RetType,X,Y):- \+ is_list(X),!,Y=X.
        eval_evals(Eq,Depth,Self,RetType,[Eval,X],Y):- Eval == 'eval',!,
          eval_evals(Eq,Depth,Self,RetType,X,XX),
          eval(Eq,RetType,Depth,Self,XX,Y).
        eval_evals(Eq,Depth,Self,RetType,[Eval,SomeType,X],Y):- Eval == 'eval-for',!,
          eval_evals(Eq,Depth,Self,RetType,X,XX),
          eval(Eq,SomeType,Depth,Self,XX,Y).
        eval_evals(Eq,Depth,Self,RetType,[H|Args],Y):-
           ignore(get_operator_typedef1(Self,H,ParamTypes,RetType)),
           maplist(eval_evals(Eq,Depth,Self),ParamTypes,Args,NewArgs),
           XX = [H|NewArgs],Y=XX.
        eval_evals(_Eq,_Depth,_Self,_RetType,X,X):-!.


