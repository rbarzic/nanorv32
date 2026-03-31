# Function definitions specific to OVR simulator
import file_list

def get_ovr_file_list(l, d, context):
    """Return a string that can be written to a file and used as
    command-line arguments for the OVR simulator.

    OVR uses -I for include directories (not +incdir+) and takes
    source files as positional arguments.

    @param l: list of files
    @type l: list of string
    @param d: list of directories (for include files)
    @type d: list of string
    @param context:
    @type context:
    @return: list of flags and files as text (one per line)
    @rtype: string
    """
    result = ""
    filelist = file_list.get_file_list(l, context, 'sim_rtl,tb_rtl')
    dirlist = file_list.get_dir_list(d, context, 'sim_rtl,tb_rtl')
    for d in dirlist:
        result += "-I" + d + "\n"

    for f in filelist:
        result += f + "\n"
    return result
