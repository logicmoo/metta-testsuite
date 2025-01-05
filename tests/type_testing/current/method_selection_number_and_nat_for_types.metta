
;; TALKABOUT

;; Define Nat
(: Nat Type)
(: Z Nat)
(: S (-> Nat Nat))


;; Define a generic less than operator, genericLT, for Nat.  < cannot be used
;; because it is a built-in, its type is hardwired and cannot be
;; overloaded.
(: genericLT (-> Nat Nat Bool))
(= (genericLT $_ Z) False)
(= (genericLT Z (S $_)) True)
(= (genericLT (S $x) (S $y)) (genericLT $x $y))

;; Overload genericLT for Number.
(: genericLT (-> Number Number Bool))
(= (genericLT $x $y) (< $x $y))
; (= (genericLT $x $y) (let (Number Number) ((get-type $x) (get-type $y)) (< $x $y)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tests for genericLT
;;;;;;;;;;;;;;;;;;;;;;;;;

!(assertEqualToResult (genericLT Z (S Z)) (True))
!(assertEqualToResult (genericLT (S Z) Z) (False))
!(assertEqualToResult (genericLT 0 1) (True))
!(assertEqualToResult (genericLT 1 0) (False))
!(assertEqualToResult (genericLT (+ 1 2) (+ 3 4)) (True))
!(assertEqualToResult (genericLT 10 10) (False))
!(assertEqualToResult (genericLT (+ 1 9) (+ 5 5)) (False))
!(assertEqualToResult (genericLT 10 11) (True))


