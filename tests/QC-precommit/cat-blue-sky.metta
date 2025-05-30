;; Stdlib extension
(= (max $1 $2) (if (> $1 $2) $1 $2))
(= (min $1 $2) (if (< $1 $2) $1 $2))
(= (TupleConcat $Ev1 $Ev2) (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))

;; Truth functions
(= (Truth_c2w $c) (/ $c (- 1 $c)))
(= (Truth_w2c $w) (/ $w (+ $w 1)))
(= (Truth_Deduction ($f1 $c1) ($f2 $c2)) ((* $f1 $f2) (* (* $f1 $f2) (* $c1 $c2))))
(= (Truth_Abduction ($f1 $c1) ($f2 $c2)) ($f2 (Truth_w2c (* (* $f1 $c1) $c2))))
(= (Truth_Induction $T1 $T2) (Truth_Abduction $T2 $T1))
(= (Truth_Revision ($f1 $c1) ($f2 $c2)) 
   (let* (($w1 (Truth_c2w $c1)) ($w2 (Truth_c2w $c2)) ($w  (+ $w1 $w2))
          ($f (/ (+ (* $w1 $f1) (* $w2 $f2)) $w)) ($c (Truth_w2c $w)))
          ((min 1.00 $f) (min 0.99 (max (max $c $c1) $c2)))))

;; Inference rules
; NAL-1/5 (selected subset)
(= (|- ($T $T1) ($T $T2)) ($T (Truth_Revision $T1 $T2)))
(= (|- (($a $-->/==> $b) $T1) (($b $-->/==> $c) $T2)) (($a $-->/==> $c) (Truth_Deduction $T1 $T2)))
(= (|- (($a $-->/==> $b) $T1) (($a $-->/==> $c) $T2)) (($c $-->/==> $b) (Truth_Induction $T1 $T2)))
(= (|- (($a $-->/==> $c) $T1) (($b $-->/==> $c) $T2)) (($b $-->/==> $a) (Truth_Abduction $T1 $T2)))
(= (|- ($A $T1) (($A ==> $B) $T2)) ($B (Truth_Deduction $T1 $T2)))
(= (|- ($A $T1) ((($A && $B) ==> $C) $T2)) (($B ==> $C) (Truth_Deduction $T1 $T2)))
(= (|- ($B $T1) (($A ==> $B) $T2)) ($A (Truth_Abduction $T1 $T2)))
; NAL-4 (selected subset)
(= (|- ((($A * $B) --> $R) $T1) ((($C * $B) --> $R) $T2)) (($C --> $A) (Truth_Abduction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) ((($A * $C) --> $R) $T2)) (($C --> $B) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($R --> ($C * $B)) $T2)) (($C --> $A) (Truth_Induction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($R --> ($A * $C)) $T2)) (($C --> $B) (Truth_Induction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($C --> $A) $T2)) ((($C * $B) --> $R) (Truth_Deduction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($A --> $C) $T2)) ((($C * $B) --> $R) (Truth_Induction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($C --> $B) $T2)) ((($A * $C) --> $R) (Truth_Deduction $T1 $T2)))
(= (|- ((($A * $B) --> $R) $T1) (($B --> $C) $T2)) ((($A * $C) --> $R) (Truth_Induction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($A --> $C) $T2)) (($R --> ($C * $B)) (Truth_Deduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($C --> $A) $T2)) (($R --> ($C * $B)) (Truth_Abduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($B --> $C) $T2)) (($R --> ($A * $C)) (Truth_Deduction $T1 $T2)))
(= (|- (($R --> ($A * $B)) $T1) (($C --> $B) $T2)) (($R --> ($A * $C)) (Truth_Abduction $T1 $T2)))

;; Whether evidence was just counted once
(= (StampDisjoint $Ev1 $Ev2)
   (== () (collapse (let* (($x (superpose $Ev1))
                           ($y (superpose $Ev2)))
                          (case (== $x $y) ((True overlap)))))))

;; Exhaustive-until-depth deriver
(= (Derive $beliefs $depth $maxdepth)
   (if (> $depth $maxdepth)
       $beliefs
       (let $derivations 
            (collapse (let* (((Sentence $x $Ev1) (superpose $beliefs))
                             ((Sentence $y $Ev2) (superpose $beliefs))
                             ($stamp (TupleConcat $Ev1 $Ev2)))
                            (if (StampDisjoint $Ev1 $Ev2) 
                                (case (|- $x $y) ((($T $TV) (Sentence ($T $TV) $stamp)))) ())))
            (Derive (TupleConcat $beliefs $derivations) (+ $depth 1) $maxdepth))))

;retrieve the best candidate
(= (BestCandidate $evaluateCandidateFunction $bestCandidate $tuple)
  (if (== $tuple ()) 
      $bestCandidate
      (let* (($head (car-atom $tuple))
             ($tail (cdr-atom $tuple)))
            (if (> ($evaluateCandidateFunction $head)
                   ($evaluateCandidateFunction $bestCandidate))
                (BestCandidate $evaluateCandidateFunction $head $tail)
                (BestCandidate $evaluateCandidateFunction $bestCandidate $tail)))))

;candidate evaluation based on confidence
(= (ConfidenceRank (($f $c) $Ev)) $c)
(= (ConfidenceRank Nil) 0)

;pose a question of a certain term to the system on some knowledge base
(= (Question $kb $term $steps)
   (BestCandidate ConfidenceRank Nil (collapse (let $x (Derive $kb 1 $steps) 
                                                    (case (superpose $x)
                                                          (((Sentence ($T $TV) $Ev) (case (== $T $term) 
                                                                                          ((True ($TV $Ev)))))))))))

;; How much evidence is there that garfield is an artist and which inputs is it based on? 
!(Question ((Sentence ((({ garfield }) --> cat) (1.0 0.9)) (1)) 
            (Sentence (((cat * sky) --> like) (1.0 0.9)) (2)) 
            (Sentence ((sky --> ([ blue ])) (1.0 0.9)) (3))
            (Sentence ((((({ garfield }) * ([ blue ])) --> like) ==> (({ garfield }) --> artist)) (1.0 0.9)) (4)))
           (({ garfield }) --> artist) 3)

