
(define (problem p01) (:domain cafeworld)
  (:objects
        canred - can
	counter - location
	fetch - robot
	gripper - manipulator
	tablered - location
  )
  (:init 
	(at counter fetch)
	(ingripper canred gripper)
	(teleported counter fetch)
	(teleported tablered fetch)
  )
  (:goal (and
	(teleported counter fetch)
	(teleported tablered fetch)
	(at counter fetch)
	(ingripper canred gripper)))
)
