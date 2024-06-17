
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
	(order_1 canred counter)
	(order_2 canred counter)
  )
  (:goal (and
	(p_psi)))
)
