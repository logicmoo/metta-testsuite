

(: py-input (-> Atom))
(= (py-input) ((py-atom input)))

(: py-print (-> Atom (->)))
(= (py-print $a) (let $_ ((py-atom print) (py-term $a)) $a))

!(py-print (quote (+ 1 2)))
!(py-print "type something")
!(let $res (parse (py-input)) (py-print $res))
