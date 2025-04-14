
;; Retrieve the Nth element in a list
(: nth_x (-> Expression Number Atom))
(= (nth_x $list $index)
   (if (== () $list) (empty)
  (if (== $index 1)
    (car-atom $list)
    (let* (($rest (cdr-atom $list))
           ($idx (- $index 1)))
         (nth_x $rest $idx)))))

!(assertEqualToResult (nth_x (1 2 3 4 5 6 7 8 9) 9) (9))

;; Choose a random value from a list
(: random-atom-ok (-> Expression Atom))
(= (random-atom-ok $list)
 (let $len (size-atom $list)
  (if (== 0 $len) (empty)
	(if (== 1 $len) (car-atom $list)
	 (let $index (random-int &rng 1 (+ 1 $len))
        (nth_x $list $index))))))

!(assertEqualToResult (random-atom-ok (1)) (1)) ;; Edge case: only one option
!(assertEqualToResult (random-atom-ok ()) ())   ;; Edge case: no options

!(random-atom-ok (1 2 3 4 5 6 7 8 9))   ;; Random

