
;; (: progLAND (-> Atom Atom) ) ;; uncommenting this does not help
(= (progLAND (quote $list))
 (if (== (quote $list) (quote ())) ()
  (let ($h $t) (decons-atom $list)
   (if (== (quote $t) (quote ()))
    $h
    (let $res1 $h 
     (let $res2 (progLAND (quote $t)) $res2))))))

!(progLAND (quote ((println! "hello2") (println! "world2"))))

;!(progLAND ((=unifying 1 $b) (=unifying 2 $c) ($b $c)))
;!(progLAND ((=is 1 $b) (=is 2 $c) ($b $c)))
;!(progLAND ((println! "hello") Empty (println! "world") Empty))
