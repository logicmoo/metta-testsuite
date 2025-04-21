(: f (-> (-> Number Number Number) Number))
(= (f $x) ($x 1 2))

!(f +)
