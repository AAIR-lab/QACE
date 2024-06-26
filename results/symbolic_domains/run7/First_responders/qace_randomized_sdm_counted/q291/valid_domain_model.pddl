
(define (domain first-response)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location victim fire_unit medical_unit)
(:predicates (fire ?v0 - location) (nfire ?v0 - location) (victim-at ?v0 - victim ?v1 - location) (victim-healthy ?v0 - victim) (victim-hurt ?v0 - victim) (victim-dying ?v0 - victim) (hospital ?v0 - location) (water-at ?v0 - location) (adjacent ?v0 - location ?v1 - location) (fire-unit-at ?v0 - fire_unit ?v1 - location) (medical-unit-at ?v0 - medical_unit ?v1 - location) (have-water ?v0 - fire_unit) (have-victim-in-unit ?v0 - victim ?v1 - medical_unit))


	(:action drive-fire-unit
		:parameters (?u - fire_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and (adjacent ?to ?from)
			(not (fire ?to))
			(fire-unit-at ?u ?from)))
		:effect (probabilistic 1.000000 (and
			(not (fire-unit-at ?u ?from))
			(fire-unit-at ?u ?to)) 0.000000 (and
			))
	)


	(:action drive-medical-unit
		:parameters (?u - medical_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and (adjacent ?to ?from)
			(not (fire ?to))
			(medical-unit-at ?u ?from)))
		:effect (probabilistic 1.000000 (and
			(not (medical-unit-at ?u ?from))
			(medical-unit-at ?u ?to)) 0.000000 (and
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
			(and (fire-unit-at ?u ?l)
			(adjacent ?l1 ?l)
			(fire ?l1)
			(have-water ?u)))
		:effect (probabilistic 1.000000 (and
			(not (fire ?l1))
			(not (have-water ?u))
			(nfire ?l1)) 0.000000 (and
			))
	)


	(:action unload-medical-unit
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (have-victim-in-unit ?v ?u)
			(medical-unit-at ?u ?l)))
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
		:effect (probabilistic 0.909091 (and
			(not (victim-hurt ?v))
			(victim-healthy ?v)) 0.090909 (and
			(not (victim-hurt ?v))
			(victim-dying ?v)) 0.000000 (and
			))
	)


	(:action treat-victim-on-scene-fire
		:parameters (?u - fire_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (victim-hurt ?v)
			(victim-at ?v ?l)
			(fire-unit-at ?u ?l)))
		:effect (probabilistic 0.600000 (and
			(not (victim-hurt ?v))
			(victim-healthy ?v)) 0.400000 (and
			(not (victim-hurt ?v))
			(victim-dying ?v)) 0.000000 (and
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
			(hospital ?l)
			(victim-dying ?v)))
		:effect (probabilistic 1.000000 (and
			(not (victim-dying ?v))
			(victim-healthy ?v)) 0.000000 (and
			))
	)
)