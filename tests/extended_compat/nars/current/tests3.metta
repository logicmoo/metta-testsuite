
;;;;MeTTaLog only: !(pragma! compiler full)
;;MeTTaLog only: !(pragma! trace-on-fail True)
;;MeTTaLog only: !(pragma! trace-on-pass False)
;;MeTTaLog only: !(pragma! trace-on-error True)
;;MeTTaLog only: !(pragma! trace-on-load False)

;; stdlib extension
(: If (-> Bool Atom Atom))
(= (If True $then) $then)
(= (If False $then) (nop))
(: If (-> Bool Atom Atom Atom))
(= (If $cond $then $else) (if $cond $then $else))
(= (TupleConcat $Ev1 $Ev2) (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))
(= (max $1 $2) (If (> $1 $2) $1 $2))
(= (min $1 $2) (If (< $1 $2) $1 $2))
(= (abs $x) (If (< $x 0) (- 0 $x) $x))
(: sequential (-> Expression %Undefined%))
(= (sequential $1) (superpose $1))
(: do (-> Expression %Undefined%))
(= (do $1) (case $1 ()))
(= (TupleCount ()) 0)
(= (TupleCount (1)) 1)
(= (BuildTupleCounts $TOld $C $N)
   (let $T (collapse (superpose (1 (superpose $TOld))))
        (superpose ((trace! (= (TupleCount $T) (+ $C 2)) ())
                    (If (< $C $N) (BuildTupleCounts $T (+ $C 1) $N))))))
(: CountElement (-> Expression Number))
(= (CountElement $x) (case $x (($y 1))))
(: CollapseCardinality (-> Expression Number))
(= (CollapseCardinality $expression) (TupleCount (collapse (CountElement $expression))))
(= (TupleCount (1 1)) 2)
(= (TupleCount (1 1 1)) 3)
(= (TupleCount (1 1 1 1)) 4)
(= (TupleCount (1 1 1 1 1)) 5)
(= (TupleCount (1 1 1 1 1 1)) 6)
(= (TupleCount (1 1 1 1 1 1 1)) 7)
(= (TupleCount (1 1 1 1 1 1 1 1)) 8)
(= (TupleCount (1 1 1 1 1 1 1 1 1)) 9)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1)) 10)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1)) 11)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1)) 12)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1)) 13)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 14)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 15)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 16)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 17)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 18)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 19)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 20)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 21)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 22)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 23)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 24)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 25)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 26)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 27)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 28)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 29)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 30)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 31)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 32)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 33)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 34)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 35)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 36)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 37)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 38)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 39)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 40)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 41)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 42)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 43)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 44)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 45)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 46)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 47)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 48)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 49)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 50)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 51)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 52)
(= (TupleCount (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)) 53)
;; Truth functions
(= (Truth_c2w $c) (/ $c (- 1 $c)))
(= (Truth_w2c $w) (/ $w (+ $w 1)))
(= (Truth_Deduction ($f1 $c1) ($f2 $c2)) ((* $f1 $f2) (* (* $f1 $f2) (* $c1 $c2))))
(= (Truth_Abduction ($f1 $c1) ($f2 $c2)) ($f2 (Truth_w2c (* (* $f1 $c1) $c2))))
(= (Truth_Induction $T1 $T2) (Truth_Abduction $T2 $T1))
(= (Truth_Exemplification ($f1 $c1) ($f2 $c2)) (1.0 (Truth_w2c (* (* $f1 $f2) (* $c1 $c2)))))
(= (Truth_StructuralDeduction $T) (Truth_Deduction $T (1.0 0.9)))
(= (Truth_Negation ($f $c)) ((- 1 $f) $c))
(= (Truth StructuralDeductionNegated $T) (Truth_Negation (Truth_StructuralDeduction $T)))
(= (Truth_Intersection ($f1 $c1) ($f2 $c2)) ((* $f1 $f2) (* $c1 $c2)))
(= (Truth_StructuralIntersection $T) (Truth_Intersection $T (1.0 0.9)))
(= (Truth_or $a $b) (- 1 (* (- 1 $a) (- 1 $b))))
(= (Truth_Comparison ($f1 $c1) ($f2 $c2)) (let $f0 (Truth_or $f1 $f2) ((If (== $f0 0.0) 0.0 (/ (* $f1 $f2) $f0)) (Truth_w2c (* $f0 (* $c1 $c2))))))
(= (Truth_Analogy ($f1 $c1) ($f2 $c2)) ((* $f1 $f2) (* (* $c1 $c2) $f2)))
(= (Truth_Resemblance ($f1 $c1) ($f2 $c2)) ((* $f1 $f2) (* (* $c1 $c2) (Truth_or $f1 $f2))))
(= (Truth_Union ($f1 $c1) ($f2 $c2)) ((Truth_or $f1 $f2) (* $c1 $c2)))
(= (Truth_Difference ($f1 $c1) ($f2 $c2)) ((* $f1 (- 1 $f2)) (* $c1 $c2)))
(= (Truth_DecomposePNN ($f1 $c1) ($f2 $c2)) (let $fn (* $f1 (- 1 $f2)) ((- 1 $fn) (* $fn (* $c1 $c2)))))
(= (Truth_DecomposeNPP ($f1 $c1) ($f2 $c2)) (let $f (* (- 1 $f1) $f2) ($f (* $f (* $c1 $c2)))))
(= (Truth_DecomposePNP ($f1 $c1) ($f2 $c2)) (let $f (* $f1 (- 1 $f2)) ($f (* $f (* $c1 $c2)))))
(= (Truth_DecomposePPP $v1 $v2) (Truth_DecomposeNPP (Truth_Negation $v1) $v2))
(= (Truth_DecomposeNNN ($f1 $c1) ($f2 $c2)) (let $fn (* (- 1 $f1) (- 1 $f2)) ((- 1 $fn) (* $fn (* $c1 $c2)))))
(= (Truth_Eternalize ($f $c)) ($f (Truth_w2c $c)))
(= (Truth_Revision ($f1 $c1) ($f2 $c2))
   (let* (($w1 (Truth_c2w $c1)) ($w2 (Truth_c2w $c2)) ($w  (+ $w1 $w2))
          ($f (/ (+ (* $w1 $f1) (* $w2 $f2)) $w)) ($c (Truth_w2c $w)))
          ((min 1.00 $f) (min 0.99 (max (max $c $c1) $c2)))))
(= (Truth_Expectation ($f $c)) (+ (* $c (- $f 0.5)) 0.5))
;;NAL-1
;;!Syllogistic rules for Inheritance:
(= (|- (($a --> $b) $T1) (($b --> $c) $T2)) (($a --> $c) (Truth_Deduction $T1 $T2)))
(= (|- (($a --> $b) $T1) (($a --> $c) $T2)) (($c --> $b) (Truth_Induction $T1 $T2)))
(= (|- (($a --> $c) $T1) (($b --> $c) $T2)) (($b --> $a) (Truth_Abduction $T1 $T2)))
(= (|- (($a --> $b) $T1) (($b --> $c) $T2)) (($c --> $a) (Truth_Exemplification $T1 $T2)))
;;NAL-2
;;!Rules for Similarity:
(= (|- (($S <-> $P) $T)) (($P <-> $S) (Truth_StructuralIntersection $T)))
(= (|- (($M <-> $P) $T1) (($S <-> $M) $T2)) (($S <-> $P) (Truth_Resemblance $T1 $T2)))
(= (|- (($P --> $M) $T1) (($S --> $M) $T2)) (($S <-> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M --> $P) $T1) (($M --> $S) $T2)) (($S <-> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M --> $P) $T1) (($S <-> $M) $T2)) (($S --> $P) (Truth_Analogy $T1 $T2)))
(= (|- (($P --> $M) $T1) (($S <-> $M) $T2)) (($P --> $S) (Truth_Analogy $T1 $T2)))
;;!Dealing with properties and instances:
(= (|- (($S --> ({ $P })) $T)) (($S <-> ({ $P })) (Truth_StructuralIntersection $T)))
(= (|- ((([ $S ]) --> $P) $T)) ((([ $S ]) <-> $P) (Truth_StructuralIntersection $T)))
(= (|- ((({ $M }) --> $P) $T1) (($S <-> $M) $T2)) ((({ $S }) --> $P) (Truth_Analogy $T1 $T2)))
(= (|- (($P --> ([ $M ])) $T1) (($S <-> $M) $T2)) (($P --> ([ $S ])) (Truth_Analogy $T1 $T2)))
(= (|- ((({ $A }) <-> ({ $B }))) ($A <-> $B) (Truth_StructuralIntersection $T)))
(= (|- ((([ $A ]) <-> ([ $B ]))) ($A <-> $B) (Truth_StructuralIntersection $T)))
;;NAL-3
;;!Set decomposition:
(= (|- ((({ $A $B }) --> $M) $T)) ((({ $A }) --> $M) (Truth_StructuralDeduction $T)))
(= (|- ((({ $A $B }) --> $M) $T)) ((({ $B }) --> $M) (Truth_StructuralDeduction $T)))
(= (|- ((M --> ([ $A $B ])) $T)) ((M --> ([ $A ])) (Truth_StructuralDeduction $T)))
(= (|- ((M --> ([ $A $B ])) $T)) ((M --> ([ $B ])) (Truth_StructuralDeduction $T)))
;;!Extensional and intensional intersection decomposition:
(= (|- ((($S | $P) --> $M) $T)) (($S --> $M) (Truth_StructuralDeduction $T)))
(= (|- (($M --> ($S & $P)) $T)) (($M --> $S) (Truth_StructuralDeduction $T)))
(= (|- ((($S | $P) --> $M) $T)) (($P --> $M) (Truth_StructuralDeduction $T)))
(= (|- (($M --> ($S & $P)) $T)) (($M --> $P) (Truth_StructuralDeduction $T)))
(= (|- ((($A ~ $S) --> $M) $T)) (($A --> $M) (Truth_StructuralDeduction $T)))
(= (|- (($M --> ($B - $S)) $T)) (($M --> $B) (Truth_StructuralDeduction $T)))
(= (|- ((($A ~ $S) --> $M) $T)) (($S --> $M) (Truth_StructuralDeductionNegated $T)))
(= (|- (($M --> ($B - $S)) $T)) (($M --> $S) (Truth_StructuralDeductionNegated $T)))
;;!Extensional and intensional intersection composition: (sets via reductions)
;(= (|- (($P --> $M) $T1) (($S --> $M) $T2)) ((($P | $S) --> $M) (Truth_Intersection $T1 $T2)))
;(= (|- (($P --> $M) $T1) (($S --> $M) $T2)) ((($P & $S) --> $M) (Truth_Union $T1 $T2)))
;(= (|- (($P --> $M) $T1) (($S --> $M) $T2)) ((($P ~ $S) --> $M) (Truth_Difference $T1 $T2)))
;(= (|- (($M --> $P) $T1) (($M --> $S) $T2)) (($M --> ($P & $S)) (Truth_Intersection $T1 $T2)))
;(= (|- (($M --> $P) $T1) (($M --> $S) $T2)) (($M --> ($P | $S)) (Truth_Union $T1 $T2)))
;(= (|- (($M --> $P) $T1) (($M --> $S) $T2)) (($M --> ($P - $S)) (Truth_Difference $T1 $T2)))
;;!Extensional and intensional intersection decomposition:
(= (|- (($S --> $M) $T1) ((($S | $P) --> $M) $T2)) (($P --> $M) (Truth_DecomposePNN $T1 $T2)))
(= (|- (($P --> $M) $T1) ((($S | $P) --> $M) $T2)) (($S --> $M) (Truth_DecomposePNN $T1 $T2)))
(= (|- (($S --> $M) $T1) ((($S & $P) --> $M) $T2)) (($P --> $M) (Truth_DecomposeNPP $T1 $T2)))
(= (|- (($P --> $M) $T1) ((($S & $P) --> $M) $T2)) (($S --> $M) (Truth_DecomposeNPP $T1 $T2)))
(= (|- (($S --> $M) $T1) ((($S ~ $P) --> $M) $T2)) (($P --> $M) (Truth_DecomposePNP $T1 $T2)))
(= (|- (($S --> $M) $T1) ((($P ~ $S) --> $M) $T2)) (($P --> $M) (Truth_DecomposeNNN $T1 $T2)))
(= (|- (($M --> $S) $T1) (($M --> ($S & $P)) $T2)) (($M --> $P) (Truth_DecomposePNN $T1 $T2)))
(= (|- (($M --> $P) $T1) (($M --> ($S & $P)) $T2)) (($M --> $S) (Truth_DecomposePNN $T1 $T2)))
(= (|- (($M --> $S) $T1) (($M --> ($S | $P)) $T2)) (($M --> $P) (Truth_DecomposeNPP $T1 $T2)))
(= (|- (($M --> $P) $T1) (($M --> ($S | $P)) $T2)) (($M --> $S) (Truth_DecomposeNPP $T1 $T2)))
(= (|- (($M --> $S) $T1) (($M --> ($S - $P)) $T2)) (($M --> $P) (Truth_DecomposePNP $T1 $T2)))
(= (|- (($M --> $S) $T1) (($M --> ($P - $S)) $T2)) (($M --> $P) (Truth_DecomposeNNN $T1 $T2)))
;; NAL-4
;;!Transformation rules between product and image:
(= (|- ((($A * $B) --> $R) $T)) (($A --> ($R /1 $B)) (Truth_StructuralIntersection $T)))
(= (|- ((($A * $B) --> $R) $T)) (($B --> ($R /2 $A)) (Truth_StructuralIntersection $T)))
(= (|- (($R --> ($A * $B)) $T)) ((($R \1 $B) --> $A) (Truth_StructuralIntersection $T)))
(= (|- (($R --> ($A * $B)) $T)) ((($R \2 $A) --> $B) (Truth_StructuralIntersection $T)))
;;other direction of same rules (as these are bi-directional)
;(= (|- (($A --> ($R /1 $B)) $T)) ((($A * $B) --> $R) (Truth_StructuralIntersection $T)))
;(= (|- (($B --> ($R /2 $A)) $T)) ((($A * $B) --> $R) (Truth_StructuralIntersection $T)))
;(= (|- ((($R \1 $B) --> $A) $T)) (($R --> ($A * $B)) (Truth_StructuralIntersection $T)))
;(= (|- ((($R \2 $A) --> $B) $T)) (($R --> ($A * $B)) (Truth_StructuralIntersection $T)))
;;!Comparative relations
;(= (|- ((({ $R }) |-> ([ $P ])) $T1) ((({ $S }) |-> ([ $P ])) $T2)) (((({ $R }) * ({ $S })) --> (>>> $P )) (Truth_FrequencyGreater $T1 $T2)))
;(= (|- ((($A * $B) --> (>>> $P)) $T1) ((($B * $C) --> (>>> $P)) $T2)) ((($A * $C) --> (>>> $P)) (Truth_Deduction $T1 $T2)))
;(= (|- ((({ $R }) |-> ([ $P ])) $T1) ((({ $S }) |-> ([ $P ])) $T2)) (((({ $R }) * ({ $S })) --> (=== $P)) (Truth_FrequencyEqual $T1 $T2)))
;(= (|- ((($A * $B) --> (=== $P)) $T1) ((($B * $C) --> (=== $P)) $T2)) ((($A * $C) --> (=== $P)) (Truth_Deduction $T1 $T2)))
;(= (|- ((($A * $B) --> (=== $P)) $T)) ((($B * $A) --> (=== $P)) (Truth_StructuralIntersection $T)))
;;!Optional rules for more efficient reasoning about relation components:
(= (|- ((($A * $B) --> $R) $T1) ((($C * $B) --> $R) $T2)) (($C --> $A) (Truth_Abduction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) ((($A * $C) --> $R) $T2)) (($C --> $B) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($R --> ($C * $B)) $T2)) (($C --> $A) (Truth_Induction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($R --> ($A * $C)) $T2)) (($C --> $B) (Truth_Induction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($C --> $A) $T2)) ((($C * $B) --> $R) (Truth_Deduction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($A --> $C) $T2)) ((($C * $B) --> $R) (Truth_Induction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($C <-> $A) $T2)) ((($C * $B) --> $R) (Truth_Analogy $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($C --> $B) $T2)) ((($A * $C) --> $R) (Truth_Deduction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($B --> $C) $T2)) ((($A * $C) --> $R) (Truth_Induction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($C <-> $B) $T2)) ((($A * $C) --> $R) (Truth_Analogy $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($A --> $C) $T2)) (($R --> ($C * $B)) (Truth_Deduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($C --> $A) $T2)) (($R --> ($C * $B)) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($C <-> $A) $T2)) (($R --> ($C * $B)) (Truth_Analogy $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($B --> $C) $T2)) (($R --> ($A * $C)) (Truth_Deduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($C --> $B) $T2)) (($R --> ($A * $C)) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($C <-> $B) $T2)) (($R --> ($A * $C)) (Truth_Analogy $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) ((($C * $B) --> $R) $T2)) (($A <-> $C) (Truth_Comparison $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) ((($A * $C) --> $R) $T2)) (($B <-> $C) (Truth_Comparison $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($R --> ($C * $B)) $T2)) (($A <-> $C) (Truth_Comparison $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($R --> ($A * $C)) $T2)) (($B <-> $C) (Truth_Comparison $T1 $T2)))
;;NAL-5
;;!Negation conjunction and disjunction decomposition:
(= (|- ((! $A) $T)) ($A (Truth_Negation $T)))
(= (|- (($A && $B) $T)) ($A (Truth_StructuralDeduction $T)))
(= (|- (($A && $B) $T)) ($B (Truth_StructuralDeduction $T)))
(= (|- (($A && $B) $T)) (($B && $A) (Truth_StructuralIntersection $T)))
(= (|- ($S $T1) (($S && $A) $T2)) ($A (Truth_DecomposePNN $T1 $T2)))
(= (|- ($S $T1) (($S || $A) $T2)) ($A (Truth_DecomposeNPP $T1 $T2)))
(= (|- ($S $T1) (((! $S) && $A) $T2)) ($A (Truth_DecomposeNNN $T1 $T2)))
(= (|- ($S $T1) (((! $S) || $A) $T2)) ($A (Truth_DecomposePPP $T1 $T2)))
;;!Syllogistic rules for Implication:
(= (|- (($A ==> $B) $T1) (($B ==> $C) $T2)) (($A ==> $C) (Truth_Deduction $T1 $T2)))
(= (|- (($A ==> $B) $T1) (($A ==> $C) $T2)) (($C ==> $B) (Truth_Induction $T1 $T2)))
(= (|- (($A ==> $C) $T1) (($B ==> $C) $T2)) (($B ==> $A) (Truth_Abduction $T1 $T2)))
(= (|- (($A ==> $B) $T1) (($B ==> $C) $T2)) (($C ==> $A) (Truth_Exemplification $T1 $T2)))
;;!Conditional composition for conjunction and disjunction:
(= (|- (($A ==> $C) $T1) (($B ==> $C) $T2)) ((($A && $B) ==> $C) (Truth_Union $T1 $T2)))
(= (|- (($A ==> $C) $T1) (($B ==> $C) $T2)) ((($A || $B) ==> $C) (Truth_Intersection $T1 $T2)))
(= (|- (($C ==> $A) $T1) (($C ==> $B) $T2)) (($C ==> ($A && $B)) (Truth_Intersection $T1 $T2)))
(= (|- (($C ==> $A) $T1) (($C ==> $B) $T2)) (($C ==> ($A || $B)) (Truth_Union $T1 $T2)))
;;!Multi-conditional inference:
(= (|- ((($S && $P) ==> $M) $T1) (($S ==> $M) $T2)) ($P (Truth_Abduction $T1 $T2)))
(= (|- ((($C && $M) ==> $P) $T1) (($S ==> $M) $T2)) ((($C && $S) ==> $P) (Truth_Deduction $T1 $T2)))
(= (|- ((($C && $P) ==> $M) $T1) ((($C && $S) ==> $M) $T2)) (($S ==> $P) (Truth_Abduction $T1 $T2)))
(= (|- ((($C && $M) ==> $P) $T1) (($M ==> $S) $T2)) ((($C && $S) ==> $P) (Truth_Induction $T1 $T2)))
;;!Rules for equivalence:
(= (|- (($S <=> $P) $T)) (($P <=> $S) (Truth_StructuralIntersection $T)))
(= (|- (($S ==> $P) $T1) (($P ==> $S) $T2)) (($S <=> $P) (Truth_Intersection $T1 $T2)))
(= (|- (($P ==> $M) $T1) (($S ==> $M) $T2)) (($S <=> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M ==> $P) $T1) (($M ==> $S) $T2)) (($S <=> $P) (Truth_Comparison $T1 $T2)))
(= (|- (($M ==> $P) $T1) (($S <=> $M) $T2)) (($S ==> $P) (Truth_Analogy $T1 $T2)))
(= (|- (($P ==> $M) $T1) (($S <=> $M) $T2)) (($P ==> $S) (Truth_Analogy $T1 $T2)))
(= (|- (($M <=> $P) $T1) (($S <=> $M) $T2)) (($S <=> $P) (Truth_Resemblance $T1 $T2)))
;;!Higher-order decomposition
(= (|- ($A $T1) (($A ==> $B) $T2)) ($B (Truth_Deduction $T1 $T2)))
(= (|- ($A $T1) ((($A && $B) ==> $C) $T2)) (($B ==> $C) (Truth_Deduction $T1 $T2)))
(= (|- ($B $T1) (($A ==> $B) $T2)) ($A (Truth_Abduction $T1 $T2)))
(= (|- ($A $T1) (($A <=> $B) $T2)) ($B (Truth_Analogy $T1 $T2)))
;;NAL term reductions
;;!Extensional intersection, union, conjunction reductions:
(= ($A & $A) $A)
(= ($A | $A) $A)
(= ($A && $A) $A)
(= ($A || $A) $A)
;;!Extensional set reductions:
(= (({ $A }) | ({ $B })) ({ $A $B }))
(= (({ $A $B }) | ({ $C })) ({ ($A . $B) $C }))
(= (({ $C }) | ({ $A $B }) ) ({ $C ($A . $B) }))
;;!Intensional set reductions:
(= (([ $A ]) & ([ $B ])) ([ $A $B ]) )
(= (([ $A $B ]) & ([ $C ])) ([ ($A . $B) $C ]))
(= (([ $A ]) & ([ $B $C ])) ([ $A ($B . $C) ]))
;;!Reduction for set element copula:
(= ({ ( $A . $B ) }) ({ $A $B }))
(= ([ ( $A . $B ) ]) ([ $A $B ]))
;params
(= (BeliefEventsMax) 10)
(= (GoalEventsMax) 10)

;spaces
!(bind! &belief_events (new-space))
!(bind! &goal_events (new-space))

;states
!(bind! &currentTime (new-state 1))
!(bind! &evidentialBase (new-state 1))
(= (increment $atom) (change-state! $atom (+ 1 (get-state $atom))))
(= (UpdateReasonerState) (trace! (time = (get-state &currentTime)) ((increment &currentTime) (increment &evidentialBase))))
(= (GetReasonerState) ((get-state &currentTime) ((get-state &evidentialBase))))

;priority of events
(= (EventPriorityNow ($T $P) $t) (* $P (/ 1 (+ 1 (- $t $T)))))

;retrieve the best candidate (allows to use tuples / collapse results / spaces as a PQ)
!(bind! &tempbest (new-state Nil))
!(bind! &tempbestscore (new-state 0))
(= (BestCandidate $tuple $evaluateCandidateFunction $t)
   (sequential ((do (change-state! &tempbestscore 0))
                (do (change-state! &tempbest Nil))
                (do (let* (($x (superpose $tuple))
                               ($fx ($evaluateCandidateFunction $x $t)))
                              (superpose ((If (> $fx (get-state &tempbestscore))
                                              (sequential ((change-state! &tempbest $x)
                                                           (change-state! &tempbestscore $fx))))))))
                (get-state &tempbest))))

;functions to select highest-priority events in belief and goal PQ
(= (PriorityOf (Event $Sentence ($occT $Ev $Prio)) $t) (EventPriorityNow $Prio $t))
(= (SelectHighestPriorityEvent $collection $t)
   (BestCandidate (collapse (get-atoms $collection)) PriorityOf $t))

;a belief event to process, which demands adding it to the PQ and updating its concept
(= (ProcessBeliefEvent $Ev $t)
   (sequential ((add-atom &belief_events $Ev)
                (UpdateConcept $Ev $t))))

;bound the size of the attentional focus for tasks / events
(= (BoundEvents $collection $Threshold $Increment $TargetAmount $t)
   (sequential ((do (let* (($Ev (get-atoms $collection))
                            ((Event $Sentence ($Time $Evidence $EPrio)) $Ev))
                          (If (< (EventPriorityNow $EPrio $t) $Threshold)
                              (remove-atom $collection $Ev))))
                (let $CurrentAmount (CollapseCardinality (get-atoms $collection))
                     (If (> $CurrentAmount $TargetAmount)
                         (BoundEvents $collection (+ $Threshold $Increment) $Increment $TargetAmount $t))))))
;params
(= (AttentionalFocusConceptsMax) 10)

;spaces
!(bind! &concepts (new-space))
!(bind! &attentional_focus (new-space))

;priority of concepts
(= (ConceptPriorityNow ($T $P) $t) (* $P (/ 1 (+ 1 (- $t $T)))))

;whether evidence was just counted once
!(bind! &tempstate (new-state False))
!(bind! &tempset (new-space))
(= (StampDisjoint $x)
   (not (sequential ((do (change-state! &tempstate False))
                     (do (case (get-atoms &tempset)
                         (($y (remove-atom &tempset $y)))))
                     (do (let $z (superpose $x)
                              (case (match &tempset $z $z)
                                    (($w (change-state! &tempstate True))
                                     (%void% (add-atom &tempset $z))))))
                     (get-state &tempstate)))))

;revise if there is no evidential overlap, else use higher-confident candidate
(= (RevisionAndChoice (Event ($Term1 ($f1 $c1)) (eternal $ev1 $EPrio1)) (Event ($Term2 ($f2 $c2)) (eternal $ev2 $EPrio2)))
   (let $ConclusionStamp (TupleConcat $ev1 $ev2)
        (If (StampDisjoint $ConclusionStamp)
            (Event ($Term1 (Truth_Revision ($f1 $c1) ($f2 $c2))) (eternal $ConclusionStamp (0 0.0)))
            (If (> $c1 $c2)
                (Event ($Term1 ($f1 $c1)) (eternal $ev1 (0 0.0)))
                (Event ($Term2 ($f2 $c2)) (eternal $ev2 (0 0.0)))))))

;update beliefs in existing concept with the new event or create new concept to enter the new evidence
(= (UpdateConcept $NewEvent $t)
   (let* (((Event ($Term $TV) ($Time $Evidence $EPrio)) $NewEvent)
          ($NewEventEternalized (Eternalize $NewEvent))
          ($MatchConcept (Concept $Term $Belief $BeliefEvent $CPrio)))
         (sequential ((case (match &attentional_focus $MatchConcept $MatchConcept)
                            (($MatchConcept (sequential ((remove-atom &attentional_focus $MatchConcept)
                                                         (let* (((Event $RevSentence $Metadata) (RevisionAndChoice $Belief $NewEventEternalized))
                                                                ($RevisedBelief (Event (trace! (@ $RevSentence) $RevSentence) $Metadata))
                                                                ($MaxPrio (If (> (EventPriorityNow $EPrio $t) (ConceptPriorityNow $CPrio $t))
                                                                              $EPrio $CPrio)))
                                                         (add-atom &attentional_focus (Concept $Term $RevisedBelief $NewEvent $MaxPrio))))))
                             (%void% (case (match &concepts $MatchConcept $MatchConcept)
                                           (($MatchConcept (sequential ((remove-atom &concepts $MatchConcept)
                                                                        (add-atom &attentional_focus $MatchConcept)
                                                                        (UpdateConcept $NewEvent $t))))
                                            (%void% (add-atom &attentional_focus (Concept $Term $NewEventEternalized $NewEvent $EPrio))))))))))))

;bound the size of attentional focus of concepts
(= (BoundAttention $Threshold $Increment $TargetAmount $t)
   (sequential ((do (let* (($C (get-atoms &attentional_focus))
                           ((Concept $Term (Event $Sentence $Metadata) $BeliefEvent $CPrio) $C))
                          (If (< (ConceptPriorityNow $CPrio $t) $Threshold) (sequential ((remove-atom &attentional_focus $C)
                                                                                         (add-atom &concepts $C))))))
                (let $CurrentAmount (CollapseCardinality (get-atoms &attentional_focus))
                     (If (> $CurrentAmount $TargetAmount)
                         (BoundAttention (+ $Threshold $Increment) $Increment $TargetAmount $t))))))

;get eternal belief of concept
(: EternalQuestion (-> Expression $t))
(= (EternalQuestion $Term) (case (match (superpose (&attentional_focus &concepts)) (Concept $Term $Belief $BeliefEvent $CPrio) $Belief)
                                 (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (eternal Nil 0.0))))))

;get event belief of concept
(: EventQuestion (-> Expression $t))
(= (EventQuestion $Term) (case (match (superpose (&attentional_focus &concepts)) (Concept $Term $Belief $BeliefEvent $CPrio) $BeliefEvent)
                               (($Ev $Ev) (%void% (Event (None (0.5 0.0)) (0 Nil 0.0))))))
;;Declarative inference (deriving events and knowledge from observed events)

;Derived belief event priority
(= (ConclusionPriority $EPrio $CPrio $ConcTV) (* (* $EPrio $CPrio) (Truth_Expectation $ConcTV)))

;making declarative inferences on two events (task from PQ and belief from concept)
(= (Conclude (Event $S1 ($time1 $ev1 $prio1)) (Event $S2 ($time2 $ev2 $prio2)) $CPrio $t)
   (let $ConclusionStamp (TupleConcat $ev1 $ev2)
        (If (StampDisjoint $ConclusionStamp)
            (let ($ConcTerm $ConcTV) (superpose ((|- $S1 $S2) (|- $S2 $S1)))
                 (Event ($ConcTerm $ConcTV)
                        ($time1 $ConclusionStamp
                                ($t (ConclusionPriority (EventPriorityNow $prio1 $t)
                                                        (ConceptPriorityNow $CPrio $t)
                                                        $ConcTV))))))))

;find a belief for the task to generate conclusions with
(= (ReasonWithTask (Event $S1 ($time1 $ev1 $prio1)) $t)
   (let ($Belief $CPrio) (case (get-atoms &attentional_focus)
                               (((Concept $Term (Event $SE2 ($timeE2 $evE2 $prioE2)) (Event $S2 ($time2 $ev2 $prio2)) $CPrio)
                                 (If (and (not (== $time1 eternal)) (> (abs (- $time1 $time2)) 20))
                                     ((Event $SE2 ($timeE2 $evE2 $prioE2)) $Cprio)
                                     ((Event $S2 ($time2 $ev2 $prio2)) $CPrio)))))
        (case (Conclude (Event $S1 ($time1 $ev1 $prio1)) (TemporallyAlignedBelief $time1 $Belief) $CPrio $t)
              (((Event $1 $2) (ProcessBeliefEvent (Event (trace! (. $1) $1) $2) $t))))))

;select the highest priority belief event from the PQ and use it for reasoning
(= (BeliefCycle $t) (do (sequential ((let $Ev (SelectHighestPriorityEvent &belief_events $t)
                                          (sequential ((remove-atom &belief_events $Ev)
                                                       (ReasonWithTask $Ev $t))))
                                     (UpdateReasonerState)
                                     (BoundEvents &belief_events 0.0 0.1 (BeliefEventsMax) $t)
                                     (BoundAttention 0.0 0.1 (AttentionalFocusConceptsMax) $t)))))
;;Temporal inference (sequence and implication formation based on FIFO)

;use the event's evidence to induce a time-independent belief which can be used in the future
(= (Eternalize $Ev) (let (Event ($Term $TV) ($Time $Evidence $EPrio)) $Ev
                         (If (== $Time eternal) $Ev
                         (Event ($Term (Truth_Eternalize $TV)) (eternal $Evidence (0 0.0))))))

;use evidence of an event at a slightly different moment in time
(= (Projection (Event ($Term ($f $c)) ($Time $Evidence $EPrio)) $TargetTime)
   (Event ($Term ($f (* $c (min 1 (/ 1 (abs (- $Time $TargetTime))))))) ($TargetTime $Evidence $EPrio)))

;make the belief occurrence time compatible with the task's
(= (TemporallyAlignedBelief $TaskTime $Belief) (If (== $TaskTime eternal)
                                                   (Eternalize $Belief)
                                                   (Projection $Belief $TaskTime)))

;FIFO max. size bound
!(bind! &FIFO (new-state ()))
(= (EventWithFIFO3 $New ($1 $2 $3)) ($New $1 $2))
(= (EventWithFIFO3 $New ($1 $2)) ($New $1 $2))
(= (EventWithFIFO3 $New ($1)) ($New $1))
(= (EventWithFIFO3 $New ()) ($New))

;Add event to FIFO
(= (EventToFIFO $Ev)
   (let $newlist (EventWithFIFO3 $Ev (get-state &FIFO))
        (change-state! &FIFO $newlist)))

;Form a sequence of two events
(= (TemporalSequence $Ev1 (Event ($Term2 $Truth2) ($Time2 $Evidence2 $EPrio2)))
   (let (Event ($Term1 $Truth1) ($Time1 $Evidence1 $EPrio1)) (Projection $Ev1 $Time2)
        (Event (($Term1 &/ $Term2) (Truth_Intersection $Truth1 $Truth2)) ($Time2 (TupleConcat $Evidence1 $Evidence2) (0 0.0)))))

;Form a temporal implication between two events
(= (TemporalImplication $Ev1 (Event ($Term2 $Truth2) ($Time2 $Evidence2 $EPrio2)))
   (let (Event ($Term1 $Truth1) ($Time1 $Evidence1 $EPrio1)) (Projection $Ev1 $Time2)
        (trace! (. (($Term1 =/> $Term2) (Truth_Induction $Truth1 $Truth2)))
                (Event (($Term1 =/> $Term2) (Truth_Induction $Truth1 $Truth2)) ($Time2 (TupleConcat $Evidence1 $Evidence2) (0 0.0))))))

;Whether an event's term is an operation
(= (IsOp (Event ($Term $Truth) $Metadata))
   (case $Term (((^ $Opname) True)
                ($Otherwise False))))

;Find implications in the event FIFO:
;procedural implications
(= (TemporalImplicationInduction ($Cons $Op $Prec))
   (If (and (IsOp $Op) (and (not (IsOp $Cons)) (not (IsOp $Prec))))
       (let $PrecOp (TemporalSequence $Prec $Op)
            (TemporalImplication $PrecOp $Cons))))
;and temporal without operation
;(= (TemporalImplicationInduction ($Cons $Prec $Trail))
;   (If (and (not (IsOp $Prec)) (not (IsOp $Cons)))
;       (TemporalImplication $Prec $Cons)))

;Add negative evidence for implications which predicted the input unsuccessfully
(= (NegConfirmation $PrecTerm $ObservedCons $t)
   (let (Event (($PrecTerm =/> $PredictedCons) $ImpTV) $ImpMetadata) (EternalQuestion ($PrecTerm =/> $PredictedCons))
        (If (not (== $ObservedCons $PredictedCons))
            (UpdateConcept (Event (($PrecTerm =/> $PredictedCons) (0.0 0.1)) ($t () (0 0.0))) $t))))

;Check if the implication's preconditions are met to anticipate the by the implication predicted outcome
;(= (Anticipate ($Pos $Pre $Trail) $t)
;   (let* (((Event ($PreTerm $PreTV) $PreMetadata) $Pre)
;          ((Event ($PosTerm $PosTV) $PosMetadata) $Pos))
;         (If (not (IsOp $Pre))
;             (NegConfirmation $PreTerm $PosTerm $t))))
(= (Anticipate ($Pos $Op $Pre) $t)
   (let* (((Event ($PreTerm $PreTV) $PreMetadata) $Pre)
          ((Event ($OpTerm $OpTV) $OpMetadata) $Op)
          ((Event ($PosTerm $PosTV) $PosMetadata) $Pos)
          ($Sequence ($Pre &/ Pos)))
         (If (and (IsOp $Op) (not (IsOp $Pre)))
             (NegConfirmation ($PreTerm &/ $OpTerm) $PosTerm $t))))

;Input procedure
(= (AddBeliefEvent $Sentence)
   (let* ((($t $evidentialBase) (GetReasonerState))
          ($InputEvent (Event (trace! (. $Sentence) $Sentence) ($t $evidentialBase ($t 1.0))))
          ($notAnOperation (not (IsOp $InputEvent))))
          (do (sequential ((EventToFIFO $InputEvent)
                           (Anticipate (get-state &FIFO) $t)
                           (If $notAnOperation
                               (sequential ((let $InducedHypothesis (TemporalImplicationInduction (get-state &FIFO))
                                                 (UpdateConcept $InducedHypothesis $t))
                                            (ProcessBeliefEvent $InputEvent $t)
                                            (BeliefCycle $t)))
                               (UpdateReasonerState)))))))
;;Procedural inference (decision making with operation execution and subgoaling)

;Derived goal event priority
(= (SubgoalPriority $EPrio $ConcTV) (* $EPrio (Truth_Expectation $ConcTV)))

;Expectation of an operation is the truth expectation of its desire value
(= (OpExpectation (Decision ($Opname $DVOp) $Subgoal) $t) (Truth_Expectation $DVOp))

;Inject executed operation as an event and return its name
(= (Execute $Opname) (superpose ((AddBeliefEvent ($Opname (1.0 0.9))) $Opname)))

;Add subgoals to the PQ
(= (DeriveSubgoals $Options)
   (do (let (Decision $Op (Event $S $Metadata)) (superpose $Options)
            (let $Subgoal (Event (trace! (! $S) $S) $Metadata)
                 (add-atom &goal_events $Subgoal)))))

;execute the operation which most likely gets the goal achieved in current contexts, and if contexts are not yet fulfilled, derive them as subgoals
(= (BestDecision $t (Event ($Term $DV) ($GoalTime $GoalEvBase $GoalPrio)) $FIFO)
   (let $Options (collapse (let* (((Event ((($Prec &/ (^ $Op)) =/> $Term) $ImpTV) ($ImpTime $ImpEvBase $ImpPrio))
                                   (EternalQuestion (($Prec &/ (^ $Op)) =/> $Term)))
                                  ($DVPrecOp (Truth_Deduction $DV $ImpTV))
                                  ((Event ($PrecTerm $PrecTV) $PrecMetadata)
                                   (Projection (EventQuestion $Prec) $t))
                                  ($DVOp (Truth_Deduction $PrecTV $DVPrecOp))
                                  ($DVPrec (Truth_StructuralDeduction $DVPrecOp))
                                  ($SubgoalStamp (TupleConcat $GoalEvBase $ImpEvBase)))
                                 (If (StampDisjoint $SubgoalStamp)
                                     (Decision ((^ $Op) $DVOp) (Event ($Prec (Truth_StructuralDeduction $DVPrecOp))
                                                                      ($t $SubgoalStamp ($t (SubgoalPriority (EventPriorityNow $GoalPrio $t) $DVPrec))))))))
        (let (Decision ($Opname $DVOp) $Subgoal) (BestCandidate $Options OpExpectation $t)
             (If (> (Truth_Expectation $DVOp) 0.5)
                 (Execute $Opname)
                 (DeriveSubgoals $Options)))))

;select the highest priority goal event from the PQ and use it for decision making
(= (GoalCycle $t) (sequential ((let $Ev (SelectHighestPriorityEvent &goal_events $t)
                                    (sequential ((do (remove-atom &goal_events $Ev))
                                                 (BestDecision $t $Ev (get-state &FIFO)))))
                               (do (UpdateReasonerState))
                               (do (BoundEvents &goal_events 0.0 0.1 (GoalEventsMax) $t)))))

;Input procedure
(= (AddGoalEvent $Sentence)
   (let* ((($t $evidentialBase) (GetReasonerState))
          ($InputEvent (Event (trace! (! $Sentence) $Sentence) ($t $evidentialBase ($t 1.0)))))
         (sequential ((do (add-atom &goal_events $InputEvent))
                      (GoalCycle $t)))))


;; !(import! &self NARS)

;;MeTTaLog only: !(pragma! trace-on-load True)


; debug
; !(assertEqual (TupleCount (get-atoms &belief_events)) 0)


!(AddBeliefEvent (((corridorIn &/ (^ forward)) =/> doorAt) (1.0 0.9)))
!(AddBeliefEvent (((windowAt &/ (^ open)) =/> Outside) (1.0 0.9)))
!(AddBeliefEvent (((doorAt &/ (^ open)) =/> Outside) (1.0 0.9)))

!(AddBeliefEvent (corridorIn (1.0 0.9)))
!(assertEqual (AddGoalEvent (Outside (1.0 0.9)))
;expected:
  None)

;needs one more goal cycle for planning 2 steps
!(GoalCycle (get-state &currentTime))

!(assertEqual (GoalCycle (get-state &currentTime))
;expected:
  (^ forward))

!(AddBeliefEvent (doorAt (1.0 0.9)))
!(assertEqual (AddGoalEvent (Outside (1.0 0.9)))
;expected:
    (^ open))
