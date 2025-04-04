(= (facF $n)
   (If2 (== $n 0)
       1
       (* $n (facF (- $n 1)))))

(: If2 (-> Bool Atom Atom Atom))
(= (If2 $cond $then $else) (If $cond $then $else))

(: If (-> Bool Atom Atom Atom))
(= (If $cond $then $else) (if $cond $then $else))

!(facF 5)

