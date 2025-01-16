; -----------------------------------------------------
; Curried plus
; -----------------------------------------------------
(: plus (-> Number (-> Number Number)))  ; 'plus' is declared as a function that takes one Number
                                         ; and returns another function (-> Number Number),
                                         ; i.e., it's curried: plus x -> (function that adds x).
(= ((plus $x) $y) (+ $x $y))             ; Definition: applying (plus x) to y gives x + y.

;!(plus 4)

;!(repl!)

!(assertEqualToResult ((plus 4) 2) (6))  ; Tests the curried call: (plus 4) -> function that adds 4.
                                         ; Then applying to 2 yields 6.



; -----------------------------------------------------
; Define inc as a partial evaluation of plus
; -----------------------------------------------------
(: inc (-> (-> Number Number)))          ; 'inc' is declared as a function with no arguments,
                                         ; returning (-> Number Number). i.e., calling 'inc'
                                         ; yields a function that takes a Number -> Number.
(= (inc) (plus 1))                       ; 'inc' returns the partially applied 'plus 1',
                                         ; which adds 1 to its argument.

!(assertEqualToResult ((inc) 2) (3))     ; Test: (inc) produces a function "x -> x+1".
                                         ; Applying that to 2 should give 3.

; -----------------------------------------------------
; Begin MEttaLog team's code
; -----------------------------------------------------

; !(repl!)


; After partially applying 'plus' with 4, we should get a function from Number -> Number.
!(assertEqualToResult (get-type (plus 4)) ((-> Number Number)))

; 'inc' is a zero-arg function returning (-> Number Number).
!(assertEqualToResult (get-type inc) ((-> (-> Number Number))))

; (inc) itself is that one-arg function (-> Number Number).
!(assertEqualToResult (get-type (inc)) ((-> Number Number)))

; -----------------------------------------------------
; implicit curry?
; -----------------------------------------------------
!(H-E-was !((+ 4) 3)) ; Some interpreters might let you do (+ 4) -> function that adds 4.
                         ; Then apply it to 3, expecting 7 (implicit partial application).
; (H-E-was Empty)


; -----------------------------------------------------
; Define plus4
; -----------------------------------------------------
(: plus4 (-> Number Number))             ; plus4 is a function from Number -> Number.
(= (plus4 $x) (+ 4 $x))                  ; plus4 x = 4 + x.

; Test: plus4 4 -> 8.
!(assertEqualToResult (plus4 4) (8))     

; Confirm plus4 is indeed (-> Number Number).
!(assertEqualToResult (get-type plus4) ((-> Number Number)))


; -----------------------------------------------------
; ; Checking that (-> Number Number) is recognized as that type itself.
; -----------------------------------------------------
!(H-E-was (get-type (-> Number Number))) 
; (H-E-was %Undefined%)   ; maybe `UnaryNumericFunction` is better answer!

; Another check: (plus 4) 5 -> 9.
!(assertEqualToResult ((plus 4) 5) (9)) 

; -----------------------------------------------------
; curried calling curried (to make a lambda)
; -----------------------------------------------------
; 'plus-some' is essentially the same as 'plus', but declared separately.
; Taking x returns the function that adds x.
(: plus-some (-> Number (-> Number Number)))
(= (plus-some $x) (plus $x))

; Test: (plus-some 4) 6 -> 10 (4 + 6).
!(assertEqualToResult ((plus-some 4) 6) (10)) 

