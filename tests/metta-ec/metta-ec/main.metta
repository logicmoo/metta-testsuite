!(import! &self fol-bc)
; !(bind! &kb (new-space))
!(import! &kb yaleshooting)
; !(import! &kb bec)
(= (query $goal)
    (backward-chain $goal &kb &kb)
)

; !(query (happens $f $t))
; !(query (tp $t))
!(query (holdsAt $f $t))
