#!/usr/bin/env python3
# Read a libspec Python file, generate a file suitable
# to be use by a CAD tool to load the correct library

from typing import List, Dict, Tuple, cast, Any

import argparse

import sys
import runpy
import logging


from collections import defaultdict

# nested_dict = None
nested_dict = lambda: defaultdict(nested_dict)  # type: ignore # noqa E731

coloredlogs_avail = False
try:
    import coloredlogs

    coloredlogs_avail = True
except ModuleNotFoundError:
    pass


_file_format = ["tcl", "python"]
_library_type = ["lef", "liberty"]

extensions: Dict = {
    "python": "py",
    "tcl": "tcl",
}


def setup_logging(verbosity: int, excluded_modules: List[str] = []) -> None:
    """Set-up root logging level according to the number of -v options
       Logging can also be set to be quiet for imported modules
    """
    for module in excluded_modules:
        logging.getLogger("docpie").setLevel(logging.WARNING)

    logging_level = logging.WARNING
    if verbosity == 1:
        logging_level = logging.INFO
    if verbosity == 2:
        logging_level = logging.DEBUG
    FORMAT = "[%(filename)s:%(lineno)s - %(funcName)20s() ] %(levelname)s %(message)s"  # noqa: E501
    # logging.basicConfig(format=FORMAT, level=logging_level)
    if coloredlogs_avail:
        coloredlogs.install(level=logging_level, fmt=FORMAT)
    else:
        logging.basicConfig(format=FORMAT, level=logging_level)
    # logging.basicConfig(level=logging_level)


def get_args() -> argparse.Namespace:
    """
    Get command line arguments
    """
    parser = argparse.ArgumentParser(
        description="""
Read a libspec Python file, generate a file suitable
to be use by a CAD tool to load the correct library

    """
    )

    # parser.add_argument(
    #    dest="tests", metavar="tests", nargs="*", help="Path(es) to the test"
    # )

    parser.add_argument("libspec", help="Library cell spec file ")

    parser.add_argument(
        "--output_dir",
        action="store",
        help="Output directory for Generated configuration file",
        default=".",
    )

    parser.add_argument(
        "--top",
        action="store",
        help="Define the value of {top} variable in the libspec file",
        default=".",
    )

    parser.add_argument(
        "--corners",
        action="store",
        help="Comma separated list of corners to be use for the generation",
        default="max",
        type=str,
    )

    parser.add_argument(
        "--format",
        action="store",
        help="Comma separated list of file format : tcl,python",
        default="tcl,python",
    )

    parser.add_argument(
        "--library_type",
        action="store",
        help="Comma separated list of library format : lef,liberty",
        default="lef,liberty",
    )

    parser.add_argument(
        "--process",
        action="store",
        choices=["sky130", "nangate45"],
        help="Process/libraries to be used for synthesis and Place&Route",
        default="nangate45",
    )

    parser.add_argument(
        "--tool",
        action="store",
        choices=["generic", "yosys", "genus"],
        help="Tool to generate configuration for",
        default="generic",
    )

    parser.add_argument(
        "-v",
        "--verbosity",
        action="count",
        help="Increase output verbosity",
        default=0,
    )
    parser.add_argument("--version", action="version", version="0.1")

    return parser.parse_args()


def get_liberty(
    args: argparse.Namespace, libspec: Dict
) -> Dict[str, Tuple[str, str]]:
    corners = args.corners.split(",")
    top = args.top
    result: Dict[str, Tuple[str, str]] = {}
    for cell, data in libspec.items():
        if ("lib" in data) and ("corners" in data["lib"]):
            for corner, libpath in data["lib"]["corners"].items():
                if corner in corners:
                    result[cell] = (corner, libpath.format(top=top))
    return result


def get_lef(args: argparse.Namespace, libspec: Dict) -> List[str]:

    result: List[str] = []
    for cell, data in libspec.items():
        if "lef" in data:
            result += data["lef"]
    logging.info(f"result = {result}")
    return result


def get_lib_tcl(
    list_of_libs: Dict[str, Tuple[str, str]], lib_ordering: List[str]
) -> str:
    result = ""
    # for lib in list_of_libs:
    for lib in lib_ordering:
        result += f"lappend lib_files {list_of_libs[lib][1]}\n"

    for libname, (corner, libpath) in list_of_libs.items():
        result += f"set lib{corner}_{libname} {libpath}\n"
    return result


def get_lib_py(
    list_of_libs: Dict[str, Tuple[str, str]], lib_ordering: List[str]
) -> str:
    result = ""
    # for lib in list_of_libs:
    for lib in lib_ordering:
        result += f"lib_files.append({list_of_libs[lib][1]})\n"

    # for libname, (corner, libpath) in list_of_libs.items():
    #    result += f"set lib{corner}_{libname} {libpath}\n"
    return result


def get_lef_py(args: argparse.Namespace, libspec: Dict, libcfg: Dict) -> str:
    all_txt_py = ""
    if "tech_lef" in libcfg:
        all_txt_py += "tech_lef = '{}'".format(
            libcfg["tech_lef"].format(top=args.top)
        )
    lefs = get_lef(args, libspec)
    all_txt_py += "\n"
    all_txt_py += "\n".join([f"lef_files.append('{f}')" for f in lefs]).format(
        top=args.top
    )
    return all_txt_py


def get_lef_tcl(args: argparse.Namespace, libspec: Dict, libcfg: Dict) -> str:
    all_txt_tcl = ""
    if "tech_lef" in libcfg:
        all_txt_tcl += "set tech_lef " + libcfg["tech_lef"].format(top=args.top)
        all_txt_tcl += "\n"
    lefs = get_lef(args, libspec)
    all_txt_tcl += "\n".join([f"lappend lef_files {f}" for f in lefs]).format(
        top=args.top
    )
    return all_txt_tcl


# def get_output_file_name(args: argparse.Namespace, libspec: Dict) -> str:
#    file_name = args.output
#    if args.tool == 'yosys':
#        ext = ".ys"
#    else:
#        ext = ".tcl"
#    return file_name


def read_libspec_file(filename: str, process_lc: str) -> Tuple[Dict, Dict]:
    init_globals: Dict = {}
    init_globals["process"] = process_lc
    logging.info(f"Process selected : {process_lc}")
    global_vars = runpy.run_path(filename, init_globals=init_globals)
    if "libspec" not in global_vars:
        logging.error(f"libspec variable not found in {args.libspec}")
        sys.exit(1)

    if "libcfg" not in global_vars:
        logging.error(f"libcfg variable not found in {args.libcfg}")
        sys.exit(1)
    libspec = global_vars["libspec"]
    libcfg = global_vars["libcfg"]
    return libspec, libcfg


if __name__ == "__main__":
    cmdline = " ".join(sys.argv)
    args = get_args()

    file_formats = args.format.split(",")
    library_types = args.library_type.split(",")

    setup_logging(args.verbosity)

    process_lc = args.process.lower()

    libspec, libcfg = read_libspec_file(args.libspec, process_lc)

    all = cast(Dict[str, Any], nested_dict())
    all["liberty"][
        "tcl"
    ] = f"""# Automatically generated by {cmdline} 
# !!! Do not edit !!!\n
"""
    all["lef"]["tcl"] = all["liberty"]["tcl"]
    all["liberty"]["py"] = all["liberty"]["tcl"]
    all["lef"]["py"] = all["liberty"]["tcl"]

    # Get a dictionnary with key = lib name, value = path to the library
    #
    list_of_libs = get_liberty(args, libspec)
    if args.tool == "yosys":
        lib_ordering = libcfg["order"]["yosys"]
    elif args.tool == "genus":
        lib_ordering = libcfg["order"]["genus"]
    elif args.tool == "generic":
        lib_ordering = libcfg["order"]["generic"]

    all["liberty"]["tcl"] += get_lib_tcl(list_of_libs, lib_ordering)
    all["liberty"]["py"] += get_lib_py(list_of_libs, lib_ordering)

    all["lef"]["tcl"] += get_lef_tcl(args, libspec, libcfg)
    all["lef"]["py"] += get_lef_py(args, libspec, libcfg)

    for file_format in file_formats:
        for lib_type in library_types:
            ext = extensions[file_format]
            file_name = (
                args.output_dir + "/" + f"list_{lib_type}.{process_lc}.{ext}"
            )
            with open(file_name, "w") as f:
                f.write(all[lib_type][ext])


# Local Variables:
# eval: (blacken-mode)
# End:
