
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(clear_1 b)
	(clear_2 b)
	(handempty_1 robot)
	(handempty_2 robot)
	(on_1 b a)
	(on_2 b a)
	(ontable_1 a)
	(ontable_2 a)
	(table-destroyed_1)
	(table-destroyed_2)
  )
  (:goal (and
	(p_psi)))
)
