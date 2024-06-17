
(define (domain cafeworld)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types manipulator can location robot)
(:predicates (empty_1 ?v0 - manipulator) (empty_2 ?v0 - manipulator) (ingripper_1 ?v0 - can ?v1 - manipulator) (ingripper_2 ?v0 - can ?v1 - manipulator) (at_1 ?v0 - location ?v1 - robot) (at_2 ?v0 - location ?v1 - robot) (teleported_1 ?v0 - location ?v1 - robot) (teleported_2 ?v0 - location ?v1 - robot) (order_1 ?v0 - can ?v1 - location) (order_2 ?v0 - can ?v1 - location) (teleport_1 ?v0 - location ?v1 - robot) (teleport_2 ?v0 - location ?v1 - robot) (move_1 ?v0 - location ?v1 - location ?v2 - robot) (move_2 ?v0 - location ?v1 - location ?v2 - robot) (grasp_1 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (grasp_2 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (put_1 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (put_2 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (p_psi))


	(:action teleport
		:parameters (?loc - location ?r - robot)
		:precondition (and (not (= ?loc ?r)) 
			(and (not (teleported_1 ?loc ?r))))
		:effect (and
			(when (and
			(not (teleported_1 ?loc ?r))
			(not (teleported_2 ?loc ?r))) (and
			(teleported_1 ?loc ?r)
			(not (teleported_2 ?loc ?r))))
			
				(when (teleported_2 ?loc ?r) (and
			(p_psi)))
			
				(when (teleported_1 ?loc ?r) (and
			(p_psi))))
	)


	(:action teleport2
		:parameters (?loc - location ?r - robot)
		:precondition (and (not (= ?loc ?r)) 
			(and (not (teleported_2 ?loc ?r))))
		:effect (and
			(when (and
			(not (teleported_1 ?loc ?r))
			(not (teleported_2 ?loc ?r))) (and
			(teleported_1 ?loc ?r)
			(not (teleported_2 ?loc ?r))))
			
				(when (teleported_2 ?loc ?r) (and
			(p_psi)))
			
				(when (teleported_1 ?loc ?r) (and
			(p_psi))))
	)


	(:action teleport300
		:parameters (?loc - location ?r - robot)
		:precondition (and (not (= ?loc ?r)) 
			(and (teleported_1 ?loc ?r)
			(not (teleported_2 ?loc ?r))))
		:effect (and
			(p_psi))
	)
)