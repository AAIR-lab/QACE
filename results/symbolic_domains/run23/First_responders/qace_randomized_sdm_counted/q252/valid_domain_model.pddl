
(define (domain first-response)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location victim fire_unit medical_unit)
(:predicates (fire ?v0 - location) (nfire ?v0 - location) (victim-at ?v0 - victim ?v1 - location) (victim-healthy ?v0 - victim) (victim-hurt ?v0 - victim) (victim-dying ?v0 - victim) (hospital ?v0 - location) (water-at ?v0 - location) (adjacent ?v0 - location ?v1 - location) (fire-unit-at ?v0 - fire_unit ?v1 - location) (medical-unit-at ?v0 - medical_unit ?v1 - location) (have-water ?v0 - fire_unit) (have-victim-in-unit ?v0 - victim ?v1 - medical_unit))


	(:action drive-fire-unit
		:parameters (?u - fire_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and (not (fire ?to))
			(adjacent ?to ?from)
			(fire-unit-at ?u ?from)))
		:effect (probabilistic 1.000000 (and
			(not (fire-unit-at ?u ?from))
			(fire-unit-at ?u ?to)) 0.000000 (and
			))
	)


	(:action drive-medical-unit
		:parameters (?u - medical_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and (medical-unit-at ?u ?from)
			(not (fire ?to))
			(adjacent ?to ?from)))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)


	(:action load-fire-unit
		:parameters (?u - fire_unit ?l - location)
		:precondition (and (not (= ?u ?l)) 
			(and (water-at ?l)
			(fire-unit-at ?u ?l)
			(not (have-water ?u))))
		:effect (probabilistic 1.000000 (and
			(have-water ?u)) 0.000000 (and
			))
	)


	(:action load-medical-unit
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (medical-unit-at ?u ?l)
			(victim-at ?v ?l)))
		:effect (probabilistic 1.000000 (and
			(not (victim-at ?v ?l))
			(have-victim-in-unit ?v ?u)) 0.000000 (and
			))
	)


	(:action unload-fire-unit
		:parameters (?u - fire_unit ?l - location ?l1 - location)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?l1)) (not (= ?l ?l1)) 
			(and (have-water ?u)
			(fire-unit-at ?u ?l)
			(fire ?l1)
			(adjacent ?l1 ?l)))
		:effect (probabilistic 1.000000 (and
			(not (fire ?l1))
			(not (have-water ?u))
			(nfire ?l1)) 0.000000 (and
			))
	)


	(:action unload-medical-unit
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (medical-unit-at ?u ?l)
			(have-victim-in-unit ?v ?u)))
		:effect (probabilistic 1.000000 (and
			(not (have-victim-in-unit ?v ?u))
			(victim-at ?v ?l)) 0.000000 (and
			))
	)


	(:action treat-victim-on-scene-medical
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (victim-hurt ?v)
			(medical-unit-at ?u ?l)
			(victim-at ?v ?l)))
		:effect (probabilistic 0.800000 (and
			(not (victim-hurt ?v))
			(victim-healthy ?v)) 0.200000 (and
			(not (victim-hurt ?v))
			(victim-dying ?v)) 0.000000 (and
			))
	)


	(:action treat-victim-on-scene-fire
		:parameters (?u - fire_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and ))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)


	(:action treat-hurt-victim-at-hospital
		:parameters (?v - victim ?l - location)
		:precondition (and (not (= ?v ?l)) 
			(and (victim-hurt ?v)
			(hospital ?l)
			(victim-at ?v ?l)))
		:effect (probabilistic 1.000000 (and
			(not (victim-hurt ?v))
			(victim-healthy ?v)) 0.000000 (and
			))
	)


	(:action treat-dying-victim-at-hospital
		:parameters (?v - victim ?l - location)
		:precondition (and (not (= ?v ?l)) 
			(and (victim-at ?v ?l)
			(victim-dying ?v)
			(hospital ?l)))
		:effect (probabilistic 1.000000 (and
			(not (victim-dying ?v))
			(victim-healthy ?v)) 0.000000 (and
			))
	)
)