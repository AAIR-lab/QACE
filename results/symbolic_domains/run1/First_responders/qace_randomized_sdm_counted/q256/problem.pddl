
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
	(adjacent_1 l1 l2)
	(adjacent_1 l2 l1)
	(adjacent_2 l1 l2)
	(adjacent_2 l2 l1)
	(fire-unit-at_1 f1 l2)
	(fire-unit-at_2 f1 l2)
	(fire_1 l1)
	(fire_2 l1)
	(have-water_1 f1)
	(have-water_2 f1)
	(hospital_1 l2)
	(hospital_2 l2)
	(medical-unit-at_1 m1 l2)
	(medical-unit-at_2 m1 l2)
	(nfire_1 l2)
	(nfire_2 l2)
	(victim-at_1 z1 l2)
	(victim-at_1 z2 l2)
	(victim-at_2 z1 l2)
	(victim-at_2 z2 l2)
	(victim-healthy_1 z2)
	(victim-healthy_2 z2)
	(victim-hurt_1 z1)
	(victim-hurt_2 z1)
	(water-at_1 l1)
	(water-at_2 l1)
  )
  (:goal (and
	(p_psi)))
)
