
(define (problem p01) (:domain cafeworld)
  (:objects
        canred - can
	counter - location
	fetch - robot
	gripper - manipulator
	tablered - location
  )
  (:init 
	(at_1 counter fetch)
	(at_2 counter fetch)
	(empty_1 gripper)
	(empty_2 gripper)
	(teleported_1 counter fetch)
	(teleported_2 counter fetch)
  )
  (:goal (and
	(p_psi)))
)
