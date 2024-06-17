
(define (domain elevators)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types floor pos elevator coin)
(:predicates (dec_f_1 ?v0 - floor ?v1 - floor) (dec_f_2 ?v0 - floor ?v1 - floor) (dec_p_1 ?v0 - pos ?v1 - pos) (dec_p_2 ?v0 - pos ?v1 - pos) (in_1 ?v0 - elevator ?v1 - floor) (in_2 ?v0 - elevator ?v1 - floor) (at_1 ?v0 - floor ?v1 - pos) (at_2 ?v0 - floor ?v1 - pos) (shaft_1 ?v0 - elevator ?v1 - pos) (shaft_2 ?v0 - elevator ?v1 - pos) (inside_1 ?v0 - elevator) (inside_2 ?v0 - elevator) (gate_1 ?v0 - floor ?v1 - pos) (gate_2 ?v0 - floor ?v1 - pos) (coin-at_1 ?v0 - coin ?v1 - floor ?v2 - pos) (coin-at_2 ?v0 - coin ?v1 - floor ?v2 - pos) (have_1 ?v0 - coin) (have_2 ?v0 - coin) (underground_1) (underground_2) (is-first-floor_1 ?v0 - floor) (is-first-floor_2 ?v0 - floor) (is-first-position_1 ?v0 - pos) (is-first-position_2 ?v0 - pos) (move-to-first-floor_1 ?v0 - floor ?v1 - pos) (move-to-first-floor_2 ?v0 - floor ?v1 - pos) (go-up_1 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-up_2 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-down_1 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-down_2 ?v0 - elevator ?v1 - floor ?v2 - floor) (step-in_1 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-in_2 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-out_1 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-out_2 ?v0 - elevator ?v1 - floor ?v2 - pos) (move-left-gate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-gate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-nogate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-nogate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-gate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-gate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-nogate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-nogate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (collect_1 ?v0 - coin ?v1 - floor ?v2 - pos) (collect_2 ?v0 - coin ?v1 - floor ?v2 - pos) (p_psi))


	(:action move-to-first-floor
		:parameters (?f1 - floor ?p1 - pos)
		:precondition (and (not (= ?f1 ?p1)) 
			(and (not (at_1 ?f1 ?p1))
			(underground_1)
			(is-first-position_1 ?p1)
			(is-first-floor_1 ?f1)))
		:effect (and
			(when (and
			(not (at_1 ?f1 ?p1))
			(underground_1)
			(is-first-position_1 ?p1)
			(is-first-floor_1 ?f1)
			(not (at_2 ?f1 ?p1))
			(underground_2)
			(is-first-position_2 ?p1)
			(is-first-floor_2 ?f1)) (and
			(oneof (and
			(not (underground_1))
			(at_1 ?f1 ?p1)))
			(oneof (and
			(not (underground_2))
			(at_2 ?f1 ?p1))))))
	)


	(:action go-up
		:parameters (?e - elevator ?f - floor ?nf - floor)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?nf)) (not (= ?f ?nf)) 
			(and (in_1 ?e ?f)
			(not (underground_1))
			(dec_f_1 ?nf ?f)))
		:effect (and
			(when (and
			(in_1 ?e ?f)
			(not (underground_1))
			(dec_f_1 ?nf ?f)
			(in_2 ?e ?f)
			(not (underground_2))
			(dec_f_2 ?nf ?f)) (and
			(oneof (and
			(in_1 ?e ?nf)
			(not (in_1 ?e ?f))))
			(oneof (and
			(in_2 ?e ?nf)
			(not (in_2 ?e ?f)))))))
	)


	(:action go-down
		:parameters (?e - elevator ?f - floor ?nf - floor)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?nf)) (not (= ?f ?nf)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action step-in
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (at_1 ?f ?p)
			(in_1 ?e ?f)
			(shaft_1 ?e ?p)
			(not (underground_1))))
		:effect (and
			(when (and
			(at_1 ?f ?p)
			(in_1 ?e ?f)
			(shaft_1 ?e ?p)
			(not (underground_1))
			(at_2 ?f ?p)
			(in_2 ?e ?f)
			(shaft_2 ?e ?p)
			(not (underground_2))) (and
			(oneof (and
			(inside_1 ?e)
			(not (at_1 ?f ?p))))
			(shaft_1 ?e ?p)
			(oneof (and
			(inside_2 ?e)
			(not (at_2 ?f ?p))))
			(not (shaft_2 ?e ?p))))
			
				(when (not (at_2 ?f ?p)) (and
			(p_psi)))
				(when (not (in_2 ?e ?f)) (and
			(p_psi)))
				(when (not (shaft_2 ?e ?p)) (and
			(p_psi)))
				(when (underground_2) (and
			(p_psi)))
			
				(when (not (at_1 ?f ?p)) (and
			(p_psi)))
				(when (not (in_1 ?e ?f)) (and
			(p_psi)))
				(when (not (shaft_1 ?e ?p)) (and
			(p_psi)))
				(when (underground_1) (and
			(p_psi))))
	)


	(:action step-out
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-left-gate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-left-nogate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-right-gate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-right-nogate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (not (underground_1))
			(at_1 ?f ?p)
			(dec_p_1 ?np ?p)
			(not (gate_1 ?f ?p))))
		:effect (and
			(when (and
			(not (underground_1))
			(at_1 ?f ?p)
			(dec_p_1 ?np ?p)
			(not (gate_1 ?f ?p))
			(not (underground_2))
			(at_2 ?f ?p)
			(dec_p_2 ?np ?p)
			(not (gate_2 ?f ?p))) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)))
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np))))))
	)


	(:action collect
		:parameters (?c - coin ?f - floor ?p - pos)
		:precondition (and (not (= ?c ?f)) (not (= ?c ?p)) (not (= ?f ?p)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-to-first-floor2
		:parameters (?f1 - floor ?p1 - pos)
		:precondition (and (not (= ?f1 ?p1)) 
			(and (not (at_2 ?f1 ?p1))
			(underground_2)
			(is-first-position_2 ?p1)
			(is-first-floor_2 ?f1)))
		:effect (and
			(when (and
			(not (at_1 ?f1 ?p1))
			(underground_1)
			(is-first-position_1 ?p1)
			(is-first-floor_1 ?f1)
			(not (at_2 ?f1 ?p1))
			(underground_2)
			(is-first-position_2 ?p1)
			(is-first-floor_2 ?f1)) (and
			(oneof (and
			(not (underground_1))
			(at_1 ?f1 ?p1)))
			(oneof (and
			(not (underground_2))
			(at_2 ?f1 ?p1))))))
	)


	(:action go-up2
		:parameters (?e - elevator ?f - floor ?nf - floor)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?nf)) (not (= ?f ?nf)) 
			(and (in_2 ?e ?f)
			(not (underground_2))
			(dec_f_2 ?nf ?f)))
		:effect (and
			(when (and
			(in_1 ?e ?f)
			(not (underground_1))
			(dec_f_1 ?nf ?f)
			(in_2 ?e ?f)
			(not (underground_2))
			(dec_f_2 ?nf ?f)) (and
			(oneof (and
			(in_1 ?e ?nf)
			(not (in_1 ?e ?f))))
			(oneof (and
			(in_2 ?e ?nf)
			(not (in_2 ?e ?f)))))))
	)


	(:action go-down2
		:parameters (?e - elevator ?f - floor ?nf - floor)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?nf)) (not (= ?f ?nf)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action step-in2
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (at_2 ?f ?p)
			(in_2 ?e ?f)
			(shaft_2 ?e ?p)
			(not (underground_2))))
		:effect (and
			(when (and
			(at_1 ?f ?p)
			(in_1 ?e ?f)
			(shaft_1 ?e ?p)
			(not (underground_1))
			(at_2 ?f ?p)
			(in_2 ?e ?f)
			(shaft_2 ?e ?p)
			(not (underground_2))) (and
			(oneof (and
			(inside_1 ?e)
			(not (at_1 ?f ?p))))
			(shaft_1 ?e ?p)
			(oneof (and
			(inside_2 ?e)
			(not (at_2 ?f ?p))))
			(not (shaft_2 ?e ?p))))
			
				(when (not (at_2 ?f ?p)) (and
			(p_psi)))
				(when (not (in_2 ?e ?f)) (and
			(p_psi)))
				(when (not (shaft_2 ?e ?p)) (and
			(p_psi)))
				(when (underground_2) (and
			(p_psi)))
			
				(when (not (at_1 ?f ?p)) (and
			(p_psi)))
				(when (not (in_1 ?e ?f)) (and
			(p_psi)))
				(when (not (shaft_1 ?e ?p)) (and
			(p_psi)))
				(when (underground_1) (and
			(p_psi))))
	)


	(:action step-in300
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (shaft_1 ?e ?p)
			(not (shaft_2 ?e ?p))))
		:effect (and
			(p_psi))
	)


	(:action step-out2
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-left-gate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-left-nogate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-right-gate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)


	(:action move-right-nogate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (not (underground_2))
			(at_2 ?f ?p)
			(dec_p_2 ?np ?p)
			(not (gate_2 ?f ?p))))
		:effect (and
			(when (and
			(not (underground_1))
			(at_1 ?f ?p)
			(dec_p_1 ?np ?p)
			(not (gate_1 ?f ?p))
			(not (underground_2))
			(at_2 ?f ?p)
			(dec_p_2 ?np ?p)
			(not (gate_2 ?f ?p))) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)))
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np))))))
	)


	(:action collect2
		:parameters (?c - coin ?f - floor ?p - pos)
		:precondition (and (not (= ?c ?f)) (not (= ?c ?p)) (not (= ?f ?p)) 
			(and ))
		:effect (and
			(when (and
			) (and
			)))
	)
)