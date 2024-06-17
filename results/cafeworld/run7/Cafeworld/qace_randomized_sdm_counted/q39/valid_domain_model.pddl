
(define (domain cafeworld)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types manipulator can location robot)
(:predicates (empty ?v0 - manipulator) (ingripper ?v0 - can ?v1 - manipulator) (at ?v0 - location ?v1 - robot) (teleported ?v0 - location ?v1 - robot) (order ?v0 - can ?v1 - location))


	(:action teleport
		:parameters (?loc - location ?r - robot)
		:precondition (and (not (= ?loc ?r)) 
			(and (not (teleported ?loc ?r))))
		:effect (probabilistic 1.000000 (and
			(at ?loc ?r)
			(teleported ?loc ?r)) 0.000000 (and
			))
	)


	(:action move
		:parameters (?from - location ?to - location ?r - robot)
		:precondition (and (not (= ?from ?to)) (not (= ?from ?r)) (not (= ?to ?r)) 
			(and (at ?from ?r)))
		:effect (probabilistic 1.000000 (and
			(not (at ?from ?r))
			(at ?to ?r)) 0.000000 (and
			))
	)


	(:action grasp
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (order ?obj ?loc)
			(at ?loc ?r)
			(empty ?g)))
		:effect (probabilistic 0.772727 (and
			(not (empty ?g))
			(not (order ?obj ?loc))
			(ingripper ?obj ?g)) 0.227273 (and
			))
	)


	(:action put
		:parameters (?g - manipulator ?loc - location ?obj - can ?r - robot)
		:precondition (and (not (= ?g ?loc)) (not (= ?g ?obj)) (not (= ?g ?r)) (not (= ?loc ?obj)) (not (= ?loc ?r)) (not (= ?obj ?r)) 
			(and (at ?loc ?r)))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)
)