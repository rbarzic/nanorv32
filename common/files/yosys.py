# Function definitions specific to the Yosys synthesis tool
import file_list
from typing import List


def get_yosys_synt_file_list(l_f: List[str], d, context):
    """Return a string that can be written to a file and used with the -f
    option of the Vivado xvlog  compiler

    @param l: list of files
    @type l: list of string
    @param d: list of directories (for include files)
    @type d: list of string
    @param context:
    @type context:
    @return: list of files or directories as text
    @rtype: string

    """
    result = ""
    filelist = file_list.get_file_list(l_f, context, "synt,synt_yosys")
    dirlist = file_list.get_dir_list(d, context, "synt,synt_yosys")
    for dd in dirlist:
        result += f"verilog_defaults -add -I {dd}\n"

    for f in filelist:
        result += f"read_verilog {f}\n"
    return result


# Local Variables:
# eval: (blacken-mode)
# End:
