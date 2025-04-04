

;; Basic equivalency
!(assertAlphaEqual (foo $x) (foo $y))

;; Nested equivalency
!(assertAlphaEqual (foo (bar $x)) (foo (bar $y)))

;; Multiple variables
!(assertAlphaEqual (foo $x $y) (foo $a $b))

;; Constants in equivalent positions
!(assertAlphaEqual (foo A B) (foo A B))

;; Equivalent repeated variables
!(assertAlphaEqual (foo $x $x) (foo $y $y))

;; Equivalent functions with swapped but consistent variable names
!(assertNotAlphaEqual (foo $x $x) (foo $y $z))

;; Equivalent nested repeated variables
!(assertAlphaEqual (foo (bar $x $x)) (foo (bar $y $y)))

;; Deep nesting equivalency
!(assertAlphaEqual (foo (bar (baz $x))) (foo (bar (baz $y))))

;; Matching structures with fixed atoms
!(assertAlphaEqual (foo (bar A B)) (foo (bar A B)))

;; Empty structures equivalency
!(assertAlphaEqual () ())

;; Equivalent functions with swapped but consistent variable names
!(assertAlphaEqual (foo $x $y $z) (foo $a $b $c))

;; Equivalent functions with swapped but consistent variable names
!(assertNotAlphaEqual (foo $x $x $z) (foo $a $b $c))

;; Deep equivalency with variables in constants
!(assertAlphaEqual (foo (bar A $x) (baz B $y)) (foo (bar A $a) (baz B $b)))

;; Multiple nested equivalent expressions
!(assertAlphaEqual ((foo $x) (bar $y)) ((foo $a) (bar $b)))

;; Multi-level equivalency with variable shadowing
!(assertAlphaEqual (foo (bar $x) (baz $x)) (foo (bar $y) (baz $y)))

;; Same structure and fixed variables
!(assertAlphaEqual (foo A (bar B)) (foo A (bar B)))

;; More deeply nested equivalency with repeated variables
!(assertAlphaEqual (foo (bar (baz $x $x))) (foo (bar (baz $y $y))))

