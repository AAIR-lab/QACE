
(define (domain tireworld)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location)
(:predicates (vehicle-at_1 ?v0 - location) (vehicle-at_2 ?v0 - location) (spare-in_1 ?v0 - location) (spare-in_2 ?v0 - location) (road_1 ?v0 - location ?v1 - location) (road_2 ?v0 - location ?v1 - location) (not-flattire_1) (not-flattire_2) (move-car_1 ?v0 - location ?v1 - location) (move-car_2 ?v0 - location ?v1 - location) (changetire_1 ?v0 - location) (changetire_2 ?v0 - location) (p_psi))


	(:action move-car
		:parameters (?from - location ?to - location)
		:precondition (and (not (= ?from ?to)) 
			(and (road_2 ?from ?to)
			(vehicle-at_2 ?from)
			(not-flattire_2)
			(not (vehicle-at_2 ?to))))
		:effect (and
			(p_psi))
	)
)