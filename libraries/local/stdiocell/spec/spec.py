from typing import Any
from typing import Dict
from typing import cast
from collections import defaultdict

import os

# To make mypy happy...
nested_dict = None
nested_dict = lambda: defaultdict(nested_dict)  # type: ignore # noqa E731

cells  = cast(Dict[str, Any], nested_dict()) # type: ignore # noqa E731

library  = cast(Dict[str, Any], nested_dict()) # type: ignore # noqa E731

library["name"] = "stdiocell"
library["process"] = "tsmc180nmrf_tdb"

library["temperature"]['min'] = -40.0 
library["temperature"]['max'] = 105.0 
library["temperature"]['typ'] = 25.0 

# Not in the LEF file
#cells["stdiocell"]["pins"]["vcc"]['type'] = "power"
#cells["stdiocell"]["pins"]["gnd"]['type'] = "ground"


cells["stdiocell"]["pins"]["dout"]['type'] = "digital"
cells["stdiocell"]["pins"]["dout"]['dir'] = "input"
cells["stdiocell"]["pins"]["dout"]['description'] = "Data to pad"

cells["stdiocell"]["pins"]["oe"]['type'] = "digital"
cells["stdiocell"]["pins"]["oe"]['dir'] = "input"
cells["stdiocell"]["pins"]["oe"]['description'] = "Output enable"

cells["stdiocell"]["pins"]["ie"]['type'] = "digital"
cells["stdiocell"]["pins"]["ie"]['dir'] = "input"
cells["stdiocell"]["pins"]["ie"]['description'] = "Input enable"

cells["stdiocell"]["pins"]["puen"]['type'] = "digital"
cells["stdiocell"]["pins"]["puen"]['dir'] = "input"
cells["stdiocell"]["pins"]["puen"]['description'] = "Pullup  enable"

cells["stdiocell"]["pins"]["rst"]['type'] = "digital"
cells["stdiocell"]["pins"]["rst"]['dir'] = "input"
cells["stdiocell"]["pins"]["rst"]['description'] = "Reset"

cells["stdiocell"]["pins"]["di"]['type'] = "digital"
cells["stdiocell"]["pins"]["di"]['dir'] = "output"
cells["stdiocell"]["pins"]["di"]['description'] = "Data from pad"

cells["stdiocell"]["pins"]["PAD"]['type'] = "analog"
cells["stdiocell"]["pins"]["PAD"]['dir'] = "inout"
cells["stdiocell"]["pins"]["PAD"]['description'] = "Pad"

cells["stdiocell"]['width'] = 84.0 # um always
cells["stdiocell"]['height'] = 150.0 # um always


# anaiocell

cells["anaiocell"]["pins"]["ao18in"]['type'] = "analog"
cells["anaiocell"]["pins"]["ao18in"]['dir'] = "inout"
cells["anaiocell"]["pins"]["ao18in"]['description'] = "analog connection"

cells["anaiocell"]["pins"]["PAD"]['type'] = "analog"
cells["anaiocell"]["pins"]["PAD"]['dir'] = "inout"
cells["anaiocell"]["pins"]["PAD"]['description'] = "Pad"

cells["anaiocell"]['width'] = 84.0 # um always
cells["anaiocell"]['height'] = 150.0 # um always


# rfiniocell

cells["rfiniocell"]["pins"]["rfin"]['type'] = "analog"
cells["rfiniocell"]["pins"]["rfin"]['dir'] = "inout"
cells["rfiniocell"]["pins"]["rfin"]['description'] = "RF input from pad"

cells["rfiniocell"]["pins"]["PAD"]['type'] = "analog"
cells["rfiniocell"]["pins"]["PAD"]['dir'] = "inout"
cells["rfiniocell"]["pins"]["PAD"]['description'] = "Pad"

cells["rfiniocell"]['width'] = 84.0 # um always
cells["rfiniocell"]['height'] = 150.0 # um always


# rfoutiocell

cells["rfoutiocell"]["pins"]["rfout"]['type'] = "analog"
cells["rfoutiocell"]["pins"]["rfout"]['dir'] = "inout"
cells["rfoutiocell"]["pins"]["rfout"]['description'] = "RF input from pad"

cells["rfoutiocell"]["pins"]["PAD"]['type'] = "analog"
cells["rfoutiocell"]["pins"]["PAD"]['dir'] = "inout"
cells["rfoutiocell"]["pins"]["PAD"]['description'] = "Pad"

cells["rfoutiocell"]['width'] = 84.0 # um always
cells["rfoutiocell"]['height'] = 150.0 # um always







