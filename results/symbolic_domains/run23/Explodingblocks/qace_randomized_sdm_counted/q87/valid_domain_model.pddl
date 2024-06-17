
(define (domain explodingblocks)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types block robot)
(:predicates (on ?v0 - block ?v1 - block) (ontable ?v0 - block) (clear ?v0 - block) (handempty ?v0 - robot) (handfull ?v0 - robot) (holding ?v0 - block) (destroyed ?v0 - block) (table-destroyed))


	(:action pick-up
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and (clear ?x)
			(not (destroyed ?x))
			(handempty ?robot)
			(ontable ?x)
			(not (table-destroyed))))
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
			(and (holding ?x)
			(not (table-destroyed))
			(handfull ?robot)))
		:effect (probabilistic 0.960000 (and
			(not (handfull ?robot))
			(not (holding ?x))
			(clear ?x)
			(handempty ?robot)
			(ontable ?x)) 0.040000 (and
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
			(and (holding ?x)
			(not (table-destroyed))
			(not (destroyed ?y))
			(handfull ?robot)
			(clear ?y)))
		:effect (probabilistic 0.880000 (and
			(not (clear ?y))
			(not (handfull ?robot))
			(not (holding ?x))
			(clear ?x)
			(handempty ?robot)
			(on ?x ?y)) 0.120000 (and
			(not (clear ?y))
			(not (handfull ?robot))
			(not (holding ?x))
			(clear ?x)
			(destroyed ?y)
			(handempty ?robot)
			(on ?x ?y)) 0.000000 (and
			))
	)


	(:action unstack
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and (on ?x ?y)))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)
)