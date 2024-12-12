(:object a)
(:object b)
(:init (
    (on-table a) 
    (on-table b)  
    (clear a)  (clear b) 
    (arm-empty)
))

(:goal (And (
    (on a b)
)))


(:action pickup 
    :parameters ($x)
    :precondition (And ((clear $x) (on-table $x) (arm-empty)))
    :effect (And ((holding $x) (Not (clear $x)) 
        (Not (on-table $x)) (Not (arm-empty)))
    )
)
(:action putdown
    :parameters ($x)
    :precondition (And ((holding $x)))
    :effect (And ((clear $x) (arm-empty) (on-table $x)
        (Not (holding $x))))
)

(:action stack
    :parameters ($x $y)
    :precondition (And (
        (clear $y) (holding $x)
    ))
    :effect (And (
        (arm-empty) (clear $x) (on $x $y) 
        (Not (clear $y)) (Not (holding $x))
    ))
)

(:action unstack
    :parameters ($x $y)
    :precondition (And ((on $x $y) (clear $x) (arm-empty)))
    :effect (And (
        (holding $x) (clear $y) (Not (on $x $y))
        (Not (clear $x)) (Not (arm-empty))
    ))
)