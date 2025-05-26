(: If3 (-> Bool Atom Atom Atom))
(= (If3 $cond $then $else) (if $cond $then $else))

(= (facF $n)
   (If3 (== $n 0)
       1
       (* $n (facF (- $n 1)))))

(= (facf $n)
   (if (== $n 0)
	   1
	   (* $n (facf (- $n 1)))))


!(pragma! time trace)

!(pragma! compile False)

; compiler off system defined branching
!(facf 10000)

; compiler off user defined branching
!(facF 10000)

; compiler off system defined branching
;!(facf 100000)

; compiler off user defined branching
;!(facF 100000)


!(pragma! compile full)

; compiler on system defined branching
!(facf 10000)

; compiler on user defined branching
!(facF 10000)

; compiler on system defined branching
;!(facf 100000)

; compiler on user defined branching
;!(facF 100000)

