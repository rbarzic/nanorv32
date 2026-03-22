from typing import Any
from typing import Dict
from typing import cast
from collections import defaultdict

import os

# To make mypy happy...
nested_dict = None
nested_dict = lambda: defaultdict(nested_dict)  # type: ignore # noqa E731

next_idx: int = 0

cell  = cast(Dict[str, Any], nested_dict())
cell["name"] = "bytewrite_ram_32bits"

cell["pins"]["dvcc"]['type'] = "power"
cell["pins"]["dgnd"]['type'] = "ground"


cell["pins"]["clk"]['type'] = "digital"
cell["pins"]["clk"]['dir'] = "input"
cell["pins"]["clk"]['description'] = "Clock input"

cell["pins"]["we"]['type'] = "digital"
cell["pins"]["we"]['dir'] = "input"
cell["pins"]["we"]['description'] = "Byte write enable"
cell["pins"]["we"]['msb'] = 3
cell["pins"]["we"]['lsb'] = 0

cell["pins"]["din"]['type'] = "digital"
cell["pins"]["din"]['dir'] = "input"
cell["pins"]["din"]['description'] = "Data in bus"
cell["pins"]["din"]['msb'] = 31
cell["pins"]["din"]['lsb'] = 0


cell["pins"]["addr"]['type'] = "digital"
cell["pins"]["addr"]['dir'] = "input"
cell["pins"]["addr"]['description'] = "Address bus"
cell["pins"]["addr"]['msb'] = 10
cell["pins"]["addr"]['lsb'] = 0

cell["pins"]["dout"]['type'] = "digital"
cell["pins"]["dout"]['dir'] = "output"
cell["pins"]["dout"]['description'] = "Data out bus"
cell["pins"]["dout"]['msb'] = 31
cell["pins"]["dout"]['lsb'] = 0



cell['width'] = 200.0 # um always
cell['height'] = 450.0 # um always

cell["temperature"]['min'] = -40.0 
cell["temperature"]['max'] = 105.0 
cell["temperature"]['typ'] = 25.0 

cell["process"] = "tsmc180nmrf_tdb"

