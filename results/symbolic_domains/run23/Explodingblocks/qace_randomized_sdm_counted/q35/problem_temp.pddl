
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(clear_1 b)
	(clear_2 b)
	(destroyed_1 b)
	(destroyed_2 b)
	(handfull_1 robot)
	(handfull_2 robot)
	(holding_1 a)
	(holding_2 a)
	(ontable_1 b)
	(ontable_2 b)
  )
  (:goal (and
	(p_psi)))
)
