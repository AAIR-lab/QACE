
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(holding_1 b)
	(holding_2 b)
  )
  (:goal (and
	(p_psi)))
)
