#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import copy
from itertools import combinations

from config import *
import os
import shutil

class FileUtils(object):

    @staticmethod
    def initialize_directory(dirpath, clean=True):
    
        dirpath = os.path.abspath(dirpath)
    
        if os.path.exists(dirpath):
            
            assert os.path.isdir(dirpath)
            if clean:
                
                shutil.rmtree(dirpath)
                os.makedirs(dirpath)
        else:
            os.makedirs(dirpath)


    @classmethod
    def get_plan_from_file(cls, result_file):
        """
        This method extracts the plan from the output of the planner.
        The planner can be either FF Planner (ff) or Madagascar (mg).
        It needs to be set in config.py in the root directory.

        :param result_file: result file where output of the planner is stored.
        :type result_file: str

        :return: Plan as a list of action names
        :rtype: list of str

        """
        import time
        plan = []

        if PLANNER == "FF":
            for line in open(result_file):
                if 'STEP' in line:
                    values = line.split()
                    if (values[2] != "REACH-GOAL"):
                        plan.append(("|".join(values[2:])).lower())

        elif PLANNER == "FD" or PLANNER == "PRP":
            for line in open(result_file):
                if ';' not in line:
                    if line == "\n":
                        continue
                    values = line.split("(")
                    values = values[1].split(")")

                    plan.append(values[0].rstrip().lower())
        return plan

    def add_unknown_predicate(model1, model2, pal_tuple_dict, pal):
        temp_actions_m1 = copy.deepcopy(model1.actions)
        for actionName, predicateDict_m1 in temp_actions_m1.items():
            if (actionName, pal[1], Location.PRECOND) not in pal_tuple_dict.keys():
                # This predicate and action might be incompatible
                continue
            predicateDict_m1['unknown'] = [Literal.POS, Literal.POS]
            if pal_tuple_dict[(actionName, pal[1], Location.PRECOND)] == True:
                predicateDict_m1['unknown'][0] = Literal.ABS
            if pal_tuple_dict[(actionName, pal[1], Location.EFFECTS)] == True:
                predicateDict_m1['unknown'][1] = Literal.NEG

        # Remove unknown from current pal tuple's a,l
        if pal[2] == Location.PRECOND:
            temp_actions_m1[pal[0]]['unknown'][int(pal[2]) - 1] = Literal.ABS
        elif pal[2] == Location.EFFECTS:
            temp_actions_m1[pal[0]]['unknown'][int(pal[2]) - 1] = Literal.NEG

        temp_actions_m2 = copy.deepcopy(model2.actions)
        for actionName, predicateDict_m2 in temp_actions_m2.items():
            if (actionName, pal[1], Location.PRECOND) not in pal_tuple_dict.keys():
                # This predicate and action might be incompatible
                continue
            predicateDict_m2['unknown'] = [Literal.POS, Literal.POS]

            if pal_tuple_dict[(actionName, pal[1], Location.PRECOND)] == True:
                predicateDict_m2['unknown'][0] = Literal.ABS
            if pal_tuple_dict[(actionName, pal[1], Location.EFFECTS)] == True:
                predicateDict_m2['unknown'][1] = Literal.NEG

        if pal[2] == Location.PRECOND:
            temp_actions_m2[pal[0]]['unknown'][int(pal[2]) - 1] = Literal.ABS
        elif pal[2] == Location.EFFECTS:
            temp_actions_m2[pal[0]]['unknown'][int(pal[2]) - 1] = Literal.NEG

        return temp_actions_m1, temp_actions_m2
