
(define (domain tireworld)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location)
(:predicates (vehicle-at_1 ?v0 - location) (vehicle-at_2 ?v0 - location) (spare-in_1 ?v0 - location) (spare-in_2 ?v0 - location) (road_1 ?v0 - location ?v1 - location) (road_2 ?v0 - location ?v1 - location) (not-flattire_1) (not-flattire_2) (move-car_1 ?v0 - location ?v1 - location) (move-car_2 ?v0 - location ?v1 - location) (changetire_1 ?v0 - location) (changetire_2 ?v0 - location) (p_psi))


	(:action move-car
		:parameters (?from - location ?to - location)
		:precondition (and (not (= ?from ?to)) 
			(and (not-flattire_1)
			(road_1 ?from ?to)
			(vehicle-at_1 ?from)))
		:effect (and
			(when (and
			(not-flattire_1)
			(road_1 ?from ?to)
			(vehicle-at_1 ?from)
			(not-flattire_2)
			(road_2 ?from ?to)
			(vehicle-at_2 ?from)) (and
			(oneof (and
			(not (not-flattire_1))
			(vehicle-at_1 ?to)
			(not (vehicle-at_1 ?from))) (and
			(vehicle-at_1 ?to)
			(not (vehicle-at_1 ?from))))
			(oneof (and
			(not (not-flattire_2))
			(vehicle-at_2 ?to)
			(not (vehicle-at_2 ?from))) (and
			(vehicle-at_2 ?to)
			(not (vehicle-at_2 ?from)))))))
	)


	(:action changetire
		:parameters (?loc - location)
		:precondition 
			(and (spare-in_1 ?loc)
			(vehicle-at_1 ?loc)
			(not (not-flattire_1)))
		:effect (and
			(when (and
			(spare-in_1 ?loc)
			(vehicle-at_1 ?loc)
			(not (not-flattire_1))
			(spare-in_2 ?loc)
			(vehicle-at_2 ?loc)
			(not (not-flattire_2))) (and
			(oneof (and
			(not-flattire_1)
			(not (spare-in_1 ?loc))))
			(spare-in_1 ?loc)
			(oneof (and
			(not-flattire_2)
			(not (spare-in_2 ?loc))))
			(not (spare-in_2 ?loc))))
			
				(when (not (spare-in_2 ?loc)) (and
			(p_psi)))
				(when (not (vehicle-at_2 ?loc)) (and
			(p_psi)))
				(when (not-flattire_2) (and
			(p_psi)))
			
				(when (not (spare-in_1 ?loc)) (and
			(p_psi)))
				(when (not (vehicle-at_1 ?loc)) (and
			(p_psi)))
				(when (not-flattire_1) (and
			(p_psi))))
	)


	(:action move-car2
		:parameters (?from - location ?to - location)
		:precondition (and (not (= ?from ?to)) 
			(and (not-flattire_2)
			(road_2 ?from ?to)
			(vehicle-at_2 ?from)))
		:effect (and
			(when (and
			(not-flattire_1)
			(road_1 ?from ?to)
			(vehicle-at_1 ?from)
			(not-flattire_2)
			(road_2 ?from ?to)
			(vehicle-at_2 ?from)) (and
			(oneof (and
			(not (not-flattire_1))
			(vehicle-at_1 ?to)
			(not (vehicle-at_1 ?from))) (and
			(vehicle-at_1 ?to)
			(not (vehicle-at_1 ?from))))
			(oneof (and
			(not (not-flattire_2))
			(vehicle-at_2 ?to)
			(not (vehicle-at_2 ?from))) (and
			(vehicle-at_2 ?to)
			(not (vehicle-at_2 ?from)))))))
	)


	(:action changetire2
		:parameters (?loc - location)
		:precondition 
			(and (spare-in_2 ?loc)
			(vehicle-at_2 ?loc)
			(not (not-flattire_2)))
		:effect (and
			(when (and
			(spare-in_1 ?loc)
			(vehicle-at_1 ?loc)
			(not (not-flattire_1))
			(spare-in_2 ?loc)
			(vehicle-at_2 ?loc)
			(not (not-flattire_2))) (and
			(oneof (and
			(not-flattire_1)
			(not (spare-in_1 ?loc))))
			(spare-in_1 ?loc)
			(oneof (and
			(not-flattire_2)
			(not (spare-in_2 ?loc))))
			(not (spare-in_2 ?loc))))
			
				(when (not (spare-in_2 ?loc)) (and
			(p_psi)))
				(when (not (vehicle-at_2 ?loc)) (and
			(p_psi)))
				(when (not-flattire_2) (and
			(p_psi)))
			
				(when (not (spare-in_1 ?loc)) (and
			(p_psi)))
				(when (not (vehicle-at_1 ?loc)) (and
			(p_psi)))
				(when (not-flattire_1) (and
			(p_psi))))
	)


	(:action changetire300
		:parameters (?loc - location)
		:precondition 
			(and (spare-in_1 ?loc)
			(not (spare-in_2 ?loc)))
		:effect (and
			(p_psi))
	)
)