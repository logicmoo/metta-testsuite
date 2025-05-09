
;;;;;;;;;;;;;;;;;
;; Combinators ;;
;;;;;;;;;;;;;;;;;

;; Combinators are disabled as they have been moved to the backward
;; chainer

;; ;; Name: Bluebird
;; ;; Description: Sequential composition
;; ;; Type: (b -> c) -> (a -> b) -> a -> c
;; ;; Definition: bluebird f g x = f (g x)
;; ;; Symbol: .
;; ;; Diagram:
;; ;; -a-b-c->
;; !(add-atom &kb (: .
;;                   (-> (: $f (-> (: $y $b) $c))
;;                       (: $g (-> (: $x $a) $b))
;;                       (-> (: $x $a) $c))))

;; ;; Name: Phoenix
;; ;; Description: Split then join
;; ;; Type: (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
;; ;; Definition: phoenix f g h x = f (g x) (h x)
;; ;; Symbol: Φ (LaTeX: \Phi, Math Emacs: \upPhi)
;; ;; Diagram:
;; ;;    b
;; ;;   / \
;; ;; -a   d->
;; ;;   \ /
;; ;;    c
;; !(add-atom &kb (: Φ
;;                   (-> (: $f (-> (: $y $b) (: $z $c) $d))
;;                       (: $g (-> (: $x $a) $b))
;;                       (: $h (-> (: $x $a) $c))
;;                       (-> (: $x $a) $d))))

;;;;;;;;;;;;;;;;;;;;;
;; Reduction rules ;;
;;;;;;;;;;;;;;;;;;;;;

;; Bluebird β-reduction
(= ((. $g $f) $x) ($g ($f $x)))

!(assertEqual 
  (h ((. g f) x)) 
  ((h (g (f x)))))

!(assertEqual 
  ((. (. h g) f) x)
  ((h (g (f x)))))

!(assertEqual 
  ((. h (. g f)) x)
  ((h (g (f x)))))

!(assertEqual 
  ($h ((. $g $f) $x))
  (($h ($g ($f $x)))))

!(assertEqual 
  ((. (. $h $g) $f) $x)
  (($h ($g ($f $x)))))

!(assertEqual 
  ((. $h (. $g $f)) $x)
  (($h ($g ($f $x)))))

!(repl!)




!((. (. h g) f) $x)
; [((h (g (f $x))))]

;; mettalog thinks this is correct
!(assertEqual
  ((. (. h g) f) $x)
  ((h (g (f $)))))

;; hyperon thinks this is correct
!(assertEqual
  ((. (. h g) f) $x)
  ((. h (. g f)) $x))



;; Bluebird β-reduction
(= ((dot $g $f) $x) ($g ($f $x)))

!(assertEqual
  ((dot (dot h g) f) $x)
  ((dot h (dot g f)) $x))


!(repl!)
!(set-debug! e True)

;; ;; Phoenix β-reduction.
;; ;;
;; ;; That rules is not recommended because it results in a duplication
;; ;; of $x.  It is therefore disabled during AI-service composition
;; ;; synthesis.
;; (= ((Φ $f $g $h) $x) (($f ($g $x)) ($h $x)))

;; These tests allow to prove that the reduction rules are correct in
;; the sense that the reduced term, if applied to arguments, β-reduces
;; to the same term.  Note that in order to pass all combinator
;; β-reduction rules need to be enabled.

;; Test that applying left associative composition reduces is
;; equivalent to applying right associative composition.
!(assertEqual
  ((. (. $h $g) $f) $x)
  ((. $h (. $g $f)) $x))

;; ;; Note: the following two tests can only pass if the Phoenix
;; ;; β-reduction rule is enabled.
;; ;;
;; ;; Test that applying (Φ (. $f $g) $j (. $h (. $i $j)))
;; ;; once is equivalent to (Φ $f (. $g $j) (. $h (. $i $j)))
;; !(assertEqual
;;   ((Φ (. $f $g) $j (. $h (. $i $j))) $x)
;;   ((Φ $f (. $g $j) (. $h (. $i $j))) $x))
;; ;; Test that applying (Φ $f (. $g $j) (. $h (. $i $j))) once is
;; ;; equivalent to (. (Φ $f $g (. $h $i)) $j)
;; !(assertEqual
;;   ((Φ $f (. $g $j) (. $h (. $i $j))) $x)
;;   ((. (Φ $f $g (. $h $i)) $j) $x))

;; Right associate composition, meaning
;;
;; h . g . f
;;
;; should be represented as
;;
;; h . (g . f)
;;
;; Thus anything deviating from that representation, such as
;;
;; (h . g) . f
;;
;; or in MeTTa
;;
;; (. (. h g) f)
;;
;; should be rewritten as
;;
;; (. h (. g f))
;;
;; The reason left associativity is choosen as default over right
;; associativity is because in prefix notation the former is easier to
;; read (to me anyway).
(= (. (. $h $g) $f) (. $h (. $g $f)))

;; Move sequential composition from aggregator to branch.
;;
;; (Φ (. f g) j (. h (. i j)))
;;
;; reduces to
;;
;; (Φ f (. g j) (. h (. i j)))
(= (Φ (. $f $g) $j (. $h (. $i $j)))
   (Φ $f (. $g $j) (. $h (. $i $j))))

;; Factorize sequential branches of phoenix.
;;
;; (Φ f (. g i) (. h i))
;;
;; reduces to
;;
;; (. (Φ f g h) i)
(= (Φ $f (. $g $i) (. $h $i))
   (. (Φ $f $g $h) $i))

;; Specialized version of factorize sequential branches of phoenix.
;;
;; (Φ f (. g j) (. h (. i j)))
;;
;; reduces to
;;
;; (. (Φ f g (. h i)) j)
(= (Φ $f (. $g $j) (. $h (. $i $j)))
   (. (Φ $f $g (. $h $i)) $j))

;; The composition of spleeter with the mixing of accomp
;; and vocals is involutive.
(= (. (Φ mixer.mix
         sound-spleeter.DTLOutput.accomp
         sound-spleeter.DTLOutput.vocals)
      sound-spleeter.spleeter)
   id)
(= (. sound-spleeter.spleeter (Φ mixer.mix
                                 sound-spleeter.DTLOutput.accomp
                                 sound-spleeter.DTLOutput.vocals))
   id)

;; The composition of (. spleeter f) or (. f spleeter) with the mixing
;; of accomp and vocals is idempotent with respect to f.
(= (. (Φ mixer.mix
         sound-spleeter.Output.accomp
         sound-spleeter.DTLOutput.vocals) (. sound-spleeter.spleeter $f))
   $f)
(= (. (. $f sound-spleeter.spleeter)
      (Φ mixer.mix
         sound-spleeter.Output.accomp
         sound-spleeter.DTLOutput.vocals))
   $f)

;; Composing with id is idempotent.  Or id is the identity element of
;; composition.
(= (. id $f) $f)
(= (. $f id) $f)

;; Applying id to x outputs x
(= (id $x) $x)

;; Sequential coercion
(= (. (coerce $bc) (coerce $ab)) (coerce (STTrans $bc $ab)))
(= (. (coerce $bc) (. (coerce $ab) $f)) (. (coerce (STTrans $bc $ab)) $f))

;; Translating from/to the same language reduces to id
(= (machine-translation.translate $l $l) id)

;; Translating back and forth from/to the same languages reduces to
;; id.  Obviously, this is not strictly true, but such combination is
;; useless enough that it gets reduced anyway.
(= (. (machine-translation.translate $l1 $l2)
      (. upload (. (machine-translation.translate $l2 $l1) upload)))
   id)

;;;;;;;;;;
;; Test ;;
;;;;;;;;;;

;; Synthesize composition of
;;
;; (-> (SongIn "English") (sound-spleeter.DTLOutput "English"))
;;
;; which is merely a spleeter call
!(assertEqual
  (bc &kb
      (fromNumber 0)
      (: $prg
         (-> (: $x (SongIn "English")) (sound-spleeter.DTLOutput "English"))))
  (: sound-spleeter.spleeter
     (-> (: $x (SongIn "English")) (sound-spleeter.DTLOutput "English"))))

;; Like above but doing type inference using type-annotated-bc
!(assertEqual
  (type-annotated-bc &kb
                     (fromNumber 0)
                     (: sound-spleeter.spleeter
                        (-> (: $x (SongIn "English"))
                            (sound-spleeter.DTLOutput "English"))))
  (: sound-spleeter.spleeter
     (-> (: $x (SongIn "English")) (sound-spleeter.DTLOutput "English"))))

;; Synthesize sequential composition of
;;
;; (-> Audio (TextIn "English"))
;;
;; which should merely be a call of speech-recognition.
!(assertEqual
  (bc &kb (fromNumber 0) (: $prg (-> (: $x Audio) (TextIn "English"))))
  (: speech-recognition.s2t (-> (: $x Audio) (TextIn "English"))))

;; Like above but doing type inference using type-annotated-bc
!(assertEqual
  (type-annotated-bc &kb
                     (fromNumber 0)
                     (: speech-recognition.s2t
                        (-> (: $x Audio) (TextIn "English"))))
  (: speech-recognition.s2t (-> (: $x Audio) (TextIn "English"))))

;; Prove that (<: (VocalsIn "English") Audio)
!(assertEqual
  (bc &kb (fromNumber 1) (: $prf (<: (VocalsIn "English") Audio)))
  (: (STTrans VA VIV) (<: (VocalsIn "English") Audio)))

;; Like above but doing type inference using type-annotated-bc
!(assertEqual
  (type-annotated-bc &kb
                     (fromNumber 1)
                     (: (STTrans (: VA $a) (: VIV $b))
                        (<: (VocalsIn "English") Audio)))
  (: (STTrans (: VA (<: Vocals Audio))
              (: VIV (<: (VocalsIn "English") Vocals)))
     (<: (VocalsIn "English") Audio)))

;; Synthesize composition of
;;
;; (-> (VocalsIn "English") Audio)
;;
;; which should be a coercion
!(assertEqual
  (unique (capture
   (bc &kb (fromNumber 2) (: $prg (-> (: $x (VocalsIn "English")) Audio)))))
  (: (coerce (STTrans VA VIV)) (-> (: $x (VocalsIn "English")) Audio)))

;; Like above but doing type inference using type-annotated-bc
!(assertEqual
  (type-annotated-bc &kb
                     (fromNumber 2)
                     (: (coerce (: (STTrans (: VA $a) (: VIV $b)) $c))
                        (-> (: $x (VocalsIn "English")) Audio)))
  (: (coerce (: (STTrans (: VA (<: Vocals Audio))
                         (: VIV (<: (VocalsIn "English") Vocals)))
                (<: (VocalsIn "English") Audio)))
     (-> (: $x (VocalsIn "English")) Audio)))

;; Synthesize sequential composition of
;;
;; (-> (VocalsIn "English") (TextIn "English"))
;;
;; which should merely be a call of speech-recognition with proper
;; casting from (VocalsIn "English") to Audio.
!(assertEqual
  (unique (capture
   (bc &kb
       (fromNumber 3)
       (: $prg
          (-> (: $x (VocalsIn "English")) (TextIn "English"))))))
  (: (. speech-recognition.s2t (coerce (STTrans VA VIV)))
     (-> (: $x (VocalsIn "English")) (TextIn "English"))))

;; Like above but doing type inference using type-annotated-bc
!(assertAlphaEqual
  (type-annotated-bc &kb
                     (fromNumber 3)
                     (: (add-type-annotation-holes
                         (. speech-recognition.s2t (coerce (STTrans VA VIV))))
                        (-> (: $x (VocalsIn "English")) (TextIn "English"))))
  (: (. (: speech-recognition.s2t (-> (: $y Audio) (TextIn "English")))
        (: (coerce (: (STTrans (: VA (<: Vocals Audio))
                               (: VIV (<: (VocalsIn "English") Vocals)))
                      (<: (VocalsIn "English") Audio)))
           (-> (: $x (VocalsIn "English")) Audio)))
     (-> (: $x (VocalsIn "English")) (TextIn "English"))))

;; Synthesize sequential composition of
;;
;; (-> Audio (UniformResourceLocatorOfType (TextIn "English")))
;;
;; which should be a sequential composition of speech-recognition and
;; upload.
!(assertEqual
  (bc &kb
      (fromNumber 1)
      (: $prg
         (-> (: $x Audio) (UniformResourceLocatorOfType (TextIn "English")))))
  (: (. upload speech-recognition.s2t)
     (-> (: $x Audio) (UniformResourceLocatorOfType (TextIn "English")))))

;; Like above but doing type inference using type-annotated-bc
!(assertAlphaEqual
  (type-annotated-bc &kb
                     (fromNumber 1)
                     (add-type-annotation-holes
                      (: (. upload speech-recognition.s2t)
                         (-> (: $x Audio)
                             (UniformResourceLocatorOfType (TextIn "English"))))))
  (: (. (: upload (-> (: $y (TextIn "English"))
                      (UniformResourceLocatorOfType (TextIn "English"))))
        (: speech-recognition.s2t (-> (: $x Audio) (TextIn "English"))))
     (-> (: $x Audio) (UniformResourceLocatorOfType (TextIn "English")))))

;; Synthesize sequential composition of
;;
;; (-> (VocalsIn "English") (UniformResourceLocatorOfType (TextIn "English")))
;;
;; which should be a sequential composition of speech-recognition,
;; upload and proper type coercion.
!(assertEqual
  (bc &kb
      (fromNumber 3)
      (: $prg
         (-> (: $x (VocalsIn "English"))
             (UniformResourceLocatorOfType (TextIn "English")))))
  (: (. upload (. speech-recognition.s2t (coerce (STTrans VA VIV))))
     (-> (: $x (VocalsIn "English"))
         (UniformResourceLocatorOfType (TextIn "English")))))

;; Like above but doing type inference using type-annotated-bc
!(assertAlphaEqual
  (type-annotated-bc
   &kb
   (fromNumber 4)
   (: (. (: upload $a)
         (: (. (: speech-recognition.s2t $b)
               (: (coerce (: (STTrans (: VA $c) (: VIV $d)) $e)) $f)) $g))
      (-> (: $x (VocalsIn "English"))
          (UniformResourceLocatorOfType (TextIn "English")))))
  (: (. (: upload (-> (: $y (TextIn "English"))
                      (UniformResourceLocatorOfType (TextIn "English"))))
        (: (. (: speech-recognition.s2t (-> (: $z Audio) (TextIn "English")))
              (: (coerce (: (STTrans (: VA (<: Vocals Audio))
                                     (: VIV (<: (VocalsIn "English") Vocals)))
                            (<: (VocalsIn "English") Audio)))
                 (-> (: $x (VocalsIn "English")) Audio)))
           (-> (: $x (VocalsIn "English")) (TextIn "English"))))
     (-> (: $x (VocalsIn "English"))
         (UniformResourceLocatorOfType (TextIn "English")))))

;; Synthesize composition of
;;
;; (-> (: "English" NaturalLanguage)
;;     (: "Chinese" NaturalLanguage)
;;     (-> (UniformResourceLocatorOfType (TextIn "English"))
;;         (TextIn "Chinese")))
;;
;; which should merely be a call to machine-translation.translate.
!(assertEqual
  (bc &kb
      (fromNumber 0)
      (: $prg
         (-> (: "English" NaturalLanguage)
             (: "Chinese" NaturalLanguage)
             (-> (: $x (UniformResourceLocatorOfType (TextIn "English")))
                 (TextIn "Chinese")))))
  (: machine-translation.translate
     (-> (: "English" NaturalLanguage)
         (: "Chinese" NaturalLanguage)
         (-> (: $x (UniformResourceLocatorOfType (TextIn "English")))
             (TextIn "Chinese")))))

;; Synthesize composition of
;;
;; (-> (UniformResourceLocatorOfType (TextIn "English")) (TextIn "Chinese"))
;;
;; which should merely be a call to machine-translation.translate with
;; proper parameters.
!(assertEqual
  (bc &kb
      (fromNumber 1)
      (: $prg
         (-> (: $x (UniformResourceLocatorOfType (TextIn "English")))
             (TextIn "Chinese"))))
  (: (machine-translation.translate "English" "Chinese")
     (-> (: $x (UniformResourceLocatorOfType (TextIn "English")))
         (TextIn "Chinese"))))

;; Synthesize sequential composition of
;;
;; (-> (TextIn "English") (TextIn "Chinese"))
;;
;; which should be a sequential composition of
;; machine-translation.translate with proper parameters and upload.
!(assertEqual
  (bc &kb
      (fromNumber 2)
      (: $prg
         (-> (: $x (TextIn "English")) (TextIn "Chinese"))))
  (: (. (machine-translation.translate "English" "Chinese") upload)
     (-> (: $x (TextIn "English")) (TextIn "Chinese"))))

;; Synthesize sequential composition of type
;;
;; (-> Audio (TextIn "Chinese"))
;;
;; which should be the composition of speech-recognition.s2t and
;; machine-translation.translate.
!(assertEqual
  (unique (capture
   (bc &kb
       (fromNumber 3)
       (: $prg
          (-> (: $x Audio) (TextIn "Chinese"))))))
  (: (. (machine-translation.translate "English" "Chinese")
        (. upload speech-recognition.s2t))
     (-> (: $x Audio) (TextIn "Chinese"))))

;; Synthesize sequential composition of type
;;
;; (-> (VocalsIn "English") (TextIn "Chinese"))
;;
;; which should be the composition of speech-recognition.s2t and
;; machine-translation.translate with the proper type coercions.
!(assertEqual
  (unique (capture
   (bc &kb
       (fromNumber 4)
       (: $prg
          (-> (: $x (VocalsIn "English")) (TextIn "Chinese"))))))
  (: (. (machine-translation.translate "English" "Chinese")
        (. upload (. speech-recognition.s2t (coerce (STTrans VA VIV)))))
     (-> (: $x (VocalsIn "English")) (TextIn "Chinese"))))

;; Type check the sequential composition
;;
;; (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter)
!(assertEqual
  (bc &kb (fromNumber 1)
      (: (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter)
         (-> (: $x (SongIn $l)) Instrumental)))
  (: (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter)
     (-> (: $x (SongIn $l)) Instrumental)))

;; Type check the following AI service composition
;;
;; (. (Φ midi2voice-zh.singingZH
;;       (. (machine-translation.translate "English" "Chinese")
;;          (. upload speech-recognition.s2t))
;;       tomidi.a2m)
;;    (coerce SIA))
!(assertEqual
  (bc &kb (fromNumber 4)
      (: (. (Φ midi2voice-zh.singingZH
               (. (machine-translation.translate "English" "Chinese")
                  (. upload speech-recognition.s2t))
               tomidi.a2m)
            (coerce SIA))
         (-> (: $x (SongIn $l)) (VocalsIn "Chinese"))))
  (: (. (Φ midi2voice-zh.singingZH
           (. (machine-translation.translate "English" "Chinese")
              (. upload speech-recognition.s2t))
           tomidi.a2m)
        (coerce SIA))
     (-> (: $x (SongIn $l)) (VocalsIn "Chinese"))))

;; Like above but doing type inference using type-annotated-bc
!(assertAlphaEqual
  (type-annotated-bc
   &kb
   (fromNumber 4)
   (: (. (: (Φ (: midi2voice-zh.singingZH $a)
               (: (. (: (machine-translation.translate (: "English" $b)
                                                       (: "Chinese" $c)) $d)
                     (: (. (: upload $e) (: speech-recognition.s2t $f)) $g)) $h)
               (: tomidi.a2m $i)) $j)
         (: (coerce (: SIA $k)) $m))
      (-> (: $x (SongIn $l)) (VocalsIn "Chinese"))))
  (: (. (: (Φ (: midi2voice-zh.singingZH
                 (-> (: $y (TextIn "Chinese"))
                     (: $z MusicalInstrumentDigitalInterface)
                     (VocalsIn "Chinese")))
              (: (. (: (machine-translation.translate
                        (: "English" NaturalLanguage)
                        (: "Chinese" NaturalLanguage))
                       (-> (: $w (UniformResourceLocatorOfType (TextIn "English")))
                           (TextIn "Chinese")))
                    (: (. (: upload
                             (-> (: $t (TextIn "English"))
                                 (UniformResourceLocatorOfType (TextIn "English"))))
                          (: speech-recognition.s2t
                             (-> (: $u Audio) (TextIn "English"))))
                       (-> (: $u Audio)
                           (UniformResourceLocatorOfType (TextIn "English")))))
                 (-> (: $u Audio) (TextIn "Chinese")))
              (: tomidi.a2m (-> (: $u Audio) MusicalInstrumentDigitalInterface)))
           (-> (: $u Audio) (VocalsIn "Chinese")))
        (: (coerce (: SIA (<: (SongIn $l) Audio)))
           (-> (: $x (SongIn $l)) Audio)))
     (-> (: $x (SongIn $l)) (VocalsIn "Chinese"))))

;; ;; ;; Enable this to carry out the final service composition
;; ;; ;; Synthesize all AI service composition going from (SongIn "English")
;; ;; ;; to (SongIn "Chinese").  Sort by lengths and select the top 10.
;; ;; ;; !(assertEqual  ; Re-enable on assert contain is supported
;; ;; !(List.sortWith termLengthLT
;; ;;                 (toList (collapse
;;                                ;; !(limit 6
;;                                 !(bc &kb (fromNumber 6)
;;                                     (: $prg
;;                                        (-> (: $x (SongIn "English"))
;;                                            (SongIn "Chinese")))););)))

;; Infer the type annotations of one of the solutions above but
;; slightly simplified
!(assertAlphaEqual
  (type-annotated-bc
   &kb
   (fromNumber 5)
   (: (Φ (: mixer.mix $a)
         (: sound-spleeter.DTLOutput.accomp $b)
         (: (. (: (Φ (: midi2voice-zh.singingZH $c)
                     (: (. (: (machine-translation.translate (: "English" $d)
                                                             (: "Chinese" $e))
                              $f)
                           (: (. (: upload $g)
                                 (: speech-recognition.s2t $h))
                              $i))
                        $j)
                     (: tomidi.a2m $k))
                  $l)
               (: (. (: (coerce (: (STTrans (: VA $m) (: VIV $n)) $o))
                        $p)
                     (: sound-spleeter.DTLOutput.vocals $q))
                  $r))
            $s))
      $t))
  (: (Φ (: mixer.mix (-> (: $x Instrumental)
                         (: $y (VocalsIn "Chinese"))
                         (SongIn "Chinese")))
        (: sound-spleeter.DTLOutput.accomp
           (-> (: $z (sound-spleeter.DTLOutput $l)) Instrumental))
        (: (. (: (Φ (: midi2voice-zh.singingZH
                       (-> (: $w (TextIn "Chinese"))
                           (: $u MusicalInstrumentDigitalInterface)
                           (VocalsIn "Chinese")))
                    (: (. (: (machine-translation.translate
                              (: "English" NaturalLanguage)
                              (: "Chinese" NaturalLanguage))
                             (-> (: $s (UniformResourceLocatorOfType
                                              (TextIn "English")))
                                 (TextIn "Chinese")))
                          (: (. (: upload
                                   (-> (: $t (TextIn "English"))
                                       (UniformResourceLocatorOfType
                                        (TextIn "English"))))
                                (: speech-recognition.s2t
                                   (-> (: $i Audio)
                                       (TextIn "English"))))
                             (-> (: $i Audio)
                                 (UniformResourceLocatorOfType
                                  (TextIn "English")))))
                       (-> (: $i Audio)
                           (TextIn "Chinese")))
                    (: tomidi.a2m
                       (-> (: $i Audio)
                           MusicalInstrumentDigitalInterface)))
                 (-> (: $i Audio)
                     (VocalsIn "Chinese")))
              (: (. (: (coerce (: (STTrans (: VA (<: Vocals Audio))
                                           (: VIV (<: (VocalsIn $l) Vocals)))
                                  (<: (VocalsIn $l) Audio)))
                       (-> (: $j (VocalsIn $l)) Audio))
                    (: sound-spleeter.DTLOutput.vocals
                       (-> (: $z (sound-spleeter.DTLOutput $l))
                           (VocalsIn $l))))
                 (-> (: $z (sound-spleeter.DTLOutput $l))
                     Audio)))
           (-> (: $z
                  (sound-spleeter.DTLOutput $l))
               (VocalsIn "Chinese"))))
     (-> (: $z (sound-spleeter.DTLOutput $l)) (SongIn "Chinese"))))

;; Infer the type annotations of one of the solutions from above
!(assertAlphaEqual
  (type-annotated-bc
   &kb
   (fromNumber 6)
   (: (. (: (Φ (: mixer.mix $a)
               (: sound-spleeter.DTLOutput.accomp $b)
               (: (. (: (Φ (: midi2voice-zh.singingZH $c)
                           (: (. (: (machine-translation.translate (: "English" $d)
                                                                   (: "Chinese" $e))
                                    $f)
                                 (: (. (: upload $g)
                                       (: speech-recognition.s2t $h))
                                    $i))
                              $j)
                           (: tomidi.a2m $k))
                        $l)
                     (: (. (: (coerce (: (STTrans (: VA $m) (: VIV $n)) $o))
                              $p)
                           (: sound-spleeter.DTLOutput.vocals $q))
                        $r))
                  $s))
            $t)
         (: sound-spleeter.spleeter $u))
      (-> (: $x (SongIn "English")) (SongIn "Chinese"))))
  (: (. (: (Φ (: mixer.mix (-> (: $i Instrumental)
                               (: $vc (VocalsIn "Chinese"))
                               (SongIn "Chinese")))
              (: sound-spleeter.DTLOutput.accomp
                 (-> (: $s (sound-spleeter.DTLOutput "English"))
                     Instrumental))
              (: (. (: (Φ (: midi2voice-zh.singingZH
                             (-> (: $tc (TextIn "Chinese"))
                                 (: $m MusicalInstrumentDigitalInterface)
                                 (VocalsIn "Chinese")))
                          (: (. (: (machine-translation.translate
                                    (: "English" NaturalLanguage)
                                    (: "Chinese" NaturalLanguage))
                                   (-> (: $u
                                          (UniformResourceLocatorOfType
                                           (TextIn "English")))
                                       (TextIn "Chinese")))
                                (: (. (: upload
                                         (-> (: $te (TextIn "English"))
                                             (UniformResourceLocatorOfType
                                              (TextIn "English"))))
                                      (: speech-recognition.s2t
                                         (-> (: $a Audio)
                                             (TextIn "English"))))
                                   (-> (: $a Audio)
                                       (UniformResourceLocatorOfType
                                        (TextIn "English")))))
                             (-> (: $a Audio)
                                 (TextIn "Chinese")))
                          (: tomidi.a2m
                             (-> (: $a Audio)
                                 MusicalInstrumentDigitalInterface)))
                       (-> (: $a Audio)
                           (VocalsIn "Chinese")))
                    (: (. (: (coerce
                              (: (STTrans
                                  (: VA (<: Vocals Audio))
                                  (: VIV (<: (VocalsIn "English") Vocals)))
                                 (<: (VocalsIn "English") Audio)))
                             (-> (: $ve (VocalsIn "English"))
                                 Audio))
                          (: sound-spleeter.DTLOutput.vocals
                             (-> (: $s (sound-spleeter.DTLOutput "English"))
                                 (VocalsIn "English"))))
                       (-> (: $s (sound-spleeter.DTLOutput "English"))
                           Audio)))
                 (-> (: $s (sound-spleeter.DTLOutput "English"))
                     (VocalsIn "Chinese"))))
           (-> (: $s (sound-spleeter.DTLOutput "English"))
               (SongIn "Chinese")))
        (: sound-spleeter.spleeter
           (-> (: $x (SongIn "English"))
               (sound-spleeter.DTLOutput "English"))))
     (-> (: $x (SongIn "English")) (SongIn "Chinese"))))

;; ;; The first 6 candidates are printed in DOT format
;; !(DOT.println! (: (. (Φ mixer.mix sound-spleeter.DTLOutput.accomp (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (. (coerce IA) sound-spleeter.DTLOutput.accomp))) sound-spleeter.spleeter) (-> (: $x (SongIn "English")) (SongIn "Chinese"))))
;; !(DOT.println! (: (. (Φ mixer.mix sound-spleeter.DTLOutput.accomp (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (. (coerce SIA) (Φ mixer.mix sound-spleeter.DTLOutput.accomp sound-spleeter.DTLOutput.vocals)))) sound-spleeter.spleeter) (-> (: $x (SongIn "English")) (SongIn "Chinese"))))
;; !(DOT.println! (: (. (Φ mixer.mix sound-spleeter.DTLOutput.accomp (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (. (coerce (STTrans VA VIV)) sound-spleeter.DTLOutput.vocals))) sound-spleeter.spleeter) (-> (: $x (SongIn "English")) (SongIn "Chinese"))))
;; !(DOT.println! (: (. (Φ mixer.mix (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter) (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (coerce SIA))) (Φ mixer.mix (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter) (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (coerce SIA)))) (-> (: $x (SongIn "English")) (SongIn "Chinese"))))
;; !(DOT.println! (: (. (Φ mixer.mix (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter) (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (coerce SIA))) (Φ mixer.mix (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter) (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (. (coerce IA) (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter))))) (-> (: $x (SongIn "English")) (SongIn "Chinese"))))
;; !(DOT.println! (: (. (Φ mixer.mix (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter) (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (coerce SIA))) (Φ mixer.mix (. sound-spleeter.DTLOutput.accomp sound-spleeter.spleeter) (. (Φ midi2voice-zh.singingZH (. (machine-translation.translate "English" "Chinese") (. upload speech-recognition.s2t)) tomidi.a2m) (. (coerce (STTrans VA VIV)) (. sound-spleeter.DTLOutput.vocals sound-spleeter.spleeter))))) (-> (: $x (SongIn "English")) (SongIn "Chinese"))))

;; ;; (Partial) 3rd candidate (the solution) printed in DOT format with type
;; ;; annotations on the edges
;; !(DOT.println!
;;   (: (Φ (: mixer.mix (-> (: $x Instrumental)
;;                          (: $y (VocalsIn "Chinese"))
;;                          (SongIn "Chinese")))
;;         (: sound-spleeter.DTLOutput.accomp
;;            (-> (: $z (sound-spleeter.DTLOutput $l)) Instrumental))
;;         (: (. (: (Φ (: midi2voice-zh.singingZH
;;                        (-> (: $w (TextIn "Chinese"))
;;                            (: $u MusicalInstrumentDigitalInterface)
;;                            (VocalsIn "Chinese")))
;;                     (: (. (: (machine-translation.translate
;;                               (: "English" NaturalLanguage)
;;                               (: "Chinese" NaturalLanguage))
;;                              (-> (: $s (UniformResourceLocatorOfType
;;                                               (TextIn "English")))
;;                                  (TextIn "Chinese")))
;;                           (: (. (: upload
;;                                    (-> (: $t (TextIn "English"))
;;                                        (UniformResourceLocatorOfType
;;                                         (TextIn "English"))))
;;                                 (: speech-recognition.s2t
;;                                    (-> (: $i Audio)
;;                                        (TextIn "English"))))
;;                              (-> (: $i Audio)
;;                                  (UniformResourceLocatorOfType
;;                                   (TextIn "English")))))
;;                        (-> (: $i Audio)
;;                            (TextIn "Chinese")))
;;                     (: tomidi.a2m
;;                        (-> (: $i Audio)
;;                            MusicalInstrumentDigitalInterface)))
;;                  (-> (: $i Audio)
;;                      (VocalsIn "Chinese")))
;;               (: (. (: (coerce (: (STTrans (: VA (<: Vocals Audio))
;;                                            (: VIV (<: (VocalsIn $l) Vocals)))
;;                                   (<: (VocalsIn $l) Audio)))
;;                        (-> (: $j (VocalsIn $l)) Audio))
;;                     (: sound-spleeter.DTLOutput.vocals
;;                        (-> (: $z (sound-spleeter.DTLOutput $l))
;;                            (VocalsIn $l))))
;;                  (-> (: $z (sound-spleeter.DTLOutput $l))
;;                      Audio)))
;;            (-> (: $z
;;                   (sound-spleeter.DTLOutput $l))
;;                (VocalsIn "Chinese"))))
;;      (-> (: $z (sound-spleeter.DTLOutput $l)) (SongIn "Chinese"))))

;; ;; 3rd candidate (the solution) printed in DOT format with type
;; ;; annotations on the edges
;; !(DOT.println!
;;   (: (. (: (Φ (: mixer.mix (-> (: $i Instrumental)
;;                                (: $vc (VocalsIn "Chinese"))
;;                                (SongIn "Chinese")))
;;               (: sound-spleeter.DTLOutput.accomp
;;                  (-> (: $s (sound-spleeter.DTLOutput "English"))
;;                      Instrumental))
;;               (: (. (: (Φ (: midi2voice-zh.singingZH
;;                              (-> (: $tc (TextIn "Chinese"))
;;                                  (: $m MusicalInstrumentDigitalInterface)
;;                                  (VocalsIn "Chinese")))
;;                           (: (. (: (machine-translation.translate
;;                                     (: "English" NaturalLanguage)
;;                                     (: "Chinese" NaturalLanguage))
;;                                    (-> (: $u
;;                                           (UniformResourceLocatorOfType
;;                                            (TextIn "English")))
;;                                        (TextIn "Chinese")))
;;                                 (: (. (: upload
;;                                          (-> (: $te (TextIn "English"))
;;                                              (UniformResourceLocatorOfType
;;                                               (TextIn "English"))))
;;                                       (: speech-recognition.s2t
;;                                          (-> (: $a Audio)
;;                                              (TextIn "English"))))
;;                                    (-> (: $a Audio)
;;                                        (UniformResourceLocatorOfType
;;                                         (TextIn "English")))))
;;                              (-> (: $a Audio)
;;                                  (TextIn "Chinese")))
;;                           (: tomidi.a2m
;;                              (-> (: $a Audio)
;;                                  MusicalInstrumentDigitalInterface)))
;;                        (-> (: $a Audio)
;;                            (VocalsIn "Chinese")))
;;                     (: (. (: (coerce
;;                               (: (STTrans
;;                                   (: VA (<: Vocals Audio))
;;                                   (: VIV (<: (VocalsIn "English") Vocals)))
;;                                  (<: (VocalsIn "English") Audio)))
;;                              (-> (: $ve (VocalsIn "English"))
;;                                  Audio))
;;                           (: sound-spleeter.DTLOutput.vocals
;;                              (-> (: $s (sound-spleeter.DTLOutput "English"))
;;                                  (VocalsIn "English"))))
;;                        (-> (: $s (sound-spleeter.DTLOutput "English"))
;;                            Audio)))
;;                  (-> (: $s (sound-spleeter.DTLOutput "English"))
;;                      (VocalsIn "Chinese"))))
;;            (-> (: $s (sound-spleeter.DTLOutput "English"))
;;                (SongIn "Chinese")))
;;         (: sound-spleeter.spleeter
;;            (-> (: $x (SongIn "English"))
;;                (sound-spleeter.DTLOutput "English"))))
;;      (-> (: $x (SongIn "English")) (SongIn "Chinese"))))
