;;Custom unique union function that works with variables

;; ==========================
;; Tests for unique-atom-by using different comparators
;; ==========================

!(assertEqual (unique-atom-by =will ($a $a $b $b)) ($a))
!(assertEqual (unique-atom-by =will ($a $a $b 2 3)) ($a))
!(assertEqual (unique-atom-by =will (3 2 $a $a $b)) (3 2))

!(assertEqual (unique-atom-by =alpha ($a $a $b $b)) ($a))
!(assertEqual (unique-atom-by =alpha ($a $a $b 2 3)) ($a 2 3))
!(assertEqual (unique-atom-by =alpha (3 2 $a $a $b)) (3 2 $a))

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


