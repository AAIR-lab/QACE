
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
	(not-flattire_1)
	(not-flattire_2)
	(road_1 l-1-1 l-1-2)
	(road_2 l-1-1 l-1-2)
	(spare-in_1 l-1-1)
	(spare-in_2 l-1-1)
  )
  (:goal (and
	(p_psi)))
)
