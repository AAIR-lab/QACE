
(define (domain cafeworld)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types manipulator can location robot)
(:predicates (empty_1 ?v0 - manipulator) (empty_2 ?v0 - manipulator) (ingripper_1 ?v0 - can ?v1 - manipulator) (ingripper_2 ?v0 - can ?v1 - manipulator) (at_1 ?v0 - location ?v1 - robot) (at_2 ?v0 - location ?v1 - robot) (teleported_1 ?v0 - location ?v1 - robot) (teleported_2 ?v0 - location ?v1 - robot) (order_1 ?v0 - can ?v1 - location) (order_2 ?v0 - can ?v1 - location) (teleport_1 ?v0 - location ?v1 - robot) (teleport_2 ?v0 - location ?v1 - robot) (move_1 ?v0 - location ?v1 - location ?v2 - robot) (move_2 ?v0 - location ?v1 - location ?v2 - robot) (grasp_1 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (grasp_2 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (put_1 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (put_2 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (p_psi))


	(:action grasp
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (empty_1 ?g)
			(order_1 ?obj ?loc)
			(at_1 ?loc ?r)))
		:effect (and
			(when (and
			(empty_1 ?g)
			(order_1 ?obj ?loc)
			(at_1 ?loc ?r)
			(empty_2 ?g)
			(order_2 ?obj ?loc)
			(at_2 ?loc ?r)) (and
			(oneof (and
			(ingripper_1 ?obj ?g)
			(not (empty_1 ?g))
			(not (order_1 ?obj ?loc))))
			(teleported_1 ?loc ?r)
			(oneof (and
			(ingripper_2 ?obj ?g)
			(not (empty_2 ?g))
			(not (order_2 ?obj ?loc))))
			(not (teleported_2 ?loc ?r))))
			
				(when (not (empty_2 ?g)) (and
			(p_psi)))
				(when (not (order_2 ?obj ?loc)) (and
			(p_psi)))
				(when (not (at_2 ?loc ?r)) (and
			(p_psi)))
			
				(when (not (empty_1 ?g)) (and
			(p_psi)))
				(when (not (order_1 ?obj ?loc)) (and
			(p_psi)))
				(when (not (at_1 ?loc ?r)) (and
			(p_psi))))
	)


	(:action grasp2
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (empty_2 ?g)
			(order_2 ?obj ?loc)
			(at_2 ?loc ?r)))
		:effect (and
			(when (and
			(empty_1 ?g)
			(order_1 ?obj ?loc)
			(at_1 ?loc ?r)
			(empty_2 ?g)
			(order_2 ?obj ?loc)
			(at_2 ?loc ?r)) (and
			(oneof (and
			(ingripper_1 ?obj ?g)
			(not (empty_1 ?g))
			(not (order_1 ?obj ?loc))))
			(teleported_1 ?loc ?r)
			(oneof (and
			(ingripper_2 ?obj ?g)
			(not (empty_2 ?g))
			(not (order_2 ?obj ?loc))))
			(not (teleported_2 ?loc ?r))))
			
				(when (not (empty_2 ?g)) (and
			(p_psi)))
				(when (not (order_2 ?obj ?loc)) (and
			(p_psi)))
				(when (not (at_2 ?loc ?r)) (and
			(p_psi)))
			
				(when (not (empty_1 ?g)) (and
			(p_psi)))
				(when (not (order_1 ?obj ?loc)) (and
			(p_psi)))
				(when (not (at_1 ?loc ?r)) (and
			(p_psi))))
	)


	(:action grasp300
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (teleported_1 ?loc ?r)
			(not (teleported_2 ?loc ?r))))
		:effect (and
			(p_psi))
	)
)