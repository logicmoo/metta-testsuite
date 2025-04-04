
; !(import! &self assert-p-equals)
;!(include assert-p-equals)


(: eval-maybe-empty (-> Atom Atom))
(= (eval-maybe-empty $eval) 
   (let $res 
	(case $eval
	  (
	   ((Error $a $b) (eval (Error $a $b)))
	   (Empty (eval Empty))
		($var $var))) $res))

(: match-maybe-empty (-> hyperon::space::DynSpace Atom Atom Atom))
(= (match-maybe-empty $space $match $template) 
	  (eval-maybe-empty (match $space $match $template)))



(: string-repr (-> Atom String))
(= (string-repr $obj)
	(let $type (get-type $obj)
		(if (== $type String)
			(format-args "\"{}\"" ($obj))
			(repr $obj))))


(: assertPEqual (-> Atom Atom Atom Atom))
(= (assertPEqual $Form $List $passes)
  (assertPEqualR (string-repr $Form) $Form $List $passes))

(: assertPEqual (-> Atom Atom Atom Atom Atom))
(= (assertPEqual $Name $Form $Form2 $passes2)
   (assertPEqualR (string-repr $Name) $Form $Form2 $passes2))

(: assertPEqualR (-> String Atom Atom Atom Atom))
(= (assertPEqualR $Name $Form $Form2 $passes2)
   (let ($n $res $List $passes) ($Name (eval-maybe-empty $Form) (eval-maybe-empty $Form2) (collapse $passes2))
   (case (quote $res)
	( 
	 ((quote $List) (println! (format-args "
	 (assertPEqual {} {} {} {})" ($Name $Form $Form2 $passes2))))
	 ($_    (println! (format-args "
	 (assertPEqual {} {} 
	   {} 
	   {})" ($Name $Form $Form2 $res))))
	 ))))


(: assertPEqualToResult (-> Atom Expression Expression Atom))
(= (assertPEqualToResult $Form $List $passes)
  (assertPEqualToResultR (string-repr $Form) $Form $List $passes))

(: assertPEqualToResult (-> Atom Atom Expression Expression Atom))
(= (assertPEqualToResult $Name $Form $Form2 $passes2)
   (assertPEqualToResultR (string-repr $Name) $Form $Form2 $passes2))

(: assertPEqualToResultR (-> String Atom Expression Expression Atom))
(= (assertPEqualToResultR $Name $Form $List $passes)
   (let ($n $res) ($Name (collapse $Form))
   (case (quote $res) 
	( 
	 ((quote $List) (println! (format-args "
	 (assertPEqualToResult {} {} {} {})" ($Name $Form $List $passes))))
	 ($_    (println! (format-args "
	 (assertPEqualToResult {} {} 
	   {} 
	   {})" ($Name $Form $List $res))))
	 ))))






(: atom-atom (-> Atom Atom))
(: number-atom (-> Number Atom))
(: atom-unit (-> Atom (->)))
(: var-var (-> $var $var))
(: atom-var (-> Atom $var))

(= (return-empty) Empty)
(= (returns-not-reducible) NotReducible)
(: return-number (-> Number Number))
(= (return-number $n) $n)


!(assertPEqual (match-maybe-empty &self (no-stuff $a) (no-stuff $a))
      Empty  $same)

!(assertPEqual (atom-atom (+ 1 1)) (atom-atom (+ 1 1)) $same)

!(assertPEqual (number-atom (+ 1 1)) (number-atom 2) $same)

!(assertPEqual (atom-unit (+ 1 1))  (atom-unit (+ 1 1)) $same)

!(assertPEqual (var-var (+ 1 1)) (var-var (+ 1 1)) $same)

!(assertPEqual (atom-var (+ 1 1)) (atom-var (+ 1 1)) $same)

!(assertPEqualToResult "nr1" (returns-not-reducible)  (NotReducible) $same)
!(assertPEqualToResult "nr2" (returns-not-reducible)  (NotReducible) $same)
!(assertPEqual "nr3" (returns-not-reducible)  NotReducible $same)


!(assertPEqual (return-number 2) 2 $same)


!(assertPEqualToResult "re1" (return-empty) () $same)
!(assertPEqual "re2" (return-empty) Empty $same)
!(assertPEqual "re3" (return-empty) (eval Empty) $same)


(: a TypeA)
!(assertPEqualToResult "rn1" (return-number a) ((Error a BadType)) $same)
!(assertPEqual "rn2" (return-number a) (Error a BadType) $same)

; !(assertPEqual "rn2.5" (return-number a) (Error a BadType) (Error (return-number a) BadType))

; wrong !(assertPEqual "rn3" (return-number a) (Error (return-number a) BadType) $same)

;!(include assert-p-equals)

;!(assertPEqual "rn3" (return-number a) (Error a BadType) $same)




