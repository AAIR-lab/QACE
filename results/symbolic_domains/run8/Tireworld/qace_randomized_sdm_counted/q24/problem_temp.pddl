
(define (problem tireworld-3) (:domain tireworld)
  (:objects
        l-1-1 - location
	l-1-2 - location
	l-1-3 - location
	l-2-1 - location
	l-2-2 - location
	l-3-1 - location
  )
  (:init 
	(spare-in_1 l-2-2)
	(spare-in_2 l-2-2)
	(vehicle-at_1 l-2-2)
	(vehicle-at_2 l-2-2)
  )
  (:goal (and
	(p_psi)))
)
