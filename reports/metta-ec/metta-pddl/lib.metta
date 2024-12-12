;; TODO: mutable data structure in MeTTa?

;; O(n) queue
(= (make-queue) ())
(= (empty-queue? $q) (unify $q () True False))
(= (front-queue $q) 
    (if (empty-queue? $q)
        (Error $q "Can't get front of empty queue")
        (car-atom $q)
    )
)
(= (pop-queue $q) (cdr-atom $q))
(= (insert-queue $q $item) 
    (if (== $q ())
        ($item)
        (let* (
            (($head $tail) (decons-atom $q))
            ($inserted (insert-queue $tail $item))
        ) (cons-atom $head $inserted))
    )
)

; !(let* (
;     ($q (make-queue))
;     ($q1 (insert-queue $q 1))
;     (() (println! $q1))
;     ($q2 (insert-queue $q1 3))
;     ($el (front-queue $q2))
;     ($q3 (pop-queue $q2))
;     (() (println! (Element $el)))
;     (() (println! $q3))
;     ($q4 (insert-queue $q3 5))
;     (() (println! $q4))
; ) ())
