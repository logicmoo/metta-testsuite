;; ==============================
;; Initialize a New Logical Space
;; ==============================

;; Create a new logical space and bind it to &space
!(bind! &space (new-space))

;; Add rules/atoms to the space:
;; - A function `f` that returns its argument.
!(add-atom &space (= (f $x) $x))
;; - Two more rules: 
;;   - One states ($y $z) reduces to $z.
;;   - The other states ($y $z) reduces to $y.
!(add-atom &space (= ($y $z) $z))
!(add-atom &space (= ($y $z) $y))

;; ==============================
;; Validate that Atoms are Stored
;; ==============================

;; Ensure that all atoms were correctly added to &space
!(assertEqualToResult (get-atoms &space) 
	 ((= (f $x) $x)   ;; Function rule
	  (= ($y $z) $z)  ;; First pattern-matching rule
	  (= ($y $z) $y))) ;; Second pattern-matching rule

;; ==============================
;; Attempt to Match and Remove an Atom
;; ==============================

;; Try to remove the rule `($y $z) ? $z` from the space
;; If `remove-atom` does not handle indexed variables correctly (e.g., #nnn placeholders), 
;; it may not work as expected.
!(match &space (= ($y $z) $z)
   (remove-atom &space (= ($y $z) $z)))

;; ==============================
;; OOPSies! Every Atom was Removed
;; ==============================
!(assertEqualToResult (get-atoms &space) ())


;; ==============================
;; The user can create their own solution!
;;
;; Define a Higher-Order Match Operator
;; ==============================

;; Define a `match-by` function that enhances matching operations.
;; - `$op` specifies the type of matching used.
;; - `$space` is the logical space to operate on.
;; - `$pattern` is the pattern to match.
;; - `$template` represents what should happen after a match.

(= (match-by $op $space $pattern $template)
  (let* (($_2 (call! same-index $pattern $found))  ;; Ensures indexed lookup for efficient matching
		 ($_1 (call! freeze $found [call $op $pattern $found])))  ;; Freezes the match before applying `$op`
	   (match $space $found $template)))  ;; Perform the match operation with the given template.


;; ==============================
;; Test Match-Based Atom Removal
;; ==============================

;; Create a new logical space &space-2 and add similar rules
!(bind! &space-2 (new-space))
!(add-atom &space-2 (= (f $x) $x))
!(add-atom &space-2 (= ($y $z) $z))
!(add-atom &space-2 (= ($y $z) $y))

;; ==============================
;; Remove an Atom Using `=alpha` Matching
;; ==============================

;; Use `match-by` with `=alpha` matching to attempt removal.
;; `=alpha` means "exactly equal up to variable renaming."
!(match-by =alpha &space-2 (= ($y $z) $z)
   (remove-atom &space-2 (= ($y $z) $z)))

;; Since `=alpha` matches exactly (not unifying variables), only one of the `(= ($y $z) $z)` atoms should be removed.
!(assertEqualToResult (get-atoms &space-2) 
	 ((= (f $x) $x)
	  (= ($y $z) $y)))  ;; The other `(= ($y $z) $y)` remains.

;; ==============================
;; Test Mismatched Removal Attempt
;; ==============================

;; Try to remove `(= (f $x) $z)`, but no exact `=alpha` match exists.
!(match-by =alpha &space-2 (= (f $x) $z)
   (remove-atom &space-2 (= (f $x) $z)))

;; Nothing should be removed because no such atom exists.
!(assertEqualToResult (get-atoms &space-2) 
	 ((= (f $x) $x)
	  (= ($y $z) $y))))

;; ==============================
;; Remove Atoms Using `=unify` Matching
;; ==============================

;; `=unify` refers to a more permissive unification-based matching rule.
;; This should match and remove **both** instances of `(= ($y $z) $z)` and `(= ($y $z) $y)`.
!(match-by =unify &space-2 (= ($y $z) $z)
   (remove-atom &space-2 (= ($y $z) $z)))

;; Since `=unify` is a more flexible unification rule, both `(= ($y $z) $z)` and `(= ($y $z) $y)` should be removed.
!(assertEqualToResult (get-atoms &space-2) ())

;; ==============================
;; Additional Testing with &space-3
;; ==============================

;; Create another logical space &space-3 and add similar rules
!(bind! &space-3 (new-space))
!(add-atom &space-3 (= (f $x) $x))
!(add-atom &space-3 (= ($y $z) $z))
!(add-atom &space-3 (= ($y $z) $y))

;; ==============================
;; Remove an Atom Using `=alpha` Matching
;; ==============================

;; Use `match-by` with `=alpha` matching to attempt removal.
!(match-by =alpha &space-3 (= ($y $z) $z)
   (remove-atom &space-3 (= ($y $z) $z)))

;; Since `=alpha` matches exactly, only one `(= ($y $z) $z)` should be removed.
!(assertEqualToResult (get-atoms &space-3) 
	 ((= (f $x) $x)
	  (= ($y $z) $y))))

;; ==============================
;; Test Mismatched Removal Attempt
;; ==============================

;; Try to remove `(= (f $x) $z)`, but no exact `=alpha` match exists.
!(match-by =alpha &space-3 (= (f $x) $z)
   (remove-atom &space-3 (= (f $x) $z)))

;; Nothing should be removed because no such atom exists.
!(assertEqualToResult (get-atoms &space-3) 
	 ((= (f $x) $x)
	  (= ($y $z) $y))))

;; ==============================
;; Remove Atoms Using `=will` Matching
;; ==============================

;; `=will` is a broader unification-based matching rule.
;; However, there is a potential issue: the removal target `(= ($f $z) $z)` does not match anything.
!(match-by =will &space-3 (= ($y $z) $z)
   (remove-atom &space-3 (= (f $z) $z)))

;; Here, we assume a mistake in the removal call, so the expected result is that `(= ($y $z) $y)` remains.
!(assertEqualToResult (get-atoms &space-3) 
	 ((= ($y $z) $y))))

