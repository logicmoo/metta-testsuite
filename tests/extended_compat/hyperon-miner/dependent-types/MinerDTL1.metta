!(register-module! ../../hyperon-pln)
!(import! &self hyperon-pln:metta:synthesis:Synthesize)
!(register-module! ../utils)
!(import! &self utils:MinerUtils)
!(import! &succ succAxiom)

(= (get-witness $x) (: (WitnessOf $x) $x))
(= (sourcedb) (match &self (= (refdb) $db) (match $db $x (axiom $x))))
(= (succ-axiom) (match &succ $x $x))

(: -> (-> Atom Atom Atom Type))

(: kb (-> Atom))
(= (kb) (superpose ((get-witness (sourcedb))
                    (succ-axiom)
                    (: trueaxiom (true)))))

;; Specialization Rule
(= (specialize-ruleX)
  (: specilizeX
    (-> (true)
        (axiom ($link $x $y))
        (specializationOf ($link (VarIdx Z) $y) ($link (VarIdx Z) (VarIdx (S Z)))))))

(= (specialize-ruleY)
  (: specilizeY
    (-> (true)
        (axiom ($link $x $y))
        (specializationOf ($link $x (VarIdx (S Z))) ($link (VarIdx Z) (VarIdx (S Z)))))))

;; support rule
(= (support-rule)
  (: support
    (-> (true)
        (specializationOf $sptrn $aptrn)
        (supportOf $sptrn (countNat $sptrn)))))

;; Minimum support rule
(= (minsupport-rule)
  (: minsupport
    (-> (supportOf $ptrn $cnt)
        (⍃ $ms $cnt)
        (minsup $ptrn $ms))))

;; Conjunction rule
(= (support-cnj-rule)
  (: support-cnj
    (-> (minsup $ptrn1 $m)
        (minsup $ptrn2 $m)
        (supportOf (, $ptrn1 $ptrn1) (countNat (, $ptrn1 $ptrn1))))))

;; Minimum support transitivity rule
(: ms-transitivity-rule (-> Atom))
(= (ms-transitivity-rule)
    (: ms-transitivity
      (-> (minsup $sptrn $m)
          (specializationOf $sptrn $aptrn)
          (minsup $aptrn $m))))

;; iSurprisingness rule
(: surprisingness-rule (-> Atom))
(= (surprisingness-rule)
    (: surprisingness
      (-> (minsup $ptrn $m)
          (supportOf $ptrn $cnt)
          (surp $ptrn (isurp? ($ptrn $cnt))))))

(: rb (-> Atom))
(= (rb) (superpose ((specialize-ruleX)
                    (specialize-ruleY)
                    (support-rule)
                    (minsupport-rule)
                    (support-cnj-rule)
                    (ms-transitivity-rule)
                    (surprisingness-rule))))
