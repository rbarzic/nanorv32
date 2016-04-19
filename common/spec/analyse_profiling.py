#!/usr/bin/env python
import argparse
import re
import sys


def get_args():
    """
    Get command line arguments
    """
    parser = argparse.ArgumentParser(description="""
Analyse results provided by the --profile option of the Nanorv32 simulator
                   """)
    parser.add_argument('--profile', action='store', dest='profile',
                        help='Profiling data from the simulator', default="")
    return parser.parse_args()

if __name__ == '__main__':

    args = get_args()

    if args.profile != "":
        print "-I Reading args.profile...."
        # match : PC : 0x00000030 F deregister_tm_clones
        re_prof_data = re.compile(r'PC\s+:\s+(?P<addr>\S+)\s+F\s+(?P<func_name>\S+)')
        with open(args.profile) as f:
            for line in f:
                match_prof = re_prof_data.match(line)
                if match_prof:
                    pc = match_prof.group('addr')
                    func = match_prof.group('func_name')
                else:
                    print "\n-E- Unrecognized profiling data\n {}".format(line)
                    sys.exit(1)
        print "-I Done"
