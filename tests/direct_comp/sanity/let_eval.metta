
(: qeval-atom (-> Atom Expression))
(= (qeval-atom $eval)
   (let $r $eval (quote ($eval -> $r))))

;(: qeval-undef (-> $_ Expression))
(= (qeval-undef $eval)
   (let $r $eval (quote ($eval -> $r))))

(: qeval-any (-> Any Expression))
(= (qeval-any $eval)
   (let $r $eval (quote ($eval -> $r))))

(= (atom-print-quoted-2) (qeval-atom (+ 1 1)))
(= (undef-print-quoted-2) (qeval-undef (+ 1 1)))
(= (any-print-quoted-2) (qeval-any (+ 1 1)))

!(atom-print-quoted-2)
!(undef-print-quoted-2)
!(any-print-quoted-2)

