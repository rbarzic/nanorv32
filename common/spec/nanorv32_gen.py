import pprint as pp


import sys
import os
sys.path.append(os.getcwd())
sys.path.append('../generators')

import riscv_gen as rg
import nanorv32

# if __name__ == '__main__':
if True:
    #pp.pprint(nanorv32.spec)
    dic_inst_format = rg.get_instruction_format(nanorv32.spec)
    #pp.pprint(dic_inst_format)
    rg.write_to_file("../../generated", "instruction_format.generated.v",
                     rg.verilog_instruction_format(dic_inst_format))
    rg.write_to_file("../../generated", "instruction_fields.generated.v",
                     rg.verilog_inst_field(dic_inst_format))

    pass
