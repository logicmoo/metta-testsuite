
;; Define Nat
(: Nat Type)
(: Z Nat)
(: S (-> Nat Nat))

;; TALKABOUT
;; Define a generic less than operator, lessThanMS, for Nat.  < cannot be used
;; because it is a built-in, its type is hardwired and cannot be
;; overloaded.
(: lessThanMS (-> Nat Nat Bool))
(= (lessThanMS $_ Z) False)
(= (lessThanMS Z (S $_)) True)
(= (lessThanMS (S $x) (S $y)) (lessThanMS $x $y))
;; Overload lessThanMS for Number.
(: lessThanMS (-> Number Number Bool))
(= (lessThanMS $x $y) (< $x $y))

(: lessThanMS MismatchFail)
(: lessThanMS Deterministic)
(: lessThanMS Nifty)

!("============ Test lessThanMS ============")

;; Tests for Nat
!(assertEqualToResult (lessThanMS Z (S Z)) (True))         ;; 0 < 1 (Nat)
!(assertEqualToResult (lessThanMS Z Z) (False))           ;; 0 < 0 (Nat)
!(assertEqualToResult (lessThanMS (S Z) Z) (False))       ;; 1 < 0 (Nat)
!(assertEqualToResult (lessThanMS (S Z) (S Z)) (False))   ;; 1 < 1 (Nat)
!(assertEqualToResult (lessThanMS (S Z) (S (S Z))) (True)) ;; 1 < 2 (Nat)
!(assertEqualToResult (lessThanMS (S (S Z)) (S (S Z))) (False)) ;; 2 < 2 (Nat)
!(assertEqualToResult (lessThanMS (S (S Z)) (S Z)) (False)) ;; 2 < 1 (Nat)
!(assertEqualToResult (lessThanMS (S Z) (S (S (S Z)))) (True)) ;; 1 < 3 (Nat)

;; Tests for Number
!(assertEqualToResult (lessThanMS 0 1) (True))            ;; 0 < 1 (Number)
!(assertEqualToResult (lessThanMS 0 0) (False))           ;; 0 < 0 (Number)
!(assertEqualToResult (lessThanMS 1 0) (False))           ;; 1 < 0 (Number)
!(assertEqualToResult (lessThanMS 2 2) (False))           ;; 2 < 2 (Number)
!(assertEqualToResult (lessThanMS 1 2) (True))            ;; 1 < 2 (Number)
!(assertEqualToResult (lessThanMS 3 2) (False))           ;; 3 < 2 (Number)


;; TALKABOUT
;; Mixed tests to ensure no type confusion
!(assertEqualToResult (lessThanMS Z 0) ())           ;; Z < 0 (Nat and Number)
!(assertEqualToResult (lessThanMS 0 Z) ())           ;; 0 < Z (Number and Nat)
!(assertEqualToResult (lessThanMS Z 1) ())            ;; Z < 1 (Nat and Number)
!(assertEqualToResult (lessThanMS 1 Z) ())           ;; 1 < Z (Number and Nat)
!(assertEqualToResult (lessThanMS (S Z) 1) ())       ;; 1 (Nat) < 1 (Number)
!(assertEqualToResult (lessThanMS 1 (S Z)) ())       ;; 1 (Number) < 1 (Nat)
!(assertEqualToResult (lessThanMS (S (S Z)) 3) ())    ;; 2 (Nat) < 3 (Number)
!(assertEqualToResult (lessThanMS 2 (S (S Z))) ())   ;; 2 (Number) < 2 (Nat)

!("============ End Tests ============")

