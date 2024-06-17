
(define (domain tireworld)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location)
(:predicates (vehicle-at ?v0 - location) (spare-in ?v0 - location) (road ?v0 - location ?v1 - location) (not-flattire))


	(:action move-car
		:parameters (?from - location ?to - location)
		:precondition (and (not (= ?from ?to)) 
			(and (not-flattire)
			(vehicle-at ?from)
			(road ?from ?to)))
		:effect (probabilistic 0.885714 (and
			(not (not-flattire))
			(not (vehicle-at ?from))
			(vehicle-at ?to)) 0.114286 (and
			(not (vehicle-at ?from))
			(vehicle-at ?to)) 0.000000 (and
			))
	)


	(:action changetire
		:parameters (?loc - location)
		:precondition 
			(and (vehicle-at ?loc))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)
)