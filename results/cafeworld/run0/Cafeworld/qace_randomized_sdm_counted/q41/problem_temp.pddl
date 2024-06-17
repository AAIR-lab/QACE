
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
	(ingripper_1 canred gripper)
	(ingripper_2 canred gripper)
  )
  (:goal (and
	(p_psi)))
)
