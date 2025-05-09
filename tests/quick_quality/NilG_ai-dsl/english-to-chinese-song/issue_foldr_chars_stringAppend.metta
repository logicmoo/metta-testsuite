;;;;;;;;;;
; String ;
;;;;;;;;;;

;; Fold a tuple from right to left
(: foldr (-> (-> $a $b $b) $b $c $d))
(= (foldr $f $i $xs)
   (if (== $xs ())
	   $i
	   (let* (($h (car-atom $xs))
			  ($t (cdr-atom $xs))
			  ($ft (foldr $f $i $t)))
		 ($f $h $ft))))

;; Concatenate two terms
(: append (-> $a $a $a))
(= (append $lhs $rhs) (foldr cons-atom $rhs $lhs))

(: String.append (-> String String String))
(= (String.append $x $y) (charsToString (append (stringToChars $x) (stringToChars $y))))

;; Test String.append
!(assertEqual (String.append "abc" "def") "abcdef")
!(assertEqual (String.append "\"" "\"") "\"\"")
!(assertEqual (String.append "\"" (String.append "\"" "\"")) "\"\"\"")
!(assertEqual (String.append (String.append "abc" "def") (String.append "g" "hij")) "abcdefghij")

;; Overload String.append to support more than 2 arguments
(: String.append3 (-> String String String String))
(= (String.append3 $x $y $z) (String.append $x (String.append $y $z)))
(: String.append4 (-> String String String String String))
(= (String.append4 $x $y $z $w) (String.append $x (String.append3 $y $z $w)))
(: String.append5 (-> String String String String String String))
(= (String.append5 $x $y $z $w $s) (String.append $x (String.append4 $y $z $w $s)))

;; Join a list of string by a separator
(: String.join (-> String (List String) String))
(= (String.join $separator Nil) "")
(= (String.join $separator (Cons $head $tail))
   (case $tail
     ((Nil $head)
      ($else (String.append3 $head $separator (String.join $separator $tail))))))

;; Test String.join
!(assertEqual (String.join ", " (Cons "x=42" (Cons "y=24" Nil))) "x=42, y=24")

