;; Formula for the modus ponens rule

;; Import modules
!(register-module! ../truthvalue)
!(import! &self truthvalue:TruthValue)
!(register-module! ../Num)
!(import! &self Num)

(= (modus-ponens-formula (STV $As $Ac)
                         (STV $ABs $ABc))
   (let*
       (($notABs 0.2)   ; temporary hack
        ($notABc 1))
       (STV
           (+ (* $ABs $As) (* $notABs (- 1 $As)))
           (min (min $ABc $notABc) $Ac))))
