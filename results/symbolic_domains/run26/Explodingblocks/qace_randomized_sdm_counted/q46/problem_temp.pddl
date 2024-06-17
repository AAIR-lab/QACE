
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(clear_1 b)
	(clear_2 b)
	(handfull_1 robot)
	(handfull_2 robot)
	(holding_1 a)
	(holding_2 a)
  )
  (:goal (and
	(p_psi)))
)
