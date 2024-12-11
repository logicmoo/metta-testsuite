;; Collection of general-purpose utilities for list (or atom as list)
;; Inefficient and untyped, for quick prototyping only

(= (L-empty? $list)
    (if (== $list ()) True False)
)

(= (L-size $list)
    (if (L-empty? $list)
        0
        (let $tail (cdr-atom $list) (+ 1 (L-size $tail)))
    )
)


(= (L-push-front $list $item)
    (cons-atom $item $list)
)

(= (L-push-back $list $item)
    (if (L-empty? $list)
        ($item)
        (let* (
            (($h $t) (decons-atom $list))
            ($pushed (L-push-back $t $item))
        ) (cons-atom $h $pushed))
    )
)


(= (L-pop-front $list)
    (if (L-empty? $list)
        (Error L-pop-front "Empty list")
        (cdr-atom $list)
    )
)

(= (L-pop-back $list)
    (if (L-empty? $list)
        (Error L-pop-back "Empty list")
        (let ($h $t) (decons-atom $list)
            (if (L-empty? $t)
                ()
                (let $popped (L-pop-back $t)
                    (cons-atom $h $popped)
                )
            )
        )
    )
)

(= (L-append $list $list2)
    (if (L-empty? $list)
        $list2
        (let* (
            (($h $rest) (decons-atom $list))
            ($appended (L-append $rest $list2))
        ) (cons-atom $h $appended))
    )
)

(= (L-front $list)
    (if (L-empty? $list)
        (Error L-front "Empty list")
        (car-atom $list)
    )
)

(= (L-back $list)
    (if (L-empty? $list)
        (Error L-back "Empty list")
        (let ($h $rest) (decons-atom $list)
            (if (L-empty? $rest) 
                $h 
                (L-back $rest)
            )
        )
    )
)

(: L-index (-> Expression Number Atom))
(= (L-index $list $index)
    (if (or (< $index 0) (and (>= $index 0) (L-empty? $list)))
        (Error L-index "Index out of range")
        (if (== $index 0)
            (car-atom $list)
            (let* (
                ($rest (cdr-atom $list))
                ($idx (- $index 1))
            ) (L-index $rest $idx))
        )
    )
)


(= (L-contains? $list $item)
    (if (L-empty? $list)
        False
        (let ($h $t) (decons-atom $list)
            (if (== $h $item) True (L-contains? $t $item))
        )
    )
)

(= (L-subset? $list1 $list2)
    (if (== $list1 ())
        True
        (let ($h $rest) (decons-atom $list1)
            (if (L-contains? $list2 $h)
                (L-subset? $rest $list2)
                False
            )
        )
    )
)

(= (L-seteq? $list1 $list2)
    (and (L-subset? $list1 $list2)
        (L-subset? $list2 $list1))
)

(= (L-intersection $list1 $list2)
    (if (== $list1 ())
        ()
        (let* (
            (($h $t) (decons-atom $list1))
            ($inters (L-intersection $t $list2))
        ) (if (L-contains? $list2 $h)
            (cons-atom $h $inters)
            $inters
        ))
    )
)