cfg['prefix'] = 'NRV32_VIC'
cfg['ip_name'] = 'nanorv32_vic'
cfg['addr_msb'] = 11
cfg['v_include_pre'] = ""
cfg['v_include_post'] = ""

regs['dbgctrl']['addr'] = 0
regs['dbgctrl']['description'] = "Debug Control Register"
regs['dbgctrl']['width'] = 32

regs['dbgctrl']['fields']["stepping"] = {
    'offset' : 0,
    'size'   :   1,
    'access' : 'rw',
    'reset_value' : 0,
    'description' : 'CPU will stop after each instruction '
}

regs['dbgctrl']['fields']["bkp0"] = {
    'offset' : 8,
    'size'   :   1,
    'access' : 'rw',
    'reset_value' : 0,
    'description' : 'Breakpoint unit 0 is enabled'
}

regs['bkpt0']['addr'] = 4
regs['bkpt0']['description'] = "Debug Control Register #0"
regs['bkpt0']['width'] = 32

regs['bkpt0']['fields']["addr"] = {
    'offset' : 0,
    'size'   :   32,
    'access' : 'rw',
    'reset_value' : 0,
}

regs['bkpt1']['addr'] = 4
regs['bkpt1']['description'] = "Debug Control Register #0"
regs['bkpt1']['width'] = 32

regs['bkpt1']['fields']["addr"] = {
    'offset' : 0,
    'size'   :   32,
    'access' : 'rw',
    'reset_value' : 0
}
