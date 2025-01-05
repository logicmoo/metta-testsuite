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
(= (some_value) $V)                    ; Variable
(= (some_value) (Cons 1 (Cons 2 (Cons 3 Nil)))) ; Example List
(= (some_value) (+ 2 3))               ; Returns number  
(= (some_value) (println! ""))   ; Returns empty
(= (some_value) (empty))               ; Returns empty
(= (some_value) ())                    ; Empty Expression (not empty like teh tow above)
(= (some_value) (format_args "x: {} y: {}" (1 2))) ; Formatted string
(= (some_value) S)                     ; Symbol (not a Nat)
(= (some_value) Z)                     ; Nat
(= (some_value) (S Z))                 ; Nat
(= (some_value) String)                ; Type
(= (some_value) (S (S Z)))             ; Nat
; (= (some_value) &self)                 ; Grounded Space

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

(= (filter_String $a) $a)
(= (filter_Number $a) $a)
(= (filter_Nat $a) $a)
(= (filter_Symbol $a) $a)
(= (filter_Variable $a) $a)
(= (filter_Grounded $a) $a)
(= (filter_Type $a) $a)
(= (filter__Undefined_ $a) $a)
(= (filter_TVar $a) $a)
(= (filter_Undeclared $a) $a)
(= (filter_Expression $a) $a)
(= (filter_Atom $a) $a)
(= (filter_ExpressionNumber $a) $a)
(= (filter_ExpressionUnit $a) $a)
(= (filter_ExpressionAtom $a) $a)
(= (filter_AtomAtom $a) $a)
(= (filter_Char $a) $a)
(= (filter_Empty $a) $a)
(= (filter_List $a) $a)

(: assertEither (-> String Atom Atom Atom Atom))

(= (assertEither $Name $Form $List $passes)
  (let ($n $res $qform) ($Name (collapse $Form) (quote $Form))
   (case $res 
    ( 
     ($List (println! (format_args "
     (assertEither \"{}\" {} 
        {} 
        {})" ($Name $Form $List $passes))))
     ($_    (println! (format_args "
     (assertEither \"{}\" {} 
       {} 
       {})" ($Name $Form $List $res))))
     ))))

!(assertEither "Should be Passing"  (+ 1 1) (2) $passes)

;; returns of appropriate type
!(assertEither "filter_Number" (filter_Number (some_value))  (1 5) ($X 1 String () 5))  ;; hyperon returns [1, String, (), 5]

!(assertEither "passing"  (+ 1 1) (2) $passes)


!(assertEither "filter_String" (filter_String (some_value)) ("a" "x: 1 y: 2") $passes )  ;; "a", String, "x: 1 y: 2", ()

;; Tests for filter_Nat
!(assertEither "filter_Nat"  (filter_Nat (some_value)) (Z (S Z) (S (S Z))) $passes)

;; Tests for filter_Symbol
!(assertEither "filter_Symbol"  (filter_Symbol (some_value)) (S &self) $passes) 

;; Tests for filter_Variable
!(assertEither "filter_Variable"  (filter_Variable (some_value)) (&self) $passes)  ;; Example case

;; Tests for filter_Grounded
!(assertEither "filter_Grounded"  (filter_Grounded (some_value)) (1 "a" 'c' Z (S Z)) $passes)

;; Tests for filter_Type
!(assertEither "filter_Type"  (filter_Type (some_value)) (String) $passes)

;; Tests for filter_%Undefined%
!(assertEither "filter_%Undefined%"  (filter_%Undefined% (some_value)) (all the values) $passes)

;; Tests for filter_TVar
!(assertEither "filter_TVar"  (filter_TVar (some_value)) (1 "a" Z (S Z) (S (S Z))) $passes)

;; Tests for filter_Undeclared
!(assertEither "filter_Undeclared"  (filter_Undeclared (some_value)) () $passes)

;; Tests for filter_Expression
!(assertEither "filter_Expression"  (filter_Expression (some_value)) ((+ 2 3) (format_args "x: {} y: {}" (1 2))) $passes)

;; Tests for filter_Atom
!(assertEither "filter_Atom"  (filter_Atom (some_value)) (1 "a" 'c' S Z (S Z)) $passes)

;; Tests for filter_ExpressionNumber
!(assertEither "filter_ExpressionNumber"  (filter_ExpressionNumber (some_value)) ((+ 2 3)) $passes)

;; Tests for filter_ExpressionUnit
!(assertEither "filter_ExpressionUnit"  (filter_ExpressionUnit (some_value)) (empty (println! "did it")) $passes)

;; Tests for filter_ExpressionAtom
!(assertEither "filter_ExpressionAtom"  (filter_ExpressionAtom (some_value)) () $passes)

;; Tests for filter_AtomAtom
!(assertEither "filter_AtomAtom"  (filter_AtomAtom (some_value))  
  (Z String "a" 1 'c' $X S (Cons 1 (Cons 2 (Cons 3 Nil))) () 5 (S Z) "x: 1 y: 2" (S (S Z)) ()) $passes)

;; Tests for filter_Char
!(assertEither "filter_Char"  (filter_Char (some_value)) ('c') $passes)

;; Tests for filter_Empty
!(assertEither "filter_Empty"  (filter_Empty (some_value)) (empty (println! "did it") ()) $passes)

;; Tests for filter_List
!(assertEither "filter_List"  (filter_List (some_value)) ((Cons 1 (Cons 2 (Cons 3 Nil)))) $passes)
