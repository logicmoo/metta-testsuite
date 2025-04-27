;;Custom unique union function that works with variables

;; ==========================
;; Tests for unique-atom-by using different comparators
;; ==========================

!(assertEqual (unique-atom-by =will ($a $a $b $b)) ($a))
!(assertEqual (unique-atom-by =will ($a $a $b 2 3)) ($a))
!(assertEqual (unique-atom-by =will (3 2 $a $a $b)) (3 2))

!(assertEqual (unique-atom-by =alpha ($a $a $b $b)) ($a))
!(assertEqual (unique-atom-by =alpha ($a $a $b 2 3)) ($a 2 3))
!(assertEqual (unique-atom-by =alpha (3 2 $a $a $b)) (3 2 $a $b))

!(assertEqual (unique-atom-by =unify ($a $a $b $b)) ($a))
!(assertEqual (unique-atom-by =unify ($a $a $b 2 3)) ($a 2 3))
!(assertEqual (unique-atom-by =unify (3 2 $a $a $b)) (3 2 $a))

!(assertEqual (unique-atom-by == ($a $a $b $b)) ($a $b))
!(assertEqual (unique-atom-by == ($a $a $b 2 3)) ($a $b 2 3))
!(assertEqual (unique-atom-by == (3 2 $a $a $b)) (3 2 $a $b))

!(assertEqual (unique-atom-by =identical ($a $a $b $b)) ($a $b))
!(assertEqual (unique-atom-by =identical ($a $a $b 2 3)) ($a $b 2 3))
!(assertEqual (unique-atom-by =identical (3 2 $a $a $b)) (3 2 $a $b))

!(assertEqual (unique-atom-by =references ($a $a $b $b)) ($a $b))
!(assertEqual (unique-atom-by =references ($a $a $b 2 3)) ($a $b 2 3))
!(assertEqual (unique-atom-by =references (3 2 $a $a $b)) (3 2 $a $b))




!(assertEqualToResult 
  (unique (capture (superpose ((a $b) (a $b)))))
  ((a $b)))

!(assertEqualToResult 
  (unique (superpose ((a $b) (a $b))))
  ((a $b)))

!(assertEqualToResult 
  (unique (superpose ((a $b) (a $c))))
  ((a $b) (a $c)))

!(assertEqualToResult 
  (unique-by == (superpose ((a $b) (a $b))))
  ((a $b)))

!(assertEqualToResult 
  (unique-by == (superpose ((a $b) (a $c))))
  ((a $b) (a $c)))

!(assertEqualToResult 
  (unique-by alpha= (superpose ((a $b) (a $c))))
  ((a $b)))

!(assertEqualToResult 
  (unique (copy-term! (superpose ((a $b) (a $b)))))
  ((a $b_01 (a $b_02))))


(= (get-var-b) $b)
!(unique (superpose ((get-var-b)(get-var-b))))
!(let $res (get-var-b)
   (assertEqualToResult 
     (unique (superpose ($res (get-var-b))))
     ($res)))

!(bind! &state-b (new-state $b))
(= (get-state-b) &state-b)
!(unique (superpose ((get-state-b)(get-state-b))))
!(let $res (get-state-b)
   (assertEqualToResult 
     (unique (superpose ($res (get-state-b))))
     ($res)))

!(bind! &anything-b (new-state (anything $b)))
(= (get-anything-b) &anything-b)
!(unique (superpose ((get-anything-b)(get-anything-b))))
!(let $res (get-anything-b)
   (assertEqualToResult 
     (unique (superpose ($res (get-anything-b))))
     ($res)))

