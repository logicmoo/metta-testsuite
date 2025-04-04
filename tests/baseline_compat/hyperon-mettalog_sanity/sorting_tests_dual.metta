
;; Define a generic less than operator, lessThan, for Nat.  < cannot be used
;; because it is a built-in, its type is hardwired and cannot be
;; overloaded.
(: lessThan (-> Number Number Bool))
(= (lessThan $x $y) (< $x $y))
(: lessThan (-> Nat Nat Bool))
(= (lessThan $_ Z) False)
(= (lessThan Z (S $_)) True)
(= (lessThan (S $x) (S $y)) (lessThan $x $y))


;; Test when the first number is zero
!(assertEqual (lessThan Z (S Z)) True)        ;; 0 < 1
!(assertEqual (lessThan Z (S (S Z))) True)    ;; 0 < 2
!(assertEqual (lessThan Z Z) False)          ;; 0 < 0


!(assertEqual (lessThan 0 1) True)        ;; 0 < 1
!(assertEqual (lessThan 0 2) True)    ;; 0 < 2
!(assertEqual (lessThan 0 0) False)          ;; 0 < 0



