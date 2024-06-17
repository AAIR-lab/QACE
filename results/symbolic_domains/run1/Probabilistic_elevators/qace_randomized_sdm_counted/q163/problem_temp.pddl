
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
	(dec_f_1 f2 f1)
	(dec_f_2 f2 f1)
	(in_1 e1 f2)
	(in_2 e1 f2)
	(inside_1 e1)
	(inside_2 e1)
	(is-first-floor_1 f1)
	(is-first-floor_2 f1)
	(underground_1)
	(underground_2)
  )
  (:goal (and
	(p_psi)))
)
