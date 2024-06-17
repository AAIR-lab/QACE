
(define (domain cafeworld)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types manipulator can location robot)
(:predicates (empty_1 ?v0 - manipulator) (empty_2 ?v0 - manipulator) (ingripper_1 ?v0 - can ?v1 - manipulator) (ingripper_2 ?v0 - can ?v1 - manipulator) (at_1 ?v0 - location ?v1 - robot) (at_2 ?v0 - location ?v1 - robot) (teleported_1 ?v0 - location ?v1 - robot) (teleported_2 ?v0 - location ?v1 - robot) (order_1 ?v0 - can ?v1 - location) (order_2 ?v0 - can ?v1 - location) (teleport_1 ?v0 - location ?v1 - robot) (teleport_2 ?v0 - location ?v1 - robot) (move_1 ?v0 - location ?v1 - location ?v2 - robot) (move_2 ?v0 - location ?v1 - location ?v2 - robot) (grasp_1 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (grasp_2 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (put_1 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (put_2 ?v0 - manipulator ?v1 - location ?v2 - can ?v3 - robot) (p_psi))


	(:action put
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (at_1 ?loc ?r)
			(ingripper_1 ?obj ?g)))
		:effect (and
			(when (and
			(at_1 ?loc ?r)
			(ingripper_1 ?obj ?g)
			(at_2 ?loc ?r)
			(ingripper_2 ?obj ?g)) (and
			(oneof (and
			(empty_1 ?g)
			(order_1 ?obj ?loc)
			(not (ingripper_1 ?obj ?g))))
			(order_1 ?obj ?loc)
			(oneof (and
			(empty_2 ?g)
			(order_2 ?obj ?loc)
			(not (ingripper_2 ?obj ?g))))
			(not (order_2 ?obj ?loc))))
			
				(when (not (at_2 ?loc ?r)) (and
			(p_psi)))
				(when (not (ingripper_2 ?obj ?g)) (and
			(p_psi)))
			
				(when (not (at_1 ?loc ?r)) (and
			(p_psi)))
				(when (not (ingripper_1 ?obj ?g)) (and
			(p_psi))))
	)


	(:action put2
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (at_2 ?loc ?r)
			(ingripper_2 ?obj ?g)))
		:effect (and
			(when (and
			(at_1 ?loc ?r)
			(ingripper_1 ?obj ?g)
			(at_2 ?loc ?r)
			(ingripper_2 ?obj ?g)) (and
			(oneof (and
			(empty_1 ?g)
			(order_1 ?obj ?loc)
			(not (ingripper_1 ?obj ?g))))
			(order_1 ?obj ?loc)
			(oneof (and
			(empty_2 ?g)
			(order_2 ?obj ?loc)
			(not (ingripper_2 ?obj ?g))))
			(not (order_2 ?obj ?loc))))
			
				(when (not (at_2 ?loc ?r)) (and
			(p_psi)))
				(when (not (ingripper_2 ?obj ?g)) (and
			(p_psi)))
			
				(when (not (at_1 ?loc ?r)) (and
			(p_psi)))
				(when (not (ingripper_1 ?obj ?g)) (and
			(p_psi))))
	)


	(:action put300
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (order_1 ?obj ?loc)
			(not (order_2 ?obj ?loc))))
		:effect (and
			(p_psi))
	)
)