
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
	(ontable_1 a)
	(ontable_2 a)
	(table-destroyed_1)
	(table-destroyed_2)
  )
  (:goal (and
	(p_psi)))
)
