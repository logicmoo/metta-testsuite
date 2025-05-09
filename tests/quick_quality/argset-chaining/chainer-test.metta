!(import! &self chainer)

!(bind! &cpu (init-kb))

!(add-to-kb &cpu (() ⊢ ((: a1 (A 1)))))
!(add-to-kb &cpu (() ⊢ ((: a2 (A 2)))))
;
!(add-to-kb &cpu (((: $a1 (A $v1)) (: $a2 (A $v2))) ⊢ ((: (CPU + ($v1 $v2)) (CPU $v3)) (: (b $a1 $a2) (B $v3)))))

;; Roman expects $b, $v
(ROMAN-EXPECTS-BUT-H-E-MISSES 
  (assertEqualToResult (bc &cpu (S Z) (() ⊢ ((: $b (B $v)))))
   ((() ⊢ ((: (CPU + (2 2)) (CPU 4)) (: (b a2 a2) (B 4)) (: a2 (A 2))))
    (() ⊢ ((: (CPU + (2 1)) (CPU 3)) (: (b a2 a1) (B 3)) (: a2 (A 2)) (: a1 (A 1))))
    (() ⊢ ((: (CPU + (1 2)) (CPU 3)) (: (b a1 a2) (B 3)) (: a1 (A 1)) (: a2 (A 2))))
    (() ⊢ ((: (CPU + (1 1)) (CPU 2)) (: (b a1 a1) (B 2)) (: a1 (A 1)))))))

;; Hyperon-experimental is not binding $b, $v
!(H-E-LEAVES-B-AND-V-UNBOUND
  (assertEqualToResult (bc &cpu (S Z) (() ⊢ ((: $b (B $v)))))
   ((() ⊢ ((: (CPU + (2 2)) (CPU $v)) (: (b a2 a2) (B $v)) (: a2 (A 2)))) 
    (() ⊢ ((: (CPU + (2 1)) (CPU $v)) (: (b a2 a1) (B $v)) (: a2 (A 2)) (: a1 (A 1))))
    (() ⊢ ((: (CPU + (1 2)) (CPU $v)) (: (b a1 a2) (B $v)) (: a1 (A 1)) (: a2 (A 2))))
    (() ⊢ ((: (CPU + (1 1)) (CPU $v)) (: (b a1 a1) (B $v)) (: a1 (A 1)))))))
 



;;Some tests
!("Some tests")
!(bind! &s (init-kb))

!(add-to-kb &s (((: $a A) (: $b B)) ⊢ ((: (f $a $b) C))))
!(add-to-kb &s (((: $b B)) ⊢ ((: (f2 a $b) D))))
!(add-to-kb &s (((: $b B) (: $e E)) ⊢ ((: (f3 a $b $e) F))))

!(add-to-kb &s (() ⊢ ((: a A))))
!(add-to-kb &s (() ⊢ ((: b B))))

;Basic type queries
!("Basic type queries")
!(assertEqual (bc &s Z (() ⊢ ((: $a A)))) (() ⊢ ((: a A))))
!(assertEqual (bc &s Z ($args ⊢ ((: $a A)))) (() ⊢ ((: a A))))
!(assertEqual (bc &s Z (() ⊢ ((: $a A)(: $b B)))) (() ⊢ ((: a A)(: b B))))

!("Partial application Pt2")

!(assertEqual (bc &s (S (S Z)) (() ⊢ ((: $p C))))
    (() ⊢ ((: (f a b) C) (: a A) (: b B))))

!(repl!)

!(assertEqual (bc &s (S (S Z)) (() ⊢ ((: (f a b) $t))))
    (() ⊢ ((: (f a b) C) (: a A) (: b B))))

;;Partial application
!("Partial application")
!(assertEqual (bc &s (S (S Z)) (((: $a A)) ⊢ ((: $c C))))
    (((: $a A)) ⊢ ((: (f $a b) C) (: b B))))

!(assertEqual (bc &s (S Z) (() ⊢ ((: (f $a b) $t))))
    (() ⊢ ((: (f a b) C) (: a A) (: b B))))

!(assertEqual (bc &s (S (S Z)) (() ⊢ ((: $d D))))
    (() ⊢ ((: (f2 a b) D) (: b B))))

!(assertEqual (bc &s (S (S Z)) (() ⊢ ((: (f2 a b) $t))))
    (() ⊢ ((: (f2 a b) D) (: b B))))

!(assertEqual (bc &s (S (S Z)) (((: $e E)) ⊢ ((: $f F))))
    (((: $e E)) ⊢ ((: (f3 a b $e) F) (: b B))))

!(assertEqual (bc &s (S (S Z)) (((: $e E)) ⊢ ((: (f3 a b $e) $t))))
    (((: $e E)) ⊢ ((: (f3 a b $e) F) (: b B))))



