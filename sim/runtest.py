#!/usr/bin/env python

import argparse
import AutoVivification as av
import pprint as pp
import os
import sys
import copy
from collections import Mapping



tpl_verilog_parameter = "VERILOG_PARAMETER += +{var_name_lc}={val}\n"
tpl_make_variable     = "{var_name_uc}={val}\n"
tpl_c_define          = "C_DEFINES += -D{var_name_uc}={val}\n"
tpl_verilog_define    = "VERILOG_DEFINES += -D{var_name_uc}={val}\n"

def merge_dict2(a, b, path=None):
    "merges b into a, with override"
    if path is None: path = []
    for key in b:
        if key in a:
            if isinstance(a[key], dict) and isinstance(b[key], dict):
                merge_dict2(a[key], b[key], path + [str(key)])
            elif a[key] == b[key]:
                pass # same leaf value
            else:
                a[key] = b[key]
                #raise Exception('Conflict at %s' % '.'.join(path + [str(key)]))
        else:
            a[key] = b[key]
    return a

# From http://stackoverflow.com/questions/10306672/how-do-you-iterate-over-two-dictionaries-and-grab-the-values-at-the-same-path

def treeZip(t1,t2, path=[]):
    if isinstance(t1,Mapping) and isinstance(t2,Mapping):
        assert set(t1)==set(t2)
        for k,v1 in t1.items():
            v2 = t2[k]
            for tuple in treeZip(v1,v2, path=path+[k]):
                yield tuple
    elif isinstance( t1, list) and isinstance( t2, list ):
        for idx,item in enumerate(t1):
            v1 = item
            v2 = t2[idx]
            for tuple in treeZip(v1, v2):
                yield tuple
    else:
        yield (path, (t1,t2))




def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(description="""
A simulation launcher for the Nanorv32 project
                   """)
    parser.add_argument('-l', '--logging', action='store_true', dest='logging',
                        help='Waveform logging (VCD,...)')

    parser.add_argument('-t', '--trace', action='store', dest='trace',
                        help='Activate CPU trace ')


    parser.add_argument('--target', action='store', dest='target',
                        choices = ['rtl','ntl', 'sdf'],
                        default='rtl',
                        help='Simulation type (rtl, sdf,...)')

    parser.add_argument('-s', '--simulator', action='store', dest='simulator',
                        default='iverilog',
                        choices = ['iverilog','xilinx'],

                        help='Select simulator (iverilog, xilinx(xlog),...)')

    parser.add_argument(dest='tests', metavar='tests', nargs='*',
                        help='Path(es) to the test')

    parser.add_argument('-v', '--verbosity', action="count", help='Increase output verbosity')



    parser.add_argument('--version', action='version', version='%(prog)s 0.1')

    return parser.parse_args()

if __name__ == '__main__':
    args = get_args()
    if args.verbosity:
        print "Verbosity set to {}".format(args.verbosity)
    # we parse the default configuration file
    default_opts = av.AutoVivification()
    define_opts = av.AutoVivification()
    execfile("./config/default.py", {}, {"cfg": default_opts, "define" : define_opts})
    # and the override file
    override_opts= av.AutoVivification()
    execfile("./config/override.py", {}, {"cfg": override_opts})

    # main loop over tests
    for test in args.tests:
        if args.verbosity>0:
            print "Parsing options for test {}".format(test)
        local_opts = av.AutoVivification()

        # check if a configuration file exist
        opt_file = test + '/options.py'
        if os.path.isfile(opt_file):
            execfile(opt_file, {}, {"cfg": local_opts})



        merge_dict2(default_opts, local_opts)
        merge_dict2(default_opts, override_opts)

        #pp.pprint(default_opts)
        #pp.pprint(define_opts)

        all_data = list(treeZip (default_opts,define_opts, path=[]))

        #pp.pprint(all_data)
        txt = ""
        for path,v  in all_data:
            #print "txt : " + txt
            #print "Path = {}".format(path)
            #print "Data = {}".format(v)
            d = dict() # use for string format(**d)
            var_name = '_'.join(path)
            d['var_name_uc'] = var_name.upper()
            d['var_name_lc'] = var_name.lower()
            d['val'] = v[0]
            # The type of the parameters can be a singel string
            # or a sequence
            # we convert everything to a list

            val_type = v[1]
            val_l = list()
            if type(val_type) == str:
                #print "val_type = {}".format(val_type)
                #print "val_l = {}".format(val_l)
                val_l.append(val_type)
                #val_l = set(val_l)
                #print "Type of val_l : {}".format(type(val_l))

            elif type(val_type) == tuple:
                val_l = val_type
            else:
                sys.exit("-E- Unrecognized type for {} : {}".format(val_type,type(val_type)))
                pass

            #print "val_l : {} ".format(val_l)
            #print "Var = {} / {}".format(var_name_uc,var_name_lc)
            #print "Type({}[1]) = {}".format(v,type(v[1]))


            for t in val_l:
                if t == 'VERILOG_PARAMETER':
                    txt += tpl_verilog_parameter.format(**d)
                elif t == 'MAKE_VARIABLE':
                    txt += tpl_make_variable.format(**d)
                elif t == 'C_DEFINE':
                    txt += tpl_c_define.format(**d)
                elif t == 'VERILOG_DEFINE':
                    txt += tpl_verilog_define.format(**d)

        print(txt)
