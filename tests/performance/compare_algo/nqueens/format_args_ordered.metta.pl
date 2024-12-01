
:- ensure_loaded('/home/deb12user/metta-wam-royward-dev/src/canary/metta_runtime').

/*
;           #(set_option_value compat false)
;           #(set_option_value compatio false)
;           #(set_option_value src_indents false)
;         #(set_option_value devel false)
;         #(set_option_value stack-max 500)
;         #(set_option_value limit inf)
;         #(set_option_value initial-result-count 10)
;         #(set_option_value answer-format show)
;         #(set_option_value repeats true)
;         #(set_option_value time true)
;         #(set_option_value synth-unit-tests false)
;         #(set_option_value optimize true)
;         #(set_option_value transpiler silent)
;          #(set_debug transpiler false)
;         #(set_option_value compile false)
;         #(set_option_value tabling auto)
;         #(set_option_value log false)
Warning: /home/deb12user/metta-wam/src/canary/metta_interp.pl:1856:
Warning:    Singleton variables: [StackMax,Self,Term,X]
% 23,933 inferences, 0.003 CPU in 0.003 seconds (100% CPU, 8737861 Lips)
;        #(is_cmd_option execute python --python=enable enable)
;         #(set_option_value python enable)
;        #(is_cmd_option execute debug --debug true)
;         #(set_option_value debug true)
;         #(is_cmd_option execute html --html true)
;         #(set_option_value html true)
;         #(is_cmd_option execute compile --compile=save save)
;          #(set_option_value compile save)

; #( : user #(load_metta_file &self tests/direct_comp/easy/format_args_ordered.metta) )
;                       #(track_load_into_file /home/deb12user/metta-wam/tests/direct_comp/easy/format_args_ordered.metta)
;                                        #(load_answer_file /home/deb12user/metta-wam/tests/direct_comp/easy/format_args_ordered.metta.answers /home/deb12user/metta-wam/tests/direct_comp/easy/format_args_ordered.metta)
Info: File /home/deb12user/metta-wam/tests/direct_comp/easy/format_args_ordered.metta is 1.14K bytes (35 lines)
;                                        #(load_answer_file /home/deb12user/metta-wam/tests/direct_comp/easy/format_args_ordered.metta.answers /home/deb12user/metta-wam/tests/direct_comp/easy/format_args_ordered.metta)
;;; (= (select $x) ((car-atom $x) (cdr-atom $x)))
;;; (= (select $x) (let* (($y (car-atom $x)) ($z (cdr-atom $x)) (($u $v) (select $z))) ($u (cons-atom $y $v))))
```
```metta
 (= (select $x)
  (if
    (== $x ())
    (empty)
    ( (car-atom $x) (cdr-atom $x))))
```
```load
; Action: load=metta_atom_asserted('&self',[=,[select,_x],[if,[==,_x,[]],[empty],[['car-atom',_x],['cdr-atom',_x]]]])

```
```ast
[ =,
  mc__select(_x,A),
  [ [ prolog_if,
      [ [assign,B,[]],
        [ assign,
          C,
          [ call(==), _x,B]],
        [ native(is_True),
          C]],
      [ [ assign,
          D,
          [call(empty)]],
        [assign,A,D]],
      [ [ assign,
          E,
          [ call('car-atom'),
            _x]],
        [ assign,
          F,
          [ call('cdr-atom'),
            _x]],
        [ assign, G,list([E,F])],
        [assign,A,G]]]]].
```
```prolog
*/

mc__select(_x, A) :-
    (   B=[],
        'mc__=='(_x, B, C),
        is_True(C)
    *-> mc__empty(D),
        A=D
    ;   'mc__car-atom'(_x, E),
        'mc__cdr-atom'(_x, F),
        G=[E, F],
        A=G
    ).


/*
```
```metta
 (= (select $x)
  (if
    (== $x ())
    (empty)
    (let*
      ( ($y (car-atom $x))
        ($z (cdr-atom $x))
        ( ($u $v) (select $z)))
      ($u (cons-atom $y $v)))))
```
```load
; Action: load=metta_atom_asserted('&self',[=,[select,_x],[if,[==,_x,[]],[empty],['let*',[[_y,['car-atom',_x]],[_z,['cdr-atom',_x]],[[_u,_v],[select,_z]]],[_u,['cons-atom',_y,_v]]]]])

```
```ast
[ =,
  mc__select(_x,A),
  [ [ prolog_if,
      [ [assign,B,[]],
        [ assign,
          C,
          [ call(==), _x,B]],
        [ native(is_True),
          C]],
      [ [ assign,
          D,
          [call(empty)]],
        [assign,A,D]],
      [ [ assign,
          _y,
          [ call('car-atom'),
            _x]],
        [ assign,
          _z,
          [ call('cdr-atom'),
            _x]],
        [ assign,
          E,
          [ call(select),
            _z]],
        [ assign,
          [_u,_v],
          E],
        [ assign,
          F,
          [ call('cons-atom'), _y,_v]],
        [ assign, G,list([_u,F])],
        [assign,A,G]]]]].
```
```prolog
*/

mc__select(_x, A) :-
    (   B=[],
        'mc__=='(_x, B, C),
        is_True(C)
    *-> mc__empty(D),
        A=D
    ;   'mc__car-atom'(_x, _y),
        'mc__cdr-atom'(_x, _z),
        mc__select(_z, E),
        [_u, _v]=E,
        'mc__cons-atom'(_y, _v, F),
        G=[_u, F],
        A=G
    ).


/*
```
```metta
 (= (range $x $y)
  (if
    (== $x $y)
    ($x)
    (let $z
      (range
        (+ $x 1) $y)
      (cons-atom $x $z))))
```
```load
; Action: load=metta_atom_asserted('&self',[=,[range,_x,_y],[if,[==,_x,_y],[_x],[let,_z,[range,[+,_x,1],_y],['cons-atom',_x,_z]]]])

```
```ast
[ =,
  mc__range(_x,_y,A),
  [ [ prolog_if,
      [ [ assign,
          B,
          [ call(==), _x,_y]],
        [ native(is_True),
          B]],
      [ [ assign, C,list([_x])],
        [assign,A,C]],
      [ [ assign,
          D,
          [ call(+), _x,1]],
        [ assign,
          _z,
          [ call(range), D,_y]],
        [ assign,
          E,
          [ call('cons-atom'), _x,_z]],
        [assign,A,E]]]]].
```
```prolog
*/

mc__range(_x, _y, A) :-
    (   'mc__=='(_x, _y, B),
        is_True(B)
    *-> C=[_x],
        A=C
    ;   'mc__+'(_x, 1, D),
        mc__range(D, _y, _z),
        'mc__cons-atom'(_x, _z, E),
        A=E
    ).


/*
```
```metta
 (= (not_attack $q $d $s)
  (if
    (== $s ()) True
    (let*
      ( ($h (car-atom $s)) ($t (cdr-atom $s)))
      (if
        (or
          (== $q $h)
          (or
            (== $q
              (+ $d $h))
            (== $h
              (+ $q $d)))) False
        (not_attack $q
          (+ $d 1) $t)))))
```
```load
; Action: load=metta_atom_asserted('&self',[=,[not_attack,_q,_d,_s],[if,[==,_s,[]],'True',['let*',[[_h,['car-atom',_s]],[_t,['cdr-atom',_s]]],[if,[or,[==,_q,_h],[or,[==,_q,[+,_d,_h]],[==,_h,[+,_q,_d]]]],'False',[not_attack,_q,[+,_d,1],_t]]]]])

```
```ast
[ =,
  mc__not_attack(_q,_d,_s,A),
  [ [ prolog_if,
      [ [assign,B,[]],
        [ assign,
          C,
          [ call(==), _s,B]],
        [ native(is_True),
          C]],
      [ [ assign,  D   ,'True'],
        [ assign,  A   ,  D   ]],
      [ [ assign,
          _h,
          [ call('car-atom'),
            _s]],
        [ assign,
          _t,
          [ call('cdr-atom'),
            _s]],
        [ prolog_if,
          [ [ assign,
              E,
              [ call(==), _q,_h]],
            [ assign,
              F,
              [ call(+), _d,_h]],
            [ assign,
              G,
              [ call(==), _q,F]],
            [ assign,
              H,
              [ call(+), _q,_d]],
            [ assign,
              I,
              [ call(==), _h,H]],
            [ assign,
              J,
              [ call(or), G,I]],
            [ assign,
              K,
              [ call(or), E,J]],
            [ native(is_True),
              K]],
          [ [ assign ,   L   ,'False'],
            [ assign ,   M   ,   L   ]],
          [ [ assign,
              N,
              [ call(+), _d,1]],
            [ assign,
              O,
              [ call(not_attack), _q,N,_t]],
            [assign,M,O]]],
        [assign,A,M]]]]].
```
```prolog
*/

mc__not_attack(_q, _d, _s, A) :-
    (   B=[],
        'mc__=='(_s, B, C),
        is_True(C)
    *-> D='True',
        A=D
    ;   'mc__car-atom'(_s, _h),
        'mc__cdr-atom'(_s, _t),
        (   'mc__=='(_q, _h, E),
            'mc__+'(_d, _h, F),
            'mc__=='(_q, F, G),
            'mc__+'(_q, _d, H),
            'mc__=='(_h, H, I),
            mc__or(G, I, J),
            mc__or(E, J, K),
            is_True(K)
        *-> L='False',
            M=L
        ;   'mc__+'(_d, 1, N),
            mc__not_attack(_q, N, _t, O),
            M=O
        ),
        A=M
    ).


/*
```
```metta
 (= (nqueens_aux $unplaced $safe)
  (if
    (== $unplaced ()) $safe
    (let
      ($q $r)
      (select $unplaced)
      (if
        (not_attack $q 1 $safe)
        (let $safeext
          (cons-atom $q $safe)
          (nqueens_aux $r $safeext))
        (empty)))))
```
```load
; Action: load=metta_atom_asserted('&self',[=,[nqueens_aux,_unplaced,_safe],[if,[==,_unplaced,[]],_safe,[let,[_q,_r],[select,_unplaced],[if,[not_attack,_q,1,_safe],[let,_safeext,['cons-atom',_q,_safe],[nqueens_aux,_r,_safeext]],[empty]]]]])

```
```ast
[ =,
  mc__nqueens_aux(_unplaced,_safe,A),
  [ [ prolog_if,
      [ [assign,B,[]],
        [ assign,
          C,
          [ call(==), _unplaced,B]],
        [ native(is_True),
          C]],
      [ [ assign,  A   ,_safe ]],
      [ [ assign,
          D,
          [ call(select),
            _unplaced]],
        [ assign,
          [_q,_r],
          D],
        [ prolog_if,
          [ [ assign,
              E,
              [ call(not_attack), _q,1,_safe]],
            [ native(is_True),
              E]],
          [ [ assign,
              _safeext,
              [ call('cons-atom'), _q,_safe]],
            [ assign,
              F,
              [ call(nqueens_aux), _r,_safeext]],
            [assign,G,F]],
          [ [ assign,
              H,
              [call(empty)]],
            [assign,G,H]]],
        [assign,A,G]]]]].
```
```prolog
*/

mc__nqueens_aux(_unplaced, _safe, A) :-
    (   B=[],
        'mc__=='(_unplaced, B, C),
        is_True(C)
    *-> A=_safe
    ;   mc__select(_unplaced, D),
        [_q, _r]=D,
        (   mc__not_attack(_q, 1, _safe, E),
            is_True(E)
        *-> 'mc__cons-atom'(_q, _safe, _safeext),
            mc__nqueens_aux(_r, _safeext, F),
            G=F
        ;   mc__empty(H),
            G=H
        ),
        A=G
    ).


/*
```
```metta
 (= (nqueens $n)
  (let $r
    (range 1 $n)
    (nqueens_aux $r ())))
```
```load
; Action: load=metta_atom_asserted('&self',[=,[nqueens,_n],[let,_r,[range,1,_n],[nqueens_aux,_r,[]]]])

```
```ast
[ =,
  mc__nqueens(_n,A),
  [ [ assign,
      _r,
      [ call(range), 1,_n]],
    [assign,B,[]],
    [ assign,
      A,
      [ call(nqueens_aux), _r,B]]]].
```
```prolog
*/

mc__nqueens(_n, A) :-
    mc__range(1, _n, _r),
    B=[],
    mc__nqueens_aux(_r, B, A).

/*
```
```metta
!(nqueens 7)

```
```prolog
*/

    :- do_metta_runtime(A, mc__nqueens(12, A)).
    :- do_metta_runtime(A, mc__nqueens(13, A)).
    :- do_metta_runtime(A, mc__nqueens(14, A)).


/*
```
```answers

Deterministic: $10000
% 993,758 inferences, 0.105 CPU in 0.106 seconds (99% CPU, 9433796 Lips)
;                       #( = /home/deb12user/metta-wam/tests/direct_comp/easy/format_args_ordered.metta 0 )
<br/> <a href="#" onclick="window.history.back(); return false;">Return to summaries</a><br/>
;         #(is_cmd_option execute stdin --stdin=tty tty)
;          #(set_option_value stdin tty)
;          #(is_cmd_option execute stdout --stdout=tty tty)
;          #(set_option_value stdout tty)
;          #(is_cmd_option execute stderr --stderr=tty tty)
;           #(set_option_value stderr tty)
;         #(set_option_value compat false)
;         #(set_option_value compatio false)
;         #(set_option_value src_indents false)
;         #(set_option_value devel false)
;         #(set_option_value stack-max 500)
;         #(set_option_value limit inf)
;         #(set_option_value initial-result-count 10)
;         #(set_option_value answer-format show)
;         #(set_option_value repeats true)
;         #(set_option_value time true)
;         #(set_option_value synth-unit-tests false)
;         #(set_option_value optimize true)
;         #(set_option_value transpiler silent)
;          #(set_debug transpiler false)
;         #(set_option_value compile false)
;         #(set_option_value tabling auto)
;         #(set_option_value log false)
;         #(set_option_value output ./)
;         #(set_option_value exeout ./Sav.gitlab.MeTTaLog)
;         #(set_option_value halt false)
;         #(set_option_value trace-length 500)
;         #(set_option_value trace-on-overtime 4.0)
;          #(set_debug overtime 4.0)
;         #(set_option_value trace-on-overflow 1000)
;          #(set_debug overflow 1000)
;         #(set_option_value trace-on-eval false)
;          #(set_debug eval false)
;         #(set_option_value trace-on-load silent)
;          #(set_debug load silent)
;          #(set_debug trace-on-load false)
;         #(set_option_value trace-on-exec false)
;          #(set_debug exec false)
;         #(set_option_value trace-on-error non-type)
;          #(set_debug error non-type)
;         #(set_option_value trace-on-fail false)
;          #(set_debug fail false)
;         #(set_option_value trace-on-test true)
;          #(set_debug test true)
;         #(set_option_value repl-on-error true)
;         #(set_option_value repl-on-fail false)
;         #(set_option_value exit-on-fail false)
;         #(set_option_value repl auto)
;         #(set_option_value prolog false)
;         #(set_option_value exec noskip)
;         #(set_option_value maximum-result-count inf)
;         #(set_option_value html false)
;         #(set_option_value python true)
;         #(set_option_value trace-on-test false)
;          #(set_debug test false)
;         #(set_option_value trace-on-fail false)
;          #(set_debug fail false)
;         #(set_option_value load show)
;         #(set_option_value test true)
[$10000]
;         #(maybe_halt 7)
#(in #(maybe_halt 7) #(unwind #(halt 7)))
```
*/

