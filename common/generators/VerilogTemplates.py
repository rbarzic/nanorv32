define_inst_format = """
// Instruction {name_lc}
parameter NANORV32_INST_FORMAT_{name_uc}_OFFSET = {offset_str};
parameter NANORV32_INST_FORMAT_{name_uc}_SIZE = {size_str};
parameter NANORV32_INST_FORMAT_{name_uc}_MSB = {msb_str};
"""

decode_def = "parameter NANORV32_DECODE_{inst_uc} = {val};\n"
decode_case = "    NANORV32_DECODE_{inst_uc}: begin\n"
decode_line = "        {port}_sel = NANORV32_MUX_SEL_{port_uc}_{port_val};\n"
decode_end = "    end\n"
decode_inst_field = """
    wire [NANORV32_INST_FORMAT_{name_uc}_MSB:0] dec_{name_lc}  = instruction_r[NANORV32_INST_FORMAT_{name_uc}_OFFSET +: NANORV32_INST_FORMAT_{name_uc}_SIZE];"""


mux_constant_width ="""
parameter NANORV32_MUX_SEL_{port_uc}_SIZE = {bits};
parameter NANORV32_MUX_SEL_{port_uc}_MSB = {msb};
 """

mux_sel_declaration ="""
    reg  [NANORV32_MUX_SEL_{port_uc}_MSB:0] {port_lc}_sel;"""

mux_constant_sel ="""
parameter NANORV32_MUX_SEL_{name} = {idx};"""

mux_sel_template_1 ="""
    case({port_lc})"""

mux_sel_template_2 ="""
        NANORV32_MUX_SEL_{name}: begin
            {port_lc} <= ;
        end"""
