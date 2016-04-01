# Function definitions specific to Icarus iverilog simulator
import file_list

def get_verilator_file_list(l, d, context):
    """Return a string that can be written to a file and used with the -f
    option of the Verilator simulator

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
    filelist = file_list.get_file_list(l, context, 'sim_rtl,sim_rtl_verilator')
    dirlist = file_list.get_dir_list(d, context, 'sim_rtl,sim_rtl_verilator')
    for d in dirlist:
        result += "+incdir+" + d + "\n"

    for f in filelist:
        result += f + "\n"
    return result
