
(define (domain explodingblocks)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types block robot)
(:predicates (on ?v0 - block ?v1 - block) (ontable ?v0 - block) (clear ?v0 - block) (handempty ?v0 - robot) (handfull ?v0 - robot) (holding ?v0 - block) (destroyed ?v0 - block) (table-destroyed))


	(:action pick-up
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and (not (destroyed ?x))
			(clear ?x)
			(not (table-destroyed))
			(ontable ?x)
			(handempty ?robot)))
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
			(and (handfull ?robot)
			(holding ?x)
			(not (table-destroyed))))
		:effect (probabilistic 0.880000 (and
			(not (handfull ?robot))
			(not (holding ?x))
			(clear ?x)
			(handempty ?robot)
			(ontable ?x)) 0.120000 (and
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
			(and (not (destroyed ?y))
			(clear ?y)
			(not (table-destroyed))
			(handfull ?robot)
			(holding ?x)))
		:effect (probabilistic 0.909091 (and
			(not (clear ?y))
			(not (handfull ?robot))
			(not (holding ?x))
			(clear ?x)
			(handempty ?robot)
			(on ?x ?y)) 0.090909 (and
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
			(and (not (destroyed ?x))
			(clear ?x)))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)
)