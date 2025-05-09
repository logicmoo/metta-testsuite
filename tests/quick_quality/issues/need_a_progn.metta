

(: progL (-> Expression Atom))
(= (progL $list)
  (if (== (quote $list) (quote ())) ()
	(let ($h $t) (decons-atom $list)
	  (if (== (quote $t) (quote ()))
		(case $h ((Empty EmptyResults)($res $res)))
		(let () (case $eval ((Empty ())($res ())))
			 (progL $t))))))

(: progN (-> Atom Atom))
(= (progN $a) (progL ($a)))
(: progN (-> Atom Atom Atom))
(= (progN $a $b) (progL ($a $b)))
(: progN (-> Atom Atom Atom Atom))
(= (progN $a $b $c) (progL ($a $b $c)))
(: progN (-> Atom Atom Atom Atom Atom))
(= (progN $a $b $c $d) (progL ($a $b $c $d)))
(: progN (-> Atom Atom Atom Atom Atom Atom))
(= (progN $a $b $c $d $e) (progL ($a $b $c $d $e)))


;;Check if 2 Atoms are unifiable without modifying them
(: =unifable (-> Atom Atom Bool))
(= (=unifable $a $b) (sealed ($a $b) (unify $a $b True False)))
;;Check if 2 Atoms are unifiable modifying them
(: =unifying (-> Atom Atom Bool))
(= (=unifying $a $b) (unify $a $b True False))
(: =is (-> Atom Atom Atom)) ; or Empty
(= (=is $x $x) $x)

!(progN (=unifying 1 $b) (=unifying 2 $c) ($b $c))
!(progN (=is 1 $b) (=is 2 $c) ($b $c))
!(progN (println! "hello") Empty (println! "world") Empty)
