; !(assertEqualToResult (rtrace (func ($variable a b))) ((func ($variable a b))))

!(let $_ (call-p freeze $var break) 
    (assertEqualToResult (func ($var a b)) ((func ($var a b)))))

!(case (let $_ (call-p freeze $var break) 
   (func ($var a b))) ())

!(case (call-p print_src (func ($var a b))) ())
