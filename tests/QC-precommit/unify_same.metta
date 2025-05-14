


!(assertEqualToResult (unify ($a $b) ($b $a) ($a $b) ())
     (($a $a)))


!(assertEqualToResult (unify ($a 1) ($b $a) ($a $b) ())
     ((1 1)))


!(assertEqualToResult (unify $a ($b $a) ($a $b) ())
     (()))


!(assertEqualToResult (unify $a ($c $a) ($a $b $c) ())
     (()))


!(assertEqualToResult (unify $a ($c $a) ($a $b $c) ($a $b $c) )
     (($a $b $c)))


!(assertEqualToResult (unify $a ($c $a) (y $a $b $c) (n $a $b $c) )
     ((n $a $b $c)))


!(assertEqualToResult (unify $a ($c $a) (y $a $b $c $d) (n $a $b $c $d) )
     ((n $a $b $c $d)))


!(assertEqualToResult (unify ($a $b) ($c $d) (y $a $b $c $d) (n $a $b $c $d) )
     ((y $a $b $a $b)))


!(assertEqualToResult (unify ($a $b) ($c 1) (y $a $b $c $d) (n $a $b $c $d) )
     ((y $a 1 $a $d)))


!(assertEqualToResult (unify ($a $b) ($c $c) (y $a $b $c $d) (n $a $b $c $d) )
     ((y $b $b $b $d)))


!(assertEqualToResult (unify ($a $b) ($c (+ 1 1)) (y $a $b $c $d) (n $a $b $c $d) )
     ((y $a 2 $a $d)))


!(assertEqualToResult (unify ($a (+ 0 2)) ($c (+ 1 1)) (y $a $b $c $d) (n $a $b $c $d) )
     ((n $a $b $c $d)))


!(assertEqualToResult (unify ($a (+ $b 1)) ($c (+ 1 1)) (y $a $b $c $d) (n $a $b $c $d) )
     ((y $a 1 $a $d)))



