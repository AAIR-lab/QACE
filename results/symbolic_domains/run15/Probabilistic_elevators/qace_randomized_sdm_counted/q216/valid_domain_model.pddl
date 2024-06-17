
(define (domain elevators)
(:requirements :typing :strips :probabilistic-effects :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types floor pos elevator coin)
(:predicates (dec_f ?v0 - floor ?v1 - floor) (dec_p ?v0 - pos ?v1 - pos) (in ?v0 - elevator ?v1 - floor) (at ?v0 - floor ?v1 - pos) (shaft ?v0 - elevator ?v1 - pos) (inside ?v0 - elevator) (gate ?v0 - floor ?v1 - pos) (coin-at ?v0 - coin ?v1 - floor ?v2 - pos) (have ?v0 - coin) (underground) (is-first-floor ?v0 - floor) (is-first-position ?v0 - pos))


	(:action move-to-first-floor
		:parameters (?f1 - floor ?p1 - pos)
		:precondition (and (not (= ?f1 ?p1)) 
			(and (is-first-position ?p1)
			(underground)
			(not (at ?f1 ?p1))
			(is-first-floor ?f1)))
		:effect (probabilistic 1.000000 (and
			(not (underground))
			(at ?f1 ?p1)) 0.000000 (and
			))
	)


	(:action go-up
		:parameters (?e - elevator ?f - floor ?nf - floor)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?nf)) (not (= ?f ?nf)) 
			(and (in ?e ?f)
			(dec_f ?nf ?f)
			(not (underground))))
		:effect (probabilistic 1.000000 (and
			(not (in ?e ?f))
			(in ?e ?nf)) 0.000000 (and
			))
	)


	(:action go-down
		:parameters (?e - elevator ?f - floor ?nf - floor)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?nf)) (not (= ?f ?nf)) 
			(and (dec_f ?f ?nf)
			(not (underground))
			(in ?e ?f)))
		:effect (probabilistic 1.000000 (and
			(not (in ?e ?f))
			(in ?e ?nf)) 0.000000 (and
			))
	)


	(:action step-in
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (at ?f ?p)
			(not (underground))
			(shaft ?e ?p)
			(in ?e ?f)))
		:effect (probabilistic 1.000000 (and
			(not (at ?f ?p))
			(inside ?e)) 0.000000 (and
			))
	)


	(:action step-out
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (inside ?e)
			(in ?e ?f)
			(shaft ?e ?p)
			(not (underground))))
		:effect (probabilistic 1.000000 (and
			(not (inside ?e))
			(at ?f ?p)) 0.000000 (and
			))
	)


	(:action move-left-gate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and ))
		:effect (probabilistic 1.000000 (and
			) 0.000000 (and
			))
	)


	(:action move-left-nogate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (not (underground))
			(at ?f ?p)
			(not (gate ?f ?p))
			(dec_p ?p ?np)))
		:effect (probabilistic 1.000000 (and
			(not (at ?f ?p))
			(at ?f ?np)) 0.000000 (and
			))
	)


	(:action move-right-gate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (at ?f ?p)
			(not (underground))
			(dec_p ?np ?p)
			(gate ?f ?p)))
		:effect (probabilistic 0.800000 (and
			(not (at ?f ?p))
			(at ?f ?np)) 0.200000 (and
			(not (at ?f ?p))
			(underground)) 0.000000 (and
			))
	)


	(:action move-right-nogate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p ?np ?p)
			(not (underground))
			(at ?f ?p)
			(not (gate ?f ?p))))
		:effect (probabilistic 1.000000 (and
			(not (at ?f ?p))
			(at ?f ?np)) 0.000000 (and
			))
	)


	(:action collect
		:parameters (?c - coin ?f - floor ?p - pos)
		:precondition (and (not (= ?c ?f)) (not (= ?c ?p)) (not (= ?f ?p)) 
			(and (at ?f ?p)
			(coin-at ?c ?f ?p)
			(not (underground))))
		:effect (probabilistic 1.000000 (and
			(not (coin-at ?c ?f ?p))
			(have ?c)) 0.000000 (and
			))
	)
)