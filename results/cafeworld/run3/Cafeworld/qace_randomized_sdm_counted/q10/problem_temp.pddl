
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
	(ingripper_1 canred gripper)
	(ingripper_2 canred gripper)
	(order_1 canred counter)
	(order_2 canred counter)
	(teleported_1 counter fetch)
	(teleported_2 counter fetch)
  )
  (:goal (and
	(p_psi)))
)
