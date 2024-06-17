
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
	(ontable_1 b)
	(ontable_2 b)
  )
  (:goal (and
	(p_psi)))
)
