
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
	(hospital_1 l2)
	(hospital_2 l2)
	(victim-at_1 z2 l2)
	(victim-at_2 z2 l2)
	(victim-dying_1 z2)
	(victim-dying_2 z2)
  )
  (:goal (and
	(p_psi)))
)
