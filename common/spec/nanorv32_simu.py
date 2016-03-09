import AutoVivification as av
spec = av.AutoVivification()
#spec = dict()


#spec['addi'] = lambda c: (  c.update_rf(c.dec_rd,c.rf[c.dec_rs1] + c.dec_imm12),
#                            c.pc_next + c.imm12 )



# Instruction specific implementation

def rshift(val, n):
    return val>>n if val >= 0 else (val+0x100000000)>>n

spec['nanorv32']['rv32i']['simu']['inst']['jalr'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd,c.pc),
        c.pc  + c.dec_imm12_se
    )
}




spec['nanorv32']['rv32i']['simu']['inst']['addi'] = {
   'func' :  lambda c: (
       c.update_rf(c.dec_rd, c.rf[c.dec_rs1] +  c.dec_imm12_se),
       c.pc + 4
   )
}

spec['nanorv32']['rv32i']['simu']['inst']['mul'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, c.rf[c.dec_rs1] * c.rf[c.dec_rs2]),
        c.pc + 4
    )
}

spec['nanorv32']['rv32i']['simu']['inst']['mulh'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf[c.dec_rs1] * c.rf[c.dec_rs2])>>32) ,
        c.pc + 4
    )

}
spec['nanorv32']['rv32i']['simu']['inst']['mulhsu'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf [c.dec_rs1] * abs(c.rf [c.dec_rs2]))>>32) ,
        c.pc + 4
    )
}
spec['nanorv32']['rv32i']['simu']['inst']['mulhu'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (abs(c.rf [c.dec_rs1]) * abs(c.rf [c.dec_rs2]))>>32) ,
        c.pc + 4
    )
}

spec['nanorv32']['rv32i']['simu']['inst']['div'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf [c.dec_rs1] / c.rf [c.dec_rs2])>>32 if c.rf [c.dec_rs2] !=0 else -1 ) ,
        c.pc + 4
    )

}
spec['nanorv32']['rv32i']['simu']['inst']['divu'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (abs(c.rf [c.dec_rs1]) / abs(c.rf[c.dec_rs2]))>>32 if c.rf [c.dec_rs2] !=0 else -1 ) ,
        c.pc + 4
    )

}
spec['nanorv32']['rv32i']['simu']['inst']['rem'] = {
     'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf [c.dec_rs1] / c.rf[c.dec_rs2])>>32 if c.rf [c.dec_rs2] !=0 else c.rf [c.dec_rs2] ) ,
        c.pc + 4
    )
}
spec['nanorv32']['rv32i']['simu']['inst']['remu'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (abs(c.rf [c.dec_rs1]) / abs(c.rf[c.dec_rs2]))>>32 if c.rf [c.dec_rs2] !=0 else c.rf [c.dec_rs2] ) ,
        c.pc + 4
    )

}


spec['nanorv32']['rv32i']['simu']['inst']['slli'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] << c.dec_shamt) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['slti'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, 1 if c.rf[c.dec_rs1] < c.dec_imm12_se else 0) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['sltiu'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, 1 if abs(c.rf[c.dec_rs1]) < abs(c.dec_imm12) else 0) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['xori'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] ^ c.dec_imm12_se) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['srli'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, rshift(c.rf[c.dec_rs1],c.dec_shamt)) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['srai'] = {
     'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] >> c.dec_shamt) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['ori'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] | c.dec_imm12_se) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['andi'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] | c.dec_imm12_se) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['lb'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.mem_read_byte(c.rf[c.dec_rs1] + c.dec_imm12_se)) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['lw'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.mem_read_word(c.rf[c.dec_rs1] + c.dec_imm12_se)) ,
        c.pc + 4
    )
}


# spec['nanorv32']['rv32i']['simu']['inst']['ld'] = {
#     'datamem' : {
#         'write' : 'no',
#         'read' : 'yes',
#     },
# }


spec['nanorv32']['rv32i']['simu']['inst']['lbu'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.mem_read_byte_u(c.rf[c.dec_rs1] + c.dec_imm12_se)) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['lhu'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.mem_read_halfword_u(c.rf[c.dec_rs1] + c.dec_imm12_se)) ,
        c.pc + 4
    )
}

spec['nanorv32']['rv32i']['simu']['inst']['lh'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.mem_read_halfword(c.rf[c.dec_rs1] + c.dec_imm12_se)) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['fence'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['fence_i'] = {

}



spec['nanorv32']['rv32i']['simu']['inst']['beq'] = {
    'func' :  lambda c: (
        None,
        c.pc + c.dec_sb_offset if c.rf[c.dec_rs1] == c.rf[c.dec_rs2] else c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['bne'] = {
    'func' :  lambda c: (
        None,
        c.pc + c.dec_sb_offset if c.rf[c.dec_rs1] != c.rf[c.dec_rs2] else c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['blt'] = {
    'func' :  lambda c: (
        None,
        c.pc + c.dec_sb_offset if c.rf[c.dec_rs1] < c.rf[c.dec_rs2] else c.pc + 4 # FIXME - signed ?
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['bge'] = {
    'func' :  lambda c: (
        None,
        c.pc + c.dec_sb_offset if c.rf[c.dec_rs1] >= c.rf[c.dec_rs2] else c.pc + 4 # FIXME - signed ?
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['bltu'] = {
     'func' :  lambda c: (
        None,
        c.pc + c.dec_sb_offset if abs(c.rf[c.dec_rs1]) < abs(c.rf[c.dec_rs2]) else c.pc + 4 # FIXME - signed ?
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['bgeu'] = {
   'func' :  lambda c: (
        None,
        c.pc + c.dec_sb_offset if abs(c.rf[c.dec_rs1]) >= abs(c.rf[c.dec_rs2]) else c.pc + 4 # FIXME - signed ?
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['lui'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.dec_imm20<<12) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['auipc'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.pc + (c.dec_imm20<<12)) ,
        c.pc + 4
    )
}


# {{{ add

spec['nanorv32']['rv32i']['simu']['inst']['add'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf[c.dec_rs1] + c.rf[c.dec_rs2])) ,
        c.pc + 4
    )
}

# }}}

# {{{ sub

spec['nanorv32']['rv32i']['simu']['inst']['sub'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf[c.dec_rs1] - c.rf[c.dec_rs2])) ,
        c.pc + 4
    )
}

# }}}



spec['nanorv32']['rv32i']['simu']['inst']['sll'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] << c.rf[c.dec_rs2]) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['slt'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, 1 if c.rf[c.dec_rs1] < c.rf[c.dec_rs2] else 0) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['sltu'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, 1 if abs(c.rf[c.dec_rs1]) < abs(c.rf[c.dec_rs2]) else 0) ,
        c.pc + 4
    )

}


spec['nanorv32']['rv32i']['simu']['inst']['xor'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf[c.dec_rs1] ^ c.rf[c.dec_rs2])) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['srl'] = {
    'func' :  lambda c: (
        c.update_rf( c.dec_rd, rshift(c.rf[c.dec_rs1],c.rf[c.dec_rs2])) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['sra'] = {
     'func' :  lambda c: (
        c.update_rf( c.dec_rd, c.rf[c.dec_rs1] >> c.rf[c.dec_rs2]) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['or'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf[c.dec_rs1] | c.rf[c.dec_rs2])) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['and'] = {
    'func' :  lambda c: (
        c.update_rf(c.dec_rd, (c.rf[c.dec_rs1] & c.rf[c.dec_rs2])) ,
        c.pc + 4
    )
}


spec['nanorv32']['rv32i']['simu']['inst']['scall'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['sbreak'] = {

}


spec['nanorv32']['rv32i']['simu']['inst']['sb'] = {
    'func' :  lambda c: (
        c.mem_write_byte(c.rf[c.dec_rs1] + c.dec_imm12_se, c.rf[c.dec_rd]) ,
        c.pc + 4
    )

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
