

(: foo (-> Atom Atom Atom))

!(assertEqualToResult (foo (+ 1 1) (+ 1 1)) ((foo (+ 1 1) (+ 1 1))))

!(assertEqualToResult (bar True (+ 1 1) (+ 1 1)) ((bar True 2 2)))

(= ((. $g $f) $x) ($g ($f $x)))

!(assertEqual
  ((. $g $f) $x)
  ($g ($f $x)))

!(assertEqual
  (foo ((. $g $f) $x))
  (foo ($g ($f $x))))

!(assertEqual
  ($h ((. $g $f) $x))
  ($h ($g ($f $x))))

!(assertEqual
  ((. (. $h $g) $f) $x)
  ($h ($g ($f $x))))

;!(repl!)

!(assertEqual
  (((. $h (. $g $f)) $x))
  (($h ($g ($f $x)))))

!(assertEqualToResult
  ((. $h (. $g $f)) $x)
  (($h ($g ($f $x)))))






