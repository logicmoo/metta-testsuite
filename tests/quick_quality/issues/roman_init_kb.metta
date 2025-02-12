(= (init-kb)
   (let* (($cs (new-space))
          ($ps (new-space))
          )
   ($cs $ps))
)

(= (add-to-kb ($cs $ps) $stmt)
   (add-atom $cs $stmt)
)

!(bind! &s (init-kb))

!(s = &s)
!(s = &s)

!(add-to-kb &s test)
!(let ($cs $ps) &s (match $cs $any $any))
!(assertEqualToResult (let ($cs $ps) &s (match $cs $any $any)) (test))
