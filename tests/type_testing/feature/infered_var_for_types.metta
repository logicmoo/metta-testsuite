
(: number_into_string (-> Number String))
(= (number_into_string $n) (repr $n))
!(let $_ (number_into_string $a) (get-type $a))
; [Number]
!(let $b (number_into_string $a) (get-type $b))
; [String]

