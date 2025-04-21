; Recursive Fibonacci
(= (fib-naive 0) 0)
(= (fib-naive 1) 1)
(= (fib-naive $n) (if (> $n 1) (+ (fib-naive (- $n 1)) (fib-naive (- $n 2))) (empty)))

!(fib-naive 10)

; Recursive Fibonacci using previous values
(= (fib-fast-aux $prev2 $prev1 $left)
    (if (== $left 0)
        $prev1
        (fib-fast-aux $prev1 (+ $prev1 $prev2) (- $left 1))))

(= (fib-fast 0) 0)
(= (fib-fast 1) 1)
(= (fib-fast $n) (if (> $n 1) (fib-fast-aux 0 1 (- $n 1)) (empty)))

!(fib-fast 300)


