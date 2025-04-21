(= (append $x $y)
    (if (== $x ())
        $y
        (let* (($h (car-atom $x)) ($t (cdr-atom $x)))
            (let $rest (append $t $y)
                (cons-atom $h $rest)))))

!(append (1 2) (3 5))
