
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
	(handempty_1 robot)
	(handempty_2 robot)
	(on_1 a b)
	(on_2 a b)
  )
  (:goal (and
	(p_psi)))
)