

; Initialize a new state for exists-props
; !(bind! &exists-props (new-state Nil))
((context5 $ctx) :-
 (

   ; Define the structure of $Houses and initialize it
   (same $Houses 
      (Places (House $_1 $_2) 
      (Places (House $_3 $_4) 
      (Places (House $_5 $_6) 
      (Places (House $_7 $_8) 
      (Places (House $_9 $_10) Nil))))))
       
   ; Define $Props structure for all properties
   (same $Props 
      (Props nationality
      (Props color
      (Props pet
      (Props drink
      (Props smokes Nil))))))      
   
   ; Ensure $Props represents a specific structure
   (same $Props (Props $_H6 $_T6))
   ; Ensure $ctx is a combination of $Houses and $Props
   (same $ctx ($Houses $Props))

   ; Declare numerical properties for various attributes in the context
   (get-declare-num nationality $Num1 in the $ctx)
   (get-declare-num color $Num2 in the $ctx)
   (get-declare-num pet $Num3 in the $ctx)
   (get-declare-num drink $Num4 in the $ctx)
   (get-declare-num drink $Num5 in the $ctx) ; this should not change the context since its already there
   (get-declare-num smokes $Num6 in the $ctx)))


;; Main predicate to find the owner of the fish
((zebra-owner $Owner) :-
 (
    (context5 $ctx)

      
 ;; Clue 8: The man in the center house drinks milk
   (center-house $CenterHouse in the $ctx)
   (declare drink $CenterHouse milk in the $ctx)   
   
 ;; Clue 9: The Norwegian lives in the first house
   (first-house $FirstHouse in the $ctx)
   (declare nationality $FirstHouse norwegian in the $ctx)

 ;; Clue 14: The Norwegian lives next to the blue house
   (declare nationality $Norwegian norwegian in the $ctx)
   (next-to $Norwegian $HouseBlue in the $ctx)
   (declare color $HouseBlue blue in the $ctx)

 ;; Clue 1: The Brit lives in the red house
   (declare nationality $Brit brit in the $ctx)
   (declare color $Brit red in the $ctx)

 ;; Clue 2: The Swede keeps dogs as pets
   (declare nationality $Swede swede in the $ctx)
   (declare pet $Swede dog in the $ctx)

 ;; Clue 3: The Dane drinks tea
   (declare nationality $Dane dane in the $ctx)
   (declare drink $Dane tea in the $ctx)

 ;; Clue 4: The green house is immediately to the left of the white house
   (left-of $Green $White in the $ctx)
   (declare color $Green green in the $ctx)
   (declare color $White white in the $ctx)

 ;; Clue 5: The owner of the green house drinks coffee
   (declare color $Green green in the $ctx)
   (declare drink $Green coffee in the $ctx)

 ;; Clue 6: The person who smokes Pall Mall rears birds
   (declare smokes $PallMallSmoker pallmall in the $ctx)
   (declare pet $PallMallSmoker birds in the $ctx)

 ;; Clue 7: The owner of the yellow house smokes Dunhill
   (declare color $Yellow yellow in the $ctx)
   (declare smokes $Yellow dunhill in the $ctx)

 ;; Clue 10: The man who smokes Blends lives next to the one who keeps cats
   (declare smokes $SmokesBlends blends in the $ctx)
   (next-to $SmokesBlends $HouseCat in the $ctx)
   (declare pet $HouseCat cat in the $ctx)

 ;; Clue 11: The man who keeps horses lives next to the man who smokes Dunhill
   (declare pet $HorseKeeper horse in the $ctx)
   (next-to $HorseKeeper $SmokesDunhills in the $ctx)
   (declare smokes $SmokesDunhills dunhill in the $ctx)

 ;; Clue 12: The owner who smokes BlueMaster drinks beer
   (declare smokes $SmokesBlueMaster bluemaster in the $ctx)
   (declare drink $SmokesBlueMaster beer in the $ctx)

 ;; Clue 13: The German smokes Prince
   (declare nationality $German german in the $ctx)
   (declare smokes $German prince in the $ctx)

 ;; Clue 15: The man who smokes Blends has a neighbor who drinks water
   (declare smokes $BlendsSmoker blends in the $ctx)
   (next-to $BlendsSmoker $WaterDrinker in the $ctx)
   (declare drink $WaterDrinker water in the $ctx)

 ;; Determine who owns the fish
   (declare pet $FishOwner fish in the $ctx)
   (declare nationality $FishOwner $Owner in the $ctx)
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helper predicates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Initialize Houses as a list of uninitialized 'exists'
((init-houses $Num $Houses) :-
 (make-houses $Num $Houses))

;; Recursive creation of houses list based on number
((make-houses (S $N) ($Cons $House $Rest)) :-
 ((create-exists $House) ; Initialize a new 'exists' for the house
   (make-houses $N $Rest))) ; Continue for the remaining houses
(make-houses Z Nil) ; Base case: no houses left to create

;; Create an 'exists' structure for a house
(create-exists ($Cons $_1 $_1))

;; Predicate: $L is immediately to the left of $R in the list
((left-of $L $R in the $ctx) :-
 ((same $ctx ($Houses $_1)) ; Verify context contains the houses list
   (left-of-list $L $R $Houses)))

;; Helper for 'left-of' within a list structure
(left-of-list $L $R ($Cons $L ($Cons $R $_1))) ; Base case: $L is followed by $R
((left-of-list $L $R ($Cons $_1 $Rest)) :-
 ((left-of-list $L $R $Rest))) ; Recursive case: continue checking the list

;; Predicate: $A and $B are next to each other in the list
((next-to $A $B in the $ctx) :- 
 ((left-of $A $B in the $ctx))) ; $A is left of $B
((next-to $A $B in the $ctx) :-
 ((left-of $B $A in the $ctx))) ; $B is left of $A

;; Predicate: Get the first house in the list
((first-house $First in the $ctx) :-
 ((same $ctx ($Houses $_1)) ; Verify context contains houses
   (nat-nth Z $Houses $First))) ; First element (index 0)

;; Predicate: Get the center house in the list
((center-house $Center in the $ctx) :-
 ((same $ctx ($Houses $_1)) ; Verify context contains houses
   (nat-nth (S (S Z)) $Houses $Center))) ; Center element for 5 houses

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Property handling predicates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General property declaration predicate
((declare $PropName $Object $PropValue in the $ctx) :-
 ((get-declare-num $PropName $Num in the $ctx) ; Get position for the property
   (nat-nth $Num $Template $PropValue) ; Assign value to property
   (something-existing $Exists in the $ctx) ; Ensure object exists in houses
   (same $Template $Exists) (same $Template $Object)))

;; Ensure $Exists is a member of Houses
((something-existing $Exists in the $ctx) :-
 ((same $ctx ($Houses $_1)) ; Verify context contains houses
   (member $Exists $Houses))) ; Check if $Exists is in houses


;; Map property names to their positions (numbers)
((get-declare-num $PropName $Num in the $ctx) :-
  ((same ($_1 $PropList) $ctx) ; Extract property list from context
   (declare-index $PropName $PropList Z $Num))) ; Get index of property

;; Map property names using manual declaration with incremental indexing
(declare-index $PropName ($Cons $PropName $_1) $Num $Num) ; Found property
((declare-index $PropName ($Cons $Nonvar $Rest) $Acc $Num) :- 
 ((nonvar $Nonvar) (declare-index $PropName $Rest (S $Acc) $Num))) ; Increment index


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backward chaining logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;!(import! &self dv-pl)
;; Predicate signatures for backward chaining logic
(: cur= (-> Atom Atom)) ; Current goal
(: retVal= (-> Atom Atom)) ; Return value
(: goal= (-> Atom Atom)) ; Final goal

;; Interface for backward chaining (quotes the arguement)
(: backward-chain (-> Atom Atom Atom Atom Atom))
(= (backward-chain $info $goal $kb $rb)
  (backward-chain-q $info (quote $goal) $kb $rb))

;; Handle specific cases during backward chaining
(: backward-chain-q (-> Atom Atom Atom Atom Atom))
(= (backward-chain-q $info (quote $goal) $kb $rb)
	(case (quote $goal) (
		((quote (is $a $b)) (let $a $b (quote $goal))) ; Assignment
		((quote (bool $expr)) (if $expr (quote $goal) (empty))) ; Boolean evaluation
		((quote (eval= $a $expr)) (let $a $expr (quote $goal))) ; Expression evaluation
		((quote (nonvar $var)) (if (== Variable (get-metatype $var)) (empty) (quote $goal))) ; Non-variable check
        ((quote (var $var)) (if (== Variable (get-metatype $var)) (quote $goal) (empty))) ; Variable check
		((quote (true)) (quote $goal)) ; Always succeeds
		((quote (fail)) (empty)) ; Always fails
	    ((quote (cut $signal)) (if (equalz $info $signal) (quote $goal) (quote $goal))) ; Cut operator for pruning
		((quote (naf $expr)) (if (has-match $kb $expr) (empty) (quote $goal))) ; Negation as failure
		((quote (qnaf $expr)) (let (Failed $_1) (backward-chain $info2 $expr $kb $rb) (quote $goal))) ; Negation as failure at query level
		($_2 (backward-chain-q2 $info  (quote $goal) $kb $rb)) ; Match against knowledge base
	)))

(= (backward-chain-q2 $info  (quote $goal) $kb $rb)
   (match $kb $goal (quote $goal)))
;; Recursive case for backward chaining
(= (backward-chain-q2 $old_info  (quote $goal) $kb $rb)
  (function 
    (return ;; if $info is bound that means a clause has called a cut (thus we return empty)
	   (if (== Variable (get-metatype $old_info)) 	 
	    (let $r (match $rb ($goal :- $body)
		(match-body $info $body $kb $rb $goal))
		     (if (== Variable (get-metatype $info)) ;; if not cut
			    $r                                  ;; then return normal
			    (return $r)))                       ;; else return early
	    (empty)))))


;; Match predicate: checks if a goal has at least one match in a space
;; This is less efficient, as it processes the entire space to find matches
(: has-match (-> Atom Atom Bool))
(= (has-match $space $g)
	(let $m (collapse (match $space $g True)) ; Attempt to match $g in $space
		(if (== $m ()) ; If no match is found
			False ; Return False
			True ; Otherwise, return True
		)
	)
)

;; Predicate to check if a function definition exists in a given space
(= (has-fundef $space $g)
	(let $m (collapse (match $space (= $g $_1) True)) ; Match $g as a function in $space
		(if (== $m ()) ; If no match is found
			False ; Return False
			True ; Otherwise, return True
		)
	)
)

;; Chain through each element in the body and return the goal
(: match-body (-> Atom Atom Atom Atom Atom Atom))
(= (match-body $info $body $kb $rb $goal)
	(if (== $body ())
		(quote $goal) ; Base case: no more elements to match
		(let* (
			(($cur $rest) (decons-atom $body)) ; Deconstruct body
			($debugging False) ;; Print debug or not
		    ($bugcheck False)  ;; Catch a bug where we dont return the quoted goals
			(() (if $debugging (println! (quote (IN (cur= $cur) (goal= $goal)))) ())) ; Debugging: log input
			($_12 (if $bugcheck
				  (let*  (($retVal (backward-chain $info $cur $kb $rb)) ; Recursive chaining
						  ($m (collapse (equalz (quote $cur) $retVal))) ; Check match
						  (() (if (== $m ()) (println! (quote (BAD!!!!!!!! (cur= $cur) (retVal= $retVal))) ())))
						  ) ()) ()))
		    ((quote $cur) (backward-chain $info $cur $kb $rb)) ; Recursive chaining
			(() (if $debugging (println! (quote (OUT (cur= $cur) (goal= $goal)))) ())) ; Debugging: log output
		    ) 
			(match-body $info $rest $kb $rb $goal) ; Continue matching
		)
    )
)


;; Predicate for general atom equality
(: equalz (-> Atom Atom Bool)) ; Compares two atoms
(= (equalz $A $A) True) ; Atoms are equal if they are identical

(: quote-equalz (-> Atom Atom Bool))
(= (quote-equalz $A $A) True)
(= (quote-equalz $A $B) (equalz (quote $A) $B))
(= (quote-equalz $A $B) (equalz $A (quote $B)))

(: is-equals (-> %Undefined %Undefined% Bool)) ; Compares two atoms
(: is-equals (-> $t $t Bool)) ; Compares two things
(= (is-equals $A $A) True) ; Atoms are equal if they are identical

;; Define natural numbers using Zero (Z) and Successor (S)
(: Z Nat) ; Base case for natural numbers (0)
(: S (-> Nat Nat)) ; Successor function for incrementing natural numbers

;; Predicate for natural number equality
(: nat-equal (-> Nat Nat Bool)) ; Compares two natural numbers
(= (nat-equal $A $A) True) ; Two numbers are equal if they are identical


;; Query execution logic
(: query (-> Atom Atom Atom))
(= (query $kb $goal)
    (let $m (collapse (backward-chain $info $goal $kb  $kb))
		(if (== $m ()) (Failed (quote $goal)) (Succeed $m)))
)

(: query-f (-> Atom Atom Atom))
(= (query-f $kb $goal)
    (let $m (collapse (backward-chain $info $goal $kb  $kb))
		(if (== $m ()) Passed-Negation (Failed $m)))
)


;!(equalz $a (+ 1 1))
;!(is-equals 2 (+ 1 1))
;!(is-equals $b (+ 1 1))


;; Predicate: Check if an element is a member of a list
(member $Elem ($Cons $Elem $_1)) ; Base case: element found
((member $Elem ($Cons $_1 $Tail)) :-
 ((member $Elem $Tail))) ; Recursive case: continue checking


;; Zero-based natural number indexing in lists
(nat-nth Z ($Cons $Elem $_1) $Elem) ; Base case: first element
((nat-nth (S $N) ($Cons $_1 $Rest) $Elem) :-
 ((nat-nth $N $Rest $Elem))) ; Recursive case: move to next element

;; Append two lists
(cons-append Nil $List2 $List2) ; Base case: append empty list
((cons-append ($Cons $H $T) $List2 ($Cons $H $T2)) :-
 ((cons-append $T $List2 $T2))) ; Recursive case: append remaining elements

;; Predicate to check equality of two values
(same $x $x)

;; Predicate to get the last element of a list
(last $x ($Cons $x Nil)) ; Base case: last element
((last $x ($Cons $_1 $rest)) :- 
 ((last $x $rest))) ; Recursive case: move to next element

;; Calculate length of a list
(length Nil 0) ; Base case: empty list has length 0
((length ($Cons $_1 $rest) $out) :- 
   ((length $rest $out2) 
	(is $out (+ $out2 1)))) ; Recursive case: increment length

;; Calculate sum of natural numbers from 0 to $n
(sum 0 0) ; Base case: sum to 0 is 0
((sum $n $s) :- (
	(bool (> $n 0)) ; Ensure $n is positive
	(is $n1 (- $n 1)) ; Decrement $n
	(sum $n1 $s1) ; Calculate sum for smaller range
	(is $s (+ $n $s1)))) ; Add $n to sum of smaller range

;; Predicate to append lists
(append Nil $L $L) ; Base case: appending an empty list
((append ($Cons $H $T) $L ($Cons $H $R)) :- (
	(append $T $L $R) ; Recursive case: append remaining elements
))



;; Negation as failure test
((bachelor $x) :- (
    (man $x) ; $x must be a man
    (naf (married $x)) ; $x must not be married
))

; Facts: Men and marital status
(man John) (man Tim)
(married Tim)

;; Predicate to define a woman
((woman $x) :- (
    (naf (man $x)) ; $x is a woman if not a man
))

;;;;;;;;;;;;;;;;;
;; TEST Queries ;;
;;;;;;;;;;;;;;;;;

(: traced-eval (-> Atom Atom))
(= (traced-eval $arg) (traced-eval-q (quote $arg)))
(: traced-eval-q (-> Expression Atom))
(= (traced-eval-q (quote $arg))
   (let* (
	(() (println! (quote (====>EVAL $arg))))
	($r $arg)
	(() (println! (quote (RET<=== $r)))))
   $r))

(: progn (-> Atom Atom))
(= (progn $body) (progn-q (quote $body)))
(: progn-q (-> Expression Atom))
(= (progn-q (quote $body))
	(if (== (quote $body) (quote ())) ()
		(let* (
			(($head $rest) (decons-atom $body)) ; Deconstruct body
			($r (traced-eval-q (quote $head))))
			(if (== (quote $rest) (quote ())) 
			   $r (progn-q (quote $rest))))))

(= (test_normal_queries $kb)

 (progn-q (quote (

; Query for the last element in a list
 (query $kb (last $x ($Cons 1 ($Cons 2 ($Cons 3 Nil)))))

; Query for the length of a list
 (query $kb (length ($Cons 1 ($Cons 2 ($Cons 3 Nil))) $out))

; Query for the sum of numbers up to 3
 (query $kb (sum 3 $x))

; Query for appending lists
 (query $kb (append ($Cons 1 ($Cons 2 Nil)) ($Cons 3 ($Cons 4 Nil)) $x))
 (query $kb (append ($Cons 1 ($Cons 2 Nil)) $Out ($Cons 1 ($Cons 2 ($Cons 3 ($Cons 4 Nil))))))
 (query $kb (append $What $Out ($Cons 1 ($Cons 2 ($Cons 3 ($Cons 4 Nil))))))

;; Test list operations
 (query $kb (append ($Cons 1 Nil) ($Cons 2 ($Cons 3 Nil)) $Result)) ; Appending lists
 (query $kb (append ($Cons 1 ($Cons 2 Nil)) $Rest ($Cons 1 ($Cons 2 ($Cons 3 ($Cons 4 Nil)))))) ; Partial list append

;; Negation as failure tests with bachelors and marital status
 (query $kb (bachelor $x)) ; Finds bachelors who are not married
 (query-f $kb (woman Tim)) ; Tests failure for a man labeled as a woman
 (query $kb (woman Jane)) ; Should succeed for Jane if defined as a woman
 (query-f $kb (woman $x)) ; Negative query for undefined women

;; Check if an element is a member of a list
 (query $kb (member 3 ($Cons 1 ($Cons 2 ($Cons 3 Nil))))) ; Should succeed
 (query-f $kb (member 5 ($Cons 1 ($Cons 2 ($Cons 3 Nil))))) ; Should fail, 5 is not in the list
 (query $kb (member $x ($Cons 1 ($Cons 2 ($Cons 3 Nil))))) ; Should find members one by one

;; Query for basic arithmetic
 (query $kb (is $x (+ 1 1))) ; $x should be assigned 2

;; Query for natural number indexing
 (query $kb (nat-nth (S (S Z)) (SomethingAtThird $1 $2) Third)) ; Should find the third element

))))


;!(import! &self dv-pl)
;!(test_normal_queries)
;!(test_normal_queries)

((because $color house keeps $other the $nationality is the $type owner) :- 
  ((same $Houses
			(Cons ( 1 $_1 $_2 $_3 $_4 $_5) ; First house
			(Cons ( 2 $_6 $_7 $_8 $_9 $_10) ; Second house
			 $Open)))

	(same $Open Nil)

	; Clue 1: The Norwegian lives in the first house
	(member ( 1 norwegian $_11 $_12 $_13 $_14) $Houses)
	; Clue 2: The Brit lives in the red house
	(member ( $_15 brit red $_16 $_17 $_18) $Houses)
	; Clue 3: The owner of the blue house drinks tea
	(member ( $_19 $_20 blue tea $_21 $_22) $Houses)
	; Clue 4: The owner of the red house keeps $other
	(member ( $_23 $_24 $color $_25 $other $_26) $Houses)
	; Clue 5: The owner of the tea-drinking house smokes Prince
	(member ( $_27 $_28 $_29 tea $_30 prince) $Houses)
	; Determine the $nationality of owns the $type
	(member ( $_31 $nationality $_32 $_33 $type $_34) $Houses)))

;;;;;;;;;;;;;;;;;;
;; TEST Queries ;;
;;;;;;;;;;;;;;;;;;

!(query &self (because red house keeps dogs the $norwegian is the fish owner))

!(query &self (because blue house keeps dogs the $brit is the fish owner))

!(query &self (because red house keeps cats the $norwegian is the fish owner))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ADDITIONAL TEST QUERIES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Solve the zebra-owner problem (Who owns the fish?)
!(query (zebra-owner $Owner)) ; Should find the owner of the fish

;; Basic declaration tests
;!(query (declare nationality $Brit brit)) ; Tests nationality declaration
;!(query (something-existing $Exists)) ; Tests if an entity exists in the context

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ADDITIONAL LOGICAL RELATIONSHIPS ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Verify properties related to the zebra-owner problem;
;!(query (declare nationality $Owner norwegian)) ; Declare that $Owner is Norwegian


