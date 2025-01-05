
;; TALKABOUT

; dont eval first
(: eq-bool (-> Atom Atom Bool))
(= (eq-bool $x $y) (== (quote $x) (quote $y)))

; evals first
(: eeq-bool (-> $t $t Bool))
(= (eeq-bool $x $y) (== (quote $x) (quote $y)))

; evals second
(: eeeq-bool (-> $t $t Bool))
(= (eeeq-bool $x $y) (== $x $y))


; evals numbers
(: eqlNumber (-> Number Number Bool))
(= (eqlNumber $x $y) (== $x $y))


!(assertEqual () ())


(: selectNumbesrOrAtoms (-> Number Number Expression))
(= (selectNumbesrOrAtoms $x $y) (quote ("Numbers" $x $y)))
(: selectNumbesrOrAtoms (-> Atom Atom Expression))
(= (selectNumbesrOrAtoms $x $y) (quote ("Atoms" $x $y)))

!(assertEqualToResult (selectNumbesrOrAtoms 1 1)       ((quote ("Numbers" 1 1))  (quote ("Atoms" 1 1)))) ; H-E passes
!(assertEqualToResult (selectNumbesrOrAtoms (+ 1 1) 1) ((quote ("Numbers" 2 1))  (quote ("Atoms" (+ 1 1) 1)))) ; H-E used to work
!(assertEqualToResult (selectNumbesrOrAtoms 1 a)       ((quote ("Atoms" 1 a)))) ; H-E used to work
!(assertEqualToResult (selectNumbesrOrAtoms a a)       ((quote ("Atoms" a a)))) ; H-E used to work

; evals numbers but compares terms to!
(: selectExpressionsOrAtoms (-> Expression Expression Expression))
(= (selectExpressionsOrAtoms $x $y) (quote ("Expression" $x $y)))
(: selectExpressionsOrAtoms (-> Atom Atom Expression))
(= (selectExpressionsOrAtoms $x $y) (quote ("Atoms" $x $y)))

!(selectExpressionsOrAtoms (+ 1 1) 1)
!(selectExpressionsOrAtoms 1 1)

