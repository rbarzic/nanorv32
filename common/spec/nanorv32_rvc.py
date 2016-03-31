spec['nanorv32']['inst_type']['CR-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rs2': {'size': 5, 'offset': 2},
    'c_rd_rs1': {'size': 5, 'offset': 7},
    'c_func4': {'size': 4, 'offset': 12, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True},
}


spec['nanorv32']['inst_type']['CI-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'ci_immlo': {'size': 5, 'offset': 2},
    'c_rd_rs1': {'size': 5, 'offset': 7},
    'ci_immhi': {'size': 1, 'offset': 12},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True},
}

spec['nanorv32']['inst_type']['CSS-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rs2': {'size': 5, 'offset': 2},
    'css_imm': {'size': 6, 'offset': 7},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True},
}

spec['nanorv32']['inst_type']['CIW-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rd_p': {'size': 3, 'offset': 2},
    'ciw_imm': {'size': 8, 'offset': 5},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True},
}

spec['nanorv32']['inst_type']['CL-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rd_p': {'size': 3, 'offset': 2},
    'cl_immlo': {'size': 2, 'offset': 5},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'cl_immhi': {'size': 3, 'offset': 10},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True},
}

spec['nanorv32']['inst_type']['CS-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rs2_p': {'size': 3, 'offset': 2},
    'cs_immlo': {'size': 2, 'offset': 5},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'cs_immhi': {'size': 3, 'offset': 10},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True},
}

spec['nanorv32']['inst_type']['CB-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'cb_offset_lo': {'size': 5, 'offset': 2},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'cb_offset_hi': {'size': 3, 'offset': 10},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True},
}

spec['nanorv32']['inst_type']['CJ-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'cj_imm': {'size': 11, 'offset': 2},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True, 'Hint' : True},
}

# Added to support the C.AND/C.OR, C.XOR, C.SUB, C.ADDW, CSUBW
spec['nanorv32']['inst_type']['CS2-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'c_rs2_p': {'size': 3, 'offset': 2},
    'cb2_dec':{'size': 2, 'offset': 5, 'decode': True},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'c_func6': {'size': 6, 'offset': 10, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True, 'Hint' : True},
}

# Added to support C.SRLI, C.SRAI, C.ANDI
spec['nanorv32']['inst_type']['CB2-type']['format'] = {
    'opcodervc': {'size': 2, 'offset': 0, 'decode': True},
    'cb2_immlo': {'size': 5, 'offset': 2},
    'c_rs1_p': {'size': 3, 'offset': 7},
    'c_func2': {'size': 2, 'offset': 10},
    'cb2_immlo': {'size': 1, 'offset': 12},
    'c_func3': {'size': 3, 'offset': 13, 'decode': True},
    'hint_rvc_rd_rs1_is_zero' : {'size': 1, 'offset': 32, 'decode': True, 'Hint' : True},
    'hint_rvc_rd_rs1_is_two' : {'size': 1, 'offset': 33, 'decode': True, 'Hint' : True},
    'hint_rvc_rs2_is_zero'    : {'size': 1, 'offset': 34, 'decode': True, 'Hint' : True},
}



################################################################
#   Instruction decoding description
#   RVC - Quadrant 0 - opcode_rvc = 0b00
################################################################


#spec['nanorv32']['rvc_rv32']['c.illegal']['desc'] = {
#    'inst_type' : 'CR-type',
#    'decode' : {
#        'opcodervc' : 0b00,
#        'c_func4'     : 0b0000,
#    }
#}


spec['nanorv32']['rvc_rv32']['c.add4spn']['desc'] = {
    'inst_type' : 'CIW-type',
    'decode' : {
        'opcodervc' : 0b00,
        'c_func3'     : 0b000,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.lw']['desc'] = {
    'inst_type' : 'CL-type',
    'decode' : {
        'opcodervc' : 0b00,
        'c_func3'     : 0b010,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.sw']['desc'] = {
    'inst_type' : 'CS-type',
    'decode' : {
        'opcodervc' : 0b00,
        'c_func3'     : 0b110,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}



################################################################
#   Instruction decoding description
#   RVC - Quadrant 1 - opcode_rvc = 0b10
################################################################

spec['nanorv32']['rvc_rv32']['c.nop']['desc'] = {
    'inst_type' : 'CI-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b000,
        'hint_rvc_rd_rs1_is_zero' : 1,
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : 1,
    }
}

spec['nanorv32']['rvc_rv32']['c.addi']['desc'] = {
    'inst_type' : 'CI-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b000,
        'hint_rvc_rd_rs1_is_zero' : 0, # rd must be != 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.jal']['desc'] = {
    'inst_type' : 'CJ-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b001,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}
spec['nanorv32']['rvc_rv32']['c.j']['desc'] = {
    'inst_type' : 'CJ-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b0101,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.li']['desc'] = {
    'inst_type' : 'CI-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b010,
        'hint_rvc_rd_rs1_is_zero' : 0, # rd must be != 0
        'hint_rvc_rd_rs1_is_two' :  0,
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.addi16sp']['desc'] = {
    'inst_type' : 'CI-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b011,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : 1,  #  must be 2
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.lui']['desc'] = {
    'inst_type' : 'CI-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b011,
        'hint_rvc_rd_rs1_is_zero' : 0,
        'hint_rvc_rd_rs1_is_two' : 0, # rd must be != 0 and != 2
        'hint_rvc_rs2_is_zero'    : '?',
    }
}


# FIXME : the current decoder does not check for shamt[5]
# C.SRLI is a CB-format instruction that performs a logical right shift of the value in register rd 0
# then writes the result to rd 0 . The shift amount is encoded in the shamt field, where shamt[5] must
# be zero for RV32C. For RV32C and RV64C, the shift amount must be non-zero.


spec['nanorv32']['rvc_rv32']['c.srli']['desc'] = {
    'inst_type' : 'CB2-type',
    'decode' : {
        'opcodervc' : 0b01,
        'cb2_dec'   : 0b00,
        'c_func3'     : 0b100,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.srai']['desc'] = {
    'inst_type' : 'CB2-type',
    'decode' : {
        'opcodervc' : 0b01,
        'cb2_dec'   : 0b01,
        'c_func3'     : 0b100,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.andi']['desc'] = {
    'inst_type' : 'CB2-type',
    'decode' : {
        'opcodervc' : 0b01,
        'cb2_dec'   : 0b10,
        'c_func3'     : 0b100,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.bnez']['desc'] = {
    'inst_type' : 'CB-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b111,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.beqz']['desc'] = {
    'inst_type' : 'CB-type',
    'decode' : {
        'opcodervc' : 0b01,
        'c_func3'     : 0b110,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}


spec['nanorv32']['rvc_rv32']['c.sub']['desc'] = {
    'inst_type' : 'CS2-type',
    'decode' : {
        'opcodervc' : 0b01,
        'cb2_dec'   : 0b00,
        'c_func6'   : 0b100011,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.xor']['desc'] = {
    'inst_type' : 'CS2-type',
    'decode' : {
        'opcodervc' : 0b01,
        'cb2_dec'   : 0b01,
        'c_func6'   : 0b100011,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.or']['desc'] = {
    'inst_type' : 'CS2-type',
    'decode' : {
        'opcodervc' : 0b01,
        'cb2_dec'   : 0b10,
        'c_func6'   : 0b100011,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.and']['desc'] = {
    'inst_type' : 'CS2-type',
    'decode' : {
        'opcodervc' : 0b01,
        'cb2_dec'   : 0b11,
        'c_func6'   : 0b100011,
        'hint_rvc_rd_rs1_is_zero' : '?',
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}







################################################################
#   Instruction decoding description
#   RVC - Quadrant 2
################################################################

spec['nanorv32']['rvc_rv32']['c.slli']['desc'] = {
    'inst_type' : 'CI-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func3'     : 0b000,
        'hint_rvc_rd_rs1_is_zero' : 0, # rd must be != 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}


spec['nanorv32']['rvc_rv32']['c.lwsp']['desc'] = {
    'inst_type' : 'CI-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func3'     : 0b010,
        'hint_rvc_rd_rs1_is_zero' : 0, # rd must be != 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : '?',
    }
}

spec['nanorv32']['rvc_rv32']['c.jr']['desc'] = {
    'inst_type' : 'CR-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func4'     : 0b1000,
        'hint_rvc_rd_rs1_is_zero' : 0, # rs1 must be != 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : 1, # rs2 must be == 0
    }
}

spec['nanorv32']['rvc_rv32']['c.mv']['desc'] = {
    'inst_type' : 'CR-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func4'     : 0b1000,
        'hint_rvc_rd_rs1_is_zero' : 0, # rs1 must be != 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : 0, # rs2 must be == 0
    }
}

spec['nanorv32']['rvc_rv32']['c.ebreak']['desc'] = {
    'inst_type' : 'CR-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func4'     : 0b1001,
        'hint_rvc_rd_rs1_is_zero' : 1, # rs1 must be == 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : 1, # rs2 must be == 0
    }
}


spec['nanorv32']['rvc_rv32']['c.jalr']['desc'] = {
    'inst_type' : 'CR-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func4'     : 0b1001,
        'hint_rvc_rd_rs1_is_zero' : 0, # rs1 must be != 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : 1, # rs2 must be == 0
    }
}

spec['nanorv32']['rvc_rv32']['c.add']['desc'] = {
    'inst_type' : 'CR-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func4'     : 0b1001,
        'hint_rvc_rd_rs1_is_zero' : 0, # rs1 must be != 0
        'hint_rvc_rd_rs1_is_two' : '?',
        'hint_rvc_rs2_is_zero'    : 0, # rs2 must be == 0
    }
}

spec['nanorv32']['rvc_rv32']['c.swsp']['desc'] = {
    'inst_type' : 'CSS-type',
    'decode' : {
        'opcodervc' : 0b10,
        'c_func3'     : 0b110,
        'hint_rvc_rd_rs1_is_zero' : '?', # rs1 must be != 0
        'hint_rvc_rd_rs1_is_two'  : '?',
        'hint_rvc_rs2_is_zero'    : '?', # rs2 must be ==     }
    }
}
