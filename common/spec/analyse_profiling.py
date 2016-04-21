#!/usr/bin/env python

import argparse
import re
import sys
import pprint as pp
import pickle
from operator import itemgetter

import matplotlib.pyplot as plt
import numpy as np
import matplotlib.pyplot as plt


from matplotlib import rcParams
rcParams.update({'figure.autolayout': True})

def get_args():
    """
    Get command line arguments
    """
    parser = argparse.ArgumentParser(description="""
Analyse results provided by the --profile option of the Nanorv32 simulator
                   """)
    parser.add_argument('--profile', action='store', dest='profile',
                        help='Profiling data from the simulator (Pickle format)', default="")

    parser.add_argument('--plot', action='store_true', dest='plot',
                        help='Generate plots for the 10 most time consuming functions', default=False)
    return parser.parse_args()


def plot_functions(func_dat,total_cycle):
    """Generate a plot regarding split between functions"""
    l = zip(*func_dat)
    func_names = l[0]
    cycles     = l[1]
    percents   = [(c*100)/total_cycle for c in cycles]
    print "="*80
    pp.pprint(func_names)
    pp.pprint(cycles)
    print "="*80
    y_pos = np.arange(len(func_names))
    plt.barh(y_pos, percents, align='center', alpha=0.4)
    plt.yticks(y_pos, func_names)
    plt.xlabel('% of total cycle count')
    plt.title('Top ten contributors')

def plot_insts(func_name,insts_dat,total_cycle):
    """Generate a plot regarding split between instructions"""
    l = zip(*insts_dat)
    inst_names = l[0]
    cycles     = l[1]
    percents   = [(c*100)/total_cycle for c in cycles]
    print "="*80
    pp.pprint(inst_names)
    pp.pprint(cycles)
    print "="*80
    y_pos = np.arange(len(inst_names))
    plt.barh(y_pos, percents, align='center', alpha=0.4)
    plt.yticks(y_pos, inst_names)
    plt.xlabel('% of total cycle count')
    plt.title('Top ten instruction usages for function {}'.format(func_name))
    plt.savefig("opus_top_ten_for_{}.svg".format(func_name),format="svg")
    plt.savefig("opus_top_ten_for_{}.png".format(func_name),format="png")
    plt.clf()

if __name__ == '__main__':

    args = get_args()
    sorted_pairs = []
    total_cycle = 0
    plt_funcs = None
    plt_insts = dict()
    if args.profile != "":
        with open(args.profile) as f:
            profile_info = pickle.load(f)
            #pp.pprint(profile_info)
            pairs = [(x,profile_info[x]['__count__']) for x in profile_info.keys()]
            #pp.pprint(pairs)
            sorted_pairs = sorted(pairs, key=itemgetter(1))
            sorted_pairs.reverse()

            total_cycle = 0
            for f,c in sorted_pairs:
                total_cycle += c
        print "-I Done - Cycles : {}".format(total_cycle)

        pp.pprint(sorted_pairs)
        plot_functions(sorted_pairs[0:10],total_cycle)
        plt.savefig("opus_top_ten.svg",format="svg")
        plt.savefig("opus_top_ten.png",format="png")
        plt.clf()
        # Display the Top ten contributors
        for f,c in sorted_pairs[0:10]:
            print "- Function  {} : {}%".format(f,(c*100/total_cycle))
            # get instructions
            insts = profile_info[f]
            #pp.pprint(insts.items())
            inst_list = sorted(insts.items(), key=itemgetter(1))
            inst_list.reverse()
            #pp.pprint(inst_list[0:10])
            for i,ic in inst_list[1:10]: # first item is the total number of cycles
                print "-     Instruction  {} : {}%".format(i,(ic*100/c))
            if len(inst_list) >11:
                plot_insts(f,inst_list[1:10],c)
            else:
                plot_insts(f,inst_list[1:],c)
