
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
	(fire_1 l1)
	(fire_2 l1)
	(have-victim-in-unit_1 z1 m1)
	(have-victim-in-unit_2 z1 m1)
	(hospital_1 l1)
	(hospital_2 l1)
	(victim-hurt_1 z1)
	(victim-hurt_2 z1)
	(water-at_1 l1)
	(water-at_2 l1)
  )
  (:goal (and
	(p_psi)))
)
