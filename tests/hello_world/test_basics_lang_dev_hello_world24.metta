
(= (zip $list1 $list2)
   (case ($list1 $list2)
         (((() ()) ())
          (((:: $x $xs) (:: $y $ys)) (:: ($x $y) (zip $xs $ys)))
          ($else ERROR)
         )
   )
)
! (zip (:: A (:: B ())) (:: 1 (:: 2 ()))) 
; (:: (A 1) (:: (B 2) ()))
! (zip (:: A (:: B ())) (:: 1 ())) 
; (:: (A 1) ERROR)

;[(:: (A 1) (:: (B 2) ()))]
;[(:: (A 1) ERROR)]


;[ (::    (A 1)    (::      (B 2) ())), 
;  (::    (A 1)    (::      (B 2) ()))
;, (::    (A 1)    (::      (B 2) ()))
;, (::    (A 1)    (::      (B 2) ()))
;, (::    (A 1)    (::      (B 2) ()))
;, (::    (A 1)    (::      (B 2) ()))
;, (::    (A 1)    (::      (B 2) ()))
;, (::    (A 1)    (::      (B 2) ()))]
;[ (::    (A 1) ERROR), (::    (A 1) ERROR) ]
;% 223,019 inferences, 0.214 CPU in 0.222 seconds (96% CPU, 1041450 Lips)