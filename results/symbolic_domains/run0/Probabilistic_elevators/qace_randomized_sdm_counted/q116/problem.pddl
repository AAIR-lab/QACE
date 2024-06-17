
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
	(at_1 f1 p1)
	(at_2 f1 p1)
	(coin-at_1 c1 f2 p2)
	(coin-at_2 c1 f2 p2)
	(dec_f_1 f2 f1)
	(dec_f_2 f2 f1)
	(dec_p_1 p2 p1)
	(dec_p_2 p2 p1)
	(gate_1 f2 p1)
	(gate_1 f2 p2)
	(gate_2 f2 p1)
	(gate_2 f2 p2)
	(in_1 e1 f2)
	(in_2 e1 f2)
	(is-first-floor_1 f1)
	(is-first-floor_2 f1)
	(is-first-position_1 p1)
	(is-first-position_2 p1)
	(shaft_1 e1 p1)
	(shaft_1 e1 p2)
	(shaft_2 e1 p1)
	(shaft_2 e1 p2)
  )
  (:goal (and
	(p_psi)))
)
