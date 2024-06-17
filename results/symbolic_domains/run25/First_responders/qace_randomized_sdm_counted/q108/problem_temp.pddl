
(define (problem problem1) (:domain first-response)
  (:objects
        f1 - fire_unit
	l1 - location
	l2 - location
	m1 - medical_unit
	z1 - victim
	z2 - victim
  )
  (:init 
	(fire_1 l2)
	(fire_2 l2)
	(hospital_1 l2)
	(hospital_2 l2)
	(medical-unit-at_1 m1 l2)
	(medical-unit-at_2 m1 l2)
	(victim-hurt_1 z1)
	(victim-hurt_2 z1)
  )
  (:goal (and
	(p_psi)))
)
