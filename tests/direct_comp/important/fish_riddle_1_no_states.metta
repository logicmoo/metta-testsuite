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

;!(equalz $a (+ 1 1))

;; Query execution logic
(: query (-> Atom Atom Atom))
(= (query $kb $goal)
	(let $m (collapse (backward-chain $info $goal $kb  $kb))
		(if (== $m ()) (Failed (quote $goal)) (Succeed $m))) 
)


;; Predicate: Check if an element is a member of a list
(member $Elem ($Cons $Elem $_1)) ; Base case: element found
((member $Elem ($Cons $_1 $Tail)) :-
 ((member $Elem $Tail))) ; Recursive case: continue checking

;; Predicate to check equality of two values
(same $x $x)

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

!(assertEqualToResult 
   (query &self (because red house keeps dogs the $norwegian is the fish owner))
  ((Succeed ((quote (because red house keeps dogs the norwegian is the fish owner))))))

!(assertEqualToResult 
  (query &self (because blue house keeps dogs the $brit is the fish owner))
 ((Succeed ((quote (because blue house keeps dogs the brit is the fish owner))))))

!(assertEqualToResult 
  (query &self (because red house keeps cats the $norwegian is the fish owner))
 ((Succeed ((quote (because red house keeps cats the norwegian is the fish owner))))))

