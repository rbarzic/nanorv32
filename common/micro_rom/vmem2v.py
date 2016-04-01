#!/usr/bin/env python
import argparse
import pprint as pp

labels = [
    "_reset_seq_start_",
    "_reset_seq_stop_",
    "_int_entry_code_start_",
    "_int_entry_code_stop_",
    "_int_exit_code_start_",
    "_int_exit_code_stop_",
]


def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(description="""
    Generate verilog code for the nanorv32 micro-rom (used for startup and interrupt entry/exit)
    """)

    parser.add_argument('--vmem32', action='store', dest='vmem32',
                        help='vmem32 file describing the actual ROM content')

    parser.add_argument('--map', action='store', dest='map',
                        help='map file used to define start and stop addresses of code sequences')

    parser.add_argument('--outdir', action='store', dest='outdir',
                        help='Directory where to output code snippets',
                        default=".")

    parser.add_argument('--version', action='version', version='%(prog)s 0.1')
    return parser.parse_args()

if __name__ == '__main__':
    args = get_args()
    code = ""
    with open(args.vmem32) as f:
        for i,line in enumerate(f):
            code += "        " + str(i) + ": dout = 32'h" + line[0:8] + ";\n"
    micro_rom_case_file = args.outdir + "/" + "micro_rom.generated.v"
    with open(micro_rom_case_file,'w') as f:
        f.write(code)
    code = ""
    micro_rom_param_file = args.outdir + "/" + "micro_rom_param.generated.v"
    with open(args.map) as f:
        for line in f:
            l_splitted = line.split()
            pp.pprint(l_splitted)
            if (len(l_splitted) == 5 ) and (l_splitted[4] in labels):
                param = "NANORV32" + l_splitted[4].upper() + "ADDR"
                code += "parameter  " + param + "= 32'h" + str(l_splitted [0]) + ";\n"
                pass
    with open(micro_rom_param_file,'w') as f:
        f.write(code)
