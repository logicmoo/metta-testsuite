(: If (-> Bool Atom Atom Atom))
(= (If $cond $then $else) (if $cond $then $else))

(: If2 (-> Bool Atom Atom Atom))
(= (If2 $cond $then $else) (If $cond $then $else))

;shouldnt be required
(: facF (-> Number Number))
(= (facF $n)
   (If2 (== $n 0)
       1
       (* $n (facF (- $n 1)))))


(= (sq $n)
   (If2 (== $n 0)
       1
       (* $n $n)))

!(sq 2)
!(sq 0)
(= (foo) bar)
!(foo)


!(If2 True OkT BadT)
!(If2 (== 0 0) Ok1 Bad1)
!(If2 (== 0 (- 1 1)) Ok2 Bad2)
!(collapse (== 0 (superpose (0 0 1 0))))
!(collapse (== $n (superpose ($n $n $other $n))))
!(== 0 (superpose (0 0 1 0)))
!(== $n (superpose ($n $n $other $n)))
!(If2 (== 0 (superpose (0 0 1 0))) Ok4 Ok3)
!(facF 5)


;should not infloop with commented out
;(: facFN (-> Number Number))
(= (facFN $n)
   (If2 (== $n 0)
	   1
	   (* $n (facFN (- $n 1)))))

; !(time-limit 2.0 (facFN 5))
; !(facFN 5)
!(call-fn! cwdl 505 (facFN 10))


