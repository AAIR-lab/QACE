#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import pathlib
sys.path.append("%s/../" % (pathlib.Path(__file__).parent))

import re
import gym
import config
import collections

from model import Model
from planner.prp import PRP
from utils import learning_utils
from pddlgym.structs import Literal, State


class Agent:
    def __init__(self, domain, problem):
        
        self.domain = domain
        self.problem = problem
        self.model = Model(domain)

    def get_domain(self):
        return self.domain

    def get_problem(self):
        return self.problem
        
class BFSAgent(Agent):
    
    DEFAULT_FILTER_FUNC = lambda _s, _a, _s_dash, _depth: True
    DEFAULT_STORAGE_FUNC = lambda _s, _a, _s_dash, _depth: (_s, _a, _s_dash, _depth)
    
    def __init__(self, gym_domain_name,
                 problem_idx,
                 problems,
                 params={},
                 base_dir=None,
                 dynamic_action_space=True,
                 monte_carlo_steps=float("-inf")):
        
        self.gym_domain_name = gym_domain_name
        self.problem_idx = problem_idx
        self.problems= problems
        self.monte_carlo_steps = monte_carlo_steps
        self.env = gym.make(
            "PDDLEnv{}-v0".format(gym_domain_name), 
            raise_error_on_invalid_action=dynamic_action_space,
            dynamic_action_space=dynamic_action_space,
            grounded_actions_in_state=config.SHOULD_FIND_GYM_ACTION_PREDS)
        self.env.fix_problem_index(self.problem_idx)
        _ = self.env.reset()
        
        domain, problem = learning_utils.extract_elements(
            self.env,
            self.problem_idx)
        
        super(BFSAgent, self).__init__(domain, problem)
        
        # TODO: Can store simulation logs there.
        assert base_dir is None
    
    def generate_state_samples(self, 
        pddlgym_state=None,
        max_depth=float("inf"),
        max_samples=float("inf"),
        filter_func = DEFAULT_FILTER_FUNC,
        storage_func = DEFAULT_STORAGE_FUNC):

        _ = self.env.reset()
        
        if pddlgym_state is not None:
            self.set_state(pddlgym_state)
        
        initial_state = self.env.get_state()
        fringe = collections.deque()
        visited = set()
        
        # previous_state, action_used, next_state, depth
        # First two terms are for debug.
        fringe.append((None, None, initial_state, 0))
        samples = []

        # A step in the environment is whenever we use a transition
        # to add an (s, a, s') tuple to the fringe.
        #
        # An SDM agent can be imagined to take so many "steps" in the
        # agent in RL mode in such a case and this would be the minimum
        # number of steps required (in the stochastic case).
        total_steps = 0

        while len(fringe) > 0 \
            and len(samples)  < max_samples:

            prev_state, action, state, depth = fringe.popleft()
            # Only add to samples if it passes the filter.
            if filter_func(prev_state, action, state, depth):
                samples.append(storage_func(prev_state, action, state, 
                                            depth))
            
            if state.literals in visited or depth >= max_depth:
                continue
            else:
                visited.add(state.literals)
                self.env.set_state(state)
                actions = self.env.get_applicable_actions()
                for action in actions:
                    self.env.set_state(state)

                    if self.env.domain.is_probabilistic \
                        and self.monte_carlo_steps == float("-inf"):

                        successors = self.env.get_all_possible_transitions(action)
                    else:
                        successors = []
                        for _ in range(self.monte_carlo_steps):
                            self.env.set_state(state)
                            next_state, _, _, _ = self.env.step(action)
                            successors.append(next_state)

                            # Do not do MC if a failure status is returned.
                            # End the markove chain here.
                            if not self.env.get_step_execution_status():
                                break

                    total_steps += len(successors)
                    fringe.extend([(state, action, x, depth + 1) for x in successors])

        return samples, total_steps
    
    @staticmethod
    def example(gym_domain_name, problem_idx):
        
        print("Running BFS agent example")
        agent = BFSAgent(gym_domain_name, problem_idx, None)
        samples = agent.generate_state_samples()
        print(samples)
        
        
class PRPAgent(Agent):
    
    def __init__(self, gym_domain_name,
                 problem_idx,
                 problems,
                 params={},
                 base_dir=None):
        
        self.gym_domain_name = gym_domain_name
        self.problem_idx = problem_idx
        self.problems = problems
        self.env = gym.make(
            "PDDLEnv{}-v0".format(gym_domain_name),
            grounded_actions_in_state=config.SHOULD_FIND_GYM_ACTION_PREDS)
        self.env.fix_problem_index(self.problem_idx)
        _ = self.env.reset()

        domain, problem = learning_utils.extract_elements(
            self.env,
            self.problem_idx)
        
        super(PRPAgent, self).__init__(domain, problem)

        self.problem.initial_state = State(self.problem.initial_state,
                                           self.problem.objects,
                                           self.problem.goal)

        # TODO: Can store simulation logs there.
        assert base_dir is None
        
        self.horizon = params.get("horizon", 40)
        self.naming_map = params.get("naming_map", {})
        self.args_func_map = params.get("args_func_map")

    def get_simulator(self):
        return self.env

    def get_state_where_action_is_applicable(self, action_name):
        
        filter_func = lambda s, a, s_dash, depth: a is not None \
            and a.predicate.name == action_name
        storage_func = lambda s, a, s_dash, depth: s.literals
        
        print("Finding for ", action_name)
        samples, total_steps = self.get_transitions(filter_func=filter_func,
                                    storage_func=storage_func,
                                    max_samples=1)
        
        return (None, total_steps) if len(samples) == 0 else (samples[0], total_steps)

    def initialize_applicable_action_cache(self, applicable_action_cache):

        class ActionFilter:

            def __init__(self, prp_agent, action_names):

                self.prp_agent = prp_agent
                self.action_names = action_names
                self.stored_actions = {}
            def filter(self, s, a, s_dash, depth):

                if a is not None \
                    and a.predicate.name not in self.stored_actions \
                    and self.prp_agent.get_execution_status(s, a):

                    self.stored_actions[a.predicate.name] = s
                    return True

            def storage(self, s, a, s_dash, depth):
                return s

        action_names = self.domain.actions
        action_filter = ActionFilter(self, action_names)

        _, total_steps = self.get_transitions(
            filter_func=action_filter.filter,
            storage_func=action_filter.storage,
            max_samples=len(action_names))

        assert len(action_filter.stored_actions) == len(action_names)
        for action_name in action_filter.stored_actions:

            applicable_action_cache[action_name] = \
                action_filter.stored_actions[action_name]

        return total_steps

    def get_transitions(self, filter_func=BFSAgent.DEFAULT_FILTER_FUNC,
                        storage_func=BFSAgent.DEFAULT_STORAGE_FUNC,
                        max_samples=float("inf"),
                        max_depth=float("inf"),
                        monte_carlo_steps=5):
        
        bfs_agent = BFSAgent(self.gym_domain_name,
                             self.problem_idx,
                             None,
                             dynamic_action_space=False,
                             monte_carlo_steps=monte_carlo_steps)
        
        samples = bfs_agent.generate_state_samples(
            max_samples=max_samples,
            max_depth=max_depth,
            filter_func=filter_func,
            storage_func=storage_func)
        
        return samples
            
    @staticmethod
    def example_get_transitions(gym_domain_name, problem_idx):

        agent = PRPAgent(gym_domain_name, problem_idx, None,
                         params={
                             "horizon": 100,
                             "naming_map": {},
                             "args_func_map": {}
                             })
        transitions = agent.get_transitions(max_samples=10)
        return transitions
        
    @staticmethod
    def example_get_state_where_action_is_applicable(gym_domain_name, 
                                                     problem_idx,
                                                     action_name):
        
        agent = PRPAgent(gym_domain_name, problem_idx, None,
                         params={
                             "horizon": 100,
                             "naming_map": {},
                             "args_func_map": {}
                             })
        goal_state = agent.get_state_where_action_is_applicable(action_name)
        print(goal_state)
            
    def generate_samples(self, policy, initial_state=None,
                         sampling_count=config.SAMPLING_COUNT):
        
        policy.transform_to_pddlgym(self.problem)
        all_samples = []
        for _i in range(sampling_count):
            samples = PRP.generate_pddlgym_samples_using_policy(
                self.env,
                self.domain,
                self.problem,
                policy,
                initial_state=initial_state,
                H=40,
                naming_map=self.naming_map,
                args_func_map=self.args_func_map)
            all_samples.append(samples)
        
        return all_samples

    def get_execution_status(self, state, action, s_dash=None):

        if not isinstance(action, Literal):
            action_name = action[0]
            action_params = action[1]
            action_name = re.sub(r'\d', '', action_name)
            action = self.domain.predicates[action_name](*action_params)

        return self.env.is_action_applicable(action, state=state)

    @staticmethod
    def example_get_execution_status(gym_domain_name, problem_idx):

        agent = PRPAgent(gym_domain_name, problem_idx, None,
                         params={
                             "horizon": 100,
                             "naming_map": {},
                             "args_func_map": {}
                         })

        state = agent.env.get_state()
        applicable_actions = set(agent.env.get_actions(state=state, applicable_only=True))
        all_actions = set(agent.env.get_actions(state=state, applicable_only=False))

        # This example is not valid if every action is applicable.
        assert len(applicable_actions) != len(all_actions)

        for action_list, expect_status in [(all_actions - applicable_actions, False),
                                           (applicable_actions, True)]:
            for action in action_list:

                assert agent.get_execution_status(state, action) == expect_status

        pass

if __name__ == "__main__":
    
    # BFSAgent.example("Tireworld", 2)
    PRPAgent.example_get_execution_status("Tireworld", 0)
