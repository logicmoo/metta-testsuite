(= (f1 $n) (cdr-atom $n))

(= (f2 $n) (cdr-atom (cdr-atom $n)))

(: f1a (-> Number Expression Expression))
(= (f1a $n) (cdr-atom $n))

(: f2a (-> Number Expression Expression))
(= (f2a $n) (cdr-atom (cdr-atom $n)))


!(f1 (1 2 3 4 5))
!(f2 (1 2 3 4 5))
!(f1a (1 2 3 4 5))
!(f2a (1 2 3 4 5))
