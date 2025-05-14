
;;;;;;;;;;;
;; Utils ;;
;;;;;;;;;;;

;; Return the total length of a term, corresponding roughly to the
;; number of symbols in the term.
(: termLength (-> Atom Number))
(= (termLength $term) (case (get-metatype $term)
                        ((Expression (if (== $term ())
                                         0
                                         (let* (($head (car-atom $term))
                                                ($tail (cdr-atom $term)))
                                           (+ (termLength $head)
                                              (termLength $tail)))))
                         ($else 1))))

;; Test termLength
!(assertEqual
  (termLength (A B (C D)))
  4)



;; Test termLength
!(assertEqualToResult
  (termLength (A B (C D)))
  (4))

