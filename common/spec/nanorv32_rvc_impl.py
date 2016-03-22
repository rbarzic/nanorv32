spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CR-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',

    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1_c',
        'port2'  : 'rs2_c',
        'portw'  : 'rd_c',  # rd_c = rs1_c

    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CI-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1_c', # Added for RVC support
        'port2'  : 'rs2_c', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}

spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CSS-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'no',
    },
    'datamem' : {
        'write' : 'yes',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CIW-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1', # Added for RVC support
        'port2'  : 'rs2', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}

spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CL-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1_c', # Added for RVC support
        'port2'  : 'rs2_c', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CS-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1_c', # Added for RVC support
        'port2'  : 'rs2_c', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CB-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'yes',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'no',
        'source' : 'alu',
        'port1'  : 'rs1_c', # Added for RVC support
        'port2'  : 'rs2_c', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CJ-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1_c', # Added for RVC support
        'port2'  : 'rs2_c', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CS2-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1_c', # Added for RVC support
        'port2'  : 'rs2_c', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}

spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CB2-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1',
        'portb' : 'rs2',
        'op' : 'noop',


    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port1'  : 'rs1_c_p', #  rs1_c_p = rs1_c'
        'portw'  : 'rs1_c_p', #  rd_c' =  rs1_c'
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word_c',
	'size_write' : 'word_c',
    },

}



# Instruction specific implementation
#CR-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.add'] = {
     'alu' : {
        'op' : 'add',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.jalr'] = {
    'pc' : {
        'next' : 'alu_res',
    },
    'alu' : {
        'porta' : 'rs1',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'pc_exe_plus_2',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.jr'] = {
    'pc' : {
        'next' : 'alu_res',
    },
    'alu' : {
        'porta' : 'rs1',
    },
    'regfile' : {
        'write' : 'no',
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.mv'] = {
    'alu' : {
        'op' : 'nop',
        'portb' : 'rs2',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'portw'  : 'rd_c', #  rd_c' =  rs1_c'
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.ebreak'] = {
    'pc' : {
        'next' : 'plus2',
    },
    'alu' : {
        'op' : 'nop',
    },
}

#CI-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.addi'] = {
     'alu' : {
        'op' : 'add',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.nop'] = {
     'alu' : {
        'op' : 'nop',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.li'] = {
     'alu' : {
        'op' : 'nop',
        'portb' : 'cimm5',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.lui'] = {
     'alu' : {
        'op' : 'nop',
        'portb' : 'cimm5_lui',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.addi16sp'] = {
     'alu' : {
        'op' : 'add',
        'portb' : 'cimm5_16sp',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.slli'] = {
     'alu' : {
        'op' : 'lshift',
        'portb' : 'cimm5',
    },
}

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.lwsp'] = {
     'alu' : {
        'op' : 'add',
        'portb' : 'cimm5_lwsp',
    },
    'regfile' : {
        'source' : 'datamem',
        'port1'  : 'c_x2', # Added for RVC support
        'portw'  : 'rd_c',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'yes',
        'size_read' : 'word',
    },
}
# CJ-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.j'] = {
    'pc' : {
        'next' : 'alu_res',
        'branch' :'yes',
    },
    'alu' : {
        'porta' : 'pc_exe',
        'portb' : 'cimm10cj',
        'op'    : 'add',
    },
    'regfile' : {
        'write' : 'no',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.jal'] = {
    'pc' : {
        'next' : 'alu_res',
        'branch' :'yes',
    },
    'alu' : {
        'porta' : 'pc_exe',
        'portb' : 'cimm10cj',
        'op'    : 'add',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'pc_exe_plus_4',
        'port1'  : 'rs1', # Added for RVC support
        'port2'  : 'rs2', # Added for RVC support
        'portw'  : 'c_x1',  # Added for RVC support
    },
}
#CSS-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.swsp'] = {
     'alu' : {
        'op' : 'add',
        'portb' : 'cimm5_swsp',
    },
    'regfile' : {
        'write' : 'no',
        'port1'  : 'c_x2', # Added for RVC support
        'port2'  : 'rs2_c', # Added for RVC support
    },
    'datamem' : {
        'write' : 'yes',
        'read' : 'no',
        'size_write' : 'word',
    },
}
#CIW-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.add4spn'] = {
     'alu' : {
        'op' : 'add',
        'portb' : 'cimm8_ciw',
    },
    'regfile' : {
        'write' : 'yes',
        'port1'  : 'c_x2', # Added for RVC support
        'source' : 'alu',
        'portw'  : 'rd_c_p', # Added for RVC support
    },
    'datamem' : {
        'write' : 'yes',
        'read' : 'no',
        'size_write' : 'word',
    },
}
#CL-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.lw'] = {
     'alu' : {
        'op' : 'add',
        'portb' : 'cimm5_cl',
    },
    'regfile' : {
        'write'  : 'yes',
        'port1'  : 'rs1_c_p', # Added for RVC support
        'source' : 'datamem',
        'portw'  : 'rd_c_p', # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'yes',
        'size_read' : 'word',
    },
}
#CS-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.sw'] = {
     'alu' : {
        'op' : 'add',
        'portb' : 'cimm5_cl',
    },
    'regfile' : {
        'write' : 'no',
        'port1'  : 'rs1_c_p', # Added for RVC support
        'port2'  : 'rs2_c_p', # Added for RVC support
    },
    'datamem' : {
        'write' : 'yes',
        'read' : 'no',
        'size_write' : 'word',
    },
}
#CB2-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.andi'] = {
     'alu' : {
        'op' : 'and',
        'portb' : 'cimm5',
    },
    'regfile' : {
        'write' : 'no',
        'port1'  : 'rs1_c_p', # Added for RVC support
        'portw'  : 'rs1_c_p', # Added for RVC support
    },
    'datamem' : {
        'read' : 'no',
        'write' : 'no',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.srai'] = {
     'alu' : {
        'op' : 'arshift',
        'portb' : 'cimm5',
    },
    'regfile' : {
        'write' : 'yes',
        'port1'  : 'rs1_c_p', # Added for RVC support
        'portw'  : 'rs1_c_p', # Added for RVC support
    },
    'datamem' : {
        'read' : 'no',
        'write' : 'no',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.srli'] = {
     'alu' : {
        'op' : 'rshift',
        'portb' : 'cimm5',
         
    },
    'regfile' : {
        'write' : 'no',
        'port1'  : 'rs1_c_p', # Added for RVC support
        'portw'  : 'rs1_c_p', # Added for RVC support
    },
    'datamem' : {
        'read' : 'no',
        'write' : 'no',
    },
}

#CB2-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.bnez'] = {
     'alu' : {
        'op' : 'neq',
        'portb' : 'cimm5_cb',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb_c'
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.beqz'] = {
     'alu' : {
        'op' : 'eq',
        'portb' : 'cimm5_cb',
    },
    'pc' : {
        'next' : 'cond_pc_plus_immsb_c'
    },
}
#CS2-type
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.sub'] = {
     'alu' : {
        'op' : 'sub',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.xor'] = {
     'alu' : {
        'op' : 'xor',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.or'] = {
     'alu' : {
        'op' : 'or',
    },
}
spec['nanorv32']['rvc_rv32']['impl']['inst']['c.and'] = {
     'alu' : {
        'op' : 'and',
    },
}
