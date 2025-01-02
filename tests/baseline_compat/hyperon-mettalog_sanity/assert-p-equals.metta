

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


