
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(handfull_1 robot)
	(handfull_2 robot)
	(holding_1 a)
	(holding_2 a)
	(table-destroyed_1)
	(table-destroyed_2)
  )
  (:goal (and
	(p_psi)))
)
