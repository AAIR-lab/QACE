#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import copy
import time
import config
import random
import importlib
import itertools

from utils import *
from config import *
from itertools import combinations
from exploration import random_walk
from lattice import LatticeNode, Lattice
from pddlgym.structs import Literal as Ltr
from pddlgym.structs import Predicate, LiteralConjunction, ProbabilisticEffect


class AgentInterrogation:
    """
    :param agent: actual agent model
    :type agent: object of class Model
    :param abstract_model: model at the most abstracted node in the lattice
    :type abstract_model: object of class Model
    :param objects: Initial state of the problem
    :type objects: dict of (str,str)
    :param domain_name: Name of the domain
    :type domain_name: String
    :param abstract_predicates:
    :param pred_type_mapping:
    :param action_parameters:
    :param types:

    """

    def __init__(self, agent, abstract_model, problem, query_files_dir, am,
                 evaluation_func, sampling_count, randomize=False,
                 should_count_sdm_samples=True,
                 explore_mode="all_bfs"):
        self.agent = agent
        self.am = am
        self.abstract_model = abstract_model
        self.sample_problem = problem
        self.randomize = randomize
        self.learned_preconditions = []
        self.predicates = abstract_model.predicates
        self.actions = abstract_model.actions
        abstract_model.predicates = {}
        self.sample_count_used = 0 # Track number of s,a,s' used
        self.learned_effects = []
        self.preconds_learned = {}
        self.effects_learned = {}
        self.effect_dict = {}
        self.query_files_dir = query_files_dir
        self.learning_phase = Location.PRECOND
        self.current_pal_tuple = None
        self.useful_states = {}
        self.init_pal_tuple_dict()
        self.query_number = 0
        self.NUM_PAL_TUPLES = None
        self.sampling_count = sampling_count
        self.itr = 0
        self.evaluation_func = evaluation_func

        assert isinstance(should_count_sdm_samples, bool)
        self.should_count_sdm_samples = int(should_count_sdm_samples)

        # This map stores a cache of 1 state per applicable action
        # This helps reduce the total environment interactions
        self.applicable_action_state_cache = {}
        self.explore_mode = explore_mode

    def product_dict(self, **kwargs):
        keys = kwargs.keys()
        vals = kwargs.values()
        for instance in itertools.product(*vals):
            yield dict(zip(keys, instance))

    def get_compatible_literals(self, action, predicate):
        mapping = {}
        for i in range(len(predicate.var_types)):
            _v = predicate.var_types[i]
            action_var_list = list(map(lambda x: x.var_type, action.params))
            if action_var_list.count(_v) > 1:
                indices = [i for i in range(len(action_var_list)) if action_var_list[i] == _v]
                mapping[i] = indices
            elif action_var_list.count(_v) == 1:
                mapping[i] = [action_var_list.index(_v)]
            else:
                return None

        literal_mapping = list(dict(zip(mapping, x)) for x in itertools.product(*mapping.values()))
        poss_values = []
        for i in literal_mapping:
            t = []
            k = list(i.values())
            for j in k:
                if k.count(j) >1:
                    break
                t.append(action.params[j])
            if len(t) == len(k):
                poss_values.append(t)
        return poss_values

    def collect_pals_for_action(self, action_name):

        if action_name is None:
            return self.preconds_learned, self.effects_learned

        preconds_learned = {}
        for pal in self.preconds_learned:
            if action_name in pal:
                preconds_learned[pal] = self.preconds_learned[pal]

        effects_learned = {}
        for pal in self.effects_learned:
            if action_name in pal:
                effects_learned[pal] = self.effects_learned[pal]

        return preconds_learned, effects_learned

    def init_pal_tuple_dict(self):
        for _a in self.actions.keys():
            for _p in self.predicates.keys():
                if not self.predicates[_p].var_types:
                    l = Ltr(self.predicates[_p],[])
                    s = set([_a, l])
                    # Change to True for testing of effect learning
                    self.preconds_learned[frozenset(s)] = False
                    self.effects_learned[frozenset(s)] = False
                    if l not in self.useful_states.keys():
                        self.useful_states[l] = {Literal.NP: None, Literal.AP: None}
                else:
                    indexes = self.get_compatible_literals(self.actions[_a],self.predicates[_p])
                    if indexes is not None:
                        for _l in indexes:
                            l = Ltr(self.predicates[_p], _l)
                            s = set([_a,l])
                            # Change to True for testing of effect learning
                            self.preconds_learned[frozenset(s)] = False
                            self.effects_learned[frozenset(s)] = False
                            if l not in self.useful_states.keys():
                                self.useful_states[l] = {Literal.AN : None, Literal.AP : None}
                            
        self.NUM_PAL_TUPLES = len(self.preconds_learned) \
            + len(self.effects_learned)

    def get_action_for_current_pal_tuple(self):
        for _i in self.current_pal_tuple:
            if isinstance(_i, str) and _i in self.actions.keys():
                return _i
        return None

    def set_current_pal_tuple(self):
        for _i in self.current_pal_tuple:
            if isinstance(_i, str) and _i in self.actions.keys():
                _a = _i
            elif isinstance(_i, Ltr):
                l = _i
        s = set([_a, l])
        assert (frozenset(s) in self.preconds_learned.keys())
        if self.current_pal_tuple[2] == Location.PRECOND:
            self.preconds_learned[frozenset(s)] = True
        else:
            self.effects_learned[frozenset(s)] = True

    def get_next_pal_tuple(self, preconds_learned, effects_learned):
        pa_tuple = None
        if self.learning_phase == Location.PRECOND and False in preconds_learned.values():
            if True not in preconds_learned.values():
                # Special case for first pal tuple
                # TODO: Buggy if init state is empty
                temp_preconds_learned = copy.deepcopy(preconds_learned)
                while True:
                    pa_tuple = list(filter(lambda x: temp_preconds_learned[x] is False, temp_preconds_learned))[0]
                    predicate = None
                    for i in pa_tuple:
                        if isinstance(i, Ltr) and i.predicate.name in self.predicates.keys():
                            predicate = copy.deepcopy(i)
                    init_state_preds = set(map(lambda x: str(x).split("(")[0], self.sample_problem.initial_state.literals))
                    if predicate.predicate.name in init_state_preds:
                        break
                    else:
                        temp_preconds_learned.pop(pa_tuple)
            pa_tuple_list = list(filter(lambda x: preconds_learned[x] is False, preconds_learned))
            if self.randomize:
                pa_tuple = random.choice(pa_tuple_list)
            else:
                pa_tuple = pa_tuple_list[0]
        else:
            self.learning_phase = Location.EFFECTS
            if False in effects_learned.values():
                pa_tuple_list = list(filter(lambda x: effects_learned[x] is False, effects_learned))
                if self.randomize:
                    pa_tuple = random.choice(pa_tuple_list)
                else:
                    pa_tuple = pa_tuple_list[0]
            else:
                return None

        if pa_tuple is None:
            return pa_tuple

        for i in pa_tuple:
            if i in self.actions.keys():
                action = copy.deepcopy(i)
            else:
                predicate = copy.deepcopy(i)

        self.current_pal_tuple = [predicate, action, self.learning_phase]

        return self.current_pal_tuple

    def make_precond_inference(self, model1, model2, policy, ps_query, type_comp):
        agent_response = ps_query.can_execute_action(self.agent.domain, policy, 0, type_comp, self.useful_states, problem=self.sample_problem)

        m1_response = ps_query.can_execute_action(model1, policy, 1, type_comp, self.useful_states)
        m2_response = ps_query.can_execute_action(model2, policy, 2, type_comp, self.useful_states)
        assert ((agent_response) or ( m1_response) or ( m2_response))

        return (m1_response != agent_response), (m2_response != agent_response)

    def analyze_samples(self, samples, model):
        for s in samples:
            self.sample_count_used += len(s)

            if len(s) == 0:
                continue

            for pre_state, action, post_state, execution_status in s:
                if execution_status:

                    action_name = action[0]
                    action_vars = action[1]
                    action_name = re.sub(r'\d', '', action_name) # If any action has my added action
                    action_object = model.actions[action_name]
                    action_params = action_object.params
                    assert len(action_params) == len(action_vars)

                    action_preconditions = action_object.preconds
                    ground_preconditions = []
                    for _lit in action_preconditions.literals:
                        precond_var = []
                        for _v in _lit.variables:
                            precond_var.append(action_vars[action_params.index(_v)])
                        ground_preconditions.append(Ltr(_lit.predicate, precond_var))

                    ## Check if precond Satisfied --- Sanity check
                    for g in ground_preconditions:
                        if g not in pre_state and g.is_negative:
                            continue

                    extra_literals = post_state.literals - pre_state.literals
                    missing_literals = pre_state.literals - post_state.literals
                    new_effect = []
                    for _lit in extra_literals:
                        lit_ground = []
                        for _v in _lit.variables:
                            lit_ground.append(action_params[action_vars.index(_v)])
                        new_effect.append(Ltr(_lit.predicate, lit_ground))
                    for _lit in missing_literals:
                        lit_ground = []
                        for _v in _lit.variables:
                            lit_ground.append(action_params[action_vars.index(_v)])
                        new_effect.append(Ltr(_lit.predicate.inverted_anti, lit_ground))
                        # new_effect.append(Ltr(_lit.predicate, precond_var))
                    new_effect = frozenset(set(new_effect))
                    if action_name not in self.effect_dict.keys():
                        self.effect_dict[action_name] = {new_effect: 1}
                    elif new_effect in self.effect_dict[action_name].keys():
                        self.effect_dict[action_name][new_effect] += 1
                    else:
                        self.effect_dict[action_name][new_effect] = 1

        for action_name, effects in self.effect_dict.items():
            assert action_name in model.actions.keys()
            all_effects = copy.deepcopy(model.actions[action_name].effects.literals)
            assert (len(all_effects) == 0 or isinstance(all_effects[0], ProbabilisticEffect))
            existing_effects = []
            old_effects = False
            updated = False
            if len(all_effects) > 0:
                old_effects = True
                for _e in all_effects[0].literals:
                    if isinstance(_e, Ltr):
                        continue  # To handle existing nochange
                    existing_effects.append(frozenset(set(list(_e.literals))))

            # We learn only effect of this type
            for effect in effects.keys():
                if effect == frozenset():
                    mod_effect = Predicate("NOCHANGE", 0)
                else:
                    mod_effect = LiteralConjunction(list(effect))

                if (effect not in existing_effects) and old_effects:
                    all_effects[0].literals.append(mod_effect)
                    all_effects[0].probabilities.append(0)
                elif (effect not in existing_effects):
                    all_effects.append(mod_effect)
                    updated = True

            if updated:
                probs = [0]*(len(all_effects))
                prob_effect = ProbabilisticEffect(all_effects, probs)
                prob_effect.is_flattened = True
                model.actions[action_name].effects = LiteralConjunction([prob_effect])

            if config.OVERRIDE_ACTION_EFFECTS_WHEN_ANALYZING_SAMPLES:
                for action_name, effects in self.effect_dict.items():
                    new_effects = [LiteralConjunction(list(effect)) for effect in effects]
                    if LiteralConjunction([]) in new_effects:
                        new_effects.remove(LiteralConjunction([]))
                    new_probs = [0] * len(new_effects)
                    prob_effect = ProbabilisticEffect(new_effects, new_probs)
                    model.actions[action_name].effects = LiteralConjunction([prob_effect])

    def make_effects_inference(self, policy, model, initial_state):
        samples = self.agent.generate_samples(
            policy,
            initial_state=initial_state,
            sampling_count=self.sampling_count)
        self.analyze_samples(samples, model)
        return [model]

    def populate_probabilities(self, model):
        for action_name, t_effects in self.effect_dict.items():
            effects = copy.deepcopy(t_effects)
            factor = 1.0 / sum(effects.values())
            for k in effects:
                effects[k] = effects[k] * factor

            idx = 0
            for _i in model.actions[action_name].effects.literals[0].literals:
                if isinstance(_i, Ltr) and _i.predicate.name.lower() == "nochange":
                    if frozenset(set()) in effects.keys():
                        val = effects[frozenset(set())]
                    else:
                        val = 0
                    model.actions[action_name].effects.literals[0].probabilities[idx] = val
                    idx += 1
                    continue
                key = frozenset(set(list(_i.literals)))
                if key in effects.keys():
                    model.actions[action_name].effects.literals[0].probabilities[idx] = effects[key]
                idx += 1

        return model


    def interrogate(self):
        assert self.should_count_sdm_samples
        self.elapsed_learning_time = 0

        if self.explore_mode == "random_walk":
            learned_model = self.abstract_model
            while len(self.applicable_action_state_cache) != len(self.actions):
                total_steps, action_name = random_walk.random_walk(
                    self.agent.get_simulator(),
                    self.applicable_action_state_cache,
                    learned_model)
                self.sample_count_used += total_steps
                assert action_name is not None
                learned_model = self.agent_interrogation_algo(action_name)

        elif self.explore_mode == "all_bfs":
            total_steps = self.agent.initialize_applicable_action_cache(
                self.applicable_action_state_cache)
            self.sample_count_used += total_steps
            learned_model = self.agent_interrogation_algo(None)

        print("Yayy!! All Done")
        return learned_model

    def agent_interrogation_algo(self, action_name=None):
        ps_query_module = importlib.import_module("query.ps_query")
        init_state = {}
        latt = Lattice()
        lattice_node = LatticeNode(latt, [self.abstract_model], self.abstract_model.predicates)

        # int_parent_models holds the possible models at any given point of time.
        int_parent_models = [self.abstract_model]

        self.learning_phase = Location.PRECOND
        preconds_learned, effects_learned = self.collect_pals_for_action(action_name)

        next_pal_tuple = self.get_next_pal_tuple(preconds_learned, effects_learned)
        init_state = self.sample_problem.initial_state

        valid_models = None
        learning_time = time.time()
        while True:
            if next_pal_tuple is None:
                # All possible refinements over
                # int_parent_models should be holding possible models at most concretized level
                break
            print("NEXT PAL TUPLE: ", next_pal_tuple)
            modes = [Literal.POS, Literal.NEG, Literal.ABS]

            for temp_abs_model in int_parent_models:
                pred = next_pal_tuple[0]
                action = next_pal_tuple[1]
                ref = next_pal_tuple[2]

                # partitions stores the partitions for a refinement next_pal_tuple when called on
                # a model temp_abs_model
                intermediate_models = lattice_node.get_model_partitions(temp_abs_model, pred,
                                                                        ref, action, tuple(modes))
                # Run query and discard models here
                # Remove all invalid models and store only the valid ones
                valid_models = [i for i in intermediate_models if not i.discarded]

                # Generate all possible combinations of models
                for m1, m2 in combinations(valid_models, 2):
                    if m1.discarded or m2.discarded:
                        continue
                    type_comp = type_comparison(m1.mode, m2.mode)

                    ps_query = ps_query_module.Query(
                        self.agent, self.query_files_dir, m1, m2, init_state,
                        next_pal_tuple, self.sample_problem,
                        self.learning_phase, preconds_learned,
                        self.applicable_action_state_cache, qno=self.query_number)

                    policy, self.query_number, new_init_state = ps_query.get_policy_from_query(agent_model=self.am)

                    # Count any steps that the query took as interactions
                    # with the environment.
                    assert ps_query.bfs_steps == 0
                    self.sample_count_used += \
                        self.should_count_sdm_samples * ps_query.bfs_steps

                    if self.learning_phase == Location.PRECOND:
                        m1.discarded, m2.discarded = self.make_precond_inference(m1, m2, policy, ps_query, type_comp)
                    if self.learning_phase == Location.EFFECTS:
                        valid_models = self.make_effects_inference(policy, temp_abs_model, new_init_state)
                        break

                valid_models = [i for i in valid_models if not i.discarded]
                self.set_current_pal_tuple()
                break
            int_parent_models = [i for i in valid_models if not i.discarded]
            
            learning_time = time.time() - learning_time
            evaluation_model = copy.deepcopy(valid_models[0])
            evaluation_model.predicates = copy.deepcopy(self.am.predicates)
            evaluation_model.action_predicate_map = self.am.action_predicate_map
            evaluation_model = self.populate_probabilities(evaluation_model)

            self.elapsed_learning_time += learning_time
            self.evaluation_func(
                evaluation_model=evaluation_model,
                itr=self.sample_count_used,
                num_pal_tuples=self.NUM_PAL_TUPLES,
                output_dir=ps_query.get_directory_for_query_number(
                    self.query_number),
                elapsed_time=self.elapsed_learning_time,
                query_number=self.query_number)
            
            learning_time = time.time()

            preconds_learned, effects_learned = self.collect_pals_for_action(action_name)
            self.current_pal_tuple = self.get_next_pal_tuple(preconds_learned, effects_learned)
            if self.current_pal_tuple is None:
                # Learned all tuples
                assert len(valid_models) == 1
                valid_models = valid_models[0]
                break
            next_pal_tuple = self.current_pal_tuple

        learned_model = self.populate_probabilities(valid_models)
        learned_model.action_predicate_map = self.am.action_predicate_map

        self.abstract_model = learned_model
        assert not self.abstract_model.is_optimized
        return learned_model
