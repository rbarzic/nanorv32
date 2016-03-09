import AutoVivification as av
spec = av.AutoVivification()
#spec = dict()


#spec['addi'] = lambda c: (  c.update_rf(c.dec_rd,c.rf[c.dec_rs1] + c.dec_imm12),
#                            c.pc_next + c.imm12 )



# Instruction specific implementation



spec['nanorv32']['rv32i']['simu']['inst']['jalr'] = {
    'func' :  lambda c: (  c.update_rf(c.dec_rd,c.pc),
                           c.pc  + c.imm12 )
}




spec['nanorv32']['rv32i']['simu']['inst']['addi'] = {
   'func' :  lambda c: (  c.update_rf(c.dec_rd, c.rf[c.dec_rs1] +  c.dec_imm12),
                           c.pc + 4 )
}

spec['nanorv32']['rv32i']['simu']['inst']['mul'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, c.rf[c.dec_rs1] * c.rf[c.dec_rs2]),
        c.pc + 4
    )
}

spec['nanorv32']['rv32i']['simu']['inst']['mulh'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, c.rf[c.dec_rs1] * c.rf[c.dec_rs2]),
        c.pc + 4
    )

}
spec['nanorv32']['rv32i']['simu']['inst']['mulhsu'] = {
     'alu' : {
        'op' : 'mulhsu',
    },
}
spec['nanorv32']['rv32i']['simu']['inst']['mulhu'] = {
     'alu' : {
        'op' : 'mulhu',
    },
}

spec['nanorv32']['rv32i']['simu']['inst']['div'] = {
     'alu' : {
        'op' : 'div',
    },
}
spec['nanorv32']['rv32i']['simu']['inst']['divu'] = {
     'alu' : {
        'op' : 'divu',
    },
}
spec['nanorv32']['rv32i']['simu']['inst']['rem'] = {
     'alu' : {
        'op' : 'rem',
    },
}
spec['nanorv32']['rv32i']['simu']['inst']['remu'] = {
     'alu' : {
        'op' : 'remu',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['slli'] = {
     'alu' : {
        'porta' : 'rs1',
        'portb' : 'shamt',
         'op'    : 'lshift',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['slti'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm12',
        'op'    : 'lt_signed',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['sltiu'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm12',
        'op'    : 'lt_unsigned',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['xori'] = {
    'alu' : {
        'op' : 'xor',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['srli'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'shamt',
        'op'    : 'rshift',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['srai'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'shamt',
        'op'    : 'arshift', # Arithmetic right shift
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['ori'] = {
    'alu' : {
        'op' : 'or',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['andi'] = {
    'alu' : {
        'op' : 'and',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['lb'] = {
    'regfile' : {
        'source' : 'datamem',
    },

    'datamem' : {
        'size_read' : 'byte',
        'write' : 'no',
        'read' : 'yes',
    }

}


spec['nanorv32']['rv32i']['simu']['inst']['lw'] = {
    'regfile' : {
        'source' : 'datamem',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'yes',
        'size_read' : 'word',
    },

}


# spec['nanorv32']['rv32i']['simu']['inst']['ld'] = {
#     'datamem' : {
#         'write' : 'no',
#         'read' : 'yes',
#     },
# }


spec['nanorv32']['rv32i']['simu']['inst']['lbu'] = {
    'regfile' : {
        'source' : 'datamem',
    },

    'datamem' : {
        'size_read' : 'byte_unsigned',
        'write' : 'no',
        'read' : 'yes',
    }
}


spec['nanorv32']['rv32i']['simu']['inst']['lhu'] = {
    'regfile' : {
        'source' : 'datamem',
    },

    'datamem' : {
        'size_read' : 'halfword_unsigned',
        'write' : 'no',
        'read' : 'yes',
    }
}

spec['nanorv32']['rv32i']['simu']['inst']['lh'] = {
    'regfile' : {
        'source' : 'datamem',
    },

    'datamem' : {
        'size_read' : 'halfword',
        'write' : 'no',
        'read' : 'yes',
    }
}


spec['nanorv32']['rv32i']['simu']['inst']['fence'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['fence_i'] = {

}



spec['nanorv32']['rv32i']['simu']['inst']['beq'] = {
    'alu' : {
        'op' : 'eq',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['bne'] = {
    'alu' : {
        'op' : 'neq',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['blt'] = {
    'alu' : {
        'op' : 'lt_signed',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },

}


spec['nanorv32']['rv32i']['simu']['inst']['bge'] = {
    'alu' : {
        'op' : 'ge_signed', # Greater or equal (signed)
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['bltu'] = {
    'alu' : {
        'op' : 'lt_unsigned',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['bgeu'] = {
    'alu' : {
        'op' : 'ge_unsigned', # Greater or equal (unsigned)
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb'
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['lui'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'imm20u',
        'op' : 'nop',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['auipc'] = {
    'alu' : {
        'op' : 'add',
    },
}


# {{{ add

spec['nanorv32']['rv32i']['simu']['inst']['add'] = {
     'alu' : {
        'op' : 'add',
    },
}

# }}}

# {{{ sub

spec['nanorv32']['rv32i']['simu']['inst']['sub'] = {
     'alu' : {
        'op' : 'sub',
    },
}

# }}}



spec['nanorv32']['rv32i']['simu']['inst']['sll'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'lshift',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['slt'] = {
     'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'lt_signed',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['sltu'] = {
         'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'lt_unsigned',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['xor'] = {
    'alu' : {
        'op' : 'xor',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['srl'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'rshift',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['sra'] = {
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op'    : 'arshift', # Arithmetic right shift
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['or'] = {
    'alu' : {
        'op' : 'or',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['and'] = {
    'alu' : {
        'op' : 'and',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['scall'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['sbreak'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['sb'] = {
     'datamem' : {
        'write' : 'yes',
        'read' : 'no',
         'size_write' : 'byte',
    },
}


spec['nanorv32']['rv32i']['simu']['inst']['sh'] = {
     'datamem' : {
        'write' : 'yes',
        'read' : 'no',
         'size_write' : 'halfword',
    },

}


spec['nanorv32']['rv32i']['simu']['inst']['sw'] = {
     'datamem' : {
        'write' : 'yes',
        'read' : 'no',
        'size_write' : 'word',
    },
}


#spec['nanorv32']['rv32i']['simu']['inst']['sd'] = {
#
#}


spec['nanorv32']['rv32i']['simu']['inst']['jal'] = {
    # See UJ-type description
}
