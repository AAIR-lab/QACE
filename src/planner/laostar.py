#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import pathlib
sys.path.append("%s/../" % (pathlib.Path(__file__).parent))

import os
import re
import gym
import copy
import utils
import config
import tempfile
import subprocess
import networkx as nx

from model import Model
from planner.prp import PRP
from utils.file_utils import FileUtils
from pddlgym import parser as pddlgym_parser
from pddlgym.structs import LiteralConjunction


class LAOStarPolicy:
    
    INIT_NODE_IDX = "0"
    STATE_ATOM_REGEX = re.compile("\([\w\W]*\)")
    
    @staticmethod
    def get_state_atoms_and_actions_from_vertex(node):

        label = node["label"]
        label = label.strip()
        label = label.split(" :: ")
        assert len(label) == 3
        state = label[0]
        action = label[1]
        state_atoms = []
        state = state.replace("[ ", "")
        state = state.replace(" ]", "")
        state = state.split(":")
        action = action.replace("(", "")
        action = action.replace(")", "")

        for atom in state:
            found_atoms = LAOStarPolicy.STATE_ATOM_REGEX.findall(atom)
            assert len(found_atoms) <= 1

            if len(found_atoms) == 1:
                state_atoms.append(found_atoms[0])

        return state_atoms, action
    
    @staticmethod
    def parse_policy(policy_filepath):
        
        if not os.path.exists(policy_filepath):
            return nx.MultiDiGraph()
        else:
            assert os.path.isfile(policy_filepath)
            G = nx.nx_agraph.read_dot(policy_filepath)
            return G
    
    def __init__(self, policy_filepath):
        
        self.G = LAOStarPolicy.parse_policy(policy_filepath)
        self.pddlgym_compatible = False
        self.is_executable = False
        
    def transform_to_pddlgym(self, env, model, pddlgym_problem):
        
        assert not self.pddlgym_compatible
        
        pddlgym_params = \
            {obj.name: obj.var_type for obj in pddlgym_problem.objects}
        
        pddlgym_model = copy.deepcopy(model)
        pddlgym_model.restore_action_predicates()
        
        for node in self.G.nodes:
            assert "label" in self.G.nodes[node]
            state_atoms, action = \
                LAOStarPolicy.get_state_atoms_and_actions_from_vertex(
                    self.G.nodes[node])
            
            if action.lower() == "stop":
                pddlgym_action = None
            else:
                pddlgym_action = pddlgym_parser.parse_plan_step(
                    action,
                    pddlgym_model.actions.values(),
                    env.action_space.predicates,
                    pddlgym_problem.objects)
            
            literals = set()
            for predicate in state_atoms:
                literal = PRP.convert_predicate_from_prp_to_pddlgym(
                    predicate, pddlgym_problem, pddlgym_params)
                literals.add(literal)
            
            self.G.nodes[node]["debug_state"] = state_atoms
            self.G.nodes[node]["debug_action"] = action
            self.G.nodes[node]["state"] = LiteralConjunction(literals)
            self.G.nodes[node]["action"] = pddlgym_action
            
        self.pddlgym_compatible = True
        
    def has_node(self, node_idx):
        
        return node_idx in self.G.nodes
    
    def get_action(self, node_idx):
        
        return self.G.nodes[node_idx]["action"]
    
    def holds(self, node_idx, state_literals):
        
        return self.G.nodes[node_idx]["state"].holds(state_literals)

    def get_policy_for(self, state_literals):

        for node_idx in self.G.nodes:
            if self.holds(node_idx, state_literals):
                return self.get_action(node_idx)

        return None

    def get_sucessor_node_idx(self, node_idx, state_literals):
        
        # LAOStar currently spits out states that are not complete. 
        # Rather it spits out formulae.
        # We match the longest formulae as the next rule.
        # Smaller ones should have been identified by LAOStar and included
        # more stuff to avoid this ambiguity, else we can assume that the 
        # longest match is the one to use.
        max_count = -1
        succ_node_idx = None
        for _, succ_idx, _ in self.G.out_edges(node_idx, data=True):
            
            total_count = self.G.nodes[succ_idx]["state"].count_holds(
                state_literals)
            
            if total_count > max_count:
                succ_node_idx = succ_idx
                max_count = total_count
            else:
                if not (max_count == -1 or total_count < max_count):
                    print("First")
                    print(self.G.nodes[succ_node_idx]["debug_state"])
                    print(self.G.nodes[succ_node_idx]["debug_action"])
                    print(self.G.nodes[succ_node_idx]["state"])
                    print(self.G.nodes[succ_node_idx]["action"])
                    print("Second")
                    print(self.G.nodes[succ_idx]["debug_state"])
                    print(self.G.nodes[succ_idx]["debug_action"])
                    print(self.G.nodes[succ_idx]["state"])
                    print(self.G.nodes[succ_idx]["action"])
                    print("NOT ASSERTING FOR NOW")                
        
        return succ_node_idx

class LAOStar:
    
    EXECUTABLE = "%s/dependencies/bin/laostar" % (
        config.PROJECT_ROOTDIR)
    
    SOLN_FILE_EXTENSION = "policy"
    LOG_FILE_EXTENSION = "log"
    COMBINED_FILE_EXTENSION = "combined"
    ACTION_SEPARATOR = " "
    
    def __init__(self, gym_domain_name, model=None,
                 gym_string="PDDLEnv{}Test-v0"):
        
        self.env = gym.make(
            gym_string.format(gym_domain_name),
            grounded_actions_in_state=config.SHOULD_FIND_GYM_ACTION_PREDS)
        
        self.problem_idx = 0
        self.env.fix_problem_index(self.problem_idx)
        _ = self.env.reset()
        
        self.domain, self.problem = utils.extract_elements(self.env, 
                                                 self.problem_idx)
        
        if model is None:
            self.model = Model(self.domain)
        else:
            
            self.model = copy.deepcopy(model)
            
        self.model = self.model.flatten(with_copy=False)
        self.model = self.model.optimize(with_copy=False)
    
    def get_total_problems(self):
        
        return len(self.env.problems)
    
    def set_problem_idx(self, problem_idx):
        
        self.problem_idx = problem_idx
        self.env.fix_problem_index(problem_idx)
        _ = self.env.reset()
        
        _, self.problem = utils.extract_elements(self.env, self.problem_idx)
    
    def sanitize(self, output_dir, domain_filename, problem_filename):
        
        if not output_dir:
            
            output_dir = tempfile.TemporaryDirectory()
            
        if not os.path.exists(output_dir):
            FileUtils.initialize_directory(output_dir)
            
        assert os.path.isdir(output_dir)

        if not domain_filename:
            
            domain_filename = "laostar_domain.pddl"
            
        if not problem_filename:
            
            problem_filename = "laostar_problem_%u.pddl" % (self.problem_idx)
            
        assert os.path.split(domain_filename)[0] == ""
        assert os.path.split(problem_filename)[0] == ""
        
        return output_dir, domain_filename, problem_filename
    
    def write_files(self, output_dir, domain_filename, problem_filename,
                    initial_state_literals):
        
        domain_filepath = "%s/%s" % (output_dir, domain_filename) 
        problem_filepath = "%s/%s" % (output_dir, problem_filename)
        solution_filepath = "%s/%s.%s" % (output_dir, problem_filename,
                                          LAOStar.SOLN_FILE_EXTENSION)
        log_filepath = "%s/%s.%s" % (output_dir, problem_filename,
                                     LAOStar.LOG_FILE_EXTENSION)
        
        if os.path.exists(solution_filepath):
            
            os.remove(solution_filepath)
        
        self.model.write(domain_filepath)
        self.problem.write(problem_filepath,
                           initial_state=initial_state_literals,
                           fast_downward_order=True)
        
        combined_filepath = "%s/%s.%s" % (output_dir, problem_filename,
                                          LAOStar.COMBINED_FILE_EXTENSION)
        file_handle = open(combined_filepath, "w")
        self.model.write(file_handle, with_probabilities=True)
        self.problem.write(file_handle, initial_state=initial_state_literals,
                           fast_downward_order=True)
        
        cmd_string = "exec %s %s %s %s" % (LAOStar.EXECUTABLE, 
                                      combined_filepath,
                                      self.problem.problem_name, 
                                      solution_filepath)
        
        return cmd_string, solution_filepath, log_filepath

    def solve(self, output_dir=None, 
              domain_filename=None,
              problem_filename=None,
              timelimit_in_sec=60,
              initial_state_literals=None,
              raise_exception=False):
        
        output_dir, domain_filename, problem_filename = \
            self.sanitize(output_dir, domain_filename, problem_filename)
            
        cmd_string, solution_filepath, log_filepath = self.write_files(
            output_dir,  domain_filename,  problem_filename, 
            initial_state_literals)
        
        stdout_filehandle = open(log_filepath, "w")
        
        try:
            
            subprocess.run(cmd_string, shell=True, check=True,
                           cwd=output_dir,
                           stdout=stdout_filehandle,
                           stderr=subprocess.STDOUT,
                           timeout=timelimit_in_sec)
        except Exception as e:
            
            if raise_exception:
                
                raise(e)

        policy = LAOStarPolicy(solution_filepath)
        policy.transform_to_pddlgym(self.env, self.model, self.problem)
        return policy
    
    def simulate_in_gym(self, output_dir=None,
                        domain_filename=None,
                        problem_filename=None,
                        timelimit_in_sec=None,
                        initial_state=None,
                        total_steps=float("inf")):
        
        if initial_state is not None:
            initial_state_literals = initial_state.literals
        else:
            initial_state_literals = None

        policy = self.solve(output_dir=output_dir,
                          domain_filename=domain_filename,
                          problem_filename=problem_filename,
                          timelimit_in_sec=timelimit_in_sec,
                          initial_state_literals=initial_state_literals)
        
        return self.gym_execute(policy, total_steps=total_steps,
                                initial_state=initial_state)
    
    def gym_execute(self, policy, total_steps=float("inf"),
                    initial_state=None):

        _ = self.env.reset()
        if initial_state is not None:
            
            self.env.set_state(initial_state)
            
        s = self.env.get_state()
        
        if policy.has_node(LAOStarPolicy.INIT_NODE_IDX) \
            and policy.holds(LAOStarPolicy.INIT_NODE_IDX, s.literals):

            node_idx = LAOStarPolicy.INIT_NODE_IDX
        else:
            
            node_idx = None
        
        transitions = []
        done = False
        for _ in range(total_steps):
            
            if node_idx is None or done:
                
                break
            
            a = policy.get_action(node_idx)
            
            if a is None:
                
                break

            try:
                s_dash, r, done, _ = self.env.step(a)
            except Exception:

                transitions.append((s, a, s, -1, False))
                return transitions
            
            node_idx = policy.get_sucessor_node_idx(node_idx, s_dash.literals)
        
            transitions.append((s, a, s_dash, r, done))
            
            s = s_dash
            
        return transitions
    
    @staticmethod
    def simple_example(domain_name, problem_idx):

        # FileUtils.initialize_directory(config.RESULT_DIR)
        print("Storing results in %s" % (config.RESULT_DIR))

        laostar = LAOStar(domain_name)
        laostar.set_problem_idx(problem_idx)
        policy = laostar.solve(output_dir=config.RESULT_DIR)
    
    @staticmethod
    def simple_execution_in_pddlgym(domain_name, problem_idx,
                                    episode_timesteps=80):
        
        print("Storing results in %s" % (config.RESULT_DIR))
        laostar = LAOStar(domain_name)
        laostar.set_problem_idx(problem_idx)
        transitions = laostar.simulate_in_gym(output_dir=config.RESULT_DIR,
                                              total_steps=episode_timesteps)
        print(transitions)
        print(transitions[-1][3])
            

if __name__ == "__main__":
    
    import gym
    import utils
    from model import Model
    from utils import FileUtils

    LAOStar.simple_execution_in_pddlgym("Tireworld", 2)