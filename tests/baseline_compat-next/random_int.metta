;!(between 3 0 10) ; returns True 
;!(between 10 0 10) ; returns False
(= (between $x $l $h) 
   ((and (<= $l $x) (< $x $h))
    )
   )

; random-int
!(assertEqual (between (random-int &rng 0 10) 0 10) (True) )

; random-float
!(assertEqual (between (random-float &rng 0 10) 0 10) (True) )

; set-random-seed
!(assertEqual
  (set-random-seed (new-random-generator 123) 456)
  ())

!(assertEqual
  ((let $x (new-random-generator 123) (random-int $x 0 10))
    (set-random-seed $x 456)
    (random-int $x 0 10))
  (7 () 2))

!(assertEqual
  ((let $x (new-random-generator 123) (random-float $x 0 10))
    (set-random-seed $x 456)
    (random-float $x 0 10))
  (1.4295206294796854 () 8.95378161092448))

; new-random-generator
!(assertEqual (new-random-generator 123) &rng_4)
; Why &rng_4? Count the new-random-generator calls.
; Default rng is &rng and every subsequent gets an incremental index

!(assertEqual
  (random-int (new-random-generator 123) 0 10)
  7)

!(assertEqual
  (random-float (new-random-generator 456) 0 10)
  8.95378161092448)

; reset-random-generator
!(assertEqual 
   (let $x (new-random-generator 1234)
   (reset-random-generator $x)) 
   &rng_7
   )

!(assertEqual
  ((let $x (new-random-generator 1234)
    (random-int $x 0 10))
    (set-random-seed $x 567)
    (random-int $x 0 10)
    (reset-random-generator $x)
    (between (random-int $x 0 10) 0 10)
    )
  (7 () 3 &rng_8 (True))
)

!(assertEqual
  ((let $x (new-random-generator 1234)
    (random-float $x 0 10))
    (set-random-seed $x 567)
    (random-float $x 0 10)
    (reset-random-generator $x)
    (between (random-float $x 0 10) 0 10)
    )
  (8.427591900348784 () 5.037420638757753 &rng_9 (True))
)
