
(define (domain tireworld)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location)
(:predicates (vehicle-at ?v0 - location) (spare-in ?v0 - location) (road ?v0 - location ?v1 - location) (not-flattire))


	(:action move-car
		:parameters (?from - location ?to - location)
		:precondition (and (not (= ?from ?to)) 
			(and (road ?from ?to)
			(vehicle-at ?from)
			(not-flattire)))
		:effect (probabilistic 0.685714 (and
			(not (not-flattire))
			(not (vehicle-at ?from))
			(vehicle-at ?to)) 0.314286 (and
			(not (vehicle-at ?from))
			(vehicle-at ?to)) 0.000000 (and
			))
	)


	(:action changetire
		:parameters (?loc - location)
		:precondition 
			(and (vehicle-at ?loc)
			(spare-in ?loc)
			(not (not-flattire)))
		:effect (probabilistic 1.000000 (and
			(not (spare-in ?loc))
			(not-flattire)) 0.000000 (and
			))
	)
)