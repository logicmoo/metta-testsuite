
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

; evals numbers but compares terms to!
(: eqlNumberT (-> Number Number Bool))
(= (eqlNumberT $x $y) (== $x $y))
(: eqlNumberT (-> Atom Atom Bool))
(= (eqlNumberT $x $y) (== (quote $x) (quote $y)))

!(assertEqual () ())

