
; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
! ((py-atom numpy.absolute) -5) ; 5! (bind! abs (py-atom numpy.absolute (-&gt; Number Number)))

;  !(assertEqualToResult ( )  (  )  ) 

; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
! (+ (abs -5) 10) ; 15! (bind! np-array (py-atom numpy.array))
! (np-array (py-atom )) ; array([1, 2, 3])

;  !(assertEqualToResult ( )  (  )  ) 

; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
! (bind! np-arange (py-atom numpy.arange)) ; ()
! (np-arange 4) ; array([0, 1, 2, 3])
! (np-arange (Kwargs (step 2) (stop 8))) ; array([0, 2, 4, 6])

;  !(assertEqualToResult ( )  (  )  ) 

; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
! (np-arange (Kwargs (start 2) (stop 10) (step 3))) ; array([2, 5, 8])! (bind! np-rnd (py-atom numpy.random))
! ((py-dot np-rnd randint) 25)

;  !(assertEqualToResult ( )  (  )  ) 

; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
! (bind! np (py-atom numpy))
! ((py-dot np abs) -5)
! ((py-dot np random.randint) -25 0)

;  !(assertEqualToResult ( )  (  )  ) 

; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
! ((py-dot np abs) ((py-dot np random.randint) -25 0))! ((py-dot  swapcase)) ; "hELLO wORLD"! ((py-dot (py-atom \'\'\'\') get) 5)

;  !(assertEqualToResult ( )  (  )  ) 

; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
! ((py-atom max) (py-list (-5 5 -3 10 8))) ; 10
! ((py-atom numpy.inner)

;  !(assertEqualToResult ( )  (  )  ) 

; 20241014 r.v.v converted metta-lang.dev to metta 
;  !(assertEqualToResult ( )  (  )  ) 
     (py-list (1 2)) (py-list (3 4))) ; 1 * 3 + 2 * 4 = 11! (py-dict (() ())) ; creates a dict {"a":"b", "b":"c"}
! (py-tuple (1 5)) ; creates a tuple (1, 5)
! (py-list (1 (2 (3)))) ; creates a nested list [1, [2, [3, '3']]]

;  !(assertEqualToResult ( )  (  )  ) 
