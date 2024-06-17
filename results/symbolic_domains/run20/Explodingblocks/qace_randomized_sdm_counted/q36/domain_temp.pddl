
(define (domain explodingblocks)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types block robot)
(:predicates (on_1 ?v0 - block ?v1 - block) (on_2 ?v0 - block ?v1 - block) (ontable_1 ?v0 - block) (ontable_2 ?v0 - block) (clear_1 ?v0 - block) (clear_2 ?v0 - block) (handempty_1 ?v0 - robot) (handempty_2 ?v0 - robot) (handfull_1 ?v0 - robot) (handfull_2 ?v0 - robot) (holding_1 ?v0 - block) (holding_2 ?v0 - block) (pick-up_1 ?v0 - block ?v1 - robot) (pick-up_2 ?v0 - block ?v1 - robot) (put-down_1 ?v0 - block ?v1 - robot) (put-down_2 ?v0 - block ?v1 - robot) (stack_1 ?v0 - block ?v1 - block ?v2 - robot) (stack_2 ?v0 - block ?v1 - block ?v2 - robot) (unstack_1 ?v0 - block ?v1 - block ?v2 - robot) (unstack_2 ?v0 - block ?v1 - block ?v2 - robot) (destroyed_1 ?v0 - block) (destroyed_2 ?v0 - block) (table-destroyed_1) (table-destroyed_2) (p_psi))


	(:action stack
		:parameters (?x - block ?y - block ?robot - robot)
		:precondition (and (not (= ?x ?y)) (not (= ?x ?robot)) (not (= ?y ?robot)) 
			(and (not (destroyed_2 ?y))
			(clear_2 ?y)
			(holding_2 ?x)
			(not (holding_2 ?y))))
		:effect (and
			(p_psi))
	)
)