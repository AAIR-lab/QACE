
(define (domain elevators)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types floor pos elevator coin)
(:predicates (dec_f_1 ?v0 - floor ?v1 - floor) (dec_f_2 ?v0 - floor ?v1 - floor) (dec_p_1 ?v0 - pos ?v1 - pos) (dec_p_2 ?v0 - pos ?v1 - pos) (in_1 ?v0 - elevator ?v1 - floor) (in_2 ?v0 - elevator ?v1 - floor) (at_1 ?v0 - floor ?v1 - pos) (at_2 ?v0 - floor ?v1 - pos) (shaft_1 ?v0 - elevator ?v1 - pos) (shaft_2 ?v0 - elevator ?v1 - pos) (inside_1 ?v0 - elevator) (inside_2 ?v0 - elevator) (gate_1 ?v0 - floor ?v1 - pos) (gate_2 ?v0 - floor ?v1 - pos) (coin-at_1 ?v0 - coin ?v1 - floor ?v2 - pos) (coin-at_2 ?v0 - coin ?v1 - floor ?v2 - pos) (have_1 ?v0 - coin) (have_2 ?v0 - coin) (underground_1) (underground_2) (is-first-floor_1 ?v0 - floor) (is-first-floor_2 ?v0 - floor) (is-first-position_1 ?v0 - pos) (is-first-position_2 ?v0 - pos) (move-to-first-floor_1 ?v0 - floor ?v1 - pos) (move-to-first-floor_2 ?v0 - floor ?v1 - pos) (go-up_1 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-up_2 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-down_1 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-down_2 ?v0 - elevator ?v1 - floor ?v2 - floor) (step-in_1 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-in_2 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-out_1 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-out_2 ?v0 - elevator ?v1 - floor ?v2 - pos) (move-left-gate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-gate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-nogate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-nogate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-gate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-gate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-nogate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-nogate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (collect_1 ?v0 - coin ?v1 - floor ?v2 - pos) (collect_2 ?v0 - coin ?v1 - floor ?v2 - pos) (p_psi))


	(:action move-to-first-floor
		:parameters (?f1 - floor ?p1 - pos)
		:precondition (and (not (= ?f1 ?p1)) 
			(and (not (at_1 ?f1 ?p1))
			(is-first-position_1 ?p1)
			(is-first-floor_1 ?f1)
			(underground_1)))
		:effect (and
			(when (and
			(not (at_1 ?f1 ?p1))
			(is-first-position_1 ?p1)
			(is-first-floor_1 ?f1)
			(underground_1)
			(not (at_2 ?f1 ?p1))
			(is-first-position_2 ?p1)
			(is-first-floor_2 ?f1)
			(underground_2)) (and
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
			(and (not (underground_1))
			(in_1 ?e ?f)
			(dec_f_1 ?f ?nf)))
		:effect (and
			(when (and
			(not (underground_1))
			(in_1 ?e ?f)
			(dec_f_1 ?f ?nf)
			(not (underground_2))
			(in_2 ?e ?f)
			(dec_f_2 ?f ?nf)) (and
			(oneof (and
			(in_1 ?e ?nf)
			(not (in_1 ?e ?f))))
			(oneof (and
			(in_2 ?e ?nf)
			(not (in_2 ?e ?f)))))))
	)


	(:action step-in
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (not (underground_1))
			(in_1 ?e ?f)
			(shaft_1 ?e ?p)
			(at_1 ?f ?p)))
		:effect (and
			(when (and
			(not (underground_1))
			(in_1 ?e ?f)
			(shaft_1 ?e ?p)
			(at_1 ?f ?p)
			(not (underground_2))
			(in_2 ?e ?f)
			(shaft_2 ?e ?p)
			(at_2 ?f ?p)) (and
			(oneof (and
			(inside_1 ?e)
			(not (at_1 ?f ?p))))
			(oneof (and
			(inside_2 ?e)
			(not (at_2 ?f ?p)))))))
	)


	(:action step-out
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (inside_1 ?e)
			(in_1 ?e ?f)
			(not (underground_1))
			(shaft_1 ?e ?p)))
		:effect (and
			(when (and
			(inside_1 ?e)
			(in_1 ?e ?f)
			(not (underground_1))
			(shaft_1 ?e ?p)
			(inside_2 ?e)
			(in_2 ?e ?f)
			(not (underground_2))
			(shaft_2 ?e ?p)) (and
			(oneof (and
			(not (inside_1 ?e))
			(at_1 ?f ?p)))
			(oneof (and
			(not (inside_2 ?e))
			(at_2 ?f ?p))))))
	)


	(:action move-left-gate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p_1 ?p ?np)
			(at_1 ?f ?p)
			(gate_1 ?f ?p)
			(not (underground_1))))
		:effect (and
			(when (and
			(dec_p_1 ?p ?np)
			(at_1 ?f ?p)
			(gate_1 ?f ?p)
			(not (underground_1))
			(dec_p_2 ?p ?np)
			(at_2 ?f ?p)
			(gate_2 ?f ?p)
			(not (underground_2))) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)) (and
			(not (at_1 ?f ?p))
			(underground_1)))
			(dec_p_1 ?np ?p)
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np)) (and
			(not (at_2 ?f ?p))
			(underground_2)))
			(not (dec_p_2 ?np ?p))))
			
				(when (not (dec_p_2 ?p ?np)) (and
			(p_psi)))
				(when (not (at_2 ?f ?p)) (and
			(p_psi)))
				(when (not (gate_2 ?f ?p)) (and
			(p_psi)))
				(when (underground_2) (and
			(p_psi)))
			
				(when (not (dec_p_1 ?p ?np)) (and
			(p_psi)))
				(when (not (at_1 ?f ?p)) (and
			(p_psi)))
				(when (not (gate_1 ?f ?p)) (and
			(p_psi)))
				(when (underground_1) (and
			(p_psi))))
	)


	(:action move-left-nogate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (not (underground_1))
			(at_1 ?f ?p)
			(not (gate_1 ?f ?p))
			(dec_p_1 ?p ?np)))
		:effect (and
			(when (and
			(not (underground_1))
			(at_1 ?f ?p)
			(not (gate_1 ?f ?p))
			(dec_p_1 ?p ?np)
			(not (underground_2))
			(at_2 ?f ?p)
			(not (gate_2 ?f ?p))
			(dec_p_2 ?p ?np)) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)))
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np))))))
	)


	(:action move-right-gate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p_1 ?np ?p)
			(at_1 ?f ?p)
			(not (underground_1))
			(gate_1 ?f ?p)))
		:effect (and
			(when (and
			(dec_p_1 ?np ?p)
			(at_1 ?f ?p)
			(not (underground_1))
			(gate_1 ?f ?p)
			(dec_p_2 ?np ?p)
			(at_2 ?f ?p)
			(not (underground_2))
			(gate_2 ?f ?p)) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)) (and
			(not (at_1 ?f ?p))
			(underground_1)))
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np)) (and
			(not (at_2 ?f ?p))
			(underground_2))))))
	)


	(:action move-right-nogate
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p_1 ?np ?p)
			(at_1 ?f ?p)
			(not (gate_1 ?f ?p))
			(not (underground_1))))
		:effect (and
			(when (and
			(dec_p_1 ?np ?p)
			(at_1 ?f ?p)
			(not (gate_1 ?f ?p))
			(not (underground_1))
			(dec_p_2 ?np ?p)
			(at_2 ?f ?p)
			(not (gate_2 ?f ?p))
			(not (underground_2))) (and
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
			(and (at_1 ?f ?p)
			(not (underground_1))
			(coin-at_1 ?c ?f ?p)))
		:effect (and
			(when (and
			(at_1 ?f ?p)
			(not (underground_1))
			(coin-at_1 ?c ?f ?p)
			(at_2 ?f ?p)
			(not (underground_2))
			(coin-at_2 ?c ?f ?p)) (and
			(oneof (and
			(not (coin-at_1 ?c ?f ?p))
			(have_1 ?c)))
			(oneof (and
			(not (coin-at_2 ?c ?f ?p))
			(have_2 ?c))))))
	)


	(:action move-to-first-floor2
		:parameters (?f1 - floor ?p1 - pos)
		:precondition (and (not (= ?f1 ?p1)) 
			(and (not (at_2 ?f1 ?p1))
			(is-first-position_2 ?p1)
			(is-first-floor_2 ?f1)
			(underground_2)))
		:effect (and
			(when (and
			(not (at_1 ?f1 ?p1))
			(is-first-position_1 ?p1)
			(is-first-floor_1 ?f1)
			(underground_1)
			(not (at_2 ?f1 ?p1))
			(is-first-position_2 ?p1)
			(is-first-floor_2 ?f1)
			(underground_2)) (and
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
			(and (not (underground_2))
			(in_2 ?e ?f)
			(dec_f_2 ?f ?nf)))
		:effect (and
			(when (and
			(not (underground_1))
			(in_1 ?e ?f)
			(dec_f_1 ?f ?nf)
			(not (underground_2))
			(in_2 ?e ?f)
			(dec_f_2 ?f ?nf)) (and
			(oneof (and
			(in_1 ?e ?nf)
			(not (in_1 ?e ?f))))
			(oneof (and
			(in_2 ?e ?nf)
			(not (in_2 ?e ?f)))))))
	)


	(:action step-in2
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (not (underground_2))
			(in_2 ?e ?f)
			(shaft_2 ?e ?p)
			(at_2 ?f ?p)))
		:effect (and
			(when (and
			(not (underground_1))
			(in_1 ?e ?f)
			(shaft_1 ?e ?p)
			(at_1 ?f ?p)
			(not (underground_2))
			(in_2 ?e ?f)
			(shaft_2 ?e ?p)
			(at_2 ?f ?p)) (and
			(oneof (and
			(inside_1 ?e)
			(not (at_1 ?f ?p))))
			(oneof (and
			(inside_2 ?e)
			(not (at_2 ?f ?p)))))))
	)


	(:action step-out2
		:parameters (?e - elevator ?f - floor ?p - pos)
		:precondition (and (not (= ?e ?f)) (not (= ?e ?p)) (not (= ?f ?p)) 
			(and (inside_2 ?e)
			(in_2 ?e ?f)
			(not (underground_2))
			(shaft_2 ?e ?p)))
		:effect (and
			(when (and
			(inside_1 ?e)
			(in_1 ?e ?f)
			(not (underground_1))
			(shaft_1 ?e ?p)
			(inside_2 ?e)
			(in_2 ?e ?f)
			(not (underground_2))
			(shaft_2 ?e ?p)) (and
			(oneof (and
			(not (inside_1 ?e))
			(at_1 ?f ?p)))
			(oneof (and
			(not (inside_2 ?e))
			(at_2 ?f ?p))))))
	)


	(:action move-left-gate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p_2 ?p ?np)
			(at_2 ?f ?p)
			(gate_2 ?f ?p)
			(not (underground_2))))
		:effect (and
			(when (and
			(dec_p_1 ?p ?np)
			(at_1 ?f ?p)
			(gate_1 ?f ?p)
			(not (underground_1))
			(dec_p_2 ?p ?np)
			(at_2 ?f ?p)
			(gate_2 ?f ?p)
			(not (underground_2))) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)) (and
			(not (at_1 ?f ?p))
			(underground_1)))
			(dec_p_1 ?np ?p)
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np)) (and
			(not (at_2 ?f ?p))
			(underground_2)))
			(not (dec_p_2 ?np ?p))))
			
				(when (not (dec_p_2 ?p ?np)) (and
			(p_psi)))
				(when (not (at_2 ?f ?p)) (and
			(p_psi)))
				(when (not (gate_2 ?f ?p)) (and
			(p_psi)))
				(when (underground_2) (and
			(p_psi)))
			
				(when (not (dec_p_1 ?p ?np)) (and
			(p_psi)))
				(when (not (at_1 ?f ?p)) (and
			(p_psi)))
				(when (not (gate_1 ?f ?p)) (and
			(p_psi)))
				(when (underground_1) (and
			(p_psi))))
	)


	(:action move-left-gate300
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p_1 ?np ?p)
			(not (dec_p_2 ?np ?p))))
		:effect (and
			(p_psi))
	)


	(:action move-left-nogate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (not (underground_2))
			(at_2 ?f ?p)
			(not (gate_2 ?f ?p))
			(dec_p_2 ?p ?np)))
		:effect (and
			(when (and
			(not (underground_1))
			(at_1 ?f ?p)
			(not (gate_1 ?f ?p))
			(dec_p_1 ?p ?np)
			(not (underground_2))
			(at_2 ?f ?p)
			(not (gate_2 ?f ?p))
			(dec_p_2 ?p ?np)) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)))
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np))))))
	)


	(:action move-right-gate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p_2 ?np ?p)
			(at_2 ?f ?p)
			(not (underground_2))
			(gate_2 ?f ?p)))
		:effect (and
			(when (and
			(dec_p_1 ?np ?p)
			(at_1 ?f ?p)
			(not (underground_1))
			(gate_1 ?f ?p)
			(dec_p_2 ?np ?p)
			(at_2 ?f ?p)
			(not (underground_2))
			(gate_2 ?f ?p)) (and
			(oneof (and
			(not (at_1 ?f ?p))
			(at_1 ?f ?np)) (and
			(not (at_1 ?f ?p))
			(underground_1)))
			(oneof (and
			(not (at_2 ?f ?p))
			(at_2 ?f ?np)) (and
			(not (at_2 ?f ?p))
			(underground_2))))))
	)


	(:action move-right-nogate2
		:parameters (?f - floor ?p - pos ?np - pos)
		:precondition (and (not (= ?f ?p)) (not (= ?f ?np)) (not (= ?p ?np)) 
			(and (dec_p_2 ?np ?p)
			(at_2 ?f ?p)
			(not (gate_2 ?f ?p))
			(not (underground_2))))
		:effect (and
			(when (and
			(dec_p_1 ?np ?p)
			(at_1 ?f ?p)
			(not (gate_1 ?f ?p))
			(not (underground_1))
			(dec_p_2 ?np ?p)
			(at_2 ?f ?p)
			(not (gate_2 ?f ?p))
			(not (underground_2))) (and
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
			(and (at_2 ?f ?p)
			(not (underground_2))
			(coin-at_2 ?c ?f ?p)))
		:effect (and
			(when (and
			(at_1 ?f ?p)
			(not (underground_1))
			(coin-at_1 ?c ?f ?p)
			(at_2 ?f ?p)
			(not (underground_2))
			(coin-at_2 ?c ?f ?p)) (and
			(oneof (and
			(not (coin-at_1 ?c ?f ?p))
			(have_1 ?c)))
			(oneof (and
			(not (coin-at_2 ?c ?f ?p))
			(have_2 ?c))))))
	)
)