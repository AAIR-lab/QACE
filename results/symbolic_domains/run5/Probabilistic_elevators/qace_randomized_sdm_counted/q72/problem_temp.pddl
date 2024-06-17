
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
	(gate_1 f2 p1)
	(gate_2 f2 p1)
	(is-first-position_1 p1)
	(is-first-position_2 p1)
	(shaft_1 e1 p1)
	(shaft_2 e1 p1)
  )
  (:goal (and
	(p_psi)))
)
