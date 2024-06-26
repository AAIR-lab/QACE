(define (domain cafeWorld)
    (:requirements :typing :strips :adl :equality)
    (:types
        can
        manipulator
        robot
        location
    )
    (:predicates
        (empty ?gripper - manipulator)
        (ingripper ?obj - can ?gripper - manipulator)
        (at ?loc - location ?r - robot)
        (teleported ?loc - location ?r - robot)
        (order ?obj - can ?loc - location)
    )

    (:action teleport
        :parameters (?loc - location ?r - robot)
        :precondition (and (not (teleported ?loc ?r)))
        :effect (and
            (at ?loc ?r)
            (teleported ?loc ?r)
        )
    )

    (:action move
        :parameters (?from - location ?to - location ?r - robot)
        :precondition (and (at ?from ?r))
        :effect (and
            (not (at ?from ?r))
            (at ?to ?r)
        )
    )
    
    (:action grasp
        :parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
        :precondition (and
            (empty ?g)
            (at ?loc ?r)
    		(order ?obj ?loc)
        )
        :effect (and (probabilistic
                    0.8 (and (not (empty ?g)) (ingripper ?obj ?g) (not (order ?obj ?loc)))
                    0.2 (and)
                )
        )
    )
    
    (:action put
        :parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
        :precondition(and
            (ingripper ?obj ?g)
            (at ?loc ?r)
        )
        :effect(and
            (not (ingripper ?obj ?g))
            (empty ?g)
            (order ?obj ?loc)
        )
    )
)

(define (problem p01) (:domain cafeworld)
  (:objects
        canred - can
	counter - location
	fetch - robot
	gripper - manipulator
	tablered - location
  )
  (:init 
	(at counter fetch)
	(ingripper canred gripper)
	(teleported counter fetch)
	(teleported tablered fetch)
  )
  (:goal (and
	(teleported counter fetch)
	(teleported tablered fetch)
	(at counter fetch)
	(ingripper canred gripper)))
)
