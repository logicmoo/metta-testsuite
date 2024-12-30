;; Knowledge base
!(bind! &kb (new-space))
!(add-atom &kb (: AND (-> Boolean Boolean Boolean)))
!(add-atom &kb (: X Boolean))

;; Backward chainer
;; Base case
(= (bc $kb $_ (: $prg $type)) (match $kb (: $prg $type) (: $prg $type)))
;; Recursive steps
;; Unary operators
(= (bc $kb (S $k) (: ($fun $arg) $type))
   (let* (((: $fun (-> $prms $type)) (bc $kb $k (: $fun (-> $prms $type))))
          ((: $arg $prms) (bc $kb $k (: $arg $prms))))
     (: ($fun $arg) $type)))
;; Binary operators
(= (bc $kb (S $k) (: ($fun $arg1 $arg2) $type))
   (let* (((: $fun (-> $prms1 $prms2 $type))
           (bc $kb $k (: $fun (-> $prms1 $prms2 $type))))
          ((: $arg1 $prms1) (bc $kb $k (: $arg1 $prms1)))
          ((: $arg2 $prms2) (bc $kb $k (: $arg2 $prms2))))
     (: ($fun $arg1 $arg2) $type)))

;; Test bc

!(bc &kb (S (S Z)) (: $prg Boolean))



!(assertEqualToResult
        (bc &kb (S (S Z)) (: $prg Boolean))

	((: X Boolean) 
	 (: (AND X X) Boolean)
 	 (: (AND X (AND X X)) Boolean) 
	 (: (AND (AND X X) X) Boolean) 
	 (: (AND (AND X X) (AND X X)) Boolean)))
