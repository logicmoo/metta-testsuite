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
            (Sentence ((Implication (Evaluation (Predicate friend) 
                                                (List $1 $2))
                                    (Implication (Evaluation (Predicate smokes) 
                                                             (List $1)) 
                                                 (Evaluation (Predicate smokes)
                                                             (List $2))))
                       (stv 0.4 0.9)) (1))

            (Sentence ((Implication (Evaluation (Predicate smokes)
                                                (List $1)) 
                                    (Evaluation (Predicate cancerous) (List $1))) 
                       (stv 0.6 0.9)) (2))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna) 
                                         (Concept Bob))) 
                       (stv 1.0 0.9)) (3))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna) 
                                         (Concept Edward)))
                       (stv 1.0 0.9)) (4))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna)
                                         (Concept Frank)))
                       (stv 1.0 0.9)) (5))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Edward)
                                         (Concept Frank)))
                       (stv 1.0 0.9)) (6))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Gary)
                                         (Concept Helen)))
                       (stv 1.0 0.9)) (7))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Gary) 
                                         (Concept Frank)))
                       (stv 0.0 0.9)) (8))

            (Sentence ((Evaluation (Predicate smokes)
                                   (List (Concept Anna)))
                       (stv 1.0 0.9)) (9))

            ;(Sentence ((Evaluation (Predicate smokes) 
            ;                       (List (Concept Edward)))
            ;          (stv 1.0 0.9)) (10))
           )

           (Evaluation (Predicate cancerous)
                       (List (Concept Edward)))

           3)

