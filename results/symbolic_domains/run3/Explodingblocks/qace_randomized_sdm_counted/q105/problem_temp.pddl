
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
	(ontable_1 b)
	(ontable_2 a)
	(ontable_2 b)
  )
  (:goal (and
	(p_psi)))
)
