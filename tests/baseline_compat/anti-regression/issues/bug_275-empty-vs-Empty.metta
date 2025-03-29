;; Confirm that (empty) evaluates to () and causes let binding to fail, so result is ()
!(assertEqualToResult (let $a (empty) 1) ())

;; Confirm that a regular let binding with a non-empty value succeeds and returns body
!(assertEqualToResult (let $a something 1) (1))

;; Nesting: (empty) causes outer let to fail; inner let is never reached
!(assertEqualToResult (let $a (empty) (let $b something 2)) ())

;; Evaluate lowercase (empty) directly — should return ()
!(assertEqualToResult (empty) ())

;; Confirm let works normally when given a valid binding (42) — returns body (99)
!(assertEqualToResult (let $x 42 99) (99))

;; Confirm Empty is equal to itself — returns True
!(assertEqualToResult (== Empty Empty) (True))

;; Confirm Empty is not equal to a variable — returns False
!(assertEqualToResult (== Empty $a) (False))

;; Print Empty — prints nothing, so result is ()
!(assertEqualToResult (println! Empty) (()))

;; (empty) evaluates to (), so (+ () 1) is invalid — returns ()
!(assertEqualToResult (+ (empty) 1) ())

;; Attempt to call Empty as a function — should return (), does nothing
!(assertEqualToResult ((Empty)) ())

;; Evaluate (Empty) on its own — returns ()
!(assertEqualToResult (Empty) ())

;; Quoting Empty — prevents evaluation — returns quoted structure
!(assertEqualToResult (quote (Empty)) ((quote (Empty))))

;; Apply quoted (Empty) as a function to Empty — does nothing — returns ()
!(assertEqualToResult ((quote (Empty)) Empty) ())

;; Test: `let` with explicit binding form fails with Empty — should return ()
!(assertEqualToResult (let ($a) (Empty) 1) ())

(= (return-empty) Empty)
!(assertEqualToResult (return-empty) ())

;; 🔔 MettaLog FAILING TESTS BELOW ────────── Based on Hyperon Results assumed to be correct ────────── 

;; Confirm that capitalized Empty should also fail in let — this is a bug if it does not 🔔
!(assertEqualToResult (let $a Empty 1) (1))   

;; Nesting: Empty allows outer let; inner let binds and returns 2 🔔
!(assertEqualToResult (let $a Empty (let $b something 2)) (2))

;; Nested lets with both variables as Empty should still allow body to return 2 🔔
!(assertEqualToResult (let $a Empty (let $b Empty 2)) (2))

;; Evaluate capitalized Empty directly — should return () 🔔
!(assertEqualToResult Empty ())

;; Confirm collapsing Empty and (empty) gives same result — ensures consistency 🔔
!(assertEqual (collapse Empty) (collapse (empty)))

;; Print (Empty) — call to Empty returns nothing — prints nothing 🔔
!(assertEqualToResult (println! (Empty)) ())

;; Expression with Empty that is not evaluated — should return unevaluated form 🔔
!(assertEqualToResult (+ Empty 1) ((+ Empty 1)))

;; println! with (empty) — evaluates to (), which prints nothing 🔔
!(assertEqualToResult (println! (empty)) ())

;; println! with ((Empty)) — evaluates to (), which prints nothing 🔔
!(assertEqualToResult (println! ((Empty))) ())

;; Evaluate Empty on its own — returns () 🔔
!(assertEqualToResult Empty ())

;; Calling the quoted (Empty) — returns quoted structure in list 🔔
!(assertEqualToResult ((quote (Empty))) (((quote (Empty)))))

