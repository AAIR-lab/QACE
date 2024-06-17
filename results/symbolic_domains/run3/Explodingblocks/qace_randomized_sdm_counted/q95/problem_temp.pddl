
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
	(ontable_1 a)
	(ontable_2 a)
  )
  (:goal (and
	(p_psi)))
)
