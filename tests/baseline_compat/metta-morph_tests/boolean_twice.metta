
(= (facf $n)
   (if (== $n 0) 
	   1
	   (* $n (facf (- $n 1)))))


!(facf 3)


(= (facB $n)
  (If (== $n 0)
	  1
	  (* $n (facB (- $n 1)))))


(: If (-> Bool Atom Atom Atom))
(= (If $cond $then $else) (if $cond $then $else))


;; Defined If too late?

!(println! "!(facB 2)")
!(pragma! e trace)
!(facB 3)

;; Defined If early enough?

(= (facA $n)
 (If (== $n 0) 
	 1
	 (* $n (facA (- $n 1)))))


!(println! "!(facA 2)")
!(pragma! e trace)
!(facA 3)



;; Did If get all the right machinery
(: ProBool Bool)
(: NotBool IsNotBool)

!(assertEqual (If $_ $then $else) (if $_ $then $else))
!(assertEqual (If UntypedSymbol $then $else) (if UntypedSymbol $then $else))
!(assertEqual (If ProBool $then $else) (if ProBool $then $else))
!(assertEqual (If 6 $then $else) (if 6 $then $else))
!(assertEqual (If "BadType" $then $else) (if "BadType" $then $else))
!(assertEqual (If NotBool $then $else) (if NotBool $then $else))
!(assertEqual (If (== $x $y) Bad-If-VarDifferent Good-If-VarDifferent)
              (if (== $x $y) Bad-If-VarDifferent Good-If-VarDifferent))
!(assertEqual (If (== $x $x) Good-If-VarSame Bad-If-VarSame)
              (if (== $x $x) Good-If-VarSame Bad-If-VarSame))
!(assertEqual (If False Bad-If-False Good-If-False)
              (if False Bad-If-False Good-If-False))
!(assertEqual (If True Good-If-True Bad-If-True)
              (if True Good-If-True Bad-If-True))
!(assertEqual (If (== 0 1) Bad-If-NonEqualNum Good-If-NonEqualNum)
              (if (== 0 1) Bad-If-NonEqualNum Good-If-NonEqualNum))
!(assertEqual (If (== 0 0) Good-If-EqualNum Bad-If-EqualNum)
              (if (== 0 0) Good-If-EqualNum Bad-If-EqualNum))
!(assertEqual (If (== 0 (- 1 0)) Bad-If-NonEqualEvalNum Good-If-NonEqualEvalNum)
              (if (== 0 (- 1 0)) Bad-If-NonEqualEvalNum Good-If-NonEqualEvalNum))
!(assertEqual (If (== 0 (- 1 1)) Good-If-EqualEvalNum Bad-If-EqualEvalNum)
              (if (== 0 (- 1 1)) Good-If-EqualEvalNum Bad-If-EqualEvalNum))


