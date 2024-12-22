!(bind! &belief_events (new-space))
!(bind! &goal_events (new-space))
!(match &belief_events $1 $1)
!(add-atom &belief_events belief1)
!(match &belief_events $1 $1)
!(case belief1
    ((Empty 42
      )))
!(case (match &belief_events $1 $1)
    ((Empty 42
      )))
!(assertEqualToResult (case (match &belief_events $1 $1)
    ((belief1 yes) (Empty 42
     ))) (yes))
!(assertEqualToResult (case (match &goal_events $1 $1)
   ((Empty 42
   ))) (42))
!(assertEqualToResult (case (match &goal_events $1 $1)
  ((goal1 yes)
    (Empty
      42))) (42))
!(add-atom &goal_events goal1)
!(assertEqualToResult (case (match &goal_events $1 $1)
   ((goal1 yes) (Empty
     42))) (yes))
!(assertEqualToResult (case (match &goal_events $1 $1) ((
  Empty 42
  ))) ())

