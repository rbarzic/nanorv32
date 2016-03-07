spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CR-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'port1'  : 'rs1',
        'port2'  : 'rs2',
        'portw'  : 'rs1',  # rd = rs1

    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CI-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}

spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CSS-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CIW-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}

spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CL-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CS-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CB-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CJ-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}


spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CS2-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'portw'  : 'rd',  # Added for RVC support
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}

spec['nanorv32']['rvc_rv32']['impl']['inst_type']['CB2-type'] = {
    'pc' : {
        'next' : 'plus4',
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
        'port1'  : 'rs1_p', #  rs1_p = rs1'
        'portw'  : 'rs1_p', #  rd' =  rs1'
    },
    'datamem' : {
        'write' : 'no',
        'read' : 'no',
        'size_read' : 'word',
	'size_write' : 'word',
    },

}



# Instruction specific implementation

spec['nanorv32']['rvc_rv32']['impl']['inst']['c.add'] = {
     'alu' : {
        'op' : 'add',
    },
}


spec['nanorv32']['rvc_rv32']['impl']['inst']['c.addi'] = {
     'alu' : {
        'op' : 'add',
    },
}
