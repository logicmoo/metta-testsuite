
(: ProBool Bool)
(: NotBool IsNotBool)

(: IfAtom (-> Atom Atom Atom Atom))
(= (IfAtom $cond $then $else) (if $cond $then $else))


;; Type Errors When or Not?
!(assertEqualToResult (IfAtom $_ $then $else) ($else $then))
!(assertEqualToResult (IfAtom UntypedSymbol $then $else) ((IfAtom UntypedSymbol $then $else)))
!(assertEqualToResult (IfAtom ProBool $then $else) ((IfAtom ProBool $then $else)))
!(assertEqual (IfAtom 6 $then $else) (Error ... ...))
!(assertEqual (IfAtom "BadType" $then $else) (Error ... ...))
!(assertEqual (IfAtom NotBool $then $else) (Error ... ...))
!(IfAtom (== $x $y) Bad-IfAtom-VarDifferent Good-IfAtom-VarDifferent)
!(IfAtom (== $x $x) Good-IfAtom-VarSame Bad-IfAtom-VarSame)
!(IfAtom False Bad-IfAtom-False Good-IfAtom-False)
!(IfAtom True Good-IfAtom-True Bad-IfAtom-True)
!(IfAtom (== 0 1) Bad-IfAtom-NonEqualNum Good-IfAtom-NonEqualNum)
!(IfAtom (== 0 0) Good-IfAtom-EqualNum Bad-IfAtom-EqualNum)
!(IfAtom (== 0 (- 1 0)) Bad-IfAtom-NonEqualEvalNum Good-IfAtom-NonEqualEvalNum)
!(IfAtom (== 0 (- 1 1)) Good-IfAtom-EqualEvalNum Bad-IfAtom-EqualEvalNum)



;; Type Errors When or Not?
(: IfBool (-> Bool Atom Atom Atom))
(= (IfBool $cond $then $else) (if $cond $then $else))

!(assertEqualToResult (IfBool $_ $then $else) ($else $then))
!(assertEqualToResult (IfBool UntypedSymbol $then $else) ((IfBool UntypedSymbol $then $else)))
!(assertEqualToResult (IfBool ProBool $then $else) ((IfBool ProBool $then $else)))
!(assertEqual (IfBool 6 $then $else) (Error ... ...))
!(assertEqual (IfBool "BadType" $then $else) (Error ... ...))
!(assertEqual (IfBool NotBool $then $else) (Error ... ...))
!(IfBool (== $x $y) Bad-IfBool-VarDifferent Good-IfBool-VarDifferent)
!(IfBool (== $x $x) Good-IfBool-VarSame Bad-IfBool-VarSame)
!(IfBool False Bad-IfBool-False Good-IfBool-False)
!(IfBool True Good-IfBool-True Bad-IfBool-True)
!(IfBool (== 0 1) Bad-IfBool-NonEqualNum Good-IfBool-NonEqualNum)
!(IfBool (== 0 0) Good-IfBool-EqualNum Bad-IfBool-EqualNum)
!(IfBool (== 0 (- 1 0)) Bad-IfBool-NonEqualEvalNum Good-IfBool-NonEqualEvalNum)
!(IfBool (== 0 (- 1 1)) Good-IfBool-EqualEvalNum Bad-IfBool-EqualEvalNum)



;; Inherit or Not
(= (IfBare $cond $then $else) (if $cond $then $else))

!(assertEqualToResult (IfBare $_ $then $else) ($else $then))
!(assertEqualToResult (IfBare UntypedSymbol $then $else) ((IfBare UntypedSymbol $then $else)))
!(assertEqualToResult (IfBare ProBool $then $else) ((IfBare ProBool $then $else)))
!(assertEqual (IfBare 6 $then $else) (Error ... ...))
!(assertEqual (IfBare "BadType" $then $else) (Error ... ...))
!(assertEqual (IfBare NotBool $then $else) (Error ... ...))
!(IfBare (== $x $y) Bad-IfBare-VarDifferent Good-IfBare-VarDifferent)
!(IfBare (== $x $x) Good-IfBare-VarSame Bad-IfBare-VarSame)
!(IfBare False Bad-IfBare-False Good-IfBare-False)
!(IfBare True Good-IfBare-True Bad-IfBare-True)
!(IfBare (== 0 1) Bad-IfBare-NonEqualNum Good-IfBare-NonEqualNum)
!(IfBare (== 0 0) Good-IfBare-EqualNum Bad-IfBare-EqualNum)
!(IfBare (== 0 (- 1 0)) Bad-IfBare-NonEqualEvalNum Good-IfBare-NonEqualEvalNum)
!(IfBare (== 0 (- 1 1)) Good-IfBare-EqualEvalNum Bad-IfBare-EqualEvalNum)

