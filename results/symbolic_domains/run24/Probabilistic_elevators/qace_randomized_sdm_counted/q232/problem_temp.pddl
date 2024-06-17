
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
	(at_1 f2 p2)
	(at_2 f2 p2)
	(dec_p_1 p2 p1)
	(dec_p_2 p2 p1)
	(gate_1 f2 p1)
	(gate_1 f2 p2)
	(gate_2 f2 p1)
	(gate_2 f2 p2)
	(is-first-position_1 p1)
	(is-first-position_1 p2)
	(is-first-position_2 p1)
	(is-first-position_2 p2)
  )
  (:goal (and
	(p_psi)))
)
