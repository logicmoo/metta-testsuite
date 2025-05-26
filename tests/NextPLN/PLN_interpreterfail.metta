(= (TupleConcat $Ev1 $Ev2)
   (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))
   
;Modus Ponens
(= (|- ($A $T1) 
       ((Implication $A $B) $T2))
   ($B (stv 1.0 0.1)))

;Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True True) ($dummy (empty))))))))

;; Exhaustive-until-depth deriver
(= (Derive $beliefs $depth $maxdepth)
   (if (> $depth $maxdepth)
       $beliefs
       (let $derivations 
            (collapse (let* (((Sentence $x $Ev1) (superpose $beliefs))
                                         ((Sentence $y $Ev2) (superpose $beliefs))
                                         ($stamp (TupleConcat $Ev1 $Ev2)))
                                        (if (StampDisjoint $Ev1 $Ev2)
                                            (case (|- $x $y) ((($T $TV) (Sentence ($T $TV) $stamp)) ($dummy (empty)))) (empty))))
            (Derive (collapse (unique (superpose (TupleConcat $beliefs $derivations)))) (+ $depth 1) $maxdepth))))

;pose a question of a certain term to the system on some knowledge base
(= (Question $kb $term $steps)
   (Derive $kb 1 $steps))

!(Question (
            (Sentence ((Implication (Evaluation (Predicate smokes)
                                                (List $1)) 
                                    (Evaluation (Predicate cancerous) (List $1))) 
                       (stv 0.6 0.9)) (2))
                       
            (Sentence ((Evaluation (Predicate smokes) 
                                   (List (Concept Edward)))
                      (stv 1.0 0.9)) (10))
           )

           (Evaluation (Predicate cancerous)
                       (List (Concept Edward)))

           3)

