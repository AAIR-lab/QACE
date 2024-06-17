
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
	(in_1 e1 f1)
	(in_2 e1 f1)
	(inside_1 e1)
	(inside_2 e1)
	(is-first-floor_1 f1)
	(is-first-floor_2 f1)
	(is-first-position_1 p1)
	(is-first-position_2 p1)
  )
  (:goal (and
	(p_psi)))
)
