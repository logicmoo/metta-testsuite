;; Import modules
!(import! &self synthesize-via-unify)
!(register-module! ../../common)
!(import! &self common:Record)

;; Knowledge base
(: kb (-> Atom))
(= (kb) (superpose ((: f (-> Number String))
                    (: g (-> String Bool))
                    (: h (-> Bool Number))
                    (: i (-> String Number Bool)))))

;; Rule base
(: rb (-> Atom))
(= (rb) (superpose ((: . (-> (-> $b $c) (-> $a $b) (-> $a $c))) ; Function composition
                    (: .: (-> (-> $c $d) (-> $a $b $c) (-> $a $b $d)))))) ; Blackbird

;; Test program synthesizer
!(assertEqualToResult (record synthesize ((: $term $type) (fromNumber 4)))  ... )   ; Too long to list
!(assertEqualToResult (record synthesize ((: $term (-> Number Number)) kb rb (fromNumber 6))) ... ) ; Too long to run
