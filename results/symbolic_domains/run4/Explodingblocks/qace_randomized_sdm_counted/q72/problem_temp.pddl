
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(destroyed_1 a)
	(destroyed_2 a)
	(handfull_1 robot)
	(handfull_2 robot)
	(holding_1 a)
	(holding_2 a)
  )
  (:goal (and
	(p_psi)))
)
