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
        'portb' : 'imm12',
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
        'porta' : 'pc',
        'portb' : 'imm20', # ALU op will be 'portb' or add
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
        'next' : 'plus4'
    },
    'alu' : {
        'porta' : 'pc',
        'portb' : 'imm20uj',
        'op'    : 'add',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'next_pc',
    },
    'datamem' : {
        'write' : 'word',
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





spec['nanorv32']['rv32i']['impl']['inst']['jalr'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['addi'] = {
     'alu' : {
        'op' : 'addi',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['slli'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['slti'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['sltiu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['xori'] = {
    'alu' : {
        'op' : 'xor',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['srli'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['srai'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['ori'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['andi'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lb'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lw'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['ld'] = {
    'datamem' : {
        'write' : 'no',
        'read' : 'yes',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['lbu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lwu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['lhu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['fence'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['fence.i'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['slli'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['slti'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['srli'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['srai'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['beq'] = {
    'alu' : {
        'op' : 'comp',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['bne'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['blt'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['bge'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['bltu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['bgeu'] = {

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

}


spec['nanorv32']['rv32i']['impl']['inst']['slt'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['sltu'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['xor'] = {
    'alu' : {
        'op' : 'or',
    },
}


spec['nanorv32']['rv32i']['impl']['inst']['srl'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['sra'] = {

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

}


spec['nanorv32']['rv32i']['impl']['inst']['sh'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['sw'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['sd'] = {

}


spec['nanorv32']['rv32i']['impl']['inst']['jal'] = {

}
