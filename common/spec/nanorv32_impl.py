import AutoVivification as av
spec = av.AutoVivification()





# 'add','sub','sll','slt','sltu','xor','srl','sra','or','and'
spec['nanorv32']['rv32i']['impl']['inst_type']['R-type'] = {
    'pc' : {
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },

}

# 'I-type jalr','addi','ssli','slti','sltiu','xori','srli','srai','ori','andi',
#                'lb','lu','lw','ld','lbu','lwu','lhu'
# We define as a default the behaviour for arithmetic instruction
spec['nanorv32']['rv32i']['impl']['inst_type']['I-type'] = {
    'pc' : {
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm12',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },

}

# S-Type : 'sb','sh','sw','sd' (Store instructions)
spec['nanorv32']['rv32i']['impl']['inst_type']['S-type'] = {
    'pc' : {
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm12hilo',
    },
    'regfile' : {
        'write' : 'no',
        'source' : 'alu', # unused
    },
    'datamem' : {
        'write' : 'word',
        'read' : 'no',
    },

}

# SB-Type : 'beq','bne','blt','bge','bltu','bgeu'
#
spec['nanorv32']['rv32i']['impl']['inst_type']['SB-type'] = {
    'pc' : {
        'next' : 'cond_pc_plus_immsb' # conditional branch
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2', # ALU op defined in each instruction
    },
    'regfile' : {
        'write' : 'no',
        'source' : 'alu', # unused
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },

}


# U-Type : ['lui','auipc']
spec['nanorv32']['rv32i']['impl']['inst_type']['U-type'] = {
    'pc' : {
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'pc_exe',
        'portb' : 'imm20u', # ALU op will be 'portb' or add
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu', # unused
    },
    'datamem' : {
        'write' : 'word',
        'read' : 'no',
    },

}

# UJ-Type : jal
spec['nanorv32']['rv32i']['impl']['inst_type']['UJ-type'] = {
    'pc' : {
        'next' : 'alu_res'
    },
    'alu' : {
        'porta' : 'pc_exe',
        'portb' : 'imm20uj',
        'op'    : 'add',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'pc_next',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },

}


# AS-type': 'slli','slti','srli','srai'
spec['nanorv32']['rv32i']['impl']['inst_type']['AS-type'] = {
    'pc' : {
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'shamt',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },

}


# F-type : fence, fence.i
spec['nanorv32']['rv32i']['impl']['inst_type']['F-type'] = {
    'pc' : {
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'noop',
    },
    'regfile' : {
        'write' : 'no',
        'source' : 'alu',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },

}

# SYS-type : scall, sbreak
spec['nanorv32']['rv32i']['impl']['inst_type']['SYS-type'] = {
    'pc' : {
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'nop',
    },
    'regfile' : {
        'write' : 'no',
        'source' : 'alu',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },

}





spec['nanorv32']['rv32i']['impl']['inst']['jalr'] = {
    'pc' : {
        'next' : 'alu_res'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm12',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['addi'] = {
     'alu' : {
        'op' : 'add',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['slli'] = {
     'alu' : {
        'porta' : 'rs1',
        'portb' : 'shamt',
         'op'    : 'lshift',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['slti'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm12',
        'op'    : 'lt_signed',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['sltiu'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm12',
        'op'    : 'lt_unsigned',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['xori'] = {
    'alu' : {
        'op' : 'xor',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['srli'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'shamt',
        'op'    : 'rshift',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['srai'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'shamt',
        'op'    : 'arshift', # Arithmetic right shift
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['ori'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['andi'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lb'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lw'] = {
    'datamem' : {
        'write' : 'no',
        'read' : 'yes',
    },

}


# spec['nanorv32']['rv32i']['impl']['inst']['ld'] = {
#     'datamem' : {
#         'write' : 'no',
#         'read' : 'yes',
#     },
# }


spec['nanorv32']['rv32i']['impl']['inst']['lbu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lwu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lhu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['fence'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['fence_i'] = {

}



spec['nanorv32']['rv32i']['impl']['inst']['beq'] = {
    'alu' : {
        'op' : 'eq',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['bne'] = {
    'alu' : {
        'op' : 'neq',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['blt'] = {
    'alu' : {
        'op' : 'lt_signed',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },

}


spec['nanorv32']['rv32i']['impl']['inst']['bge'] = {
    'alu' : {
        'op' : 'ge_signed', # Greater or equal (signed)
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['bltu'] = {
    'alu' : {
        'op' : 'lt_unsigned',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['bgeu'] = {
    'alu' : {
        'op' : 'ge_unsigned', # Greater or equal (unsigned)
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['lui'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['auipc'] = {

}


# {{{ add

spec['nanorv32']['rv32i']['impl']['inst']['add'] = {
     'alu' : {
        'op' : 'add',
    },
}

# }}}

# {{{ sub

spec['nanorv32']['rv32i']['impl']['inst']['sub'] = {
     'alu' : {
        'op' : 'sub',
    },
}

# }}}



spec['nanorv32']['rv32i']['impl']['inst']['sll'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'lshift',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['slt'] = {
     'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'lt_signed',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['sltu'] = {
         'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'lt_unsigned',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['xor'] = {
    'alu' : {
        'op' : 'or',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['srl'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'rshift',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['sra'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'arshift', # Arithmetic right shift
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['or'] = {
    'alu' : {
        'op' : 'or',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['and'] = {
    'alu' : {
        'op' : 'and',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['scall'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['sbreak'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['sb'] = {
     'datamem' : {
        'write' : 'yes',
        'read' : 'no',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['sh'] = {
     'datamem' : {
        'write' : 'yes',
        'read' : 'no',
    },

}


spec['nanorv32']['rv32i']['impl']['inst']['sw'] = {
     'datamem' : {
        'write' : 'yes',
        'read' : 'no',
    },
}


#spec['nanorv32']['rv32i']['impl']['inst']['sd'] = {
#
#}


spec['nanorv32']['rv32i']['impl']['inst']['jal'] = {
    # See UJ-type description
}
