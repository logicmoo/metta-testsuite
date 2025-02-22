!(import! &self test_wrap_unwrap)

! (plus_unwrap_true 1 (+ 10 100))
! (plus_unwrap_false 2  (+ 20 200))

! (ident_unwrap_false (+ 3 30))
! (ident_unwrap_false (quote (+ 4 40)))

! (ident_unwrap_true  (+ 5 50))
! (ident_unwrap_true  (quote (+ 6 60)))


