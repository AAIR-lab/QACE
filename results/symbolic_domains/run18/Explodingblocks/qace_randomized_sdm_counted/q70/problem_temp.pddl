
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(destroyed_1 b)
	(destroyed_2 b)
	(handfull_1 robot)
	(handfull_2 robot)
	(holding_1 b)
	(holding_2 b)
  )
  (:goal (and
	(p_psi)))
)
