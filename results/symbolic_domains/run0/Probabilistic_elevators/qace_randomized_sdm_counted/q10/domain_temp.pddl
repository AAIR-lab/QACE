
(define (domain elevators)
(:requirements :typing :strips :non-deterministic :disjunctive-preconditions :conditional-effects :negative-preconditions :equality)
(:types floor pos elevator coin)
(:predicates (dec_f_1 ?v0 - floor ?v1 - floor) (dec_f_2 ?v0 - floor ?v1 - floor) (dec_p_1 ?v0 - pos ?v1 - pos) (dec_p_2 ?v0 - pos ?v1 - pos) (in_1 ?v0 - elevator ?v1 - floor) (in_2 ?v0 - elevator ?v1 - floor) (at_1 ?v0 - floor ?v1 - pos) (at_2 ?v0 - floor ?v1 - pos) (shaft_1 ?v0 - elevator ?v1 - pos) (shaft_2 ?v0 - elevator ?v1 - pos) (inside_1 ?v0 - elevator) (inside_2 ?v0 - elevator) (gate_1 ?v0 - floor ?v1 - pos) (gate_2 ?v0 - floor ?v1 - pos) (coin-at_1 ?v0 - coin ?v1 - floor ?v2 - pos) (coin-at_2 ?v0 - coin ?v1 - floor ?v2 - pos) (have_1 ?v0 - coin) (have_2 ?v0 - coin) (underground_1) (underground_2) (is-first-floor_1 ?v0 - floor) (is-first-floor_2 ?v0 - floor) (is-first-position_1 ?v0 - pos) (is-first-position_2 ?v0 - pos) (move-to-first-floor_1 ?v0 - floor ?v1 - pos) (move-to-first-floor_2 ?v0 - floor ?v1 - pos) (go-up_1 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-up_2 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-down_1 ?v0 - elevator ?v1 - floor ?v2 - floor) (go-down_2 ?v0 - elevator ?v1 - floor ?v2 - floor) (step-in_1 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-in_2 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-out_1 ?v0 - elevator ?v1 - floor ?v2 - pos) (step-out_2 ?v0 - elevator ?v1 - floor ?v2 - pos) (move-left-gate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-gate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-nogate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-left-nogate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-gate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-gate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-nogate_1 ?v0 - floor ?v1 - pos ?v2 - pos) (move-right-nogate_2 ?v0 - floor ?v1 - pos ?v2 - pos) (collect_1 ?v0 - coin ?v1 - floor ?v2 - pos) (collect_2 ?v0 - coin ?v1 - floor ?v2 - pos) (p_psi))


	(:action move-to-first-floor
		:parameters (?f1 - floor ?p1 - pos)
		:precondition (and (not (= ?f1 ?p1)) 
			(and (is-first-position_2 ?p1)
			(not (at_2 ?f1 ?p1))
			(is-first-floor_2 ?f1)))
		:effect (and
			(p_psi))
	)
)