(= (f1 $n) (cdr-atom $n))

!(f1 (1 2 3))

!(listing! cdr-atom)
!(println! "!(cdr-atom (1 2 3))")

!(call-string "listing('mc__1_1_car-atom').")

; would break things
; (= (car-atom $x) $x)

!(call-string "listing('mc__1_1_car-atom').")

!(call-string "compiled_info('car-atom')")


