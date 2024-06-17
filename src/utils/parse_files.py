#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import copy
import itertools
import os
import subprocess
from collections import OrderedDict

import numpy as np
# import pddlgym
from utils.parser import PDDLDomainParser, structs

import utils.translate.pddl_fd as pddl
import utils.translate.pddl_parser as pddl_parser
from config import *
from utils import FileUtils


def extract_task(domain_file_path, problem_file_path):
    # Extract the domain specific args.
    domain_pddl = pddl_parser.pddl_file.parse_pddl_file(
        "domain", domain_file_path)
    domain_name, \
    domain_requirements, \
    types, \
    type_dict, \
    constants, \
    predicates, \
    predicate_dict, \
    functions, \
    actions, \
    axioms = pddl_parser.parsing_functions.parse_domain_pddl(
        domain_pddl)

    task_pddl = pddl_parser.pddl_file.parse_pddl_file(
        "task", problem_file_path)
    task_name, \
    task_domain_name, \
    task_requirements, \
    objects, \
    init, \
    goal, \
    use_metric = pddl_parser.parsing_functions.parse_task_pddl(
        task_pddl, type_dict, predicate_dict)

    assert domain_name == task_domain_name
    requirements = pddl.Requirements(sorted(set(
        domain_requirements.requirements +
        task_requirements.requirements)))
    objects = constants + objects
    pddl_parser.parsing_functions.check_for_duplicates(
        [o.name for o in objects],
        errmsg="error: duplicate object %r",
        finalmsg="please check :constants and :objects definitions")

    #############################
    init += [pddl.Atom("=", (obj.name, obj.name))
             for obj in objects]
    #############################

    task = pddl.Task(domain_name,
                     task_name,
                     requirements,
                     types,
                     objects,
                     predicates,
                     functions,
                     init,
                     goal,
                     actions,
                     axioms,
                     use_metric)
    return task


def check_nested(test_dict):
    for key1, val in test_dict.items():
        for key2 in test_dict.keys():
            if key2 in val and key1 != 'object':
                return True, key2, key1
    return False, None, None


class PredicateDetails:
    def __init__(self, literal, param_dict, predTypeMapping):
        name_set = False
        self.param_matching = OrderedDict()
        try:
            for param in literal.variables:
                self.param_matching[param.name] = param_dict[param.name]
        except KeyError as e:
            print("KeyError")
        self.isnegative = literal.is_anti
        if literal.is_negative == True and literal.is_anti == False:
            self.isnegative = True
        for pred in predTypeMapping:
            if literal.predicate.name in pred and sorted(list(self.param_matching.values())) == sorted(
                    list(predTypeMapping[pred])):
                self.name = pred
                name_set = True
        if not name_set:
            self.name = literal.predicate.name
            print("pred not found")

    def __str__(self):
        return self.name + "(" + str(self.param_matching) + ")" + str(self.isnegative)


class ActionDetails:
    def __init__(self, action, param_types, predTypeMapping):
        self.name = action.name
        self.precondition = []
        self.effects = []
        self.param_matching = OrderedDict()
        self.precondition_literal_names = []
        self.add_effects_literal_names = []
        self.del_effects_literal_names = []

        for i, param in enumerate(action.params):
            self.param_matching[param.name] = param_types[i]
        try:
            if isinstance(action.preconds,  structs.LiteralConjunction):
                [self.precondition.append(PredicateDetails(lit, self.param_matching, predTypeMapping)) for lit in
                 action.preconds.literals]
                [self.precondition_literal_names.append(p.name) for p in self.precondition]

            elif isinstance(action.preconds, structs.Literal):
                self.precondition.append(PredicateDetails(action.preconds, self.param_matching, predTypeMapping))

            else:
                print("Some other action precondition type")
        except AttributeError as e:
            print("Attribute Error!")

        for lit in action.effects.literals:
            self.effects.append(PredicateDetails(lit, self.param_matching, predTypeMapping))

        for p in self.effects:
            if p.isnegative:
                self.del_effects_literal_names.append(p.name)
            else:
                self.add_effects_literal_names.append(p.name)

    def __str__(self):
        return self.name + "\nParams: [\n" + str(self.params) + "\n]\n Precond:[\n " + str(
            self.precondition) + "\n] Add_effects:[\n" + str(self.add_effects) + "\n] Del_effects:[\n" + str(
            self.del_effects)

