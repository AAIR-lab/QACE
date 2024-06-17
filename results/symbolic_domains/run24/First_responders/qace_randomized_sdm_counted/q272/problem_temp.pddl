
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
	(have-water_1 f1)
	(have-water_2 f1)
	(nfire_1 l1)
	(nfire_2 l1)
	(victim-hurt_1 z1)
	(victim-hurt_2 z1)
  )
  (:goal (and
	(p_psi)))
)
