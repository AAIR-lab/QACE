
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(clear_1 a)
	(clear_2 a)
	(handempty_1 robot)
	(handempty_2 robot)
	(on_1 a b)
	(on_2 a b)
	(ontable_1 a)
	(ontable_1 b)
	(ontable_2 a)
	(ontable_2 b)
  )
  (:goal (and
	(p_psi)))
)
