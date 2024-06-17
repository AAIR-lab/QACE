
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
	(adjacent_1 l2 l1)
	(adjacent_2 l2 l1)
	(hospital_1 l2)
	(hospital_2 l2)
	(medical-unit-at_1 m1 l2)
	(medical-unit-at_2 m1 l2)
	(nfire_1 l1)
	(nfire_1 l2)
	(nfire_2 l1)
	(nfire_2 l2)
	(water-at_1 l1)
	(water-at_2 l1)
  )
  (:goal (and
	(p_psi)))
)
