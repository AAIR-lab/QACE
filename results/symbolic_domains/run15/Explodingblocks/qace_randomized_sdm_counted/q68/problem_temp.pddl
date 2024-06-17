
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(clear_1 a)
	(clear_2 a)
	(handfull_1 robot)
	(handfull_2 robot)
  )
  (:goal (and
	(p_psi)))
)
