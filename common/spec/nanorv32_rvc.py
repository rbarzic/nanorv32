spec['nanorv32']['inst_type']['CR-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rs2': {'size': 5, 'offset': 2},
    'c_rd_rs1': {'size': 5, 'offset': 7},
    'c_func4': {'size': 4, 'offset': 12, 'decode': True},
}


spec['nanorv32']['inst_type']['CI-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'ci_immlo': {'size': 5, 'offset': 2},
    'c_rd_rs1': {'size': 5, 'offset': 7},
    'ci_immhi': {'size': 1, 'offset': 12},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
}

spec['nanorv32']['inst_type']['CSS-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rs2': {'size': 5, 'offset': 2},
    'css_imm': {'size': 6, 'offset': 7},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
}

spec['nanorv32']['inst_type']['CIW-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rd_p': {'size': 3, 'offset': 2},
    'ciw_imm': {'size': 8, 'offset': 5},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
}

spec['nanorv32']['inst_type']['CL-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rd_p': {'size': 3, 'offset': 2},
    'cl_immlo': {'size': 2, 'offset': 5},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'cl_immhi': {'size': 3, 'offset': 10},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
}

spec['nanorv32']['inst_type']['CL-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rs2_p': {'size': 3, 'offset': 2},
    'cs_immlo': {'size': 2, 'offset': 5},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'cs_immhi': {'size': 3, 'offset': 10},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
}

spec['nanorv32']['inst_type']['CB-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'cb_offset_lo': {'size': 5, 'offset': 2},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'cb_offset_hi': {'size': 3, 'offset': 10},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
}

spec['nanorv32']['inst_type']['CJ-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'cj_imm': {'size': 11, 'offset': 2},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
}


################################################################
#   Instruction decoding description
#   RVC - Quadrant 0
################################################################
spec['nanorv32']['rv32i']['c.addi4spn']['desc'] = {
    'inst_type' : '???',
    'decode' : {
        'opcode1' : 0b1110011,
        'rs1'     : 0b000,
        'func3'   : 0b000,
        'func12'   : 0b000000000000
    }
}
