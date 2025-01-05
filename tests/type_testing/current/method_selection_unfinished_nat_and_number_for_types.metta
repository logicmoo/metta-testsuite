
;; Declares `Nat` as a new type representing natural numbers, enabling the construction of numbers using `Z` and `S`.
(: Nat Type)

;; Declares `Z` (zero) as a constructor of type `Nat`, representing the base case for natural numbers.
(: Z Nat)
;; Declares `S` (successor) as a function that takes a `Nat` and returns a `Nat`, representing the next number in the sequence.
(: S (-> Nat Nat))


;; Define a generic less than operator, genericLT, for Nat.
;; Declares `genericLT` as a function that compares two `Nat` values and returns a boolean (`True` or `False`).
(: genericLT (-> Nat Nat Bool))

;; Defines the behavior of `genericLT` for the case where any number is compared to `Z`.
(= (genericLT $_ Z) False) ;; Any number is not less than `Z`, so it returns `False`.
;; Defines the behavior of `genericLT` when comparing `Z` with any successor value.
(= (genericLT Z (S $_)) True) ;; `Z` is always less than any successor (`S`), so it returns `True`.
;; Defines the recursive behavior of `genericLT` for successors. 
(= (genericLT (S $x) (S $y)) (genericLT $x $y)) ; To compare two successors, recursively compare their predecessors.


;; Overload genericLT for Number.
;; Declares a new `genericLT` function for the `Number` type, allowing comparisons of non-`Nat` numeric types.
(: genericLT (-> Number Number Bool))

;; Example code for mapping `genericLT` to the built-in `<` operator.
;; This line is commented out because it's not implemented in the current context.
; dont add this though (= (genericLT $x $y) (< $x $y))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tests for genericLT
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Tests that `genericLT` correctly evaluates `Z` as less than `S Z`, returning `True`.
!(assertEqualToResult (genericLT Z (S Z)) (True))

;; Tests that `genericLT` correctly evaluates `S Z` as not less than `Z`, returning `False`.
!(assertEqualToResult (genericLT (S Z) Z) (False))

;; Tests that `genericLT` can handle numbers (`0` and `1`) but does not simplify the expression, leaving it unevaluated.
!(assertEqualToResult (genericLT 0 1) ((genericLT 0 1)))

;; Tests another unevaluated case for numbers, showing that `1` is not simplified relative to `0`.
!(assertEqualToResult (genericLT 1 0) ((genericLT 1 0)))

;; Tests how `genericLT` handles invalid input types such as strings.
;; When strings like `"1"` and `"0"` are passed, it raises a type error.
!(assertEqualToResult (genericLT "1" "0") ((Error "1" BadType) (Error "1" BadType)))

;; Tests how `genericLT` handles unevaluated addition expressions with unknown inputs.
;; These are left unevaluated because `unknown_A` and `unknown_B` could be valid numbers.
!(assertEqualToResult (genericLT unknown_A unknown_B) ((genericLT unknown_A unknown_B)))

;; Tests how `genericLT` handles evaluated addition results.
;; For example, comparing the sum `3` (`1+2`) with `7` (`3+4`).
!(assertEqualToResult (genericLT (+ 1 2) (+ 3 4)) ((genericLT 3 7)))

;; C_or_D type test
;; Declares `known_C` and `known_D` as values of type `C_or_D`, representing user-defined or custom types.
(: known_C C_or_D)
(: known_D C_or_D)

;; Tests error handling when comparing values of the custom `C_or_D`.
;; `genericLT` raises a type error because it cannot compare `C_or_D` values by default.
!(assertEqualToResult (genericLT known_C known_C) ((Error known_C BadType) (Error known_C BadType)))

;; Extends `genericLT` to allow comparisons for any type `$SameTypes`.
;; This makes `genericLT` generic and capable of handling comparisons for types beyond `Nat` and `Number`.
(: genericLT (-> $SameTypes $SameTypes Bool))

;; Tests the new generic `genericLT` with identical `C_or_D` values.
;; Instead of raising an error, it returns an unevaluated comparison.
!(assertEqualToResult (genericLT known_C known_C) ((genericLT known_C known_C)))

;; Redefines `genericLT` to compare two values based on inequality.
;; If two values are equal, it returns `False`; if they are not equal, it returns the orignal .. (`NotReducible` is not working?!)
(= (genericLT $x $y) (if (== $x $y) False (let (quote $ret) (quote (genericLT $x $y)) $ret)))

;; Tests the new generic `genericLT` with identical `C_or_D` values.
;; Evaluates to `False` since `known_C` is equal to itself and therefore not less than itself.
!(assertEqualToResult (genericLT known_C known_C) (False))

;; Tests the new generic `genericLT` with identical numeric values.
;; Evaluates to `False` since `10` is equal to `10`.
!(assertEqualToResult (genericLT 10 10) (False))

;; Tests the new generic `genericLT` with evaluated addition expressions resulting in equal values.
;; Evaluates to `False` since `1+9` equals `5+5`, both resulting in `10`.
!(assertEqualToResult (genericLT (+ 1 9) (+ 5 5)) (False))

;; Tests the new generic `genericLT` with different `C_or_D` values.
;; Since `known_C` and `known_D` are not equal and the comparison is not defined, it returns `NotReducible`.
!(assertEqualToResult (genericLT known_C known_D) ((genericLT known_C known_D)))

;; Tests the new generic `genericLT` with different numeric values.
;; Since `10` is not equal to `11` and the comparison is not defined, it returns `NotReducible`.
!(assertEqualToResult (genericLT 10 11) ((genericLT 10 11)))

;; Tests ***NOW*** `genericLT` handles string inputs that are not comparable.
;; Since strings like `"1"` and `"0"` are not comparable, it returns the unevaluated comparison.
!(assertEqualToResult (genericLT "1" "0") ((genericLT "1" "0")))

;; Tests ***NOW*** `genericLT` handles identical string inputs.
;; Since the strings are equal, it returns `False`.
!(assertEqualToResult (genericLT "1" "1") (False))



;; GEt rid of all type errors (but it adds an extra soluation to Nat.. why
(: genericLT (-> Atom Atom Bool))

!(assertEqualToResult (genericLT Z (S Z)) ((genericLT Z (S Z)) True))
!(assertEqualToResult (genericLT (S Z) Z) ((genericLT (S Z) Z) False))
!(assertEqualToResult (genericLT 0 1) ((genericLT 0 1)))
!(assertEqualToResult (genericLT 1 0) ((genericLT 1 0)))
!(assertEqualToResult (genericLT "1" "0") ((genericLT "1" "0")))
!(assertEqualToResult (genericLT unknown_A unknown_B) ((genericLT unknown_A unknown_B)))
!(assertEqualToResult (genericLT (+ 1 2) (+ 3 4)) ((genericLT 3 7)))
!(assertEqualToResult (genericLT known_C known_C) (False))
!(assertEqualToResult (genericLT 10 10) (False))
!(assertEqualToResult (genericLT (+ 1 9) (+ 5 5)) (False))
!(assertEqualToResult (genericLT known_C known_D) ((genericLT known_C known_D)))
!(assertEqualToResult (genericLT 10 11) ((genericLT 10 11)))
!(assertEqualToResult (genericLT "1" "0") ((genericLT "1" "0")))
!(assertEqualToResult (genericLT "1" "1") (False))

