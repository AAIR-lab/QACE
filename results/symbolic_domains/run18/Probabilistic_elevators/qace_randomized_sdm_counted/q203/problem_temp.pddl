
(define (problem elevators1) (:domain elevators)
  (:objects
        c1 - coin
	e1 - elevator
	f1 - floor
	f2 - floor
	p1 - pos
	p2 - pos
  )
  (:init 
	(have_1 c1)
	(have_2 c1)
	(is-first-floor_1 f1)
	(is-first-floor_2 f1)
	(is-first-position_1 p1)
	(is-first-position_2 p1)
  )
  (:goal (and
	(p_psi)))
)
