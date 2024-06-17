#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import csv
from utils.file_utils import FileUtils

class ResultLogger:
    
    M = "Metadata"
    ITR = "Interaction"
    SR = "Success Rate"
    VD_SAMPLES = "Variational Difference (Samples)"
    VD_GT = "Best VD"
    ET = "Elapsed Time"
    LAO_C = "LAO (Costs)"
    LAO_R = "LAO (Success Rate)"
    LAO_AGG_C = "LAO (Aggregate Costs)"
    LAO_AGG_R = "LAO (Aggregate Success Rate)"
    
    CSV_SEPARATOR = ";"
    CSV_HEADER = [M, ITR, SR, VD_SAMPLES, VD_GT, ET, LAO_C, LAO_R,
                  LAO_AGG_C, LAO_AGG_R]
    
    @staticmethod
    def get_name(prefix, *args):
        
        string = prefix
        
        for arg in args:
            
            string += "_%s" % (arg)

        return string.lower()
    
    @staticmethod
    def create_csv_files(results_dir, filename="results.csv",
                         clean_dir=False, clean_file=True):
        

        FileUtils.initialize_directory(results_dir, clean=clean_dir)
        
        if not filename.endswith(".csv"):
            results_csvfilepath = "%s/%s.csv" % (results_dir, filename)
        else:
            results_csvfilepath = "%s/%s" % (results_dir, filename)
        
        assert not os.path.exists(results_csvfilepath) \
            or not os.path.isdir(results_csvfilepath)
            

        write_header = True
        results_filehandle = open(results_csvfilepath, "w")
        results_csvwriter = csv.DictWriter(results_filehandle,
                                       delimiter=ResultLogger.CSV_SEPARATOR,
                                       fieldnames=ResultLogger.CSV_HEADER)
        
        if write_header:
            results_csvwriter.writeheader()
            results_filehandle.flush()
            
        return results_filehandle, results_csvwriter
    
    def __init__(self, results_dir, filename="results.csv",
                        clean_dir=False, clean_file=True):
        
        self.results_filehandle, self.results_csvwriter = \
            ResultLogger.create_csv_files(results_dir, 
                                          filename, 
                                          clean_dir, clean_file)
        
    def log_results(self, metadata, itr, success_rate, vd_samples,
                    vd_gt, elapsed_time, total_cost=None,  
                    total_reward=None,  agg_cost=None, 
                    agg_reward=None):
        
        self.results_csvwriter.writerow({
                ResultLogger.M: metadata,
                ResultLogger.ITR: itr,
                ResultLogger.SR: success_rate,
                ResultLogger.VD_SAMPLES: vd_samples,
                ResultLogger.VD_GT: vd_gt,
                ResultLogger.ET: elapsed_time,
                ResultLogger.LAO_C: total_cost,
                ResultLogger.LAO_R: total_reward,
                ResultLogger.LAO_AGG_C: agg_cost,
                ResultLogger.LAO_AGG_R: agg_reward,
            })
        
        self.results_filehandle.flush()