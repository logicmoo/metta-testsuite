;
;                         generated: 17 November 1989

;
;                         option(s): SOURCE_TRANSFORM_1

;
; 

;
;                           tak

;
; 

;
;                            Evan Tick (from Lisp version by R. P. Gabriel)

;
; 

;
;                            (almost) Takeuchi function (recursive arithmetic)



  (= 
    (top) 
    (tak))


  (= 
    (tak) 
    (tak 18 12 6 $_))

  (= 
    (tak $X $Y $Z $A) 
    ( (=< $X $Y) (= $Z $A)))
  (= 
    (tak $X $Y $Z $A) 
    ( (> $X $Y) 
      (is $X1 
        (- $X 1)) 
      (tak $X1 $Y $Z $A1) 
      (is $Y1 
        (- $Y 1)) 
      (tak $Y1 $Z $X $A2) 
      (is $Z1 
        (- $Z 1)) 
      (tak $Z1 $X $Y $A3) 
      (tak $A1 $A2 $A3 $A)))

