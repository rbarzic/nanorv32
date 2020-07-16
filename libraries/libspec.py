from typing import Any
from typing import Dict
import os
import sys
from typing import cast

from collections import defaultdict
import logging
nested_dict = None
nested_dict = lambda: defaultdict(nested_dict)  # type: ignore # noqa E731

next_idx: int = 0

libspec = cast(Dict[str, Any], nested_dict())
libcfg = cast(Dict[str, Any], nested_dict())


logging.info(f"Process selected : {process}")

if process == "nangate45":
    libspec["stdcells"]["lib"]["corners"] = {
        "typ": "{top}/libraries/imported/nangate45/lib/NangateOpenCellLibrary_typical.lib", 
        "min": "{top}/libraries/imported/nangate45/lib/NangateOpenCellLibrary_typical.lib",
        "max": "{top}/libraries/imported/nangate45/lib/NangateOpenCellLibrary_typical.lib",
    }
    libspec["stdcells"]["lef"] = [
        "{top}/libraries/imported/nangate45/lef/NangateOpenCellLibrary.macro.mod.lef"
    ]
    libcfg["tech_lef"] = "{top}/libraries/imported/nangate45/lef/NangateOpenCellLibrary.tech.lef"
    libcfg["default_site"] = "FreePDK45_38x28_10R_NP_162NW_34O"
    

    
else:
    logging.error(f"Incorrect process argument : {process}")
    sys.exit(1)

###########################################################################
# RAM macro
###########################################################################
    
# just an helper
# {top} will be set by the script reading this specification
lib_bytewrite_ram_32bits_path = (
    "{top}/libraries/local/bytewrite_ram_32bits/lib/"
)
lef_bytewrite_ram_32bits_path = (
    "{top}/libraries/local/bytewrite_ram_32bits/lef/"
)

libspec["bytewrite_ram_32bits"]["lib"]["corners"] = {
    "typ": lib_bytewrite_ram_32bits_path + "bytewrite_ram_32bits.lib",
    "min": lib_bytewrite_ram_32bits_path + "bytewrite_ram_32bits.lib",
    "max": lib_bytewrite_ram_32bits_path + "bytewrite_ram_32bits.lib",
}

if process == "nangate45":
    libspec["bytewrite_ram_32bits"]["lef"] = [
        lef_bytewrite_ram_32bits_path + "bytewrite_ram_32bits_metal.lef"
    ]


    
# IOCELLS
libspec["stdiocell"]["lib"]["corners"] = {
    "typ": "{top}/libraries/local/stdiocell/lib/stdiocell.lib",
    "min": "{top}/libraries/local/stdiocell/lib/stdiocell.lib",
    "max": "{top}/libraries/local/stdiocell/lib/stdiocell.lib",
}

if process == "nangate45":
    libspec["stdiocell"]["lef"] =[
        "{top}/libraries/local/stdiocell/lef/iocells_metal.lef",
    ]

dflt_order = [
    "stdcells", # 0 / first
    "stdiocell", # 1 / 2nd
    "bytewrite_ram_32bits",
]

libcfg["order"]['generic'] = dflt_order
# this may no be needed anymore
# but we keep it just in case
libcfg["order"]['yosys'] = dflt_order 
libcfg["order"]['genus'] = dflt_order
