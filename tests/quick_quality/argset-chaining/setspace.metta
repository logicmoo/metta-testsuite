!(import! &self utils)
;; A pure MeTTa implementation of lookup_all_subsets for a trie-based set space.
;;
;; A trie node is represented as an expression: (trie <value> <children>)
;; where <value> is an optional atom (use () when there is no value),
;; and <children> is a space wrappend in a state
;; The space contains elements of the form (child <key> <child>), where <key> is a symbol and <child> is a trie node.

;; Create a new setspace. With no arguments, returns an empty setspace.

;;Because mettalog eliminates duplicates
(= (create-setspace)
 (trie () (new-state (new-space))))

;There is no way to remove an atom from a space based on unification
;This is a workaround that copies all other atoms to a new space
;Requires that the space is wrapped in a state
(= (removeUnify $space $atom)
 (let $nspace (new-space)
  (let $selems (collapse (get-atoms (get-state $space)))
   (let $res (foldl-atom $selems () $accum $selem (let $_ $accum (unify $atom $selem () (add-atom $nspace $selem))))
    (change-state! $space $nspace)))))

;;Add an atom to a space wrapped in a state
(= (add-atom2 $space $atoms)
   (add-atom (get-state $space) $atoms))

;; Insert function: insert-setspace
(= (insert-setspace (trie $old_val $children) $keys $new_val)
 (if-decons-expr $keys $key $rest
  (let $insert (insert-child $children $key $rest $new_val) (trie $old_val $children))
  (trie (cons-atom $new_val $old_val) $children)))

(= (insert-child $children $key $rest $new_val)
(case (sealed $key (let $s (get-state $children) (collapse (unify $s (child $key $child) (child $key $child) Empty))))
 ( (Empty (insert-new-child $children $key $rest $new_val))
   ($matches (insert-possible-match $children $matches $key $rest $new_val))
 )))

(= (insert-possible-match $children $matches $key $rest $new_val)
   (if-decons-expr $matches $match $rest_matches
      (let (child $rkey $child) $match
         (if (=alpha $key $rkey) ;Alpha equivalent keys are merged
            (let $new_child (child $key (insert-setspace $child $rest $new_val))
               (let $rm (removeUnify $children (child $key $child))
                  (add-atom2 $children $new_child)))
            (insert-possible-match $children $rest_matches $key $rest $new_val)))
      (insert-new-child $children $key $rest $new_val)))

(= (insert-new-child $children $key $rest $new_val)
   (let $child (insert-setspace (create-setspace) $rest $new_val)
     (add-atom2 $children (child $key $child))
     ))


;;Convert a trie to a string
(= (sstostring (trie $value $children))
  (trie $value (collapse (let $s (get-state $children) (unify $s (child $key $child) (child $key (sstostring $child)) ())))))

;; Main function: lookup_all_subsets
(= (lookup-all-subsets (trie $value $children) $query)
 (let $recurse (lookup-all-subsets-children $children $query)
  (munion-atom $value $recurse)))

;; Traverse the children list of a trie node.
(= (lookup-all-subsets-children $children $query)
 (if-decons-expr $query $key $rest
  (let $a (lookup-all-subsets-children $children $rest)
    (let $b (let $s (get-state $children) (collapse (unify $s (child $key $child) (lookup-all-subsets $child $rest) ())))
      (munion-atom $a $b)))
  ()))


!(time 
 (let* ( ($s1 (create-setspace))
		 ($s2 (insert-setspace $s1 ((: $a1 A)) (: $a1 A1)))
		 ($s3 (insert-setspace $s2 ((: $a2 A)) (: $a2 A2)))
		 ($s4 (insert-setspace $s3 ((: $t $T)) (: $t T)))
		 ($rr (lookup-all-subsets $s4 ((: a B))))
	   )
   (  (sstostring $s4) $rr)))


