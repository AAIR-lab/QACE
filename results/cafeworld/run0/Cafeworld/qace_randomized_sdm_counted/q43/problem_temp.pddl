
(define (problem p01) (:domain cafeworld)
  (:objects
        canred - can
	counter - location
	fetch - robot
	gripper - manipulator
	tablered - location
  )
  (:init 
	(ingripper_1 canred gripper)
	(ingripper_2 canred gripper)
	(teleported_1 counter fetch)
	(teleported_2 counter fetch)
  )
  (:goal (and
	(p_psi)))
)
