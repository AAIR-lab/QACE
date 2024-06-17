#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import copy

from config import *
from collections import OrderedDict
from itertools import permutations, combinations, product
from pddlgym.structs import LiteralConjunction

class State:
    def __init__(self, state, objects):
        self.state = state
        self.objects = objects

    def __str__(self):
        return str(self.state) + str(self.objects)

class Lattice(object):
    """
    This class defines the lattice where each node (class LatticeNode)
    is a collection of models (class Models).

    """

    def __init__(self):
        self.nodes = {}
        # Refinement = 0 means precondition refined first
        # Refinement = 1 means effects refined first
        self.refinement = Location.EFFECTS

    def add_node(self, node_id, node):
        self.nodes[node_id] = node


class LatticeNode(object):
    """
    This class defines the AI planning model that we have the model to have.
    Each model is defined in terms of predicates and actions.

    :param models:  list of models
    :type models: list of Model objects
    :param predicates: dictionary of predicates and their parameters
    :type predicates: dict of (str, int)

    """

    def __init__(self, lattice, models, predicates, action_pred_dict=None):
        """
        This method creates a new instance of Model.

        """

        if action_pred_dict is None:
            action_pred_dict = {}
        self.models = models
        self.predicates = list(predicates.keys())
        self.id = hash(tuple(sorted(self.predicates)))

        self.lattice = lattice
        self.lattice.add_node(self.id, self)
        self.action_pred_dict = action_pred_dict

    def add_models(self, models):
        temp_models = self.models
        for i in range(len(temp_models)):
            temp_models[i].discarded = False
        for m in models:
            discarded = m.discarded
            m.discarded = False
            if m in temp_models:
                temp_models.remove(m)
            m.discarded = discarded
            self.models.append(m)

    @staticmethod
    def act_pred_mapping(action_list, ref, modes=(Literal.ABS, Literal.NEG, Literal.POS)):
        pre_list = [[Literal.ABS]]
        eff_list = [[Literal.ABS]]

        if ref == Location.ALL or ref == Location.PRECOND:
            pre_list = [list(i) for i in product(modes)]
        if ref == Location.ALL or ref == Location.EFFECTS:
            eff_list = [list(i) for i in product(modes)]
        pre_eff_list = [list(i[0] + i[1]) for i in list(product(pre_list, eff_list))]

        # Stores which action will have the predicate with what precondition and effect
        action_mapping = []
        pred_list = list(product(pre_eff_list, repeat=len(action_list)))
        act_list = list(combinations(action_list, len(action_list)))

        # Mapping of actions to predicates' variations
        action_mapping.append(list(product(act_list, pred_list)))

        return list(action_mapping)

    @staticmethod
    def generate_preds_for_action(predicate, action, pred_type_mapping, action_parameters):
        for p in pred_type_mapping[predicate]:
            if p not in action_parameters[action]:
                return None

        need_multiple_mapping = False
        pred_type_count = {}
        for t in action_parameters[action]:
            if t not in pred_type_count.keys():
                pred_type_count[t] = action_parameters[action].count(t)
            else:
                continue

            if pred_type_count[t] > 1 and t in pred_type_mapping[predicate]:
                need_multiple_mapping = True

            if pred_type_mapping[predicate].count(t) > 1:
                need_multiple_mapping = True

        if not need_multiple_mapping:
            updated_predicate = str(predicate)
            for p in pred_type_mapping[predicate]:
                if p in action_parameters[action]:
                    updated_predicate += "|" + str(action_parameters[action].index(p))
                else:
                    print("Error")
                    exit(1)
            return [updated_predicate]
        else:
            type_combination_dict = OrderedDict()
            for t in pred_type_mapping[predicate]:
                if pred_type_count[t] > 1 and t not in type_combination_dict.keys():
                    type_count_in_predicate = pred_type_mapping[predicate].count(t)
                    # Locations of type t in action_parameters[action]'s paramteres
                    pred_locations = [i for i, x in enumerate(action_parameters[action]) if x == t]
                    type_combinations = permutations(pred_locations, type_count_in_predicate)
                    type_combination_dict[t] = list(type_combinations)

            final_combinations = list(product(*list(type_combination_dict.values())))
            updated_predicate_list = []
            for comb in final_combinations:
                pred_type_count_temp = {}
                updated_predicate = str(predicate)
                to_remove = []  # to store preds like on|0|0
                for p in pred_type_mapping[predicate]:
                    if p not in pred_type_count_temp.keys():
                        pred_type_count_temp[p] = 0
                    else:
                        pred_type_count_temp[p] = pred_type_count_temp[p] + 1

                    if p not in type_combination_dict.keys():
                        updated_predicate += "|" + str(action_parameters[action].index(p))
                        if pred_type_mapping[predicate].count(p) > 1:
                            to_remove.append(updated_predicate)
                    else:
                        index_to_search = list(type_combination_dict.keys()).index(p)
                        updated_predicate += "|" + str(comb[index_to_search][pred_type_count_temp[p]])

                updated_predicate_list.append(updated_predicate)
                for r in to_remove:
                    if r in updated_predicate_list:
                        updated_predicate_list.remove(r)

            return updated_predicate_list

    def get_specific_children(self, model, predicate, ref, action, modes):
        child_predicates = self.predicates
        child_predicates.append(predicate)

        child_id = hash(tuple(sorted(child_predicates)))

        child_models = []
        if str(predicate) not in model.predicates.keys():
            model.predicates[str(predicate)] = predicate
        action_mapping = self.act_pred_mapping([action], ref, modes)
        for i in action_mapping:
            for actionNames, mappings in i:
                new_child = copy.deepcopy(model)
                _update_actions = {}
                literal = predicate
                if ref == Location.PRECOND:
                    precond = copy.deepcopy(model.actions[actionNames[0]].preconds.literals)
                    new_child.mode = mappings[0][0]
                    if new_child.mode == Literal.POS:
                        precond.append(literal)
                        new_child.actions[actionNames[0]].preconds = LiteralConjunction(list(precond))
                    elif new_child.mode == Literal.NEG:
                        precond.append(literal.inverted_anti)
                        new_child.actions[actionNames[0]].preconds = LiteralConjunction(list(precond))
                if ref == Location.EFFECTS:
                    new_child.mode = mappings[0][1]
                    effect = copy.deepcopy(model.actions[actionNames[0]].effects.literals)
                    if new_child.mode == Literal.POS:
                        effect.append(literal)
                        new_child.actions[actionNames[0]].effects = LiteralConjunction(list(effect))
                        # model.actions[actionNames[0]].preconds.append(literal)
                    elif new_child.mode == Literal.NEG:
                        effect.append(literal.inverted_anti)
                        new_child.actions[actionNames[0]].effects = LiteralConjunction(list(effect))

                    if model.discarded:
                        new_child.discarded = True

                child_models.append(new_child)

        # Assuming that we will never need child
        if child_id in self.lattice.nodes.keys():
            child_node = self.lattice.nodes[child_id]
            child_node.add_models(child_models)
        else:
            pred_dict = {}
            for p in child_predicates:
                pred_dict[p] = 0
            child_node = LatticeNode(self.lattice, child_models, pred_dict, self.action_pred_dict)
        return child_node

    def get_model_partitions(self, model, predicate, ref, action, modes):
        child_node = self.get_specific_children(model, predicate, ref, action, modes)
        child_models = child_node.models

        return child_models
