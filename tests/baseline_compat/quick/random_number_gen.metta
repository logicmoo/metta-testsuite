;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Additional Tests for Random API
;;; 
;;; This assumes you already have definitions like:
;;;   (random-int <RNG> <start> <end>)
;;;   (random-float <RNG> <start> <end>)
;;;   (new-random-generator <seed>)
;;;   (set-random-seed <RNG> <seed>)
;;;   (reset-random-generator <RNG>)
;;;   (Error ...)
;;;   (RangeIsEmpty)
;;;   (unit-atom)
;;;   etc.
;;;   
;;; and macros:
;;;   !(assert <bool-expr>)
;;;   !(assertEqual <expr1> <expr2>)
;;;   ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;--------------------------------------------------------------------
; 1) Test reproducibility: two RNGs with the same seed => same results
;--------------------------------------------------------------------
!(assert
    (let $rng1 (new-random-generator 1234)
        (let $v1 (random-int $rng1 0 100)
            (let $rng2 (new-random-generator 1234)
                (let $v2 (random-int $rng2 0 100)
                    (== $v1 $v2))))))

;--------------------------------------------------------------------
; 2) Test reproducibility with floats: same seed => same random-float
;--------------------------------------------------------------------
!(assert
    (let $rngA (new-random-generator 999)
        (let $f1 (random-float $rngA 0.0 10.0)
            (let $rngB (new-random-generator 999)
                (let $f2 (random-float $rngB 0.0 10.0)
                    (== $f1 $f2))))))

;--------------------------------------------------------------------
; 3) Test that set-random-seed overrides any prior seed 
;    => repeated seeds yield the same next random-int
;--------------------------------------------------------------------
!(assert
    (let $rng (new-random-generator 555)
        (let _ (random-int $rng 0 100) ; discard one random value
            (let _ (set-random-seed $rng 42)
                (let $val1 (random-int $rng 0 100)
                    (let _ (set-random-seed $rng 42)
                        (let $val2 (random-int $rng 0 100)
                            (== $val1 $val2))))))))

;--------------------------------------------------------------------
; 4) Test reset-random-generator => the RNG should no longer produce
;    the same sequence as a newly seeded RNG.  By default, we expect
;    (reset-random-generator) to use an OS-based seed.
;--------------------------------------------------------------------
!(assert
    (let $rng (new-random-generator 0)
        (let $val1 (random-int $rng 0 100)
            (let _ (reset-random-generator $rng)
                (let $val2 (random-int $rng 0 100)
                    ; It's *possible* (though extremely unlikely) that $val1 == $val2
                    ; by pure chance, but we generally test that they're different.
                    (not (== $val1 $val2)))))))

;--------------------------------------------------------------------
; 5) Check that random-int with zero-width range => Error(RangeIsEmpty).
;--------------------------------------------------------------------
!(assertEqual
    (random-int (new-random-generator 10) 5 5)
    (Error (random-int (new-random-generator 10) 5 5) RangeIsEmpty))

;--------------------------------------------------------------------
; 6) Check negative bounds are allowed: random-int rng -10 0 => valid int
;--------------------------------------------------------------------
!(assert
    (let $rng (new-random-generator 77)
        (let $val (random-int $rng -10 0)
            (and (>= $val -10) (< $val 0)))))

;--------------------------------------------------------------------
; 7) Check random-float with reversed bounds => Error(RangeIsEmpty)
;--------------------------------------------------------------------
!(assertEqual
    (random-float (new-random-generator 234) 10.0 5.0)
    (Error (random-float (new-random-generator 234) 10.0 5.0) RangeIsEmpty))

;--------------------------------------------------------------------
; 8) Confirm set-random-seed returns unit-atom
;--------------------------------------------------------------------
!(assert
    (==
        (set-random-seed (new-random-generator 9999) 12345)
        unit-atom))

;--------------------------------------------------------------------
; 9) Test random-float range check: [0..1) => result in [0.0..1.0)
;--------------------------------------------------------------------
!(assert
    (let $rng (new-random-generator 23)
        (let $fval (random-float $rng 0.0 1.0)
            (and (>= $fval 0.0) (< $fval 1.0)))))

;--------------------------------------------------------------------
; 10) Confirm that two different seeds => likely different random-int
;     (We can't guarantee absolutely different, but we usually test 
;     that it's not always the same.)
;--------------------------------------------------------------------
!(assert
    (let $rng1 (new-random-generator 123)
        (let $rng2 (new-random-generator 456)
            (let $val1 (random-int $rng1 0 100)
                (let $val2 (random-int $rng2 0 100)
                    (not (== $val1 $val2)))))))

; End of additional tests


