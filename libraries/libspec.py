from typing import Any
from typing import Dict
import os
import sys
from typing import cast, Optional

from collections import defaultdict
import logging

# allow auto-vivification
nested_dict = None
nested_dict = lambda: defaultdict(nested_dict)  # type: ignore # noqa E731

# A little trick for getting rid of linting error(s) as
# process variable is defined in the global context when we execute this file


try: process : Optional[str]
except NameError: process = None

next_idx: int = 0

libspec = cast(Dict[str, Any], nested_dict()) # type: ignore
libcfg = cast(Dict[str, Any], nested_dict()) # type: ignore 


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
    
elif process == "sky130":
    libspec["stdcells"]["lib"]["corners"] = {
        "typ": "{top}/libraries/imported/sky130-lite/sky130_fd_sc_hdll/timing/sky130_fd_sc_hdll__tt_025C_1v80.lib", 
        "min": "{top}/libraries/imported/sky130-lite/sky130_fd_sc_hdll/timing/sky130_fd_sc_hdll__ff_n40C_1v95.lib",
        "max": "{top}/libraries/imported/sky130-lite/sky130_fd_sc_hdll/timing/sky130_fd_sc_hdll__ss_100C_1v60.lib",
    }
    libspec["stdcells"]["lef"] = [
        "{top}/libraries/imported/sky130-lite/sky130_fd_sc_hdll/sky130_fd_sc_hdll.lef"
    ]
    libcfg["tech_lef"] = "{top}/libraries/imported/sky130-lite/sky130_fd_sc_hdll/tech/sky130_fd_sc_hdll.tlef"
    libcfg["default_site"] = "unithd"
    

    
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
elif process == "sky130":
    libspec["bytewrite_ram_32bits"]["lef"] = [
        lef_bytewrite_ram_32bits_path + "bytewrite_ram_32bits_met.lef"
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
elif process == "sky130":
    libspec["stdiocell"]["lef"] =[
        "{top}/libraries/local/stdiocell/lef/iocells_met.lef",
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


# Local Variables:
# eval: (blacken-mode)
# End:
