
(define (domain first-response)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location victim fire_unit medical_unit)
(:predicates (fire_1 ?v0 - location) (fire_2 ?v0 - location) (nfire_1 ?v0 - location) (nfire_2 ?v0 - location) (victim-at_1 ?v0 - victim ?v1 - location) (victim-at_2 ?v0 - victim ?v1 - location) (victim-healthy_1 ?v0 - victim) (victim-healthy_2 ?v0 - victim) (victim-hurt_1 ?v0 - victim) (victim-hurt_2 ?v0 - victim) (victim-dying_1 ?v0 - victim) (victim-dying_2 ?v0 - victim) (hospital_1 ?v0 - location) (hospital_2 ?v0 - location) (water-at_1 ?v0 - location) (water-at_2 ?v0 - location) (adjacent_1 ?v0 - location ?v1 - location) (adjacent_2 ?v0 - location ?v1 - location) (fire-unit-at_1 ?v0 - fire_unit ?v1 - location) (fire-unit-at_2 ?v0 - fire_unit ?v1 - location) (medical-unit-at_1 ?v0 - medical_unit ?v1 - location) (medical-unit-at_2 ?v0 - medical_unit ?v1 - location) (have-water_1 ?v0 - fire_unit) (have-water_2 ?v0 - fire_unit) (have-victim-in-unit_1 ?v0 - victim ?v1 - medical_unit) (have-victim-in-unit_2 ?v0 - victim ?v1 - medical_unit) (drive-fire-unit_1 ?v0 - fire_unit ?v1 - location ?v2 - location) (drive-fire-unit_2 ?v0 - fire_unit ?v1 - location ?v2 - location) (drive-medical-unit_1 ?v0 - medical_unit ?v1 - location ?v2 - location) (drive-medical-unit_2 ?v0 - medical_unit ?v1 - location ?v2 - location) (load-fire-unit_1 ?v0 - fire_unit ?v1 - location) (load-fire-unit_2 ?v0 - fire_unit ?v1 - location) (load-medical-unit_1 ?v0 - medical_unit ?v1 - location ?v2 - victim) (load-medical-unit_2 ?v0 - medical_unit ?v1 - location ?v2 - victim) (unload-fire-unit_1 ?v0 - fire_unit ?v1 - location ?v2 - location) (unload-fire-unit_2 ?v0 - fire_unit ?v1 - location ?v2 - location) (unload-medical-unit_1 ?v0 - medical_unit ?v1 - location ?v2 - victim) (unload-medical-unit_2 ?v0 - medical_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-medical_1 ?v0 - medical_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-medical_2 ?v0 - medical_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-fire_1 ?v0 - fire_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-fire_2 ?v0 - fire_unit ?v1 - location ?v2 - victim) (treat-hurt-victim-at-hospital_1 ?v0 - victim ?v1 - location) (treat-hurt-victim-at-hospital_2 ?v0 - victim ?v1 - location) (treat-dying-victim-at-hospital_1 ?v0 - victim ?v1 - location) (treat-dying-victim-at-hospital_2 ?v0 - victim ?v1 - location) (p_psi))


	(:action drive-medical-unit
		:parameters (?u - medical_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and (not (fire_2 ?to))
			(not (adjacent_2 ?to ?from))))
		:effect (and
			(p_psi))
	)
)