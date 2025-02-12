; Bug Report #231: MeTTaLog fails to correctly evaluate a curried nested call
; Description: Curried nested calls fail when not flattened in MeTTaLog.

; Original curried function test that fails
(= (foo A) A)
(= ((bar $x) $x) (== $x (foo $x)))
!(assertEqualToResult ((bar A) A) (True)) ; In Nil's bug report the test fails; expected [True], got [False]

(= ((bar1 $x) $y) (== $x (foo $y)))  ; Douglas wonders if this was an issue
!(assertEqualToResult ((bar1 A) A) (True)) 

; Alternative working scenario using non-curried format
; Replacing the curried function with a non-curried version solves the issue
(= (bar2 $x $x) (== $x (foo $x)))
!(assertEqualToResult (bar2 A A) (True)) ; Test passes; correctly evaluates to [True]








