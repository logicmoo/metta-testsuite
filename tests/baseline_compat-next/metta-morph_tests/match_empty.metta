!(bind! &belief_events (new-space))
!(bind! &goal_events (new-space))

!(match &belief_events $1 $1)
!(add-atom &belief_events belief1)
!(match &belief_events $1 $1)

!(assertEqualToResult
  (case belief1
    ((Empty WasEmpty)
     ))
  ())

!(assertEqualToResult
  (case (match &belief_events $1 $1)
    ((Empty WasEmpty)
     ))
  ())

!(assertEqualToResult
  (case (match &belief_events $1 $1)
    ((belief1 yes)
     (Empty WasEmpty)
     ))
  (yes))

!(assertEqualToResult
  (case (match &goal_events $1 $1)
    ((Empty WasEmpty)
     ))
  (WasEmpty))

!(assertEqualToResult
  (case (match &goal_events $1 $1)
    ((goal1 yes)
     (Empty WasEmpty)
     ))
  (WasEmpty))

!(add-atom &goal_events goal1)

!(assertEqualToResult
  (case (match &goal_events $1 $1)
    ((goal1 yes)
     (Empty WasEmpty)
     ))
  (yes))

!(assertEqualToResult
  (case (match &goal_events $1 $1)
    ((Empty WasEmpty)
     ))
  ())

