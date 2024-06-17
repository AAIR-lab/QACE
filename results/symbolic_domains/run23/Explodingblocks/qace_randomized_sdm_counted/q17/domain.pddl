
(define (domain explodingblocks)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types block robot)
(:predicates (on_1 ?v0 - block ?v1 - block) (on_2 ?v0 - block ?v1 - block) (ontable_1 ?v0 - block) (ontable_2 ?v0 - block) (clear_1 ?v0 - block) (clear_2 ?v0 - block) (handempty_1 ?v0 - robot) (handempty_2 ?v0 - robot) (handfull_1 ?v0 - robot) (handfull_2 ?v0 - robot) (holding_1 ?v0 - block) (holding_2 ?v0 - block) (pick-up_1 ?v0 - block ?v1 - robot) (pick-up_2 ?v0 - block ?v1 - robot) (put-down_1 ?v0 - block ?v1 - robot) (put-down_2 ?v0 - block ?v1 - robot) (stack_1 ?v0 - block ?v1 - block ?v2 - robot) (stack_2 ?v0 - block ?v1 - block ?v2 - robot) (unstack_1 ?v0 - block ?v1 - block ?v2 - robot) (unstack_2 ?v0 - block ?v1 - block ?v2 - robot) (destroyed_1 ?v0 - block) (destroyed_2 ?v0 - block) (table-destroyed_1) (table-destroyed_2) (p_psi))


	(:action pick-up
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and (clear_1 ?x)
			(not (destroyed_1 ?x))
			(handempty_1 ?robot)
			(ontable_1 ?x)
			(not (table-destroyed_1))))
		:effect (and
			(when (and
			(clear_1 ?x)
			(not (destroyed_1 ?x))
			(handempty_1 ?robot)
			(ontable_1 ?x)
			(not (table-destroyed_1))
			(clear_2 ?x)
			(not (destroyed_2 ?x))
			(handempty_2 ?robot)
			(ontable_2 ?x)
			(not (table-destroyed_2))) (and
			(oneof (and
			(not (clear_1 ?x))
			(handfull_1 ?robot)
			(holding_1 ?x)
			(not (handempty_1 ?robot))
			(not (ontable_1 ?x))))
			(handempty_1 ?robot)
			(oneof (and
			(not (clear_2 ?x))
			(handfull_2 ?robot)
			(holding_2 ?x)
			(not (handempty_2 ?robot))
			(not (ontable_2 ?x))))
			(not (handempty_2 ?robot))))
			
				(when (not (clear_2 ?x)) (and
			(p_psi)))
				(when (destroyed_2 ?x) (and
			(p_psi)))
				(when (not (handempty_2 ?robot)) (and
			(p_psi)))
				(when (not (ontable_2 ?x)) (and
			(p_psi)))
				(when (table-destroyed_2) (and
			(p_psi)))
			
				(when (not (clear_1 ?x)) (and
			(p_psi)))
				(when (destroyed_1 ?x) (and
			(p_psi)))
				(when (not (handempty_1 ?robot)) (and
			(p_psi)))
				(when (not (ontable_1 ?x)) (and
			(p_psi)))
				(when (table-destroyed_1) (and
			(p_psi))))
	)


	(:action put-down
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action stack
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action unstack
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action pick-up2
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and (clear_2 ?x)
			(not (destroyed_2 ?x))
			(handempty_2 ?robot)
			(ontable_2 ?x)
			(not (table-destroyed_2))))
		:effect (and
			(when (and
			(clear_1 ?x)
			(not (destroyed_1 ?x))
			(handempty_1 ?robot)
			(ontable_1 ?x)
			(not (table-destroyed_1))
			(clear_2 ?x)
			(not (destroyed_2 ?x))
			(handempty_2 ?robot)
			(ontable_2 ?x)
			(not (table-destroyed_2))) (and
			(oneof (and
			(not (clear_1 ?x))
			(handfull_1 ?robot)
			(holding_1 ?x)
			(not (handempty_1 ?robot))
			(not (ontable_1 ?x))))
			(handempty_1 ?robot)
			(oneof (and
			(not (clear_2 ?x))
			(handfull_2 ?robot)
			(holding_2 ?x)
			(not (handempty_2 ?robot))
			(not (ontable_2 ?x))))
			(not (handempty_2 ?robot))))
			
				(when (not (clear_2 ?x)) (and
			(p_psi)))
				(when (destroyed_2 ?x) (and
			(p_psi)))
				(when (not (handempty_2 ?robot)) (and
			(p_psi)))
				(when (not (ontable_2 ?x)) (and
			(p_psi)))
				(when (table-destroyed_2) (and
			(p_psi)))
			
				(when (not (clear_1 ?x)) (and
			(p_psi)))
				(when (destroyed_1 ?x) (and
			(p_psi)))
				(when (not (handempty_1 ?robot)) (and
			(p_psi)))
				(when (not (ontable_1 ?x)) (and
			(p_psi)))
				(when (table-destroyed_1) (and
			(p_psi))))
	)


	(:action pick-up300
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and (handempty_1 ?robot)
			(not (handempty_2 ?robot))))
		:effect (and
			(p_psi))
	)


	(:action put-down2
		:parameters (?x - block ?robot - robot)
		:precondition (and (not (= ?x ?robot)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action stack2
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action unstack2
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)
)