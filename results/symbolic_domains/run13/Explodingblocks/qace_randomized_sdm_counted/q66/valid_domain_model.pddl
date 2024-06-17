
(define (domain explodingblocks)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types block robot)
(:predicates (on ?v0 - block ?v1 - block) (ontable ?v0 - block) (clear ?v0 - block) (handempty ?v0 - robot) (handfull ?v0 - robot) (holding ?v0 - block) (destroyed ?v0 - block) (table-destroyed))


	(:action pick-up
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and (not (table-destroyed))
			(handempty ?robot)
			(clear ?x)
			(ontable ?x)
			(not (destroyed ?x))))
		:effect (probabilistic 1.000000 (and
			(not (clear ?x))
			(not (handempty ?robot))
			(not (ontable ?x))
			(handfull ?robot)
			(holding ?x)) 0.000000 (and
			))
	)


	(:action put-down
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and (not (table-destroyed))
			(holding ?x)
			(handfull ?robot)))
		:effect (probabilistic 0.800000 (and
			(not (handfull ?robot))
			(not (holding ?x))
			(clear ?x)
			(handempty ?robot)
			(ontable ?x)) 0.200000 (and
			(not (handfull ?robot))
			(not (holding ?x))
			(clear ?x)
			(handempty ?robot)
			(ontable ?x)
			(table-destroyed)) 0.000000 (and
			))
	)


	(:action stack
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and (clear ?y)
			(not (destroyed ?y))
			(not (table-destroyed))
			(holding ?x)))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)


	(:action unstack
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and ))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)
)