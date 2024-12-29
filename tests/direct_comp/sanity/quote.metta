
(: quote-atom (-> Atom Expression))
(= (quote-atom $eval)
   (quote $eval))

!(println! (quote-atom (+ 1 1)))
; (quote (+ 1 1))
!(println! (quote (+ 1 1)))
; (quote (+ 1 1))
