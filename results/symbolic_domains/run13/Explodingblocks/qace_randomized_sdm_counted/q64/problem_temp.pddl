
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(clear_1 a)
	(clear_2 a)
	(destroyed_1 b)
	(destroyed_2 b)
	(handfull_1 robot)
	(handfull_2 robot)
	(holding_1 b)
	(holding_2 b)
	(ontable_1 a)
	(ontable_2 a)
  )
  (:goal (and
	(p_psi)))
)
