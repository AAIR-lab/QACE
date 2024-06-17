
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(handfull_1 robot)
	(handfull_2 robot)
  )
  (:goal (and
	(p_psi)))
)
