
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(handempty_1 robot)
	(handempty_2 robot)
	(handfull_1 robot)
	(handfull_2 robot)
	(holding_1 b)
	(holding_2 b)
  )
  (:goal (and
	(p_psi)))
)
