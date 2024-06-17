
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(holding_1 a)
	(holding_2 a)
  )
  (:goal (and
	(p_psi)))
)
