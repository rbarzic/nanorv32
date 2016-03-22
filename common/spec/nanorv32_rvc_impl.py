spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CR-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CIW-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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

spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CL-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CJ-type'] = {
    'pc' : {
        'next' : 'plus2',
        'branch' :'no',
        'size'   : '16bits'
    },
    'alu' : {
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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
        'porta' : 'rs1_c',
        'portb' : 'rs2_c',
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
    'pc' : {
        'next' : 'plus2',
    },
    'alu' : {
        'op' : 'nop',
    },
    'regfile' : {
        'write' : 'yes',
        'source' : 'alu',
        'port2'  : 'rs2', #  rs1_c_p = rs1_c
        'portw'  : 'rd_c', #  rd_c' =  rs1_c'
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
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
