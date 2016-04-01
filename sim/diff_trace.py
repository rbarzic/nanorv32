#!/usr/bin/env python

import argparse
import re
import pprint as pp

def debug(variable):
    print variable, '=', repr(eval(variable))

def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(description="""
A tol to check trace differences for the Nanorv32
                   """)
    parser.add_argument('--pysim', action='store', dest='pysim',
                        help='Python Simulator trace')

    parser.add_argument('--rtlsim', action='store', dest='rtlsim',
                        help='Rtl  Simulator trace')

    parser.add_argument('--rvc', action='store_true', dest='rvc',
                        default=False,
                        help='RVC mode')
    parser.add_argument('--skip_inst_comp', action='store_true', dest='skip_inst_comp',
                        default=False,
                        help='Skip the comparison of the instruction strings')

    return parser.parse_args()


def pysim_action(action1,action2):
    "Parse an action field from python simulator trace"
    re_reg = re.compile(r'\s*RF\[(?P<reg>\S+)\s*\]\s*<=\s*(?P<data>\S*)\s*')
    re_memwrite1 = re.compile(r'\s*MEM\[(?P<addr>\S+)\s*\]\s*<=\s*RF\[(?P<reg>\S*)\s*\]')
    re_memwrite2 = re.compile(r'\s*(?P<data>\S+)\s*\(')
    re_memread = re.compile(r'\s*RF\[(?P<reg>\S+)\s*\]\s*<=\s*(?P<data>\S*)\s*MEM\[(?P<addr>\S+)\s*\]')

    reg_write = re_reg.match(action1)
    mem_write1 = re_memwrite1.match(action1)
    mem_write2 = re_memwrite2.match(action2)
    mem_read = re_memread.match(action1)

    res = dict()
    if reg_write:
        res['reg'] = reg_write.group('reg')
        res['data'] = reg_write.group('data')
        return ('regwrite',res)
    elif mem_write1:
        res['addr'] = mem_write1.group('addr')
        res['reg'] = mem_write1.group('reg')
        res['data'] = mem_write2.group('data')
        return ('memwrite',res)
    elif mem_read:
        res['addr'] = mem_read.group('addr')
        res['reg'] = mem_read.group('reg')
        res['data'] = mem_read.group('data')
        return ('memread',res)
    else:
        return ('not_found', {})


def rtlsim_action(action1,action2):
    "Parse an action field from RTL simulator trace"
    re_reg = re.compile(r'\s*RF\[(?P<reg>\S+)\s*\]\s*<=\s*(?P<data>\S*)')

    re_memwrite1 = re.compile(r'\s*MEM\[(?P<addr>\S+)\s*\]\s*<=\s*RF\[(?P<reg>\S*)\s*\]')
    re_memwrite2 = re.compile(r'\s*(?P<data>\S+)\s*')
    # A memory read is reported as a register write only in the RTL simulator
    re_memread = re.compile(r'\s*RF\[(?P<rd>\S+)\s*\]\s*<=\s*(?P<val>\S*)\s*MEM\[(?P<addr>\S+)\s*\]')

    reg_write = re_reg.match(action1)
    mem_write1 = re_memwrite1.match(action1)
    mem_write2 = re_memwrite2.match(action2)
    mem_read = re_memread.match(action1)

    res = dict()
    if reg_write:
        res['reg'] = reg_write.group('reg')
        res['data'] = reg_write.group('data')
        return ('regwrite',res)
    elif mem_write1:
        res['addr'] = mem_write1.group('addr')
        res['reg'] = mem_write1.group('reg')
        res['data'] = mem_write2.group('data')
        return ('memwrite',res)
    elif mem_read:
        res['addr'] = mem_read.group('addr')
        res['reg'] = mem_read.group('reg')
        res['data'] = mem_read.group('data')
        return ('memread',res)
    else:
        return ('not_found', {})

def compare_regwrite(a, b):
    return (a['reg'] == b['reg']) and  (a['data'] == b['data'])

def compare_memwrite(pysim, rtlsim):
    if (pysim['reg'] == rtlsim['reg']) and  (pysim['addr'] == rtlsim['addr']):
        if rtlsim['data'] == '0xxxxxxxxx':
            return True
        else:
            return (pysim['data'] == rtlsim['data'])

def compare_memread(a, b):
    return (a['reg'] == b['reg']) and  (a['data'] == b['data']) and(a['addr'] == b['addr'])




def compare(pysim,rtlsim):
    "Compare 'actions' from both traces"
    type_pysim = pysim[0]
    val_pysim = pysim[1]
    type_rtlsim = rtlsim[0]
    val_rtlsim = rtlsim[1]
    if(type_pysim == type_rtlsim):
        if(type_pysim == 'regwrite'):
            return compare_regwrite(val_pysim,val_rtlsim)
        elif(type_pysim == 'memwrite'):
            return compare_memwrite(val_pysim,val_rtlsim)
        elif(type_pysim == 'memread'):
            return compare_memread(val_pysim,val_rtlsim)
        elif(type_pysim == 'not_found'):
            return True
        else:
            print "-I Action type unknown"
            return False
    # RTL simulator reports memory read as simple register update
    elif ((type_pysim == 'memread') and   (type_rtlsim=='regwrite')):
        return compare_regwrite(val_pysim,val_rtlsim)
    else:
        return False



if __name__ == '__main__':
    line = 0
    args= get_args()
    with open(args.pysim) as f_pysim:
        with open(args.rtlsim) as f_rtlsim:
            while(1):
                l_pysim = f_pysim.next()
                l_rtlsim = f_rtlsim.next()

                ll_pysim = l_pysim.split(':')
                ll_rtlsim = l_rtlsim.split(':')

                pc_pysim = ll_pysim[1].replace('I', '').strip()
                pc_rtlsim = ll_rtlsim[1].replace('I', '').strip()

                insthex_pysim = ll_pysim[2].strip()
                insthex_rtlsim = ll_rtlsim[2].strip()

                inst_pysim = ll_pysim[3].strip()
                inst_rtlsim = ll_rtlsim[3].strip()

                action1_pysim = ll_pysim[4]
                action1_rtlsim = ll_rtlsim[4]

                if len(ll_pysim) > 5:
                    action2_pysim = ll_pysim[5]
                else:
                    action2_pysim = ''

                if len(ll_rtlsim) > 5:
                    action2_rtlsim = ll_rtlsim[5]
                else:
                    action2_rtlsim = ''



                if pc_pysim != pc_rtlsim:
                    print "-E- Error comparing PC values - line {}".format(line)
                    print "Line {}".format(line)
                    print "pysim  : " + str(ll_pysim)
                    print "rtlsim : " + str(ll_rtlsim)

                elif (inst_pysim != inst_rtlsim) and not args.skip_inst_comp:
                    print "-E- Error comparing Instruction - line {}".format(line)
                    print "Line {}".format(line)
                    print "pysim  : " + str(ll_pysim)
                    print "rtlsim : " + str(ll_rtlsim)

                elif (insthex_pysim != insthex_rtlsim) and not args.rvc:
                    print "-E- Error comparing Instruction encoding - line {}".format(line)
                    print "Line {}".format(line)
                    print "pysim  : " + str(ll_pysim)
                    print "rtlsim : " + str(ll_rtlsim)

                else:
                    pysim_act = pysim_action(action1_pysim, action2_pysim)
                    rtlsim_act = rtlsim_action(action1_rtlsim, action2_rtlsim)


                    if not compare(pysim_act, rtlsim_act):

                        print "-E- Error comparing actions - line {}".format(line)
                        print "Line {}".format(line)
                        print "pysim  : " + str(ll_pysim)
                        print "rtlsim : " + str(ll_rtlsim)
                        print "============ Python Simulator ================="
                        pp.pprint(pysim_act)
                        print "============ RTL Simulator ================="
                        pp.pprint(rtlsim_act)
                    line += 1
