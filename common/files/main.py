import nanorv32_fl
import iverilog
import xilinx
import verilator
import argparse
import yosys


def get_args():
    """
    Get command line arguments
    """

    parser = argparse.ArgumentParser(
        description="""
Put description of application here
                   """
    )
    parser.add_argument(
        "--iverilog",
        action="store",
        dest="iverilog",
        help="iverilog file list",
        default="",
    )

    parser.add_argument(
        "--verilator",
        action="store",
        dest="verilator",
        help="Verilator file list",
        default="",
    )

    parser.add_argument(
        "--vivado_sim",
        action="store",
        dest="vivado_sim",
        help="Vivado simulator file list",
        default="",
    )

    parser.add_argument(
        "--vivado_synt",
        action="store",
        dest="vivado_synt",
        help="Vivado synthesis file list (as tcl file)",
        default="",
    )

    parser.add_argument(
        "--yosys_synt",
        action="store",
        dest="yosys_synt",
        help="Yosys synthesis file list (as tcl file)",
        default="",
    )

    parser.add_argument(
        "--topdir",
        action="store",
        dest="topdir",
        help="Top directory for the project",
        default="",
    )

    parser.add_argument(
        "--designstart",
        action="store",
        dest="designstart",
        help="Top directory for the ARM DesignStart forlder",
        default="",
    )
    parser.add_argument(
        "-v", "--verbosity", action="count", help="Increase output verbosity"
    )

    parser.add_argument("--version", action="version", version="%(prog)s 0.1")

    return parser.parse_args()


args = get_args()


context = dict()

context["top"] = args.topdir
context["top_ds"] = args.designstart

l, d = nanorv32_fl.nanor32_fl(context)

if args.iverilog != "":
    print("-I- iverilog generation" "")
    txt = iverilog.get_iverilog_file_list(l, d, context)
    with open(args.iverilog, "w") as f:
        f.write(txt)

if args.verilator != "":
    print("-I- Verilator generation" "")
    txt = verilator.get_verilator_file_list(l, d, context)
    with open(args.verilator, "w") as f:
        f.write(txt)

if args.vivado_sim != "":
    print("-I- Vivado/Sim  generation" "")
    txt = xilinx.get_xvlog_file_list(l, d, context)
    with open(args.vivado_sim, "w") as f:
        f.write(txt)

if args.vivado_synt != "":
    print("-I- Vivado/Synt  generation" "")
    txt = xilinx.get_vivado_synt_file_list(l, d, context)
    with open(args.vivado_synt, "w") as f:
        f.write(txt)


if args.yosys_synt != "":
    print("-I- Yosys/Synt  generation" "")
    txt = yosys.get_yosys_synt_file_list(l, d, context)
    with open(args.yosys_synt, "w") as f:
        f.write(txt)


# Local Variables:
# eval: (blacken-mode)
# End:
