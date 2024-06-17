
(define (problem p01) (:domain cafeworld)
  (:objects
        canred - can
	counter - location
	fetch - robot
	gripper - manipulator
	tablered - location
  )
  (:init 
	(teleported_1 counter fetch)
	(teleported_2 counter fetch)
  )
  (:goal (and
	(p_psi)))
)
