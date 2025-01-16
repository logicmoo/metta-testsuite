;; Define Nat
(: Nat Type)
(: Z Nat)
(: S (-> Nat Nat))

;; Define List
(: List (-> $a Type))
(: Nil (List $a))
(: Cons (-> $a (List $a) (List $a)))

;; Define some_value returning various types
(= (some_value) 1)                     ; Number
(= (some_value) "a")                   ; String
(= (some_value) 'c')                   ; Char
(= (some_value) (Cons 1 (Cons 2 (Cons 3 Nil)))) ; Example List
(= (some_value) (+ 2 3))               ; Returns number  
(= (some_value) (println! ""))   ; Returns empty
(= (some_value) (empty))               ; Returns empty


(= (some_value) (format-args "x: {} y: {}" (1 2))) ; Formatted string
(= (some_value) S)                     ; Symbol (not a Nat)
(= (some_value) Z)                     ; Nat
(= (some_value) (S Z))                 ; Nat
(= (some_value) (S (S Z)))             ; Nat

(= (some_value) ())                    ; Empty Expression (not empty like teh tow above)
(= (some_value) String)                ; Type
(= (some_value) $V)                    ; Variable
(= (some_value) &self)                 ; Grounded Space

;; filter definitions
(: filter_String (-> String $t))
(: filter_Number (-> Number $t))
(: filter_Nat (-> Nat $t))
(: filter_Symbol (-> Symbol $t))
(: filter_Variable (-> Variable $t))
(: filter_Grounded (-> Grounded $t))
(: filter_Type (-> Type $t))
(: filter__Undefined_ (-> %Undefined% $t))
(: filter_TVar (-> $t $t))
(: filter_Undeclared (-> Undeclared $t)) ; undeclared type
(: filter_Expression (-> Expression $t))
(: filter_Atom (-> Atom $t))
(: filter_ExpressionNumber (-> Expression Number))
(: filter_ExpressionUnit (-> Expression (->)))
(: filter_ExpressionAtom (-> Expression Atom))
(: filter_AtomAtom (-> Atom Atom))
(: filter_Char (-> Char $t))
(: filter_Empty (-> Empty $t))
(: filter_List (-> (List $a) $t))

(= (filter_String $a) (quote $a))
(= (filter_Number $a) (quote $a))
(= (filter_Nat $a) (quote $a))
(= (filter_Symbol $a) (quote $a))
(= (filter_Variable $a) (quote $a))
(= (filter_Grounded $a) (quote $a))
(= (filter_Type $a) (quote $a))
(= (filter__Undefined_ $a) (quote $a))
(= (filter_TVar $a) (quote $a))
(= (filter_Undeclared $a) (quote $a))
(= (filter_Expression $a) (quote $a))
(= (filter_Atom $a) (quote $a))
(= (filter_ExpressionNumber $a) (quote $a))
(= (filter_ExpressionUnit $a) (quote $a))
(= (filter_ExpressionAtom $a) (quote $a))
(= (filter_AtomAtom $a) (quote $a))
(= (filter_Char $a) (quote $a))
(= (filter_Empty $a) (quote $a))
(= (filter_List $a) (quote $a))

(: assertEither (-> String Atom Atom Atom Atom))

(= (assertEither $Name $Form $List $passes)
  (let ($n $res $qform) ($Name (collapse $Form) (quote $Form))
   (case $res 
	( 
	 ($List (let $_1 (println! (format-args 
"
;; Tests for {}
!(assertEither \"{}\" {} \t{} \t{})"  ($Name $Name $Form $List $passes))) ($Name $res)))
	 ($_    (let $_1 (println! (format-args 
"
;; Tests for {}
!(assertEither \"{}\" {} \t{} \t{})" ($Name $Name $Form $List $res))) ($Name $res)) )))))




;; Tests for filter_Number
!(assertEither "filter_Number" (filter_Number (some_value))     ((quote $X_568) (quote String) (quote 1) (quote 5) (quote ()))  $passes)

;; Tests for filter_String
!(assertEither "filter_String" (filter_String (some_value))     ((quote $X_2332) (quote "a") (quote String) (quote ()) (quote "x: 1 y: 2"))     $passes)

;; Tests for filter_Nat
!(assertEither "filter_Nat" (filter_Nat (some_value))   		((quote $X) (quote String) (quote Z) (quote (S Z)) (quote (S (S Z))) (quote ()))   $passes)

;; Tests for filter_Symbol
!(assertEither "filter_Symbol" (filter_Symbol (some_value))     ((quote $X) (quote S) (quote String) (quote Z) (quote ()))         $passes)

;; Tests for filter_Variable
!(assertEither "filter_Variable" (filter_Variable (some_value)) ((quote $X) (quote String) (quote ()))     $passes)

;; Tests for filter_Undeclared
!(assertEither "filter_Undeclared" (filter_Undeclared (some_value))     ((quote $X_16306) (quote String) (quote ()))    $passes)

;; Tests for filter_Grounded
!(assertEither "filter_Grounded" (filter_Grounded (some_value))         ((quote $X_17422) (quote "a") (quote &self) (quote 'c') (quote String) (quote 1) (quote ()) (quote "x: 1 y: 2"))   $passes)

;; Tests for filter_Type
!(assertEither "filter_Type" (filter_Type (some_value))         ((quote $X_21653) (quote String) (quote ()))    $passes)

;; Tests for filter_Char
!(assertEither "filter_Char" (filter_Char (some_value))         ((quote $X_22769) (quote 'c') (quote String) (quote ()))        $passes)

;; Tests for filter_Empty
!(assertEither "filter_Empty" (filter_Empty (some_value))       ((quote $X_24034) (quote String) (quote ()))    $passes)

;; Tests for filter_List
!(assertEither "filter_List" (filter_List (some_value))         ((quote $X_25168) (quote String) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))))     $passes)


;; Tests for filter_%Undefined%
!(assertEither "filter__Undefined_" (filter__Undefined_ (some_value)) 		                 ((quote $a) (quote "a") (quote &self) (quote 'c') 
																										(quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) 
																										(quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) 
																																						  (quote "x: 1 y: 2"))         $passes)



;; Tests for filter_Expression
!(assertEither "filter_Expression" (let $a (some_value) (filter_Expression $a))         		((quote $a) (quote "a") (quote &self) (quote 'c') 
																										(quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) 
																										(quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) 
																																						  (quote "x: 1 y: 2"))         $passes)


;; Tests for filter_TVar
!(assertEither "filter_TVar" (filter_TVar (some_value))         						    ((quote $X_8652) (quote "a") (quote &self) (quote 'c') (quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) (quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) (quote "x: 1 y: 2"))    $passes)


;; Tests for filter_Atom
!(assertEither "filter_Atom" (let $a (some_value) (filter_Atom $a))     						((quote $a) (quote "a") (quote &self) (quote 'c') (quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) (quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) (quote "x: 1 y: 2"))         $passes)


;; Tests for filter_ExpressionNumber
!(assertEither "filter_ExpressionNumber" (let $a (some_value) (filter_ExpressionNumber $a))     ((quote $a) (quote "a") (quote &self) (quote 'c') (quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) (quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) (quote "x: 1 y: 2"))         $passes)


;; Tests for filter_ExpressionUnit
!(assertEither "filter_ExpressionUnit" (let $a (some_value) (filter_ExpressionUnit $a))         ((quote $a) (quote "a") (quote &self) (quote 'c') (quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) (quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) (quote "x: 1 y: 2"))         $passes)


;; Tests for filter_ExpressionAtom
!(assertEither "filter_ExpressionAtom" (let $a (some_value) (filter_ExpressionAtom $a))         ((quote $a) (quote "a") (quote &self) (quote 'c') (quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) (quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) (quote "x: 1 y: 2"))         $passes)


;; Tests for filter_AtomAtom
!(assertEither "filter_AtomAtom" (let $a (some_value) (filter_AtomAtom $a))     				((quote $a) (quote "a") (quote &self) (quote 'c') (quote S) (quote String) (quote Z) (quote 1) (quote (S Z)) (quote (S (S Z))) (quote 5) (quote ()) (quote ()) (quote (Cons 1 (Cons 2 (Cons 3 Nil)))) (quote "x: 1 y: 2"))         $passes)




