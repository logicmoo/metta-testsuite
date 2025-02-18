;; Step 1: Create a new space
!(bind! &space (new-space))

;; Step 2: Add an atom to the space
!(add-atom &space (= (f $x) $x))

;; Step 3: Retrieve and verify that the atom is stored in the space
!(get-atoms &space)  ;; Expected output: (= (f $x) $x)

;; Step 4: Attempt to match and remove the atom
;; If remove-atom struggles with indexed variables (#nnn), this might not work as expected.
!(match &space (= ($y $z) $z)
   (remove-atom &space (= ($y $z) $z)))

;; Step 5: Verify if the atom was successfully removed
!(get-atoms &space)  ;; Expected: Space should be empty or unchanged if remove-atom failed


!(add-atom &space (= (f $x) $x))
!(get-atoms &space)  ;; Expected output: (= (f $x) $x)

;; Step 6: Define a function to match alpha-equivalent atoms
;; Alpha equivalence means structurally identical expressions with different variable names are considered the same.
(= (match-alpha $space $match)
  (progn
     (call! freeze $match (call! =@= $match $explorer))
      (match $space $explorer  $explorer)))

;; Step 7: Test alpha equivalence matching
!(match-alpha &space (= (f $a) $a))
;; Expected: Returns (= (f $x) $x), since $a and $x are alpha-equivalent

;; Step 8: Define a function to match using unification (i.e., allowing variable substitution)
(= (match-unifiable $space $match)
  (progn
     (call! freeze $match (not (not (call! unify $match $explorer))))
      (match $space $explorer $explorer)))

;; Step 9: Test unification-based matching
!(match-unifiable &space (= (f ?X) ?X))
;; Expected: Returns (= (f $x) $x), as ?X can unify with $x

;; Step 10: Define a more efficient version of match-unifiable using indexing
(= (match-unifiable $space $match)
  (progn
     (call! freeze $match (not (not (call! unify $match $explorer))))
      (call! same-index $match $explorer)  ;; Ensures efficient lookup
       (match $space $explorer $explorer)))

;; Step 11: Test the optimized unification function
!(match-unifiable &space (= (f ?X) ?X))
;; Expected: Returns (= (f $x) $x), but now optimized for efficiency.


