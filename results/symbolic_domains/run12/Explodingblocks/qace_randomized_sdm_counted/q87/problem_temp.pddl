
(define (problem explodingblocks) (:domain explodingblocks)
  (:objects
        a - block
	b - block
	robot - robot
  )
  (:init 
	(handempty_1 robot)
	(handempty_2 robot)
	(on_1 b a)
	(on_2 b a)
	(ontable_1 a)
	(ontable_2 a)
  )
  (:goal (and
	(p_psi)))
)
