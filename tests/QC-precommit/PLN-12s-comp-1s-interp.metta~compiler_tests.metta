
; count 
  ! (assertCounted 1 
      (Implication 
        (Evaluation 
          (Predicate smokes) 
          (List $7140440)) 
        (Evaluation 
          (Predicate cancerous) 
          (List $7140440))))


; count 
  ! (assertCounted 1 
      (stv 0.6 0.9))


; count 
  ! (assertCounted 1 
      ( (Implication 
          (Evaluation 
            (Predicate smokes) 
            (List $7140446)) 
          (Evaluation 
            (Predicate cancerous) 
            (List $7140446))) (stv 0.6 0.9)))


; count 
  ! (assertCounted 1 
      (Sentence 
        ( (Implication 
            (Evaluation 
              (Predicate smokes) 
              (List $7140458)) 
            (Evaluation 
              (Predicate cancerous) 
              (List $7140458))) (stv 0.6 0.9)) 
        (1)))


; count 
  ! (assertCounted 1 
      (stv 1.0 0.9))


; count 
  ! (assertCounted 1 
      ( (Evaluation 
          (Predicate smokes) 
          (List (Concept Edward))) (stv 1.0 0.9)))


; count 
  ! (assertCounted 1 
      (Sentence 
        ( (Evaluation 
            (Predicate smokes) 
            (List (Concept Edward))) (stv 1.0 0.9)) 
        (2)))


; count 
  ! (assertCounted 1 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7140464)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7140464))) (stv 0.6 0.9)) 
          (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))


; count 
  ! (assertCounted 1 
      (> 1 2))


; count 
  ! (assertCounted 2 
      (superpose ((superpose (1)) (superpose (1)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (1)) (superpose (1))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (1) 
        (1)))


; no_results 
  ! (assertEmpty (StampDisjoint (1) (1)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (1)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140518)) (Evaluation (Predicate cancerous) (List $7140518))) (stv 0.6 0.9)) ((Implication (Evaluation (Predicate smokes) (List $7140518)) (Evaluation (Predicate cancerous) (List $7140518))) (stv 0.6 0.9))) ((($0 $1) (Sentence ($0 $1) (1 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (1)) (if (StampDisjoint (1) (1)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140576)) (Evaluation (Predicate cancerous) (List $7140576))) (stv 0.6 0.9)) ((Implication (Evaluation (Predicate smokes) (List $7140576)) (Evaluation (Predicate cancerous) (List $7140576))) (stv 0.6 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; count 
  ! (assertCounted 2 
      (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140476)) (Evaluation (Predicate cancerous) (List $7140476))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))))


; count 
  ! (assertCounted 2 
      (superpose ((superpose (1)) (superpose (2)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (1)) (superpose (2))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (1) 
        (2)))


; no_results 
  ! (assertEmpty (StampDisjoint (1) (2)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (2)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140518)) (Evaluation (Predicate cancerous) (List $7140518))) (stv 0.6 0.9)) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($0 $1) (Sentence ($0 $1) (1 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (2)) (if (StampDisjoint (1) (2)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140576)) (Evaluation (Predicate cancerous) (List $7140576))) (stv 0.6 0.9)) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (let (Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140520)) (Evaluation (Predicate cancerous) (List $7140520))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (let $2 (TupleConcat (1) $1) (if (StampDisjoint (1) $1) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140520)) (Evaluation (Predicate cancerous) (List $7140520))) (stv 0.6 0.9)) $0) ((($3 $4) (Sentence ($3 $4) $2)))) ()))))


; count 
  ! (assertCounted 2 
      (superpose ((superpose (2)) (superpose (1)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (2)) (superpose (1))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (2) 
        (1)))


; count 
  ! (assertCounted 1 
      (StampDisjoint 
        (2) 
        (1)))


; count 
  ! (assertCounted 1 
      (stv 0.6 0.81))


; count 
  ! (assertCounted 1 
      (|- 
        ( (Evaluation 
            (Predicate smokes) 
            (List (Concept Edward))) (stv 1.0 0.9)) 
        ( (Implication 
            (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) 
            (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward)))) (stv 0.6 0.9))))


; count 
  ! (assertCounted 1 
      ( (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward))) (stv 0.6 0.81)))


; count 
  ! (assertCounted 1 
      (2 1))


; count 
  ! (assertCounted 1 
      (Sentence 
        ( (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) (stv 0.6 0.81)) 
        (2 1)))


; count 
  ! (assertCounted 1 
      (case 
        (|- 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) 
              (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward)))) (stv 0.6 0.9))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2 1))))))


; count 
  ! (assertCounted 1 
      (if 
        (StampDisjoint 
          (2) 
          (1)) 
        (case 
          (|- 
            ( (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) (stv 1.0 0.9)) 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List (Concept Edward))) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward)))) (stv 0.6 0.9))) 
          ( ( ($0 $1) (Sentence ($0 $1) (2 1))))) ()))


; count 
  ! (assertCounted 1 
      (let $0 
        (TupleConcat 
          (2) 
          (1)) 
        (if 
          (StampDisjoint 
            (2) 
            (1)) 
          (case 
            (|- 
              ( (Evaluation 
                  (Predicate smokes) 
                  (List (Concept Edward))) (stv 1.0 0.9)) 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List (Concept Edward)))) (stv 0.6 0.9))) 
            ( ( ($1 $2) (Sentence ($1 $2) $0)))) ())))


; count 
  ! (assertCounted 1 
      (let 
        (Sentence $0 $1) 
        (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List (Concept Edward))) (Evaluation (Predicate cancerous) (List (Concept Edward)))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) 
        (let $2 
          (TupleConcat 
            (2) $1) 
          (if 
            (StampDisjoint 
              (2) $1) 
            (case 
              (|- 
                ( (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) (stv 1.0 0.9)) $0) 
              ( ( ($3 $4) (Sentence ($3 $4) $2)))) ()))))


; count 
  ! (assertCounted 2 
      (superpose ((superpose (2)) (superpose (2)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (2)) (superpose (2))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (2) 
        (2)))


; no_results 
  ! (assertEmpty (StampDisjoint (2) (2)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (2)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($0 $1) (Sentence ($0 $1) (2 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (2)) (if (StampDisjoint (2) (2)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; count 
  ! (assertCounted 1 
      (|- ((Implication (Evaluation (Predicate smokes) (List $7140458)) (Evaluation (Predicate cancerous) (List $7140458))) (stv 0.6 0.9))))


; count 
  ! (assertCounted 1 
      (Sentence 
        (|- ((Implication (Evaluation (Predicate smokes) (List $7140470)) (Evaluation (Predicate cancerous) (List $7140470))) (stv 0.6 0.9))) 
        (1)))


; count 
  ! (assertCounted 1 
      (case 
        (|- ((Implication (Evaluation (Predicate smokes) (List $7140470)) (Evaluation (Predicate cancerous) (List $7140470))) (stv 0.6 0.9))) 
        ( ( ($0 $1) (Sentence ($0 $1) (1))))))


; count 
  ! (assertCounted 1 
      (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))))


; count 
  ! (assertCounted 1 
      (Sentence 
        (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
        (2)))


; count 
  ! (assertCounted 1 
      (case 
        (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2))))))


; count 
  ! (assertCounted 3 
      (superpose ((let* (((Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140550)) (Evaluation (Predicate cancerous) (List $7140550))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ((Sentence $2 $3) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140550)) (Evaluation (Predicate cancerous) (List $7140550))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ($4 (TupleConcat $1 $3))) (if (StampDisjoint $1 $3) (case (|- $0 $2) ((($5 $6) (Sentence ($5 $6) $4)))) ())) (let (Sentence $7 $8) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140550)) (Evaluation (Predicate cancerous) (List $7140550))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (case (|- $7) ((($9 $10) (Sentence ($9 $10) $8))))))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((let* (((Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140562)) (Evaluation (Predicate cancerous) (List $7140562))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ((Sentence $2 $3) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140562)) (Evaluation (Predicate cancerous) (List $7140562))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ($4 (TupleConcat $1 $3))) (if (StampDisjoint $1 $3) (case (|- $0 $2) ((($5 $6) (Sentence ($5 $6) $4)))) ())) (let (Sentence $7 $8) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140562)) (Evaluation (Predicate cancerous) (List $7140562))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (case (|- $7) ((($9 $10) (Sentence ($9 $10) $8)))))))))


; count 
  ! (assertCounted 1 
      ( (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7140608)) (Evaluation (Predicate cancerous) (List $7140608))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2))))


; count 
  ! (assertCounted 5 
      (superpose ((superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140494)) (Evaluation (Predicate cancerous) (List $7140494))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (superpose ((Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140956)) (Evaluation (Predicate cancerous) (List $7140956))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140506)) (Evaluation (Predicate cancerous) (List $7140506))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (superpose ((Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140968)) (Evaluation (Predicate cancerous) (List $7140968))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140476)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140476))) (stv 0.6 0.9)) 
            (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 
        ( (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7140926)) (Evaluation (Predicate cancerous) (List $7140926))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2)))))


; count 
  ! (assertCounted 1 
      (+ 1 1))


; count 
  ! (assertCounted 1 
      (> 2 2))


; count 
  ! (assertCounted 3 
      (superpose ((superpose (1)) (superpose (2 1)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (1)) (superpose (2 1))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (1) 
        (2 1)))


; no_results 
  ! (assertEmpty (StampDisjoint (1) (2 1)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (2 1)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140524)) (Evaluation (Predicate cancerous) (List $7140524))) (stv 0.6 0.9)) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($0 $1) (Sentence ($0 $1) (1 2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (2 1)) (if (StampDisjoint (1) (2 1)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140588)) (Evaluation (Predicate cancerous) (List $7140588))) (stv 0.6 0.9)) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (1)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140518)) (Evaluation (Predicate cancerous) (List $7140518))) (stv 0.6 0.9)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140680)) (Evaluation (Predicate cancerous) (List $7140680))) (stv 0.6 0.9)))) ((($0 $1) (Sentence ($0 $1) (1 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (1)) (if (StampDisjoint (1) (1)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140576)) (Evaluation (Predicate cancerous) (List $7140576))) (stv 0.6 0.9)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140738)) (Evaluation (Predicate cancerous) (List $7140738))) (stv 0.6 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; count 
  ! (assertCounted 5 
      (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140476)) (Evaluation (Predicate cancerous) (List $7140476))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140920)) (Evaluation (Predicate cancerous) (List $7140920))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (2)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140518)) (Evaluation (Predicate cancerous) (List $7140518))) (stv 0.6 0.9)) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($0 $1) (Sentence ($0 $1) (1 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (2)) (if (StampDisjoint (1) (2)) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140576)) (Evaluation (Predicate cancerous) (List $7140576))) (stv 0.6 0.9)) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (let (Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140520)) (Evaluation (Predicate cancerous) (List $7140520))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140964)) (Evaluation (Predicate cancerous) (List $7140964))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (let $2 (TupleConcat (1) $1) (if (StampDisjoint (1) $1) (case (|- ((Implication (Evaluation (Predicate smokes) (List $7140520)) (Evaluation (Predicate cancerous) (List $7140520))) (stv 0.6 0.9)) $0) ((($3 $4) (Sentence ($3 $4) $2)))) ()))))


; count 
  ! (assertCounted 1 
      (let 
        (Sentence $0 $1) 
        (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List (Concept Edward))) (Evaluation (Predicate cancerous) (List (Concept Edward)))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140988)) (Evaluation (Predicate cancerous) (List $7140988))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) 
        (let $2 
          (TupleConcat 
            (2) $1) 
          (if 
            (StampDisjoint 
              (2) $1) 
            (case 
              (|- 
                ( (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) (stv 1.0 0.9)) $0) 
              ( ( ($3 $4) (Sentence ($3 $4) $2)))) ()))))


; count 
  ! (assertCounted 3 
      (superpose ((superpose (2)) (superpose (2 1)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (2)) (superpose (2 1))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (2) 
        (2 1)))


; no_results 
  ! (assertEmpty (StampDisjoint (2) (2 1)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (2 1)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($0 $1) (Sentence ($0 $1) (2 2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (2 1)) (if (StampDisjoint (2) (2 1)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140572)) (Evaluation (Predicate cancerous) (List $7140572))) (stv 0.6 0.9)))))


; count 
  ! (assertCounted 1 
      ($0 $1))


; no_results 
  ! (assertEmpty (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 1))))))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (1)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140632)) (Evaluation (Predicate cancerous) (List $7140632))) (stv 0.6 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (1)) (if (StampDisjoint (2) (1)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140690)) (Evaluation (Predicate cancerous) (List $7140690))) (stv 0.6 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (2)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (2)) (if (StampDisjoint (2) (2)) (case (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; count 
  ! (assertCounted 3 
      (superpose ((superpose (2 1)) (superpose (1)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (2 1)) (superpose (1))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (2 1) 
        (1)))


; no_results 
  ! (assertEmpty (StampDisjoint (2 1) (1)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2 1) (1)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) ((Implication (Evaluation (Predicate smokes) (List $7140626)) (Evaluation (Predicate cancerous) (List $7140626))) (stv 0.6 0.9))) ((($0 $1) (Sentence ($0 $1) (2 1 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2 1) (1)) (if (StampDisjoint (2 1) (1)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) ((Implication (Evaluation (Predicate smokes) (List $7140690)) (Evaluation (Predicate cancerous) (List $7140690))) (stv 0.6 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; count 
  ! (assertCounted 3 
      (superpose ((superpose (2 1)) (superpose (2)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (2 1)) (superpose (2))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (2 1) 
        (2)))


; no_results 
  ! (assertEmpty (StampDisjoint (2 1) (2)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2 1) (2)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($0 $1) (Sentence ($0 $1) (2 1 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2 1) (2)) (if (StampDisjoint (2 1) (2)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; count 
  ! (assertCounted 4 
      (superpose ((superpose (2 1)) (superpose (2 1)))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose (2 1)) (superpose (2 1))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        (2 1) 
        (2 1)))


; no_results 
  ! (assertEmpty (StampDisjoint (2 1) (2 1)))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2 1) (2 1)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($0 $1) (Sentence ($0 $1) (2 1 2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2 1) (2 1)) (if (StampDisjoint (2 1) (2 1)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2 1) (1)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140638)) (Evaluation (Predicate cancerous) (List $7140638))) (stv 0.6 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 1 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2 1) (1)) (if (StampDisjoint (2 1) (1)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (|- ((Implication (Evaluation (Predicate smokes) (List $7140702)) (Evaluation (Predicate cancerous) (List $7140702))) (stv 0.6 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2 1) (2)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 1 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2 1) (2)) (if (StampDisjoint (2 1) (2)) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (let (Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140520)) (Evaluation (Predicate cancerous) (List $7140520))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140964)) (Evaluation (Predicate cancerous) (List $7140964))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (let $2 (TupleConcat (2 1) $1) (if (StampDisjoint (2 1) $1) (case (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) $0) ((($3 $4) (Sentence ($3 $4) $2)))) ()))))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (1)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140530)) (Evaluation (Predicate cancerous) (List $7140530))) (stv 0.6 0.9))) ((Implication (Evaluation (Predicate smokes) (List $7140680)) (Evaluation (Predicate cancerous) (List $7140680))) (stv 0.6 0.9))) ((($0 $1) (Sentence ($0 $1) (1 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (1)) (if (StampDisjoint (1) (1)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140588)) (Evaluation (Predicate cancerous) (List $7140588))) (stv 0.6 0.9))) ((Implication (Evaluation (Predicate smokes) (List $7140738)) (Evaluation (Predicate cancerous) (List $7140738))) (stv 0.6 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (2)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140530)) (Evaluation (Predicate cancerous) (List $7140530))) (stv 0.6 0.9))) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($0 $1) (Sentence ($0 $1) (1 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (2)) (if (StampDisjoint (1) (2)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140588)) (Evaluation (Predicate cancerous) (List $7140588))) (stv 0.6 0.9))) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (2 1)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140536)) (Evaluation (Predicate cancerous) (List $7140536))) (stv 0.6 0.9))) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($0 $1) (Sentence ($0 $1) (1 2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (2 1)) (if (StampDisjoint (1) (2 1)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140600)) (Evaluation (Predicate cancerous) (List $7140600))) (stv 0.6 0.9))) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (1)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140530)) (Evaluation (Predicate cancerous) (List $7140530))) (stv 0.6 0.9))) (|- ((Implication (Evaluation (Predicate smokes) (List $7140530)) (Evaluation (Predicate cancerous) (List $7140530))) (stv 0.6 0.9)))) ((($0 $1) (Sentence ($0 $1) (1 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (1)) (if (StampDisjoint (1) (1)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140588)) (Evaluation (Predicate cancerous) (List $7140588))) (stv 0.6 0.9))) (|- ((Implication (Evaluation (Predicate smokes) (List $7140588)) (Evaluation (Predicate cancerous) (List $7140588))) (stv 0.6 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (1) (2)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140530)) (Evaluation (Predicate cancerous) (List $7140530))) (stv 0.6 0.9))) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($0 $1) (Sentence ($0 $1) (1 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (1) (2)) (if (StampDisjoint (1) (2)) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140588)) (Evaluation (Predicate cancerous) (List $7140588))) (stv 0.6 0.9))) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (let (Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140520)) (Evaluation (Predicate cancerous) (List $7140520))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140964)) (Evaluation (Predicate cancerous) (List $7140964))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (let $2 (TupleConcat (1) $1) (if (StampDisjoint (1) $1) (case (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140964)) (Evaluation (Predicate cancerous) (List $7140964))) (stv 0.6 0.9))) $0) ((($3 $4) (Sentence ($3 $4) $2)))) ()))))


; no_results 
  ! (assertEmpty (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Implication (Evaluation (Predicate smokes) (List $7140572)) (Evaluation (Predicate cancerous) (List $7140572))) (stv 0.6 0.9))))


; no_results 
  ! (assertEmpty (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9))) ((($0 $1) (Sentence ($0 $1) (2 1))))))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (1)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Implication (Evaluation (Predicate smokes) (List $7140632)) (Evaluation (Predicate cancerous) (List $7140632))) (stv 0.6 0.9))) ((($0 $1) (Sentence ($0 $1) (2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (1)) (if (StampDisjoint (2) (1)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Implication (Evaluation (Predicate smokes) (List $7140690)) (Evaluation (Predicate cancerous) (List $7140690))) (stv 0.6 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (2)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($0 $1) (Sentence ($0 $1) (2 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (2)) (if (StampDisjoint (2) (2)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (2 1)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($0 $1) (Sentence ($0 $1) (2 2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (2 1)) (if (StampDisjoint (2) (2 1)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (|- ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)))))


; no_results 
  ! (assertEmpty (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (|- ((Implication (Evaluation (Predicate smokes) (List $7140596)) (Evaluation (Predicate cancerous) (List $7140596))) (stv 0.6 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 1))))))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (1)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (|- ((Implication (Evaluation (Predicate smokes) (List $7140644)) (Evaluation (Predicate cancerous) (List $7140644))) (stv 0.6 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 1))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (1)) (if (StampDisjoint (2) (1)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (|- ((Implication (Evaluation (Predicate smokes) (List $7140702)) (Evaluation (Predicate cancerous) (List $7140702))) (stv 0.6 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (if (StampDisjoint (2) (2)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($0 $1) (Sentence ($0 $1) (2 2))))) ()))


; no_results 
  ! (assertEmpty (let $0 (TupleConcat (2) (2)) (if (StampDisjoint (2) (2)) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) ((($1 $2) (Sentence ($1 $2) $0)))) ())))


; no_results 
  ! (assertEmpty (let (Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140520)) (Evaluation (Predicate cancerous) (List $7140520))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140964)) (Evaluation (Predicate cancerous) (List $7140964))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (let $2 (TupleConcat (2) $1) (if (StampDisjoint (2) $1) (case (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) $0) ((($3 $4) (Sentence ($3 $4) $2)))) ()))))


; count 
  ! (assertCounted 1 
      (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))))


; count 
  ! (assertCounted 1 
      (Sentence 
        (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
        (2 1)))


; count 
  ! (assertCounted 1 
      (case 
        (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2 1))))))


; count 
  ! (assertCounted 1 
      (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140470)) (Evaluation (Predicate cancerous) (List $7140470))) (stv 0.6 0.9)))))


; count 
  ! (assertCounted 1 
      (Sentence 
        (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140482)) (Evaluation (Predicate cancerous) (List $7140482))) (stv 0.6 0.9)))) 
        (1)))


; count 
  ! (assertCounted 1 
      (case 
        (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140482)) (Evaluation (Predicate cancerous) (List $7140482))) (stv 0.6 0.9)))) 
        ( ( ($0 $1) (Sentence ($0 $1) (1))))))


; count 
  ! (assertCounted 1 
      (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))))


; count 
  ! (assertCounted 1 
      (Sentence 
        (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
        (2)))


; count 
  ! (assertCounted 1 
      (case 
        (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2))))))


; count 
  ! (assertCounted 6 
      (superpose ((let* (((Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140550)) (Evaluation (Predicate cancerous) (List $7140550))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140994)) (Evaluation (Predicate cancerous) (List $7140994))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ((Sentence $2 $3) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140550)) (Evaluation (Predicate cancerous) (List $7140550))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140994)) (Evaluation (Predicate cancerous) (List $7140994))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ($4 (TupleConcat $1 $3))) (if (StampDisjoint $1 $3) (case (|- $0 $2) ((($5 $6) (Sentence ($5 $6) $4)))) ())) (let (Sentence $7 $8) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140550)) (Evaluation (Predicate cancerous) (List $7140550))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140994)) (Evaluation (Predicate cancerous) (List $7140994))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (case (|- $7) ((($9 $10) (Sentence ($9 $10) $8))))))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((let* (((Sentence $0 $1) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140562)) (Evaluation (Predicate cancerous) (List $7140562))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141006)) (Evaluation (Predicate cancerous) (List $7141006))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ((Sentence $2 $3) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140562)) (Evaluation (Predicate cancerous) (List $7140562))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141006)) (Evaluation (Predicate cancerous) (List $7141006))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ($4 (TupleConcat $1 $3))) (if (StampDisjoint $1 $3) (case (|- $0 $2) ((($5 $6) (Sentence ($5 $6) $4)))) ())) (let (Sentence $7 $8) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140562)) (Evaluation (Predicate cancerous) (List $7140562))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141006)) (Evaluation (Predicate cancerous) (List $7141006))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (case (|- $7) ((($9 $10) (Sentence ($9 $10) $8)))))))))


; count 
  ! (assertCounted 1 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7140464)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7140464))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7140908)) (Evaluation (Predicate cancerous) (List $7140908))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2))))


; count 
  ! (assertCounted 1 
      ( (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7140608)) (Evaluation (Predicate cancerous) (List $7140608))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141088)) (Evaluation (Predicate cancerous) (List $7141088))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; count 
  ! (assertCounted 11 
      (superpose ((superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140494)) (Evaluation (Predicate cancerous) (List $7140494))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140938)) (Evaluation (Predicate cancerous) (List $7140938))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (superpose ((Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141412)) (Evaluation (Predicate cancerous) (List $7141412))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141892)) (Evaluation (Predicate cancerous) (List $7141892))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2)))))))


; count 
  ! (assertCounted 1 
      (collapse (superpose ((superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140506)) (Evaluation (Predicate cancerous) (List $7140506))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140950)) (Evaluation (Predicate cancerous) (List $7140950))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (superpose ((Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141424)) (Evaluation (Predicate cancerous) (List $7141424))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141904)) (Evaluation (Predicate cancerous) (List $7141904))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2))))))))


; count 
  ! (assertCounted 1 
      (TupleConcat 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140476)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140476))) (stv 0.6 0.9)) 
            (1)) 
          (Sentence 
            ( (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) (stv 1.0 0.9)) 
            (2)) 
          (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7140920)) (Evaluation (Predicate cancerous) (List $7140920))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2))) 
        ( (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7141382)) (Evaluation (Predicate cancerous) (List $7141382))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2)) 
          (Sentence 
            (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
            (2 1)) 
          (Sentence 
            (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141862)) (Evaluation (Predicate cancerous) (List $7141862))) (stv 0.6 0.9)))) 
            (1)) 
          (Sentence 
            (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
            (2)))))


; count 
  ! (assertCounted 1 
      (+ 2 1))


; count 
  ! (assertCounted 1 
      (> 3 2))


; count 
  ! (assertCounted 1 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7140464)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7140464))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7140908)) (Evaluation (Predicate cancerous) (List $7140908))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7141364)) (Evaluation (Predicate cancerous) (List $7141364))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141844)) (Evaluation (Predicate cancerous) (List $7141844))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; count 
  ! (assertCounted 1 
      (if 
        (> 3 2) 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140500)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140500))) (stv 0.6 0.9)) 
            (1)) 
          (Sentence 
            ( (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) (stv 1.0 0.9)) 
            (2)) 
          (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2)) 
          (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7141400)) (Evaluation (Predicate cancerous) (List $7141400))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2)) 
          (Sentence 
            (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
            (2 1)) 
          (Sentence 
            (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141880)) (Evaluation (Predicate cancerous) (List $7141880))) (stv 0.6 0.9)))) 
            (1)) 
          (Sentence 
            (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
            (2))) 
        (let $0 
          (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141400)) (Evaluation (Predicate cancerous) (List $7141400))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141880)) (Evaluation (Predicate cancerous) (List $7141880))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141400)) (Evaluation (Predicate cancerous) (List $7141400))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141880)) (Evaluation (Predicate cancerous) (List $7141880))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141400)) (Evaluation (Predicate cancerous) (List $7141400))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141880)) (Evaluation (Predicate cancerous) (List $7141880))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
          (Derive 
            (TupleConcat 
              ( (Sentence 
                  ( (Implication 
                      (Evaluation 
                        (Predicate smokes) 
                        (List $7140500)) 
                      (Evaluation 
                        (Predicate cancerous) 
                        (List $7140500))) (stv 0.6 0.9)) 
                  (1)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate smokes) 
                      (List (Concept Edward))) (stv 1.0 0.9)) 
                  (2)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate cancerous) 
                      (List (Concept Edward))) (stv 0.6 0.81)) 
                  (2 1)) 
                (Sentence 
                  (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) 
                  (1)) 
                (Sentence 
                  (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                  (2)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate cancerous) 
                      (List (Concept Edward))) (stv 0.6 0.81)) 
                  (2 1)) 
                (Sentence 
                  (|- ((Implication (Evaluation (Predicate smokes) (List $7141400)) (Evaluation (Predicate cancerous) (List $7141400))) (stv 0.6 0.9))) 
                  (1)) 
                (Sentence 
                  (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                  (2)) 
                (Sentence 
                  (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
                  (2 1)) 
                (Sentence 
                  (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141880)) (Evaluation (Predicate cancerous) (List $7141880))) (stv 0.6 0.9)))) 
                  (1)) 
                (Sentence 
                  (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
                  (2))) $0) 
            (+ 3 1) 2))))


; count 
  ! (assertCounted 1 
      (Derive 
        (TupleConcat 
          ( (Sentence 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List $7140488)) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List $7140488))) (stv 0.6 0.9)) 
              (1)) 
            (Sentence 
              ( (Evaluation 
                  (Predicate smokes) 
                  (List (Concept Edward))) (stv 1.0 0.9)) 
              (2)) 
            (Sentence 
              ( (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward))) (stv 0.6 0.81)) 
              (2 1)) 
            (Sentence 
              (|- ((Implication (Evaluation (Predicate smokes) (List $7140932)) (Evaluation (Predicate cancerous) (List $7140932))) (stv 0.6 0.9))) 
              (1)) 
            (Sentence 
              (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
              (2))) 
          ( (Sentence 
              ( (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward))) (stv 0.6 0.81)) 
              (2 1)) 
            (Sentence 
              (|- ((Implication (Evaluation (Predicate smokes) (List $7141394)) (Evaluation (Predicate cancerous) (List $7141394))) (stv 0.6 0.9))) 
              (1)) 
            (Sentence 
              (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
              (2)) 
            (Sentence 
              (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
              (2 1)) 
            (Sentence 
              (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141874)) (Evaluation (Predicate cancerous) (List $7141874))) (stv 0.6 0.9)))) 
              (1)) 
            (Sentence 
              (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
              (2)))) 
        (+ 2 1) 2))


; count 
  ! (assertCounted 1 
      (let $0 
        (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141028)) (Evaluation (Predicate cancerous) (List $7141028))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141028)) (Evaluation (Predicate cancerous) (List $7141028))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141028)) (Evaluation (Predicate cancerous) (List $7141028))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
        (Derive 
          (TupleConcat 
            ( (Sentence 
                ( (Implication 
                    (Evaluation 
                      (Predicate smokes) 
                      (List $7140584)) 
                    (Evaluation 
                      (Predicate cancerous) 
                      (List $7140584))) (stv 0.6 0.9)) 
                (1)) 
              (Sentence 
                ( (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) (stv 1.0 0.9)) 
                (2)) 
              (Sentence 
                ( (Evaluation 
                    (Predicate cancerous) 
                    (List (Concept Edward))) (stv 0.6 0.81)) 
                (2 1)) 
              (Sentence 
                (|- ((Implication (Evaluation (Predicate smokes) (List $7141028)) (Evaluation (Predicate cancerous) (List $7141028))) (stv 0.6 0.9))) 
                (1)) 
              (Sentence 
                (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                (2))) $0) 
          (+ 2 1) 2)))


; count 
  ! (assertCounted 1 
      (if 
        (> 2 2) 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140500)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140500))) (stv 0.6 0.9)) 
            (1)) 
          (Sentence 
            ( (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) (stv 1.0 0.9)) 
            (2)) 
          (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2))) 
        (let $0 
          (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
          (Derive 
            (TupleConcat 
              ( (Sentence 
                  ( (Implication 
                      (Evaluation 
                        (Predicate smokes) 
                        (List $7140500)) 
                      (Evaluation 
                        (Predicate cancerous) 
                        (List $7140500))) (stv 0.6 0.9)) 
                  (1)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate smokes) 
                      (List (Concept Edward))) (stv 1.0 0.9)) 
                  (2)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate cancerous) 
                      (List (Concept Edward))) (stv 0.6 0.81)) 
                  (2 1)) 
                (Sentence 
                  (|- ((Implication (Evaluation (Predicate smokes) (List $7140944)) (Evaluation (Predicate cancerous) (List $7140944))) (stv 0.6 0.9))) 
                  (1)) 
                (Sentence 
                  (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                  (2))) $0) 
            (+ 2 1) 2))))


; count 
  ! (assertCounted 1 
      (Derive 
        (TupleConcat 
          ( (Sentence 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List $7140488)) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List $7140488))) (stv 0.6 0.9)) 
              (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 
          ( (Sentence 
              ( (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward))) (stv 0.6 0.81)) 
              (2 1)) 
            (Sentence 
              (|- ((Implication (Evaluation (Predicate smokes) (List $7140938)) (Evaluation (Predicate cancerous) (List $7140938))) (stv 0.6 0.9))) 
              (1)) 
            (Sentence 
              (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
              (2)))) 
        (+ 1 1) 2))


; count 
  ! (assertCounted 1 
      (let $0 
        (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140584)) (Evaluation (Predicate cancerous) (List $7140584))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
        (Derive 
          (TupleConcat 
            ( (Sentence 
                ( (Implication 
                    (Evaluation 
                      (Predicate smokes) 
                      (List $7140584)) 
                    (Evaluation 
                      (Predicate cancerous) 
                      (List $7140584))) (stv 0.6 0.9)) 
                (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) $0) 
          (+ 1 1) 2)))


; count 
  ! (assertCounted 1 
      (if 
        (> 1 2) 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140500)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140500))) (stv 0.6 0.9)) 
            (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 
        (let $0 
          (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140500)) (Evaluation (Predicate cancerous) (List $7140500))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
          (Derive 
            (TupleConcat 
              ( (Sentence 
                  ( (Implication 
                      (Evaluation 
                        (Predicate smokes) 
                        (List $7140500)) 
                      (Evaluation 
                        (Predicate cancerous) 
                        (List $7140500))) (stv 0.6 0.9)) 
                  (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) $0) 
            (+ 1 1) 2))))


; count 
  ! (assertCounted 1 
      (Derive 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140476)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140476))) (stv 0.6 0.9)) 
            (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 1 2))


; count 
  ! (assertCounted 1 
      (== 
        (Implication 
          (Evaluation 
            (Predicate smokes) 
            (List $7140452)) 
          (Evaluation 
            (Predicate cancerous) 
            (List $7140452))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))))


; no_results 
  ! (assertEmpty (case (== (Implication (Evaluation (Predicate smokes) (List $7140464)) (Evaluation (Predicate cancerous) (List $7140464))) (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ((stv 0.6 0.9) (1))))))


; count 
  ! (assertCounted 1 
      (== 
        (Evaluation 
          (Predicate smokes) 
          (List (Concept Edward))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))))


; no_results 
  ! (assertEmpty (case (== (Evaluation (Predicate smokes) (List (Concept Edward))) (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ((stv 1.0 0.9) (2))))))


; count 
  ! (assertCounted 1 
      (== 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))))


; count 
  ! (assertCounted 1 
      ( (stv 0.6 0.81) (2 1)))


; count 
  ! (assertCounted 1 
      (case 
        (== 
          (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) 
          (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward)))) 
        ( (True ((stv 0.6 0.81) (2 1))))))


; count 
  ! (assertCounted 1 
      (== |- 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))))


; no_results 
  ! (assertEmpty (case (== |- (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True (((Implication (Evaluation (Predicate smokes) (List $7140560)) (Evaluation (Predicate cancerous) (List $7140560))) (stv 0.6 0.9)) (1))))))


; no_results 
  ! (assertEmpty (case (== |- (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True (((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))))


; count 
  ! (assertCounted 2 
      (case 
        (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140488)) (Evaluation (Predicate cancerous) (List $7140488))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140932)) (Evaluation (Predicate cancerous) (List $7140932))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141388)) (Evaluation (Predicate cancerous) (List $7141388))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141868)) (Evaluation (Predicate cancerous) (List $7141868))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2)))) 
        ( ( (Sentence 
              ($0 $1) $2) (case (== $0 (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ($1 $2))))))))


; count 
  ! (assertCounted 2 
      (let $0 
        (Derive 
          ( (Sentence 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List $7140498)) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List $7140498))) (stv 0.6 0.9)) 
              (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 1 2) 
        (case 
          (superpose $0) 
          ( ( (Sentence 
                ($1 $2) $3) (case (== $1 (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ($2 $3)))))))))


; no_results 
  ! (assertEmpty (case (== |- (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True (((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1))))))


; no_results 
  ! (assertEmpty (case (== |- (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ((|- ((Implication (Evaluation (Predicate smokes) (List $7140572)) (Evaluation (Predicate cancerous) (List $7140572))) (stv 0.6 0.9))) (1))))))


; count 
  ! (assertCounted 11 
      (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140476)) (Evaluation (Predicate cancerous) (List $7140476))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140920)) (Evaluation (Predicate cancerous) (List $7140920))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141376)) (Evaluation (Predicate cancerous) (List $7141376))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141856)) (Evaluation (Predicate cancerous) (List $7141856))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2)))))


; no_results 
  ! (assertEmpty (case (== |- (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ((|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))))


; count 
  ! (assertCounted 1 
      (collapse (let $0 (Derive ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140510)) (Evaluation (Predicate cancerous) (List $7140510))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 1 2) (case (superpose $0) (((Sentence ($1 $2) $3) (case (== $1 (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ($2 $3))))))))))


; count 
  ! (assertCounted 1 
      ( ( (stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))))


; count 
  ! (assertCounted 1 
      (== 
        ( ( (stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))) ()))


; count 
  ! (assertCounted 1 
      (car-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))))


; count 
  ! (assertCounted 1 
      (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))))


; count 
  ! (assertCounted 1 
      (ConfidenceRank ((stv 0.6 0.81) (2 1))))


; count 
  ! (assertCounted 1 
      (ConfidenceRank ()))


; count 
  ! (assertCounted 1 
      (> 
        (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
        (ConfidenceRank ())))


; count 
  ! (assertCounted 1 
      ( ( (stv 0.6 0.81) (2 1))))


; count 
  ! (assertCounted 1 
      (== 
        ( ( (stv 0.6 0.81) (2 1))) ()))


; count 
  ! (assertCounted 1 
      (car-atom (((stv 0.6 0.81) (2 1)))))


; count 
  ! (assertCounted 1 
      (cdr-atom (((stv 0.6 0.81) (2 1)))))


; count 
  ! (assertCounted 1 
      (> 
        (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
        (ConfidenceRank ((stv 0.6 0.81) (2 1)))))


; count 
  ! (assertCounted 1 
      (== () ()))


; count 
  ! (assertCounted 1 
      (if 
        (== () ()) 
        ( (stv 0.6 0.81) (2 1)) 
        (let* 
          ( ($0 (car-atom ())) ($1 (cdr-atom ()))) 
          (if 
            (> 
              (ConfidenceRank $0) 
              (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
            (BestCandidate ConfidenceRank $0 $1) 
            (BestCandidate ConfidenceRank 
              ( (stv 0.6 0.81) (2 1)) $1)))))


; count 
  ! (assertCounted 1 
      (BestCandidate ConfidenceRank 
        ( (stv 0.6 0.81) (2 1)) ()))


; count 
  ! (assertCounted 1 
      (if 
        (> 
          (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
          (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
        (BestCandidate ConfidenceRank 
          ( (stv 0.6 0.81) (2 1)) ()) 
        (BestCandidate ConfidenceRank 
          ( (stv 0.6 0.81) (2 1)) ())))


; count 
  ! (assertCounted 1 
      (let $0 
        (cdr-atom (((stv 0.6 0.81) (2 1)))) 
        (if 
          (> 
            (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
            (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $0) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $0))))


; count 
  ! (assertCounted 1 
      (let* 
        ( ($0 (car-atom (((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)))))) 
        (if 
          (> 
            (ConfidenceRank $0) 
            (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
          (BestCandidate ConfidenceRank $0 $1) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $1))))


; count 
  ! (assertCounted 1 
      (if 
        (== 
          ( ( (stv 0.6 0.81) (2 1))) ()) 
        ( (stv 0.6 0.81) (2 1)) 
        (let* 
          ( ($0 (car-atom (((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)))))) 
          (if 
            (> 
              (ConfidenceRank $0) 
              (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
            (BestCandidate ConfidenceRank $0 $1) 
            (BestCandidate ConfidenceRank 
              ( (stv 0.6 0.81) (2 1)) $1)))))


; count 
  ! (assertCounted 1 
      (BestCandidate ConfidenceRank 
        ( (stv 0.6 0.81) (2 1)) 
        ( ( (stv 0.6 0.81) (2 1)))))


; count 
  ! (assertCounted 1 
      (if 
        (> 
          (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
          (ConfidenceRank ())) 
        (BestCandidate ConfidenceRank 
          ( (stv 0.6 0.81) (2 1)) 
          ( ( (stv 0.6 0.81) (2 1)))) 
        (BestCandidate ConfidenceRank () 
          ( ( (stv 0.6 0.81) (2 1))))))


; count 
  ! (assertCounted 1 
      (let $0 
        (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))) 
        (if 
          (> 
            (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
            (ConfidenceRank ())) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $0) 
          (BestCandidate ConfidenceRank () $0))))


; count 
  ! (assertCounted 1 
      (let* 
        ( ($0 (car-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))))) 
        (if 
          (> 
            (ConfidenceRank $0) 
            (ConfidenceRank ())) 
          (BestCandidate ConfidenceRank $0 $1) 
          (BestCandidate ConfidenceRank () $1))))


; count 
  ! (assertCounted 1 
      (if 
        (== 
          ( ( (stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))) ()) () 
        (let* 
          ( ($0 (car-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))))) 
          (if 
            (> 
              (ConfidenceRank $0) 
              (ConfidenceRank ())) 
            (BestCandidate ConfidenceRank $0 $1) 
            (BestCandidate ConfidenceRank () $1)))))


; count 
  ! (assertCounted 1 
      (BestCandidate ConfidenceRank () 
        (collapse (let $0 (Derive ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140534)) (Evaluation (Predicate cancerous) (List $7140534))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 1 2) (case (superpose $0) (((Sentence ($1 $2) $3) (case (== $1 (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ($2 $3)))))))))))


; count 
  ! (assertCounted 1 
      (Question 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140476)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140476))) (stv 0.6 0.9)) 
            (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward))) 2))


; xform 
  ! (assertEqual 
      (> 1 2) False)


; xform 
  ! (assertEqual 
      (StampDisjoint 
        (2) 
        (1)) True)


; xform 
  ! (assertEqual 
      (|- 
        ( (Evaluation 
            (Predicate smokes) 
            (List (Concept Edward))) (stv 1.0 0.9)) 
        ( (Implication 
            (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) 
            (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward)))) (stv 0.6 0.9))) 
      ( (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward))) (stv 0.6 0.81)))


; xform 
  ! (assertEqual 
      (+ 1 1) 2)


; xform 
  ! (assertEqual 
      (> 2 2) False)


; xform 
  ! (assertEqual 
      (+ 2 1) 3)


; xform 
  ! (assertEqual 
      (> 3 2) True)


; xform 
  ! (assertEqual 
      (if 
        (> 3 2) 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140502)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140502))) (stv 0.6 0.9)) 
            (1)) 
          (Sentence 
            ( (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) (stv 1.0 0.9)) 
            (2)) 
          (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2)) 
          (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7141402)) (Evaluation (Predicate cancerous) (List $7141402))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2)) 
          (Sentence 
            (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
            (2 1)) 
          (Sentence 
            (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141882)) (Evaluation (Predicate cancerous) (List $7141882))) (stv 0.6 0.9)))) 
            (1)) 
          (Sentence 
            (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
            (2))) 
        (let $0 
          (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141402)) (Evaluation (Predicate cancerous) (List $7141402))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141882)) (Evaluation (Predicate cancerous) (List $7141882))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141402)) (Evaluation (Predicate cancerous) (List $7141402))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141882)) (Evaluation (Predicate cancerous) (List $7141882))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141402)) (Evaluation (Predicate cancerous) (List $7141402))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141882)) (Evaluation (Predicate cancerous) (List $7141882))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
          (Derive 
            (TupleConcat 
              ( (Sentence 
                  ( (Implication 
                      (Evaluation 
                        (Predicate smokes) 
                        (List $7140502)) 
                      (Evaluation 
                        (Predicate cancerous) 
                        (List $7140502))) (stv 0.6 0.9)) 
                  (1)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate smokes) 
                      (List (Concept Edward))) (stv 1.0 0.9)) 
                  (2)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate cancerous) 
                      (List (Concept Edward))) (stv 0.6 0.81)) 
                  (2 1)) 
                (Sentence 
                  (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) 
                  (1)) 
                (Sentence 
                  (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                  (2)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate cancerous) 
                      (List (Concept Edward))) (stv 0.6 0.81)) 
                  (2 1)) 
                (Sentence 
                  (|- ((Implication (Evaluation (Predicate smokes) (List $7141402)) (Evaluation (Predicate cancerous) (List $7141402))) (stv 0.6 0.9))) 
                  (1)) 
                (Sentence 
                  (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                  (2)) 
                (Sentence 
                  (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
                  (2 1)) 
                (Sentence 
                  (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141882)) (Evaluation (Predicate cancerous) (List $7141882))) (stv 0.6 0.9)))) 
                  (1)) 
                (Sentence 
                  (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
                  (2))) $0) 
            (+ 3 1) 2))) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7140502)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7140502))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7141402)) (Evaluation (Predicate cancerous) (List $7141402))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141882)) (Evaluation (Predicate cancerous) (List $7141882))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xform 
  ! (assertEqual 
      (Derive 
        (TupleConcat 
          ( (Sentence 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List $7140490)) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List $7140490))) (stv 0.6 0.9)) 
              (1)) 
            (Sentence 
              ( (Evaluation 
                  (Predicate smokes) 
                  (List (Concept Edward))) (stv 1.0 0.9)) 
              (2)) 
            (Sentence 
              ( (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward))) (stv 0.6 0.81)) 
              (2 1)) 
            (Sentence 
              (|- ((Implication (Evaluation (Predicate smokes) (List $7140934)) (Evaluation (Predicate cancerous) (List $7140934))) (stv 0.6 0.9))) 
              (1)) 
            (Sentence 
              (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
              (2))) 
          ( (Sentence 
              ( (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward))) (stv 0.6 0.81)) 
              (2 1)) 
            (Sentence 
              (|- ((Implication (Evaluation (Predicate smokes) (List $7141396)) (Evaluation (Predicate cancerous) (List $7141396))) (stv 0.6 0.9))) 
              (1)) 
            (Sentence 
              (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
              (2)) 
            (Sentence 
              (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
              (2 1)) 
            (Sentence 
              (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141876)) (Evaluation (Predicate cancerous) (List $7141876))) (stv 0.6 0.9)))) 
              (1)) 
            (Sentence 
              (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
              (2)))) 
        (+ 2 1) 2) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7142230)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7142230))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7142674)) (Evaluation (Predicate cancerous) (List $7142674))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7143130)) (Evaluation (Predicate cancerous) (List $7143130))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7143610)) (Evaluation (Predicate cancerous) (List $7143610))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xform 
  ! (assertEqual 
      (Derive 
        (TupleConcat 
          ( (Sentence 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List $7140490)) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List $7140490))) (stv 0.6 0.9)) 
              (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 
          ( (Sentence 
              ( (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward))) (stv 0.6 0.81)) 
              (2 1)) 
            (Sentence 
              (|- ((Implication (Evaluation (Predicate smokes) (List $7140940)) (Evaluation (Predicate cancerous) (List $7140940))) (stv 0.6 0.9))) 
              (1)) 
            (Sentence 
              (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
              (2)))) 
        (+ 1 1) 2) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7141282)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7141282))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7141726)) (Evaluation (Predicate cancerous) (List $7141726))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7142182)) (Evaluation (Predicate cancerous) (List $7142182))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7142662)) (Evaluation (Predicate cancerous) (List $7142662))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xform 
  ! (assertEqual 
      (Derive 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140478)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140478))) (stv 0.6 0.9)) 
            (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 1 2) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7140790)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7140790))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7141234)) (Evaluation (Predicate cancerous) (List $7141234))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7141690)) (Evaluation (Predicate cancerous) (List $7141690))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7142170)) (Evaluation (Predicate cancerous) (List $7142170))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xform 
  ! (assertEqual 
      (== 
        (Implication 
          (Evaluation 
            (Predicate smokes) 
            (List $7140454)) 
          (Evaluation 
            (Predicate cancerous) 
            (List $7140454))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))) False)


; xform 
  ! (assertEqual 
      (== 
        (Evaluation 
          (Predicate smokes) 
          (List (Concept Edward))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))) False)


; xform 
  ! (assertEqual 
      (== 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))) True)


; xform 
  ! (assertEqual 
      (case 
        (== 
          (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) 
          (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward)))) 
        ( (True ((stv 0.6 0.81) (2 1))))) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (== |- 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward)))) False)


; xform 
  ! (assertEqual 
      (== 
        ( ( (stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))) ()) False)


; xform 
  ! (assertEqual 
      (car-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))) 
      ( ( (stv 0.6 0.81) (2 1))))


; xform 
  ! (assertEqual 
      (ConfidenceRank ((stv 0.6 0.81) (2 1))) 0.81)


; xform 
  ! (assertEqual 
      (ConfidenceRank ()) 0)


; xform 
  ! (assertEqual 
      (> 
        (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
        (ConfidenceRank ())) True)


; xform 
  ! (assertEqual 
      (== 
        ( ( (stv 0.6 0.81) (2 1))) ()) False)


; xform 
  ! (assertEqual 
      (car-atom (((stv 0.6 0.81) (2 1)))) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (cdr-atom (((stv 0.6 0.81) (2 1)))) ())


; xform 
  ! (assertEqual 
      (> 
        (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
        (ConfidenceRank ((stv 0.6 0.81) (2 1)))) False)


; xform 
  ! (assertEqual 
      (== () ()) True)


; xform 
  ! (assertEqual 
      (if 
        (== () ()) 
        ( (stv 0.6 0.81) (2 1)) 
        (let* 
          ( ($0 (car-atom ())) ($1 (cdr-atom ()))) 
          (if 
            (> 
              (ConfidenceRank $0) 
              (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
            (BestCandidate ConfidenceRank $0 $1) 
            (BestCandidate ConfidenceRank 
              ( (stv 0.6 0.81) (2 1)) $1)))) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (BestCandidate ConfidenceRank 
        ( (stv 0.6 0.81) (2 1)) ()) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (if 
        (> 
          (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
          (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
        (BestCandidate ConfidenceRank 
          ( (stv 0.6 0.81) (2 1)) ()) 
        (BestCandidate ConfidenceRank 
          ( (stv 0.6 0.81) (2 1)) ())) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (BestCandidate ConfidenceRank 
        ( (stv 0.6 0.81) (2 1)) 
        ( ( (stv 0.6 0.81) (2 1)))) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (if 
        (> 
          (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
          (ConfidenceRank ())) 
        (BestCandidate ConfidenceRank 
          ( (stv 0.6 0.81) (2 1)) 
          ( ( (stv 0.6 0.81) (2 1)))) 
        (BestCandidate ConfidenceRank () 
          ( ( (stv 0.6 0.81) (2 1))))) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (BestCandidate ConfidenceRank () 
        (collapse (let $0 (Derive ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140536)) (Evaluation (Predicate cancerous) (List $7140536))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 1 2) (case (superpose $0) (((Sentence ($1 $2) $3) (case (== $1 (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ($2 $3)))))))))) 
      ( (stv 0.6 0.81) (2 1)))


; xform 
  ! (assertEqual 
      (Question 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140478)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140478))) (stv 0.6 0.9)) 
            (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 
        (Evaluation 
          (Predicate cancerous) 
          (List (Concept Edward))) 2) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (case 
        (|- 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) 
              (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward)))) (stv 0.6 0.9))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2 1))))) 
      (Sentence 
        ( (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) (stv 0.6 0.81)) 
        (2 1)))


; xxform 
  ! (assertEqual 
      (if 
        (StampDisjoint 
          (2) 
          (1)) 
        (case 
          (|- 
            ( (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) (stv 1.0 0.9)) 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List (Concept Edward))) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List (Concept Edward)))) (stv 0.6 0.9))) 
          ( ( ($0 $1) (Sentence ($0 $1) (2 1))))) ()) 
      (Sentence 
        ( (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) (stv 0.6 0.81)) 
        (2 1)))


; xxform 
  ! (assertEqual 
      (let $0 
        (TupleConcat 
          (2) 
          (1)) 
        (if 
          (StampDisjoint 
            (2) 
            (1)) 
          (case 
            (|- 
              ( (Evaluation 
                  (Predicate smokes) 
                  (List (Concept Edward))) (stv 1.0 0.9)) 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List (Concept Edward)))) (stv 0.6 0.9))) 
            ( ( ($1 $2) (Sentence ($1 $2) $0)))) ())) 
      (Sentence 
        ( (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) (stv 0.6 0.81)) 
        (2 1)))


; xxform 
  ! (assertEqual 
      (let 
        (Sentence $0 $1) 
        (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List (Concept Edward))) (Evaluation (Predicate cancerous) (List (Concept Edward)))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) 
        (let $2 
          (TupleConcat 
            (2) $1) 
          (if 
            (StampDisjoint 
              (2) $1) 
            (case 
              (|- 
                ( (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) (stv 1.0 0.9)) $0) 
              ( ( ($3 $4) (Sentence ($3 $4) $2)))) ()))) 
      (Sentence 
        ( (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) (stv 0.6 0.81)) 
        (2 1)))


; xxform 
  ! (assertEqual 
      (case 
        (|- ((Implication (Evaluation (Predicate smokes) (List $7140472)) (Evaluation (Predicate cancerous) (List $7140472))) (stv 0.6 0.9))) 
        ( ( ($0 $1) (Sentence ($0 $1) (1))))) 
      (Sentence 
        (|- ((Implication (Evaluation (Predicate smokes) (List $7140472)) (Evaluation (Predicate cancerous) (List $7140472))) (stv 0.6 0.9))) 
        (1)))


; xxform 
  ! (assertEqual 
      (case 
        (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2))))) 
      (Sentence 
        (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
        (2)))


; xxform 
  ! (assertEqual 
      (let 
        (Sentence $0 $1) 
        (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List (Concept Edward))) (Evaluation (Predicate cancerous) (List (Concept Edward)))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140990)) (Evaluation (Predicate cancerous) (List $7140990))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) 
        (let $2 
          (TupleConcat 
            (2) $1) 
          (if 
            (StampDisjoint 
              (2) $1) 
            (case 
              (|- 
                ( (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) (stv 1.0 0.9)) $0) 
              ( ( ($3 $4) (Sentence ($3 $4) $2)))) ()))) 
      (Sentence 
        ( (Evaluation 
            (Predicate cancerous) 
            (List (Concept Edward))) (stv 0.6 0.81)) 
        (2 1)))


; xxform 
  ! (assertEqual 
      (case 
        (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2 1))))) 
      (Sentence 
        (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
        (2 1)))


; xxform 
  ! (assertEqual 
      (case 
        (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140484)) (Evaluation (Predicate cancerous) (List $7140484))) (stv 0.6 0.9)))) 
        ( ( ($0 $1) (Sentence ($0 $1) (1))))) 
      (Sentence 
        (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140484)) (Evaluation (Predicate cancerous) (List $7140484))) (stv 0.6 0.9)))) 
        (1)))


; xxform 
  ! (assertEqual 
      (case 
        (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
        ( ( ($0 $1) (Sentence ($0 $1) (2))))) 
      (Sentence 
        (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
        (2)))


; xxform 
  ! (assertEqual 
      (let $0 
        (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140586)) (Evaluation (Predicate cancerous) (List $7140586))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141030)) (Evaluation (Predicate cancerous) (List $7141030))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140586)) (Evaluation (Predicate cancerous) (List $7140586))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141030)) (Evaluation (Predicate cancerous) (List $7141030))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140586)) (Evaluation (Predicate cancerous) (List $7140586))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141030)) (Evaluation (Predicate cancerous) (List $7141030))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
        (Derive 
          (TupleConcat 
            ( (Sentence 
                ( (Implication 
                    (Evaluation 
                      (Predicate smokes) 
                      (List $7140586)) 
                    (Evaluation 
                      (Predicate cancerous) 
                      (List $7140586))) (stv 0.6 0.9)) 
                (1)) 
              (Sentence 
                ( (Evaluation 
                    (Predicate smokes) 
                    (List (Concept Edward))) (stv 1.0 0.9)) 
                (2)) 
              (Sentence 
                ( (Evaluation 
                    (Predicate cancerous) 
                    (List (Concept Edward))) (stv 0.6 0.81)) 
                (2 1)) 
              (Sentence 
                (|- ((Implication (Evaluation (Predicate smokes) (List $7141030)) (Evaluation (Predicate cancerous) (List $7141030))) (stv 0.6 0.9))) 
                (1)) 
              (Sentence 
                (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                (2))) $0) 
          (+ 2 1) 2)) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7144146)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7144146))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7144590)) (Evaluation (Predicate cancerous) (List $7144590))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7145046)) (Evaluation (Predicate cancerous) (List $7145046))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7145526)) (Evaluation (Predicate cancerous) (List $7145526))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xxform 
  ! (assertEqual 
      (if 
        (> 2 2) 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140502)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140502))) (stv 0.6 0.9)) 
            (1)) 
          (Sentence 
            ( (Evaluation 
                (Predicate smokes) 
                (List (Concept Edward))) (stv 1.0 0.9)) 
            (2)) 
          (Sentence 
            ( (Evaluation 
                (Predicate cancerous) 
                (List (Concept Edward))) (stv 0.6 0.81)) 
            (2 1)) 
          (Sentence 
            (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) 
            (1)) 
          (Sentence 
            (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
            (2))) 
        (let $0 
          (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
          (Derive 
            (TupleConcat 
              ( (Sentence 
                  ( (Implication 
                      (Evaluation 
                        (Predicate smokes) 
                        (List $7140502)) 
                      (Evaluation 
                        (Predicate cancerous) 
                        (List $7140502))) (stv 0.6 0.9)) 
                  (1)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate smokes) 
                      (List (Concept Edward))) (stv 1.0 0.9)) 
                  (2)) 
                (Sentence 
                  ( (Evaluation 
                      (Predicate cancerous) 
                      (List (Concept Edward))) (stv 0.6 0.81)) 
                  (2 1)) 
                (Sentence 
                  (|- ((Implication (Evaluation (Predicate smokes) (List $7140946)) (Evaluation (Predicate cancerous) (List $7140946))) (stv 0.6 0.9))) 
                  (1)) 
                (Sentence 
                  (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
                  (2))) $0) 
            (+ 2 1) 2))) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7144944)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7144944))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7145388)) (Evaluation (Predicate cancerous) (List $7145388))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7145844)) (Evaluation (Predicate cancerous) (List $7145844))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7146324)) (Evaluation (Predicate cancerous) (List $7146324))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xxform 
  ! (assertEqual 
      (let $0 
        (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140586)) (Evaluation (Predicate cancerous) (List $7140586))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140586)) (Evaluation (Predicate cancerous) (List $7140586))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140586)) (Evaluation (Predicate cancerous) (List $7140586))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
        (Derive 
          (TupleConcat 
            ( (Sentence 
                ( (Implication 
                    (Evaluation 
                      (Predicate smokes) 
                      (List $7140586)) 
                    (Evaluation 
                      (Predicate cancerous) 
                      (List $7140586))) (stv 0.6 0.9)) 
                (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) $0) 
          (+ 1 1) 2)) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7142322)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7142322))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7142766)) (Evaluation (Predicate cancerous) (List $7142766))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7143222)) (Evaluation (Predicate cancerous) (List $7143222))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7143702)) (Evaluation (Predicate cancerous) (List $7143702))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xxform 
  ! (assertEqual 
      (if 
        (> 1 2) 
        ( (Sentence 
            ( (Implication 
                (Evaluation 
                  (Predicate smokes) 
                  (List $7140502)) 
                (Evaluation 
                  (Predicate cancerous) 
                  (List $7140502))) (stv 0.6 0.9)) 
            (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 
        (let $0 
          (collapse (superpose ((let* (((Sentence $1 $2) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ((Sentence $3 $4) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))) ($5 (TupleConcat $2 $4))) (if (StampDisjoint $2 $4) (case (|- $1 $3) ((($6 $7) (Sentence ($6 $7) $5)))) ())) (let (Sentence $8 $9) (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140502)) (Evaluation (Predicate cancerous) (List $7140502))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))) (case (|- $8) ((($10 $11) (Sentence ($10 $11) $9)))))))) 
          (Derive 
            (TupleConcat 
              ( (Sentence 
                  ( (Implication 
                      (Evaluation 
                        (Predicate smokes) 
                        (List $7140502)) 
                      (Evaluation 
                        (Predicate cancerous) 
                        (List $7140502))) (stv 0.6 0.9)) 
                  (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) $0) 
            (+ 1 1) 2))) 
      ( (Sentence 
          ( (Implication 
              (Evaluation 
                (Predicate smokes) 
                (List $7142664)) 
              (Evaluation 
                (Predicate cancerous) 
                (List $7142664))) (stv 0.6 0.9)) 
          (1)) 
        (Sentence 
          ( (Evaluation 
              (Predicate smokes) 
              (List (Concept Edward))) (stv 1.0 0.9)) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7143108)) (Evaluation (Predicate cancerous) (List $7143108))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          ( (Evaluation 
              (Predicate cancerous) 
              (List (Concept Edward))) (stv 0.6 0.81)) 
          (2 1)) 
        (Sentence 
          (|- ((Implication (Evaluation (Predicate smokes) (List $7143564)) (Evaluation (Predicate cancerous) (List $7143564))) (stv 0.6 0.9))) 
          (1)) 
        (Sentence 
          (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) 
          (2)) 
        (Sentence 
          (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) 
          (2 1)) 
        (Sentence 
          (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7144044)) (Evaluation (Predicate cancerous) (List $7144044))) (stv 0.6 0.9)))) 
          (1)) 
        (Sentence 
          (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) 
          (2))))


; xxform 
  ! (assertEqual 
      (case 
        (superpose ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140490)) (Evaluation (Predicate cancerous) (List $7140490))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140934)) (Evaluation (Predicate cancerous) (List $7140934))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141390)) (Evaluation (Predicate cancerous) (List $7141390))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141870)) (Evaluation (Predicate cancerous) (List $7141870))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2)))) 
        ( ( (Sentence 
              ($0 $1) $2) (case (== $0 (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ($1 $2))))))) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (let $0 
        (Derive 
          ( (Sentence 
              ( (Implication 
                  (Evaluation 
                    (Predicate smokes) 
                    (List $7140500)) 
                  (Evaluation 
                    (Predicate cancerous) 
                    (List $7140500))) (stv 0.6 0.9)) 
              (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))) 1 2) 
        (case 
          (superpose $0) 
          ( ( (Sentence 
                ($1 $2) $3) (case (== $1 (Evaluation (Predicate cancerous) (List (Concept Edward)))) ((True ($2 $3)))))))) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (let $0 
        (cdr-atom (((stv 0.6 0.81) (2 1)))) 
        (if 
          (> 
            (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
            (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $0) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $0))) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (let* 
        ( ($0 (car-atom (((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)))))) 
        (if 
          (> 
            (ConfidenceRank $0) 
            (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
          (BestCandidate ConfidenceRank $0 $1) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $1))) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (if 
        (== 
          ( ( (stv 0.6 0.81) (2 1))) ()) 
        ( (stv 0.6 0.81) (2 1)) 
        (let* 
          ( ($0 (car-atom (((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)))))) 
          (if 
            (> 
              (ConfidenceRank $0) 
              (ConfidenceRank ((stv 0.6 0.81) (2 1)))) 
            (BestCandidate ConfidenceRank $0 $1) 
            (BestCandidate ConfidenceRank 
              ( (stv 0.6 0.81) (2 1)) $1)))) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (let $0 
        (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))) 
        (if 
          (> 
            (ConfidenceRank ((stv 0.6 0.81) (2 1))) 
            (ConfidenceRank ())) 
          (BestCandidate ConfidenceRank 
            ( (stv 0.6 0.81) (2 1)) $0) 
          (BestCandidate ConfidenceRank () $0))) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (let* 
        ( ($0 (car-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))))) 
        (if 
          (> 
            (ConfidenceRank $0) 
            (ConfidenceRank ())) 
          (BestCandidate ConfidenceRank $0 $1) 
          (BestCandidate ConfidenceRank () $1))) 
      ( (stv 0.6 0.81) (2 1)))


; xxform 
  ! (assertEqual 
      (if 
        (== 
          ( ( (stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))) ()) () 
        (let* 
          ( ($0 (car-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))))) ($1 (cdr-atom (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1)))))) 
          (if 
            (> 
              (ConfidenceRank $0) 
              (ConfidenceRank ())) 
            (BestCandidate ConfidenceRank $0 $1) 
            (BestCandidate ConfidenceRank () $1)))) 
      ( (stv 0.6 0.81) (2 1)))


; same 
  ! (assertSame (Implication (Evaluation (Predicate smokes) (List $7140440)) (Evaluation (Predicate cancerous) (List $7140440))))


; same 
  ! (assertSame (stv 0.6 0.9))


; same 
  ! (assertSame ((Implication (Evaluation (Predicate smokes) (List $7140446)) (Evaluation (Predicate cancerous) (List $7140446))) (stv 0.6 0.9)))


; same 
  ! (assertSame (Sentence ((Implication (Evaluation (Predicate smokes) (List $7140458)) (Evaluation (Predicate cancerous) (List $7140458))) (stv 0.6 0.9)) (1)))


; same 
  ! (assertSame (stv 1.0 0.9))


; same 
  ! (assertSame ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))


; same 
  ! (assertSame (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)))


; same 
  ! (assertSame ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140464)) (Evaluation (Predicate cancerous) (List $7140464))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2))))


; same 
  ! (assertSame (stv 0.6 0.81))


; same 
  ! (assertSame ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)))


; same 
  ! (assertSame (2 1))


; same 
  ! (assertSame (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)))


; same 
  ! (assertSame (|- ((Implication (Evaluation (Predicate smokes) (List $7140458)) (Evaluation (Predicate cancerous) (List $7140458))) (stv 0.6 0.9))))


; same 
  ! (assertSame (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140470)) (Evaluation (Predicate cancerous) (List $7140470))) (stv 0.6 0.9))) (1)))


; same 
  ! (assertSame (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))))


; same 
  ! (assertSame (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)))


; same 
  ! (assertSame ((Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140608)) (Evaluation (Predicate cancerous) (List $7140608))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))


; same 
  ! (assertSame ($0 $1))


; same 
  ! (assertSame (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))))


; same 
  ! (assertSame (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)))


; same 
  ! (assertSame (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140470)) (Evaluation (Predicate cancerous) (List $7140470))) (stv 0.6 0.9)))))


; same 
  ! (assertSame (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7140482)) (Evaluation (Predicate cancerous) (List $7140482))) (stv 0.6 0.9)))) (1)))


; same 
  ! (assertSame (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))))


; same 
  ! (assertSame (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2)))


; same 
  ! (assertSame ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140464)) (Evaluation (Predicate cancerous) (List $7140464))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140908)) (Evaluation (Predicate cancerous) (List $7140908))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2))))


; same 
  ! (assertSame ((Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140608)) (Evaluation (Predicate cancerous) (List $7140608))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141088)) (Evaluation (Predicate cancerous) (List $7141088))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2))))


; same 
  ! (assertSame ((Sentence ((Implication (Evaluation (Predicate smokes) (List $7140464)) (Evaluation (Predicate cancerous) (List $7140464))) (stv 0.6 0.9)) (1)) (Sentence ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7140908)) (Evaluation (Predicate cancerous) (List $7140908))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81)) (2 1)) (Sentence (|- ((Implication (Evaluation (Predicate smokes) (List $7141364)) (Evaluation (Predicate cancerous) (List $7141364))) (stv 0.6 0.9))) (1)) (Sentence (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9))) (2)) (Sentence (|- ((Evaluation (Predicate cancerous) (List (Concept Edward))) (stv 0.6 0.81))) (2 1)) (Sentence (|- (|- ((Implication (Evaluation (Predicate smokes) (List $7141844)) (Evaluation (Predicate cancerous) (List $7141844))) (stv 0.6 0.9)))) (1)) (Sentence (|- (|- ((Evaluation (Predicate smokes) (List (Concept Edward))) (stv 1.0 0.9)))) (2))))


; same 
  ! (assertSame ((stv 0.6 0.81) (2 1)))


; same 
  ! (assertSame (((stv 0.6 0.81) (2 1)) ((stv 0.6 0.81) (2 1))))


; same 
  ! (assertSame (((stv 0.6 0.81) (2 1))))























