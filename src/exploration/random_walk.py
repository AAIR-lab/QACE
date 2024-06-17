#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import random

def get_action_lists(actions,
                     state, action_cache, model,
                     shuffle=True):

    learned_actions_to_try = []
    unlearned_actions_to_try = []
    for a in actions:

        action_name = a.predicate.name
        if action_name in action_cache:

            action = model.actions[action_name]
            action = action.ground(a.variables, with_copy=True)
            if action.preconds.holds(state.literals | {a}):

                learned_actions_to_try.append(a)
        else:
            unlearned_actions_to_try.append(a)

    if shuffle:
        random.shuffle(learned_actions_to_try)
        random.shuffle(unlearned_actions_to_try)

    return learned_actions_to_try, \
        unlearned_actions_to_try


def random_walk(simulator,
                action_cache,
                learned_model,
                horizon=40,
                num_tries=float("inf")):

    total_steps = 0
    try_no = 0
    learned_model = learned_model.flatten(with_copy=True)
    learned_model = learned_model.optimize(with_copy=False)
    actions = simulator.get_actions()
    initial_state = simulator.get_initial_state()

    while try_no < num_tries:

        simulator.set_state(initial_state)
        state = simulator.get_state()
        old_state = None
        h = 0

        while h < horizon:
            h += 1

            if old_state != state:

                learned_actions, unlearned_actions = get_action_lists(
                    actions,
                    state,
                    action_cache,
                    learned_model)

            old_state = state

            # Try all unlearned actions first.
            while len(unlearned_actions) > 0:

                action = unlearned_actions.pop()
                next_state, _, _, _ = simulator.step(action)
                total_steps += 1
                execution_status = simulator.get_step_execution_status()

                if execution_status:

                    action_cache[action.predicate.name] = state
                    return total_steps, action.predicate.name
                else:
                    assert state.literals == next_state.literals

            if len(learned_actions) == 0:

                h = horizon
            else:
                action = learned_actions.pop()
                state, _, _, _ = simulator.step(action)
                total_steps += 1
                execution_status = simulator.get_step_execution_status()
                assert execution_status

    return total_steps, None
