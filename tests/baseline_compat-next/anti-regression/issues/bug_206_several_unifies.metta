


!(let $_ (unify $x (superpose (1 2 3)) True False) (quote $x))
; [(quote (superpose (1 2 3)))]

!(let $_ (unify $x (superpose (1 2 3)) True False) $x)

!(unify $x $y True False)

!(unify $x $x True False)

(a b c)

!(unify &self $x $x False)
!(unify  &self (a $b c) $b BFalse)


!(bind! ns (new-space))

!(unify ns $x $x False)

!(unify (a b c) b be False)







