#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import copy

from config import *

def map_pred_action_param(pred, action):
    """
    :param pred: Pred in format ontable|c
    :param action: Action in format pickup|c
    :return: pred in format ontable|0
    """
    action_name = action.split("|")[0]
    action_params = action.split('|')[1:]
    pred_params = pred.split("|")[1:]
    pred_name = pred.split("|")[0]
    for param in pred_params:
        if param in action_params:
            indx = action_params.index(param)
            if indx != -1:
                pred_name += "|" + str(indx)
        else:
            return None, None

    if pred.count("|") != pred_name.count("|"):
        return None, None

    return action_name, pred_name


def type_comparison(m1, m2):
    if set([m1,m2]) == set([Literal.POS, Literal.NEG]):
        return Literal.NP
    if set([m1,m2]) == set([Literal.POS, Literal.ABS]):
        return Literal.AP
    if set([m1,m2]) == set([Literal.ABS, Literal.NEG]):
        return Literal.AN


def get_model_difference(model1, model2, pal_tuple_dict):
    # model1 is agent model
    diff = 0
    for action in model1.actions:
        for pred in model1.actions[action].keys():
            for loc in [Location.PRECOND, Location.EFFECTS]:
                if not pal_tuple_dict[(action, pred, loc)]:
                    diff += 1
                elif model1.actions[action][pred][loc - 1] != model2.actions[action][pred][loc - 1]:
                    diff += 1
                    print("Incorrect PALM: ", action, pred, loc)
                    print("In Agent: ", model1.actions[action][pred][loc - 1])
                    print("In Model: ", model2.actions[action][pred][loc - 1])
                    print("")

    return diff / len(pal_tuple_dict)


