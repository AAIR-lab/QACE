
(define (problem p01) (:domain cafeworld)
  (:objects
        canred - can
	counter - location
	fetch - robot
	gripper - manipulator
	tablered - location
  )
  (:init 
	(empty_1 gripper)
	(empty_2 gripper)
	(order_1 canred counter)
	(order_2 canred counter)
	(teleported_1 counter fetch)
	(teleported_2 counter fetch)
  )
  (:goal (and
	(p_psi)))
)
