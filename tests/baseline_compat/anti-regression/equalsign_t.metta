
; Define the type `T` and the logical equivalence for reflexivity
(: T Type)
(= (= $x $x) T)

; Test: Get the type of `=` before declaring its type
;!(assertEqual (get-type =) (-> $t $t Atom))
!(get-type =) 

; Declare the type of `=` explicitly
(: = (-> $t $t Type))

; Test: Get the type of `=` after declaring its type
!(get-type =)
; ((-> $t $t Atom) (-> $t $t Type)))

; Test: Reflexivity with numbers
!(assertEqualToResult (= 1 1) (T))

; Test: Non-equivalence with different numbers
!(assertEqualToResult (= 1 2) ((= 1 2)))

; Test: Reflexivity with variables
!(assertEqualToResult (= 1 $x) (T))

; Test: Reflexivity with arithmetic expressions
!(assertEqualToResult (= 1 (+ 0 1)) (T))

