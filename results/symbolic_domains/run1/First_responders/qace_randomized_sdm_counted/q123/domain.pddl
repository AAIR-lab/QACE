
(define (domain first-response)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types location victim fire_unit medical_unit)
(:predicates (fire_1 ?v0 - location) (fire_2 ?v0 - location) (nfire_1 ?v0 - location) (nfire_2 ?v0 - location) (victim-at_1 ?v0 - victim ?v1 - location) (victim-at_2 ?v0 - victim ?v1 - location) (victim-healthy_1 ?v0 - victim) (victim-healthy_2 ?v0 - victim) (victim-hurt_1 ?v0 - victim) (victim-hurt_2 ?v0 - victim) (victim-dying_1 ?v0 - victim) (victim-dying_2 ?v0 - victim) (hospital_1 ?v0 - location) (hospital_2 ?v0 - location) (water-at_1 ?v0 - location) (water-at_2 ?v0 - location) (adjacent_1 ?v0 - location ?v1 - location) (adjacent_2 ?v0 - location ?v1 - location) (fire-unit-at_1 ?v0 - fire_unit ?v1 - location) (fire-unit-at_2 ?v0 - fire_unit ?v1 - location) (medical-unit-at_1 ?v0 - medical_unit ?v1 - location) (medical-unit-at_2 ?v0 - medical_unit ?v1 - location) (have-water_1 ?v0 - fire_unit) (have-water_2 ?v0 - fire_unit) (have-victim-in-unit_1 ?v0 - victim ?v1 - medical_unit) (have-victim-in-unit_2 ?v0 - victim ?v1 - medical_unit) (drive-fire-unit_1 ?v0 - fire_unit ?v1 - location ?v2 - location) (drive-fire-unit_2 ?v0 - fire_unit ?v1 - location ?v2 - location) (drive-medical-unit_1 ?v0 - medical_unit ?v1 - location ?v2 - location) (drive-medical-unit_2 ?v0 - medical_unit ?v1 - location ?v2 - location) (load-fire-unit_1 ?v0 - fire_unit ?v1 - location) (load-fire-unit_2 ?v0 - fire_unit ?v1 - location) (load-medical-unit_1 ?v0 - medical_unit ?v1 - location ?v2 - victim) (load-medical-unit_2 ?v0 - medical_unit ?v1 - location ?v2 - victim) (unload-fire-unit_1 ?v0 - fire_unit ?v1 - location ?v2 - location) (unload-fire-unit_2 ?v0 - fire_unit ?v1 - location ?v2 - location) (unload-medical-unit_1 ?v0 - medical_unit ?v1 - location ?v2 - victim) (unload-medical-unit_2 ?v0 - medical_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-medical_1 ?v0 - medical_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-medical_2 ?v0 - medical_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-fire_1 ?v0 - fire_unit ?v1 - location ?v2 - victim) (treat-victim-on-scene-fire_2 ?v0 - fire_unit ?v1 - location ?v2 - victim) (treat-hurt-victim-at-hospital_1 ?v0 - victim ?v1 - location) (treat-hurt-victim-at-hospital_2 ?v0 - victim ?v1 - location) (treat-dying-victim-at-hospital_1 ?v0 - victim ?v1 - location) (treat-dying-victim-at-hospital_2 ?v0 - victim ?v1 - location) (p_psi))


	(:action drive-fire-unit
		:parameters (?u - fire_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action drive-medical-unit
		:parameters (?u - medical_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action load-fire-unit
		:parameters (?u - fire_unit ?l - location)
		:precondition (and (not (= ?u ?l)) 
			(and (water-at_1 ?l)
			(fire-unit-at_1 ?u ?l)
			(not (have-water_1 ?u))))
		:effect (and
			(when (and
			(water-at_1 ?l)
			(fire-unit-at_1 ?u ?l)
			(not (have-water_1 ?u))
			(water-at_2 ?l)
			(fire-unit-at_2 ?u ?l)
			(not (have-water_2 ?u))) (and
			(oneof (and
			(have-water_1 ?u)))
			(oneof (and
			(have-water_2 ?u))))))
	)


	(:action load-medical-unit
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (victim-at_1 ?v ?l)
			(medical-unit-at_1 ?u ?l)))
		:effect (and
			(when (and
			(victim-at_1 ?v ?l)
			(medical-unit-at_1 ?u ?l)
			(victim-at_2 ?v ?l)
			(medical-unit-at_2 ?u ?l)) (and
			(oneof (and
			(not (victim-at_1 ?v ?l))
			(have-victim-in-unit_1 ?v ?u)))
			(oneof (and
			(not (victim-at_2 ?v ?l))
			(have-victim-in-unit_2 ?v ?u))))))
	)


	(:action unload-fire-unit
		:parameters (?u - fire_unit ?l - location ?l1 - location)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?l1)) (not (= ?l ?l1)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action unload-medical-unit
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action treat-victim-on-scene-medical
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (medical-unit-at_1 ?u ?l)
			(victim-hurt_1 ?v)
			(victim-at_1 ?v ?l)))
		:effect (and
			(when (and
			(medical-unit-at_1 ?u ?l)
			(victim-hurt_1 ?v)
			(victim-at_1 ?v ?l)
			(medical-unit-at_2 ?u ?l)
			(victim-hurt_2 ?v)
			(victim-at_2 ?v ?l)) (and
			(oneof (and
			(victim-healthy_1 ?v)
			(not (victim-hurt_1 ?v))) (and
			(not (victim-hurt_1 ?v))
			(victim-dying_1 ?v)))
			(victim-healthy_1 ?v)
			(oneof (and
			(victim-healthy_2 ?v)
			(not (victim-hurt_2 ?v))) (and
			(not (victim-hurt_2 ?v))
			(victim-dying_2 ?v)))
			(not (victim-healthy_2 ?v))))
			
				(when (not (medical-unit-at_2 ?u ?l)) (and
			(p_psi)))
				(when (not (victim-hurt_2 ?v)) (and
			(p_psi)))
				(when (not (victim-at_2 ?v ?l)) (and
			(p_psi)))
			
				(when (not (medical-unit-at_1 ?u ?l)) (and
			(p_psi)))
				(when (not (victim-hurt_1 ?v)) (and
			(p_psi)))
				(when (not (victim-at_1 ?v ?l)) (and
			(p_psi))))
	)


	(:action treat-victim-on-scene-fire
		:parameters (?u - fire_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action treat-hurt-victim-at-hospital
		:parameters (?v - victim ?l - location)
		:precondition (and (not (= ?v ?l)) 
			(and (hospital_1 ?l)
			(victim-hurt_1 ?v)
			(victim-at_1 ?v ?l)))
		:effect (and
			(when (and
			(hospital_1 ?l)
			(victim-hurt_1 ?v)
			(victim-at_1 ?v ?l)
			(hospital_2 ?l)
			(victim-hurt_2 ?v)
			(victim-at_2 ?v ?l)) (and
			(oneof (and
			(victim-healthy_1 ?v)
			(not (victim-hurt_1 ?v))))
			(oneof (and
			(victim-healthy_2 ?v)
			(not (victim-hurt_2 ?v)))))))
	)


	(:action treat-dying-victim-at-hospital
		:parameters (?v - victim ?l - location)
		:precondition (and (not (= ?v ?l)) 
			(and (victim-dying_1 ?v)
			(victim-at_1 ?v ?l)
			(hospital_1 ?l)))
		:effect (and
			(when (and
			(victim-dying_1 ?v)
			(victim-at_1 ?v ?l)
			(hospital_1 ?l)
			(victim-dying_2 ?v)
			(victim-at_2 ?v ?l)
			(hospital_2 ?l)) (and
			(oneof (and
			(victim-healthy_1 ?v)
			(not (victim-dying_1 ?v))))
			(oneof (and
			(victim-healthy_2 ?v)
			(not (victim-dying_2 ?v)))))))
	)


	(:action drive-fire-unit2
		:parameters (?u - fire_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action drive-medical-unit2
		:parameters (?u - medical_unit ?from - location ?to - location)
		:precondition (and (not (= ?u ?from)) (not (= ?u ?to)) (not (= ?from ?to)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action load-fire-unit2
		:parameters (?u - fire_unit ?l - location)
		:precondition (and (not (= ?u ?l)) 
			(and (water-at_2 ?l)
			(fire-unit-at_2 ?u ?l)
			(not (have-water_2 ?u))))
		:effect (and
			(when (and
			(water-at_1 ?l)
			(fire-unit-at_1 ?u ?l)
			(not (have-water_1 ?u))
			(water-at_2 ?l)
			(fire-unit-at_2 ?u ?l)
			(not (have-water_2 ?u))) (and
			(oneof (and
			(have-water_1 ?u)))
			(oneof (and
			(have-water_2 ?u))))))
	)


	(:action load-medical-unit2
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (victim-at_2 ?v ?l)
			(medical-unit-at_2 ?u ?l)))
		:effect (and
			(when (and
			(victim-at_1 ?v ?l)
			(medical-unit-at_1 ?u ?l)
			(victim-at_2 ?v ?l)
			(medical-unit-at_2 ?u ?l)) (and
			(oneof (and
			(not (victim-at_1 ?v ?l))
			(have-victim-in-unit_1 ?v ?u)))
			(oneof (and
			(not (victim-at_2 ?v ?l))
			(have-victim-in-unit_2 ?v ?u))))))
	)


	(:action unload-fire-unit2
		:parameters (?u - fire_unit ?l - location ?l1 - location)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?l1)) (not (= ?l ?l1)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action unload-medical-unit2
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action treat-victim-on-scene-medical2
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (medical-unit-at_2 ?u ?l)
			(victim-hurt_2 ?v)
			(victim-at_2 ?v ?l)))
		:effect (and
			(when (and
			(medical-unit-at_1 ?u ?l)
			(victim-hurt_1 ?v)
			(victim-at_1 ?v ?l)
			(medical-unit-at_2 ?u ?l)
			(victim-hurt_2 ?v)
			(victim-at_2 ?v ?l)) (and
			(oneof (and
			(victim-healthy_1 ?v)
			(not (victim-hurt_1 ?v))) (and
			(not (victim-hurt_1 ?v))
			(victim-dying_1 ?v)))
			(victim-healthy_1 ?v)
			(oneof (and
			(victim-healthy_2 ?v)
			(not (victim-hurt_2 ?v))) (and
			(not (victim-hurt_2 ?v))
			(victim-dying_2 ?v)))
			(not (victim-healthy_2 ?v))))
			
				(when (not (medical-unit-at_2 ?u ?l)) (and
			(p_psi)))
				(when (not (victim-hurt_2 ?v)) (and
			(p_psi)))
				(when (not (victim-at_2 ?v ?l)) (and
			(p_psi)))
			
				(when (not (medical-unit-at_1 ?u ?l)) (and
			(p_psi)))
				(when (not (victim-hurt_1 ?v)) (and
			(p_psi)))
				(when (not (victim-at_1 ?v ?l)) (and
			(p_psi))))
	)


	(:action treat-victim-on-scene-medical300
		:parameters (?u - medical_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and (victim-healthy_1 ?v)
			(not (victim-healthy_2 ?v))))
		:effect (and
			(p_psi))
	)


	(:action treat-victim-on-scene-fire2
		:parameters (?u - fire_unit ?l - location ?v - victim)
		:precondition (and (not (= ?u ?l)) (not (= ?u ?v)) (not (= ?l ?v)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action treat-hurt-victim-at-hospital2
		:parameters (?v - victim ?l - location)
		:precondition (and (not (= ?v ?l)) 
			(and (hospital_2 ?l)
			(victim-hurt_2 ?v)
			(victim-at_2 ?v ?l)))
		:effect (and
			(when (and
			(hospital_1 ?l)
			(victim-hurt_1 ?v)
			(victim-at_1 ?v ?l)
			(hospital_2 ?l)
			(victim-hurt_2 ?v)
			(victim-at_2 ?v ?l)) (and
			(oneof (and
			(victim-healthy_1 ?v)
			(not (victim-hurt_1 ?v))))
			(oneof (and
			(victim-healthy_2 ?v)
			(not (victim-hurt_2 ?v)))))))
	)


	(:action treat-dying-victim-at-hospital2
		:parameters (?v - victim ?l - location)
		:precondition (and (not (= ?v ?l)) 
			(and (victim-dying_2 ?v)
			(victim-at_2 ?v ?l)
			(hospital_2 ?l)))
		:effect (and
			(when (and
			(victim-dying_1 ?v)
			(victim-at_1 ?v ?l)
			(hospital_1 ?l)
			(victim-dying_2 ?v)
			(victim-at_2 ?v ?l)
			(hospital_2 ?l)) (and
			(oneof (and
			(victim-healthy_1 ?v)
			(not (victim-dying_1 ?v))))
			(oneof (and
			(victim-healthy_2 ?v)
			(not (victim-dying_2 ?v)))))))
	)
)