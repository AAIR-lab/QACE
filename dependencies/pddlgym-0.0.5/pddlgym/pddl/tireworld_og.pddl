; Probabilistic triangle tireworld.

(define (domain tireworld)
  (:requirements :typing :strips :probabilistic-effects)
  (:types location)
  (:predicates
       (vehicle-at ?loc - location)
       (spare-in ?loc - location)
       (road ?from - location ?to - location)
       (not-flattire)
       (move-car ?to - location)
       (changetire ?loc - location)
  )

  ; (:actions move-car changetire)

  (:action move-car
    :parameters (?from - location ?to - location)
    :precondition (and (vehicle-at ?from) (road ?from ?to) (not-flattire) (move-car ?to))
    :effect (and (vehicle-at ?to) (not (vehicle-at ?from))
       (probabilistic 0.8 (and (not (not-flattire))))))
  (:action changetire
    :parameters (?loc - location)
    :precondition (and (spare-in ?loc) (vehicle-at ?loc) (changetire ?loc) (not (not-flattire)))
    :effect (and (not (spare-in ?loc)) (not-flattire)))
)
