
;; TODO: how to levarage native MeTTa for typing?

;; (State id fluent) ;; only true fluent

;; check satisfaction of a ground formula

!(import! &kb task2) ;; Hyperon requires to be at the top

(= (formula-satisfaction $stateId (Not $expr))
    (not (formula-satisfaction $stateId $expr))
)
(= (formula-satisfaction $stateId (Or $exprList))
    (if (== $exprList ())
        False
        (let* (
            (($head $rest) (decons-atom $exprList))
            ($v (formula-satisfaction $stateId $head))
            ) (if $v True (or $v (formula-satisfaction $stateId (Or $rest)))))
    )
)
(= (formula-satisfaction $stateId (And $exprList))
    (if (== $exprList ())
        True
        (let* (
            (($head $rest) (decons-atom $exprList))
            ($v (formula-satisfaction $stateId $head))
            ) (if (not $v) False (and $v (formula-satisfaction $stateId (And $rest)))))
    )
)

(= (formula-satisfaction $stateId $expr) ;; base case, match positive fluent
    (case $expr (
        ((And $x) (empty))
        ((Or $x) (empty))
        ((Not $x) (empty))
        ($1 (let $all (collapse (match &kb (State $stateId $expr) True))
                (if (== $all ()) False True)))
    ))
)

;; check if an action is applicable in a state
(= (action-applicable $stateId $actionId $args)
    (match &kb (:action $actionId
            :parameters $params 
            :precondition $preds 
            :effect $effs
    )  (unf $args $params 
            (formula-satisfaction $stateId $preds) 
            (Error $params FailedUnification)))
)

;; (:object x) TODO: object typing, how to only extract objects with potential updating? in a state?
;; all possible grounding for a variable ~ objects
(= (args-combination $params)
    (if (== $params ()) ()
        (let* (
            (($1 $rest) (decons-atom $params))
            ($h (match &kb (:object $o) $o))
            ($r (args-combination $rest))
        ) (cons-atom $h $r))
    )
)

;; for each action & combination of args, try if its precondition is satisfied in state
(= (actions-applicable $stateId)
    (match &kb (:action $actionId
            :parameters $params 
            :precondition $preds 
            :effect $effs
    ) (let* (
        ($args (args-combination $params))
        ($1 (unf $args $params True (Error $params FailedUnification)))
        ) (if (formula-satisfaction $stateId $preds) ($actionId $params) (empty))
    ))
)

(= (action-applyEffect $actionId $args)
    (match &kb (:action $actionId
            :parameters $params 
            :precondition $preds 
            :effect $effs
    ) (unf $args $params $effs FailedUnification))
)

(= (signed-fluents $list)
    (if (== $list ())
        (() ())
        (let* (
            (($h $rest) (decons-atom $list))
            (($pos $neg) (signed-fluents $rest))
            (($isNeg $f) (unf $h (Not $v) (True $v) (False $h)))
        ) (if $isNeg 
            ($pos (cons-atom $f $neg))
            ((cons-atom $f $pos) $neg)
        ))
    )
)

;; diffing algorithm? 
(= (state-diff $allStates $diffs)
    (let* (
        ((And $d) $diffs)
        (($pos $neg) (signed-fluents $d))
        ($s1 (collapse (subtraction  ;; remove negative fluents
            (superpose $allStates)
            (superpose $neg)
        )))
        ($s2 (collapse (union  ;; add any positive fluents
            (superpose $s1)
            (superpose $pos)
        )))
    )  $s2)
)

;; a list of atom to add for the next non-determinisitc state (out of all possible states)
(= (state-transition $stateId) 
    (let* (
        (($actionId $args) (actions-applicable $stateId))
        ($effsDiff (action-applyEffect $actionId $args))
        ($stsEffs (collapse (match &kb (State $stateId $form) $form)))
        ($newState (state-diff $stsEffs $effsDiff))
    ) 
        ; $newState
        (if (== $newState ()) 
            (Error ($stateId $effsDiff $stsEffs) "Empty State") 
            (($actionId $args)  $newState)
        )
    )
)

(= (state-visited? $stateFluents)
    (if (== $stateFluents ()) ()
        (let* (
            (($h $rest) (decons-atom $stateFluents))
            ($included (collapse (match &kb (State $id $h) $id)))
        ) (if (== $rest ()) 
            $included 
            (let $other (state-visited? $rest) (L-intersection $included $other))
        ))
    )
)
(= (state-visited $stateId)
    (let $fs (collapse (match &kb (State $stateId $form) $form))
        (state-visited? $fs)
    )
)

(= (state-enqueued? $stateId)
    (let $s (collapse (match &kb (State $stateId $f) $stateId))
        (if (== $s ()) False True)
    )
)

(= (goal-satisfied $stateId)
    (match &kb (:goal $expr) (formula-satisfaction $stateId $expr))
)

(= (retrace-steps $toStateId)
    (if (== $toStateId 0)
        ()
        (let* (
            (($fromId $action $args) (match &kb 
                    (Succ $fromId ($action $args) $toStateId)
                    ($fromId $action $args)))
            ($prevSteps (retrace-steps $fromId))
        ) (L-push-back $prevSteps ($action $args)))
    )
)

;; Performance note: use space for global state versus pass as arguments, 
;; depends on complexity of (match)
;; TODO: match in space versus list

!(import! &self alist)

(= (add-state-fluents! $stateId $fluents)
    (if (== $fluents ())
        ()
        (let* (
            (($h $rest) (decons-atom $fluents))
            (() (add-atom &kb (State $stateId $h)))
        ) (add-state-fluents! $stateId $rest))
    )
)

;; states = [(fluents) (fluents2)]
;; for each next state, add its fluents and enqueue id
(= (enqueue-next-states! $fromID $states $nextUID)
    (if (== $states ())
        $nextUID
        (let* (
            (($state $rest) (decons-atom $states))
            ((($action $args) $stateFluents) $state)
            ($visited (state-visited? $stateFluents))
        ) (if (== $visited ())  
            (let* (
                (() (add-state-fluents! $nextUID $stateFluents))
                (() (add-atom &kb (Succ $fromID ($action $args) $nextUID)))
                (() (println! (ENQUEUED $nextUID)))
                ($id (+ $nextUID 1))
            ) (enqueue-next-states! $fromID $rest $id))

            (enqueue-next-states! $fromID $rest $nextUID)) ;; skipped
        ))
)

(= (fw-state-search $curState $nextUID $statesLimit) ;; CHECK VISITED STATE?
    
    (let () 
            ; ()
            (println! 
                (Processing $curState 
                    (collapse (match &kb (State $curState $f) $f))
                    (collapse (match &kb (Succ $from ($action $args) $curState) ($from ($action $args))))
                    ; (state-visited $curState)
                ))
        (if (not (state-enqueued? $curState)) FailedToReachGoal
        (if (goal-satisfied $curState) (retrace-steps $curState)
        (if (> $curState $statesLimit)  (Error $statesLimit "Limit of states exploration reached.")   
        (let* (
            ($nextStates (collapse (state-transition $curState)))
            ($uid (enqueue-next-states! $curState $nextStates $nextUID))
            ($nextFront (+ $curState 1))
        ) (fw-state-search $nextFront $uid $statesLimit)))))
    )
)

(= (planner-main $statesLimit)
    (let* (
        ($initState ((None None) (match &kb (:init $f) $f)))
        ($nextUID (enqueue-next-states! -1 ($initState) 0))
    ) 
    ; ()
    (fw-state-search 0 $nextUID $statesLimit)
    )
)

;; NEXT: modularize space

;; work around for unify predicate
(= (unf $x $y $s $f)
    (let $unf (collapse 
        (let $x $y True)
    ) (if (== $unf ()) $f (let $x $y $s)))
)

;; state fluents must all be grounded, TODO: semantics for non-ground state?
; !(add-atom &kb (State 1 (clear b))) 
; !(add-atom &kb (State 1 (on-table b)))
; !(add-atom &kb (State 1 (arm-empty)))
; !(state-visited? ((clear b) (on-table b) (arm-empty)))

; !(formula-satisfaction 1 (clear b))
; !(formula-satisfaction 1 (Not (holding b)))
; !(formula-satisfaction 1 (Or ((clear b) (holding b))))
; !(formula-satisfaction 1 (And ((clear b) (Not (holding b)))))
; !(formula-satisfaction 1 
;     (Or ((arm-empty) (And ((holding b) (clear b)))))
; )

; !(action-applicable 1 pickup (b))
; !(action-applicable 1 putdown (b))
; !(actions-applicable 1)

; !(state-transition 1)
; !(import! &kb domain) ;; Hyperon doesn't allow for importing multiple files into same space
!(planner-main 100)

