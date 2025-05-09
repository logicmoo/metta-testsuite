

(: once* (-> Atom Atom))
(= (once* $eval)
   (function (return* $eval)))

(: return* (-> Atom Atom))
(= (return* $eval)  
  (case $eval
	((Empty (return NoResults))
	 ($captured (return (quote $captured))))))

!(once* (superpose (1 2 3)))

