

!(case (match &self (foo-missing $bar) (quote $bar)) 
  (((quote $bar) (println! (quote (found $bar)))) 
   ($n (quote ($n $bar)))
   (Empty "Found Empty")
   (%void% "Found %void%")))

!(case (match &self (foo-missing $bar) (quote $bar)) 
  (((quote $bar) (println! (quote (found $bar)))) 
   (Empty "Found Empty")))

!(case (match &self (foo-missing $bar) (quote $bar))
  (((quote $n) ($n (quote ($n $bar))))
   ($n (quote ($n $bar)))
   (Empty "Found Empty")))


(foo-found a)
(foo-found (+ 1 1))

!(case (match &self (foo-found $bar) (quote $bar)) 
  (((quote $bar) (println! (quote (found $bar)))) 
   ($n (quote ($n $bar)))
   (Empty "Found Empty")
   (%void% "Found %void%")))

!(case (match &self (foo-found $bar) (quote $bar)) 
  (((quote $bar) (println! (quote (found $bar)))) 
   (Empty "Found Empty")))

!(case (match &self (foo-found $bar) (quote $bar))
  (((quote $n) ($n (quote ($n $bar))))
   ($n (quote ($n $bar)))
   (Empty "Found Empty")))


