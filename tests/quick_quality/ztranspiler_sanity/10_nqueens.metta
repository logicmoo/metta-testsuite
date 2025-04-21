; The next two lines would do select in MeTTalog, but don't work in Hyperon Experimental
; (= (select $x) ((car-atom $x) (cdr-atom $x)))
; (= (select $x) (let* (($y (car-atom $x)) ($z (cdr-atom $x)) (($u $v) (select $z))) ($u (cons-atom $y $v))))
(: select (-> Expression Expression))
(= (select $x) (if (== $x ()) (empty) ((car-atom $x) (cdr-atom $x))))
(= (select $x) (if (== $x ()) (empty) (let* (($y (car-atom $x)) ($z (cdr-atom $x)) (($u $v) (select $z))) ($u (cons-atom $y $v)))))

(: range (-> Number Number Expression))
(= (range $x $y)
    (if (== $x $y)
        ($x)
        (let $z (range (+ $x 1) $y)
            (cons-atom $x $z))))

(: nqueens (-> Number Expression))
(= (nqueens $n)
    (let $r (range 1 $n) (nqueens_aux $r ())))

(: nqueens_aux (-> Expression Expression Expression))
(= (nqueens_aux $unplaced $safe)
    (if (== $unplaced ())
        $safe
        (let ($q $r) (select $unplaced)
            (if (not_attack $q 1 $safe)
                (let $safeext (cons-atom $q $safe)
                (nqueens_aux $r $safeext))
                (empty)))))

(: not_attack (-> Number Number Expression Bool))
(= (not_attack $q $d $s)
    (if (== $s ())
        True
        (let* (($h (car-atom $s)) ($t (cdr-atom $s)))
            (if (or (== $q $h) (or (== $q (+ $d $h)) (== $h (+ $q $d)))) False
                (not_attack $q (+ $d 1) $t)))))

!(nqueens 8)

% !(time (collapse (nqueens 8)))
