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


def plot_functions(func_dat):
    """Generate a plot regarding split between functions"""
    l = zip(*func_dat)
    func_names = l[0]
    cycles     = l[1]
    print "="*80
    pp.pprint(func_names)
    pp.pprint(cycles)
    print "="*80
    y_pos = np.arange(len(func_names))
    plt.barh(y_pos, cycles, align='center', alpha=0.4)
    plt.yticks(y_pos, func_names)
    plt.xlabel('Cycles')
    plt.title('How fast do you want to go today?')
    plt.show()


if __name__ == '__main__':

    args = get_args()
    sorted_pairs = []
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
        plot_functions(sorted_pairs[0:10])
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
